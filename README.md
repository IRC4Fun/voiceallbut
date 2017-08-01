# voiceallbut
Voice All But TCL _(for eggdrops)_
v2.5.1    

VoiceAllBut (VAB) allows you to auto-voice users in VAB-enabled channels, while maintaining a list of those who should not be auto-voiced.  
This is _especially_ helpful in **Help Channels** or **chat channels that utilize moderation (+m)** to _prevent_ or _handle abuse_.  Unlike 
Services, this eggdrop script allows you to avoid blindly auto-voicing everyone that joins.  VoiceAllBut will (in addition to allowing you 
to manually add users to the VAB (Voice All But) list) also automatically add users to it's VAB list upon being de-voiced, kicked, killed 
by an IRC Operator, or banned from the IRC network.  This means that abusive users or flooders will not be auto-voiced during a flood or 
spam attack, nor will users that you have decided to devoice, remove from the channel, or network.  Voice All But _(the bad guys!)_    

### Installation:
 1. Download from GitHub and upload to your eggdrop's /scripts/ directory.  
 2. Edit your `eggdrop.conf` to include `/scripts/voiceallbut.tcl` 
 3. Create empty `vablist.dat` file inside /scripts/  
 4. Rehash or Start eggdrop  
 5. Enjoy!    
 
### Use:  
 Primary VoiceAllBut commands:  
 ``*vab add nickname`` _(adds a user to the channel's VoiceAllBut list)_  
 ``*vab del nickname`` _(removes a user from the channel's VoiceAllBut list)_  
 ``*vab list`` _(shows a list of VoiceAllBut/No-Voice users on channel)_    
 
 ``*vabadd`` _(enables VoiceAllBut on channel)_  
 ``*vabdel`` _(disables VoiceAllBut on channel)_  
 ``*vablist`` _(lists channels with VoiceAllBut functionality enabled)_    

-Commands are in-channel OR via /MSG now.  
-Automated VAB adds for being De-voiced, Kicked, Killed, G-lined, K-lined, Killed or Z-lined 
are **complete**!  Supports Charybdis and Ratbox ban-types as well. (D/K/X:lines)    

### New Features / To Do List:  
- [x] Fix spelling mistakes  
- [x] Add ability to use VAB commands in private message  
- [x] Add automated VAB adds for being De-voiced  
- [x] Add automated VAB adds for being Kicked  
- [x] Add automated VAB adds for being Killed  
- [x] Add exclusion for NickServ KILLs from Auto VAB  
additions  
- [x] Add automated VAB adds for being G-lined  
- [x] Add automated VAB adds for being K-lined  
- [x] Add automated VAB adds for being Killed  
- [x] Add automated VAB adds for being Z-lined  
- [x] Add support for Charybdis and forks (D-lines, K-lines, X-lines) (2.5.1)  
- [x] Automated VABs no longer generate 3 lines of /NOTICE (now 1 line) (2.5.1)  
- [x] Manual VAB additions also generate 1 line NOTICE instead of 3. (2.5.1)  
- [] Code clean-ups for 2.6 (2.6)  
- [] Add exclusion for users devoicing, kicking, or killing themselves. (2.6)    

### For Questions, Support, etc:  
See _siniStar_ in #IRC4Fun on **irc.IRC4Fun.net**  
(plaintext: 6667-6669)
(ssl: 6697-6699)
