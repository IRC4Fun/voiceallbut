#         Script : VoiceAllBut v1.02 by David Proper (Dr. Nibble [DrN])
#
#    Description : VoiceAllBut is an auto-voice script with an exceptions
#                  list. You can add/remove people from the no-voice list
#                  via a channel command. VAB will voice all users who 
#                  join except users on the no-voice list.
#                  Good for botchannels who are +m and want the talker
#                  bots to just shut up. :)
#
#        History : 02/10/2002 - First Release
#                  03/25/2002 - v1.01
#                              o Modified sitemask definition to make a
#                                more normal mask. (Instead of full domain)
#                              o Will now de-voice user if they are voiced
#                                when added to the novoice list and voice
#                                them when removed. (Suggested by UTAKER)
#                  06/21/2002 - v1.02
#                              o Added subst command to see if that'd help
#                                with nicks using | and shit.
#                              o Added list of channels to voice on.
#                                (Requested by UTAKER@DALnet)
#                              o Added public commands to add/del/list VAB
#                                channel list.
#                              o Saves channel list to datafile. Will only
#                                use VAB(chans) list if no datafile is found
#
#
#   Future Plans : Fix Bugs. :)
#                 o Only active on defined channels
#
# Commands Added:
#  Where     F CMD          F CMD            F CMD           F CMD
#  -------   - ----------   - ------------   - -----------   - ----------
#  Public:   o vab          o vablist        o vabadd        o vabdel
#     MSG:   N/A
#     DCC:   N/A
#

# This is the user-definable flag to use to indicate a user on the no-voice list
set VAB(flag) V

# Default flags to give when adding a new user
set VAB(default-flags) "+h-p"

# User access required to modify/list no-voice list.
set VAB(access) "o|o"

# Define this as the channels you want to protect. * for all
set VAB(chans) "#Channel"

# Define this as the file to store dynamic list of channels to voice on
set VAB(datafile) "vablist.dat"

# Trigger charactor to use.
set cmdchar_ "*"



set VAB(ver) "v1.02.02"

proc cmdchar { } {global cmdchar_; return $cmdchar_}

bind join - ** VAB_join
proc VAB_join {nick uhost hand chan} {
global VAB
 if {![voicechan $chan]} {return 1}
 if {([matchchanattr $hand |$VAB(flag) $chan])} {return 0}
 pushmode $chan +v $nick
                                     }

bind pub $VAB(access) [cmdchar]vab pub_vab
proc pub_vab {nick uhost hand chan rest} {
global VAB
subst -nobackslashes -nocommands -novariables rest

 if {$rest == ""} {
              putserv "NOTICE $nick :Calling Syntax: [cmdchar]vab cmd \[nick\]"
              putserv "NOTICE $nick :  Commands: list      - Lists no-voice users"
              putserv "NOTICE $nick :            add nick  - Add nick to novoice list"
              putserv "NOTICE $nick :            del nick  - Remove nick from novoice list"
              return 0
                  }
 set cmd [string toupper [lindex $rest 0]]
 set rest [lrange $rest 1 end]

 switch $cmd {
  "LIST" {vab_listuser $nick $uhost $hand $chan $rest}
  "ADD" {vab_adduser $nick $uhost $hand $chan $rest}
  "DEL" {vab_deluser $nick $uhost $hand $chan $rest}
             }
}

proc vab_adduser {nick uhost hand chan rest} {
global VAB 
 subst -nobackslashes -nocommands -novariables rest

 if {$rest == ""} {putserv "NOTICE $nick :Calling Syntax: [cmdchar]vab add nick"; return 0}
 set user [lindex $rest 0]

 if {![onchan $user $chan]} {set thand $user} else {set thand [nick2hand $user]}
 if {![validuser $thand]} {
  if {![onchan $user $chan]} {putserv "NOTICE $nick :$user is not on $chan. Can't get a hostmask to add as new user."; return 0}
   if {$thand == "*"} {set thand $user}
   set sitemask "*!*[string trimleft [maskhost [getchanhost $user $chan]] *!]"
   set rt [adduser $thand $sitemask]
   if {$rt == 1} {set rt "Success"} else {set rt "Failed"}
   putserv "NOTICE $nick :Adding $user\($thand\): $rt"
   set rt [chattr $thand ${VAB(default-flags)}]
   putserv "NOTICE $nick :Setting default flags for $user\($thand\): $rt"

                          }
 if {([matchchanattr $thand |$VAB(flag) $chan])} {putserv "NOTICE $nick :$user is allready no-voiced on $chan"; return 0}
 set rt [chattr $thand |+$VAB(flag) $chan]
 putserv "NOTICE $nick :Flags for $user\($thand\) are now: $rt"
 if {[isvoice $user $chan]} {pushmode $chan -v $user}
}

