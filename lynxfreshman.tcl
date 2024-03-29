package require http
#proc tt {} {
#set ::time [clock format [clock seconds] -format "現在是%Y年%m月%d日 %H時%M分%S秒" ]
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
	tk_messageBox -default "ok" -message  "個人申請 第二階段\n放榜查詢\n版本2.0\n作者:紀孟辰\n資料來源:\n新鮮人查榜" -title "關於"
	}
#menu bar set
menu .mbar -type menubar -tearoff 0
.mbar add command -label "關於" -command about 
.mbar add command -label "離開" -command {exit}
. configure -menu .mbar
#menu bar set end
#title set
wm title . "放榜進度查詢� by 紀孟辰"
#title set end
set ::data " "
set ::data2 " "
set fm [::ttk::frame .a -relief groove]
set fm1 [::ttk::labelframe $fm.a1 -text "舊資料" ]
set fm2 [::ttk::labelframe $fm.a2 -text "更新後" ]
set old [ttk::label $fm1.title1 -text "百分比 \n (已放榜/所有校系)" -font [font create -family "標楷體" -size 16]]
set new [ttk::label $fm2.title2 -text "百分比 \n (已放榜/所有校系)" -font [font create -family "標楷體" -size 16]]
#set stattime [ttk::label $fm.stat -text "處理 freshman.tw(新鮮人查榜) 的資料\n每小時更新一次" -anchor w -font [font create -family "標楷體" -size 14]]
set dat [ttk::label $fm1.percent -textvariable ::data -anchor w -font [font create -family "標楷體" -size 16]]
set datnew [ttk::label $fm2.percentnew -textvariable ::data2 -anchor w -font [font create -family "標楷體" -size 16]]
set but [ttk::label $fm.init -text "滑鼠移過以取得更新" -font [font create -family "標楷體" -size 16]]

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


