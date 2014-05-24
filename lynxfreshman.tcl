package require http
#proc tt {} {
#set ::time [clock format [clock seconds] -format "²{¦b¬O%Y¦~%m¤ë%d¤é %H®É%M¤À%S¬í" ]
#after 1000 tt
#}
proc getPage { url } {
       ::http::config -useragent "Mozilla/4.75 (X11; U; Linux 2.2.17; i586; Nav)"
       set token [::http::geturl $url]
       set data [::http::data $token]
       ::http::cleanup $token          
       regexp {(div[^>]*>)([^%]*%) (<[^>]*>)(\([^\s]*)(\s[^\)]*)} $data tag tag1 tag2 tag3 tag4 tag5
       set data2 [concat $tag2 $tag5]
       return $data2
}
proc fetch {} {
	set tmp [getPage http://freshman.tw/cross/]
	set ::data $::data2
	set ::data2 $tmp
	after 3600000 fetch 
	#1 hr update
}
proc about {} {
	tk_messageBox -default "ok" -message  "­Ó¤H¥Ó½Ð ²Ä¤G¶¥¬q\n©ñº]¬d¸ß\nª©¥»2.0\n§@ªÌ:¬ö©s¨°\n¸ê®Æ¨Ó·½:\n·sÂA¤H¬dº]" -title "Ãö©ó"
	}
#menu bar set
menu .mbar -type menubar -tearoff 0
.mbar add command -label "Ãö©ó" -command about 
.mbar add command -label "Â÷¶}" -command {exit}
. configure -menu .mbar
#menu bar set end
#title set
wm title . "©ñº]¶i«×¬d¸ß– by ¬ö©s¨°"
#title set end
set ::data " "
set ::data2 " "
set fm [::ttk::frame .a -relief groove]
set fm1 [::ttk::labelframe $fm.a1 -text "ÂÂ¸ê®Æ" ]
set fm2 [::ttk::labelframe $fm.a2 -text "§ó·s«á" ]
set old [ttk::label $fm1.title1 -text "¦Ê¤À¤ñ \n (¤w©ñº]/©Ò¦³®Õ¨t)" -font [font create -family "¼Ð·¢Åé" -size 16]]
set new [ttk::label $fm2.title2 -text "¦Ê¤À¤ñ \n (¤w©ñº]/©Ò¦³®Õ¨t)" -font [font create -family "¼Ð·¢Åé" -size 16]]
#set stattime [ttk::label $fm.stat -text "³B²z freshman.tw(·sÂA¤H¬dº]) ªº¸ê®Æ\n¨C¤p®É§ó·s¤@¦¸" -anchor w -font [font create -family "¼Ð·¢Åé" -size 14]]
set dat [ttk::label $fm1.percent -textvariable ::data -anchor w -font [font create -family "¼Ð·¢Åé" -size 16]]
set datnew [ttk::label $fm2.percentnew -textvariable ::data2 -anchor w -font [font create -family "¼Ð·¢Åé" -size 16]]
set but [ttk::label $fm.init -text "·Æ¹«²¾¹L¥H¨ú±o§ó·s" -font [font create -family "¼Ð·¢Åé" -size 16]]

#sub prog init
#tt
fetch
#sub prog init end
#$but invoke
bind $but <Enter> {fetch}
bind . <Return> {fetch}
bind . <Escape> {exit}
grid $fm -sticky "news" -row 0 -column 0 
grid $fm1 -sticky "news" -row 0 -column 0 
grid $fm2 -sticky "news" -row 0 -column 1
grid $old -sticky "news" -row 0 -column 0
grid $new -sticky "news" -row 0 -column 0
grid $dat -sticky "news" -row 1 -column 0
grid $datnew -sticky "news" -row 1 -column 0
grid $but -sticky "ns" -row 1  -column 0 -columnspan 2
#grid $stattime -sticky "news" -row 2 -column 0 -columnspan 2
grid rowconfigure $fm 0 -weight 1
grid columnconfigure $fm 1 -weight 1
grid columnconfigure $fm 0 -weight 1
grid columnconfigure . 0 -weight 1
grid rowconfigure . 0 -weight 1


