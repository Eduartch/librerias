 
*1* created on sunday 05 of november 2017
*run an click the summary help
*Menu adapted from the tutorial https://thatwebdude.com/tutorial/css-transparent-drop-down-menu/ by Ali jafarian

If !_vfp.StartMode=0
On Shutdown Quit
Endi

Publi yform
yform=Newobject("ytransp")
yform.Show
Read Events
Retu

Define Class ytransp As Form
BorderStyle = 3
Height = 627
Width = 1145
ShowWindow = 2
AutoCenter = .T.
Caption = "A web transparent horizontal menu with CSS."
WindowState = 2
BackColor = 0
Icon=Home(1)+"GRAPHICS\ICONS\ELEMENTS\SUN.ICO"
yurl = .F.
Name = "Form1"

Add Object olecontrol1 As OleControl With ;
	Oleclass="shell.explorer.2",;
	Top = 0, ;
	Left = -2, ;
	Height = 648, ;
	Width = 1154, ;
	Anchor = 15, ;
	Name = "Olecontrol1"

Add Object timer1 As Timer With ;
	Top = 60, ;
	Left = 792, ;
	Height = 23, ;
	Width = 23, ;
	Interval = 10000, ;
	Name = "Timer1"

Add Object timer2 As Timer With ;
	Top = 36, ;
	Left = 60, ;
	Height = 23, ;
	Width = 23, ;
	Interval = 2000, ;
	Name = "Timer2"

Procedure yactions
	Lparameters xURL
	xURL=Lower(Allt(xURL))
	Wait Window xURL  Nowait

	Do Case
		Case xURL=="yvfp://1/"
			Thisform.yapie("www.yousfi.over-blog.com")


		Case xURL=="yvfp://2/"
		Case xURL=="yvfp://3/"
		Case xURL=="yvfp://44/"
			If _vfp.Visible=.T.
				Sys(1500,'_MST_HPSCH','_MSYSTEM')  &&can run on vfp visible only.
			Else
				Messagebox("Help can run on vfp visible only",16+4096,"",1200)
			Endi

		Case xURL="yvfp://5/"
			Run/N mspaint
		Case xURL=="yvfp://6/"
			Run/N notepad
		Case xURL=="yvfp://7/"
			Run/N Calc
		Case xURL=="yvfp://8/"
			Run/N c:\Windows\sysnative\snippingtool
		Case xURL=="yvfp://9/"
			Run/N explorer.Exe "shell:appsfolder\Microsoft.BingNews_8wekyb3d8bbwe!AppexNews"

		Case xURL=="yvfp://10/"
			Thisform.yapie("https://www.foxite.com/")
		Case xURL=="yvfp://11/"
			Thisform.yapie("http://www.atoutfox.org")
		Case xURL=="yvfp://111/"
			Thisform.yapie("https://www.levelextreme.com/Default.aspx?LevelExtremeRedirect=1")
		Case xURL=="yvfp://112/"
			Thisform.yapie("http://weblogs.foxite.com/vfpimaging/author/vfpimaging/")
		Case xURL=="yvfp://113/"
			Thisform.yapie("https://vfpx.github.io/")
		Case xURL=="yvfp://114/"
			Thisform.yapie("http://sandstorm36.blogspot.com/")
		Case xURL=="yvfp://115/"
			Thisform.yapie("http://praisachion.blogspot.ro/")
		Case xURL=="yvfp://116/"
			Thisform.yapie("http://doughennig.blogspot.com/")
		Case xURL=="yvfp://117/"
			Thisform.yapie("http://fox.wikis.com/")
		Case xURL=="yvfp://118/"
			Thisform.yapie("https://blogs.msdn.microsoft.com/calvin_hsia/tag/visual-foxpro/")


		Case xURL=="yvfp://12/"
			Run/N explorer.Exe "shell:appsfolder\Microsoft.BingNews_8wekyb3d8bbwe!AppexNews"
		Case xURL=="yvfp://13/"
			Run/N explorer.Exe "shell:appsfolder\Microsoft.BingSports_8wekyb3d8bbwe!AppexSports"
			*!*	case xURL=="yvfp://14/"   &&to customize...
			*!*	case xURL=="yvfp://15/"
			*!*	case xURL=="yvfp://16/"
			*!*	case xURL=="yvfp://17/"
			*!*	case xURL=="yvfp://18/"
		case xURL=="yvfp://19/"
	