proc vab_deluser {nick uhost hand chan rest} {
global VAB 
 subst -nobackslashes -nocommands -novariables rest
 if {$rest == ""} {putserv "NOTICE $nick :Calling Syntax: [cmdchar]vab add nick"; return 0}
 set user [lindex $rest 0]

 if {![validuser $user]} {putserv "NOTICE $nick :$user is not a valid user."; return 0}
 if {(![matchchanattr $user |$VAB(flag) $chan])} {putserv "NOTICE $nick :$user isn't on the no-voiced for $chan"; return 0}
 set rt [chattr $user |-$VAB(flag) $chan]
 putserv "NOTICE $nick :Flags for $user are now: $rt"
 if {[isvoice $user $chan]} {pushmode $chan +v $user}
}

bind pub o|o [cmdchar]vablist pub_VABlist
proc pub_VABlist {nick uhost hand channel rest} {
global VAB
if {$VAB(chans) == ""} {puthelp "NOTICE $nick :VAB Channel list is empty."
                       } else {puthelp "NOTICE $nick :Current VAB channels are: $VAB(chans)"
                              }
}

bind pub o|o [cmdchar]vabadd pub_VABadd
proc pub_VABadd {nick uhost hand channel rest} {
global VAB
 if {[voicechan $channel]} {
                            puthelp "NOTICE $nick :$channel allready in VAB List"
                            return 0
                           }
 puthelp "NOTICE $nick :Adding $channel to VAB List"
 lappend VAB(chans) $channel
 save_VAB
}

bind pub o|o [cmdchar]vabdel pub_VABdel
proc pub_VABdel {nick uhost hand channel rest} {
global VAB
 if {![voicechan $channel]} {
                            puthelp "NOTICE $nick :$channel not found in  VAB List"
                            return 0
                           }
 puthelp "NOTICE $nick :Removing $channel from VAB List"
 set chans $VAB(chans)
 set VAB(chans) ""
 foreach chan $chans {
  if {[string tolower $chan] != [string tolower $channel]} {lappend VAB(chans) $chan}
                     }
save_VAB
}

proc voicechan {chan} {
 global VAB
 set chan [string tolower $chan]
 set chans [string tolower $VAB(chans)]
 if {$chan == "*"} {set chans [string tolower [channels]]}
 set dothechan 0
 foreach c $chans {
  if {($chan == $c)} {set dothechan 1}
                  }
 if {$dothechan == 0} {return 0} else {return 1}
}


proc vab_listuser {nick uhost hand chan rest} {
global VAB 
 subst -nobackslashes -nocommands -novariables rest

 set users [userlist |$VAB(flag) $chan]
 putserv "NOTICE $nick :The following are listed as no-voice for $chan: $users"
}

proc load_VAB {} {
global VAB
  if {[file exists $VAB(datafile)]} {
                                 set in [open $VAB(datafile) r]
                                 set VAB(chans) [gets $in]
                                 close $in
                                } {putlog "-VAB- Datafile $VAB(datafile) not found. Using default channel list."}
                    }
load_VAB

proc save_VAB {} {
global VAB
 putlog "Saving VAB Data to $VAB(datafile)"
 set out [open $VAB(datafile) w]
 puts $out $VAB(chans)
 close $out
}


putlog "VoiceAllBut $VAB(ver) by David Proper (DrN) -:LoadeD:-"
return "VoiceAllBut $VAB(ver) by David Proper (DrN) -:LoadeD:-"

