# voiceallbut
Voice All But TCL _(for eggdrops)_
v2.0    

VoiceAllBut (VAB) allows you to auto-voice users in VAB-enabled channels, while maintaining a list of those who should not be auto-voiced.    

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
are **complete**!    

### To Do List:  
- [x] Fix spelling mistakes  
- [x] Add ability to use VAB commands in private message  
- [x] Add automated VAB adds for being De-voiced  
- [x] Add automated VAB adds for being Kicked  
- [x] Add automated VAB adds for being Killed  
- [x] Add automated VAB adds for being G-lined  
- [x] Add automated VAB adds for being K-lined  
- [x] Add automated VAB adds for being Killed  
- [x] Add automated VAB adds for being Z-lined  
- [x] Complete above To Do list for v2.0, then all new  
To Do's, requests or issues should be maintained in  
https://github.com/IRC4Fun/voiceallbut/issues  

### For Questions, Support, etc:  
See _siniStar_ in #IRC4Fun on **irc.IRC4Fun.net**  
(plaintext: 6667-6669)
(ssl: 6697-6699)