local m.lcUrl
m.lcUrl="https://www.youtube.com/embed/fA_dBVxcPCo"
yview(m.lcURl)


		Case xURL=="yvfp://20/"
			Local m.myvar
			TEXT to m.myvar pretext 7 noshow
This code builds a desktop application with a top level vfp form.
a web transparent menu with html & css is used to lauch vfp codes
with the ingenious method "beforenavigate" to redirect the original
url to vfp namespace.
the menu is built with the standard tags <ul>,<li>
can integrate in the web menu any vfp coding (the minimize,maximize/restore,release form for example) .
the titlebar can be on/off
5 menu color themes can be changed randomly in the system bar of menu.
the background web picture is changed every 10 sec with a timer.
i populated some menu items ,can customize.
to work with a web element from vfp, give it an unique Id and use the method getElementById("..") to access
it Properties.
important note: for compiling an exe i added the meta tag
<meta http-equiv="x-ua-compatible" content="ie=edge" />
otherwise the menu is not displayed correctly with exe file.

			ENDTEXT
			Local oshell
			oshell = Createobject('WScript.Shell')
			oshell.Popup(m.myvar,0, 'Summary help', 0+32+4096)  &&4,16,48,64...
			oshell=Null

		Case xURL=="yvfp://21/"
			Thisform.WindowState=1

		Case xURL=="yvfp://22/"
			Thisform.WindowState=Iif(Thisform.WindowState=0,2,0)

		Case xURL=="yvfp://23/"
			Sele ycolors
			Try
				Skip
			Catch
				Locate
			Endtry
			Thisform.ybuild()

		Case xURL="yvfp://24/"
			Thisform.timer1.Timer()
			*wait window  thisform.olecontrol1.document.getElementByID("yimg").src nowait
			Inkey(0.5)
			DoEvent
			Thisform.timer1.Reset()

		Case xURL=="yvfp://25/"
			Thisform.TitleBar=Iif(Thisform.TitleBar=1,0,1)
			If Thisform.TitleBar=0
				Thisform.Height=Thisform.Height+31
			Else
				Thisform.Height=Thisform.Height-31
			Endi
			Thisform.ybuild()

		Case xURL=="yvfp://26/"
			Thisform.Release
	Endcase
Endproc

Procedure ybuild
	Sele ycolors
	Local m.myvar
	TEXT to m.myvar textmerge noshow
	<!DOCTYPE html">
	<html>
	<head>
	<meta http-equiv="x-ua-compatible" content="ie=edge" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>CSS Transparent Drop-down Menu - Demo | alijafarian.com</title>

	<style type="text/css">
	* {
	  margin: 0;
	  padding: 0;
	  outline: none;
	}
	#wrapper {
	  margin: 0px auto 0;
	  width: <<thisform.width>>px;
	}
	#wrapper h1 {
	  font-family: 'Play', sans-serif;
	  text-align: center;
	  text-shadow: 0 2px 1px #fff;
	}
	#wrapper p {
	  margin: 0 0 0px;
	  text-align: center;
	}
	.container {
	  background:#fff;
	  box-shadow: 0 0 10px #ccc;
	  margin-bottom: 0px;
	  padding: 1px;
	  width: thisform.width-40>>px;
	}
	.container img {
	 width: 100%;
	 height:97%;
	}
	#main-nav {
	  background: <<xcolor>> ;
	  background: -moz-linear-gradient(top, <<xcolor>> 0%, #547b00 100%);
	  background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,<<xcolor>>), color-stop(100%,#547b00));
	  background: -webkit-linear-gradient(top, <<xcolor>> 0%,<<xcolor>> 100%);
	  background: -o-linear-gradient(top, <<xcolor>> 0%,<<xcolor>> 100%);
	  background: -ms-linear-gradient(top, <<xcolor>> 0%,<<xcolor>> 100%);
	  background: linear-gradient(top, <<xcolor>> 0%,<<xcolor>> 100%);
	  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='<<xcolor>>' , endColorstr='#547b00',GradientType=0 );
	  float: left;
	  width: <<thisform.width>>px;
	  z-index: 1000;
	}
	#main-nav ul {
	  font-family: 'Droid Sans', sans-serif;
	  font-size: .9em;
	  font-weight: bold;
	  list-style: none;
	}
	#main-nav ul li {
	  border-left: 1px solid <<xcolor>> ;
	  float: left;
	}
	#main-nav ul li:first-child {
	  border: none;
	}
	#main-nav ul li a {
	  color:indigo;  //#2b4001;
	  display: block;
	  padding: 5px;
	  position: relative;
	  width: 120px;  //139px;
	  text-decoration: none;
	  text-shadow: 0 1px 1px #9fc255;
	}
	#main-nav ul li a span.drop-down {
	  height: 7px;
	  position: absolute;
	  right: 3px;
	  top: 3px;
	  width: 10px;
	}
	#main-nav ul li:hover {
	  background: <<xcolor>> ;
	}
	/* First Level drop-down */
	#main-nav ul li ul {
	  display: none;
	}
	#main-nav ul li:hover ul {
	  background: rgba(0, 0, 0, .75);
	  display: block;
	  font-size: .9em;
	  font-weight: normal;
	  padding: 3px;
	  position: absolute;
	}
	#main-nav ul li ul li {
	  float: none;
	  display: block;
	  border-left: none;
	  position: relative;
	}
	#main-nav ul li ul li a {
	  width: 170px;
	  padding: 15px 10px;
	  border-top: solid 1px <<xcolor>> ;
	  color: #fff;
	  text-shadow: none;
	}
	#main-nav ul li ul li:first-child a {
	  border: none;
	}
	</style>

	</head>

	<body color=black  oncontextmenu="return false;"  scroll="no">
	<div id="wrapper">

	  <div class="container">
		  <div id="main-nav">
			<ul>
			  <li><a href="yvfp://1">Home</a></li>
			  <li><a href="#">Visual Foxpro<span class="drop-down"></a>
				<ul>
				  <li><a href="yvfp://2">Classes</a></li>
				  <li><a href="yvfp://3">Forms</a></li>
				  <li><a href="yvfp://4">Reports</a></li>
				  <li><a href="yvfp://41">Functions</a></li>
				  <li><a href="yvfp://42">Foxtools</a></li>
				  <li><a href="yvfp://43">Downloads</a></li>
				  <li><a href="yvfp://44">Help</a></li>
				</ul>
				</li>

			  <li><a href="#">Applications<span class="drop-down"></a>
				<ul>
				  <li><a href="yvfp://5">Mspaint</a></li>
				  <li><a href="yvfp://6">Notepad</a></li>
				  <li><a href="yvfp://7">Calculator</a></li>
				  <li><a href="yvfp://8">SnippingTool</a></li>
				  <li><a href="yvfp://9">WIn10 News</a></li>
				</ul>
				</li>

			 <li><a href="#">Fox Links<span class="drop-down"></a>
				<ul>
				  <li><a href="yvfp://10">Foxite</a></li>
				  <li><a href="yvfp://11">Atoutfox</a></li>
				  <li><a href="yvfp://111">Extreme</a></li>
				  <li><a href="yvfp://112">VFP imaging</a></li>
				  <li><a href="yvfp://113">Github</a></li>
				  <li><a href="yvfp://114">sandstorm36</a></li>
				  <li><a href="yvfp://115">praisachion.blogspot</a></li>
				  <li><a href="yvfp://116">Doug Henning</a></li>
				  <li><a href="yvfp://117">FOX wikis</a></li>
				  <li><a href="yvfp://118">Calvin Hsias</a></li>
				</ul>
				</li>

			  <li><a href="yvfp://12">News</a> </li>
			  <li><a href="yvfp://13">Sports</a></li>
			  <li><a href="yvfp://14">Travels</a></li>
			  <li><a href="#">Sciences<span class="drop-down"></a>
			  <ul>
			  <li><a href="yvfp://15">Mathematics</a></li>
			  <li><a href="yvfp://16">Astronomy</a></li>
			  <li><a href="yvfp://17">Physics</a></li>
			  <li><a href="yvfp://18">Programming</a></li>
			  </ul>
			  </li>

			  <li><a href="yvfp://19">Archeology</a></li>
			  <li><a href="yvfp://20">About</a></li>

			  <li><a href="#">System<span class="drop-down"></a>
			  <ul>
			  <li><a href="yvfp://21">Minimize</a></li>
			  <li><a href="yvfp://22">Maximize/restore</a></li>
			  <li><a href="yvfp://23">Change colors</a></li>
			  <li><a href="yvfp://24">Change Picture</a></li>
			   <li><a href="yvfp://25">Form titlebar on/off</a></li>
			  <li><a href="yvfp://26">Exit</a></li>
			  </ul>
			  </li>
			
			</ul>
		  </div>
		  <!--#main-nav-->

		  <img id="yimg" src="https://i.ytimg.com/vi/S1oX9L6e6_Q/maxresdefault.jpg" alt="" title="" width="<<thisform.width>>px"   height="thisform.height+40>>px"  />
	  </div>
	  <!--/.container-->
	</div>
	<!--/#wrapper-->
	</body>
	</html>
	ENDTEXT

	Local m.lcdest
	m.lcdest=Addbs(Sys(2023))+"ytemp.html"
	Strtofile(m.myvar,m.lcdest)
	Thisform.Refresh
	Thisform.olecontrol1.Navigate(m.lcdest)
Endproc

Procedure yapie
	Lparameters xURL
	If Empty(xURL)
		Return .F.
	Endi

	If Vartype(apie)="O"
		apie.Quit
	Endi

	Local apie
	apie=Newobject("internetexplorer.application")
	With apie
		.Navigate(xURL)
		.menubar=0
		.Toolbar=0
		.StatusBar=0
		.Width=1024
		.Height=800
		bringWindowToTop(.HWnd)
		.Visible=.T.
	Endwith
Endproc

Procedure Load
	Set Safe Off
	Declare Integer BringWindowToTop In user32 Integer
	Declare Integer SetWindowText In user32 INTEGER HWnd, String lpString
    Declare Integer ExtractIcon In shell32 Integer hInst, String  lpszExeFileName, Integer lpiIcon
    Declare Integer SendMessage In user32 Integer HWnd, Integer Msg, Integer wParam, Integer Lparam
	
	Close Data All

	Create Cursor ycolors (xcolor  c(7))
	Insert Into  ycolors Values("#7dad16")    &&green light
	Insert Into  ycolors Values("D2691E")     && CHOCOLATE
	Insert Into  ycolors Values("#006400")    && DARKGREEN
	Insert Into  ycolors Values("#DAA520")    && GOLDENROD
	Insert Into  ycolors Values("#FF7F50")    &&CORAL
	Insert Into  ycolors Values("#00FF00")    && LIME
    Insert Into  ycolors Values("#000080")    && NAVY
    Insert Into  ycolors Values("#B22222")    && FIREBRICK
    Insert Into  ycolors Values("#00008B")    && DARKBLUE
		
	Locate
Endproc

Procedure Init
	_Screen.WindowState=1
	Thisform.TitleBar=0
	Thisform.ybuild()
Endproc

Procedure Resize
	Thisform.ybuild()
Endproc

Procedure Destroy
	Clea Events
Endproc

Procedure olecontrol1.BeforeNavigate2
	*** Événement de contrôle ActiveX  ***
	Lparameters pdisp, url, Flags, targetframename, postdata, headers, Cancel
	Nodefault
	If Lower(Substr(Allt(url),1,7))== "yvfp://"
		Thisform.yurl=Allt(url)
		*messagebox(thisform.yurl)
		Thisform.yactions(Thisform.yurl)
		Cancel=.T. &&this prevent the browser to do the default action .
		Return .F.
	Endi
Endproc

Procedure olecontrol1.Init
	This.silent=.T.
Endproc

Procedure timer1.Timer
	Local m.myv
	Set Memowidth To 8192
	TEXT to m.myv noshow
	https://i.ytimg.com/vi/S1oX9L6e6_Q/maxresdefault.jpg
	https://media-cdn.tripadvisor.com/media/photo-s/02/6f/4d/c4/filename-tour-eiffel.jpg
	http://www.mulierchile.com/dubai-city-images/dubai-city-images-012.jpg
	http://dubaicitytours.net/wp-content/uploads/2013/12/Dubai-City-Tour.jpg
	http://www.almariahtravel.com/inc_img/57421394625421.jpg
	http://www.zagygroup.com/web-images/cheap-hotel-dubai-ZAGY-Group-Internet-Marketing.png
	https://www.tmb.ie/wp/wp-content/uploads/2017/01/dubai-travel-tips2.jpg
	https://www.dubaieveningsafari.com/files/2016/08/Burj-Khalifa.jpg
	http://glamazonsblog.com/wp-content/uploads/dubai-glamazons-blog.jpg
	http://www.almariahtravel.com/inc_img/57421394625505.jpg
	http://www.ahstatic.com/photos/6146_hodesti_00_p_1024x768.jpg
	https://www.traditours.com/sliders/jordanie_croisiere/data1/images/04dubai.jpg
	https://www.oneandonlyresorts.com/fr/-/media/oneandonly/the-palm/home-page/1440x900/the_palm_dubai_pool_beach_1440x900.jpg?v2
	https://d12dkjq56sjcos.cloudfront.net/pub/media/wysiwyg/dubai/06-route-detail/View-Of-Dubai-Marina-Big-Bus-Tours-01.17.jpg
	ENDTEXT

	Local N
	N=Int((Memlines(m.myv))*Rand( ) + 1)
	Thisform.olecontrol1.Document.getElementByID("yimg").src=Allt(Mline(m.myv,N))
Endproc

Procedure timer2.Timer
	With Thisform
		.Resize()
		.Width=.Width-1
		.Width=.Width+1
	Endwith
	This.Enabled=.F.
Endproc

Enddefine
*
*-- EndDefine: ytransp

*this receive a youtube video url (embed-can obtain by rightclick on any youtube playing video )
function yview()
lparameters url
declare integer BringWindowToTop in user32 integer

local m.myvar
text to m.myvar textmerge noshow
<iframe width=100% height=100% src="<<url>>" frameborder="0" gesture="media" allowfullscreen></iframe>
endtext

local apie
apie=newObject("internetexplorer.application")
with apie
.navigate("about:blank")
.menubar=0
.toolbar=0
.statusbar=0
.resizable=1
inke(1)
.document.open()
.document.write(m.myvar)
.document.close()
.document.body.style.background="#000000"    && black
bringWindowToTop(.hwnd)
.width=1100
.height=700
.visible=.t.
inke(1.5)
SetWindowText(.HWnd, "Playing video:  "+url)

**changing ie icon
*Constants for SendMessage second parameter
#Define WM_GETICON 0x7F
#Define WM_SETICON 0x80

*Constants for SendMessage third parameter
#Define ICON_SMALL 0
#Define ICON_BIG 1
lnHWND=apie.HWnd
lnIcon = ExtractIcon (0,Home(1)+"GRAPHICS\ICONS\misc\camera.ICO",0)
SendMessage(lnHWND, WM_SETICON, ICON_SMALL, lnIcon)
endwith
endfunc
