
set date long
IF VAL(OS(3)) < 6  
messagebox("this code is for os=Vista and above !",16+4096,"Error",1300)
  RETURN .F.
 ENDIF
publi yform
yform=newObject("ytitlebar")
yform.show
read events
retu
*
DEFINE CLASS ytitlebar AS form
Top = 6
Left = 97
Height = 430
Width = 781
Autocenter=.t.
ShowWindow = 2
Caption = "This is a new titlebar on top level form"
BackColor = RGB(146,136,116)
Themes = .f.
Name = "Form1"

ADD OBJECT ycont AS ycontainer WITH ;
    Top = 0, ;
	Left = 0, ;
	Width = 781, ;
	Height = 48, ;
	BackStyle = 1, ;
	BorderWidth = 0, ;
	SpecialEffect = 2, ;
	MousePointer = 15, ;
	BackColor = RGB(0,0,0), ;
	Name = "yCont"


ADD OBJECT grid1 AS grid WITH ;
	FontBold = .T., ;
	Anchor = 15, ;
	Height = 356, ;
	Left = 20, ;
	Top = 58, ;
	Width = 732, ;
	Name = "Grid1"

PROCEDURE Destroy
	clea events
ENDPROC


PROCEDURE Activate
	*only one way to activate the form troubleshoted with api !
	thisform.windowstate=1
	sleep(30)
	thisform.windowstate=0
ENDPROC


PROCEDURE Resize
	with thisform.ycont
	.left=0
	.top=0
	.width=.parent.width
	.height=48
	.zorder(0)
	endwith
	doevent
ENDPROC

PROCEDURE Init
	*Thisform.BackColor=Rgb(0,0,0)  &&mandatory to have unique color for titlebar+container even if windows themes changed
	Local lnHwnd, lcMargin, lnGlassLeft, lnGlassRight, lnGlassTop, lnGlassBottom

		m.lnHwnd = Thisform.HWnd
		m.lnGlassLeft =Thisform.ycont.Left
		m.lnGlassRight = Thisform.ycont.Top
		m.lnGlassTop = Thisform.ycont.Left+Thisform.ycont.Width
		m.lnGlassBottom =Thisform.ycont.Top+Thisform.ycont.Height

		m.lcMargin = BinToC(m.lnGlassLeft, '4RS') ;
			+ BinToC(m.lnGlassRight, '4RS') ;
			+ BinToC(m.lnGlassTop, '4RS') ;
			+ BinToC(m.lnGlassBottom, '4RS')
		Local lnResult
		lnResult=DwmExtendFrameIntoClientArea(m.lnHwnd, @m.lcMargin)
	thisform.resize
ENDPROC

PROCEDURE Load
    	Declare Long DwmExtendFrameIntoClientArea In dwmapi.Dll Long HWnd, String @ pMarInset
		Declare Integer ReleaseCapture In WIN32API
		Declare Integer SendMessage In WIN32API Integer, Integer, Integer, Integer
		Declare integer BringWindowToTop in user32 integer
		Declare integer Sleep in kernel32 integer
        DECLARE INTEGER MessageBox IN user32 As MessageBoxA;
    INTEGER hwnd,;
    STRING  lpText,;
	STRING  lpCaption,;
	INTEGER wType

		_Screen.WindowState=1
ENDPROC


PROCEDURE grid1.Init
	sele * from home(1)+"samples\data\customer" into cursor ycurs
	with this
	.recordsource="ycurs"
	.recordsourceType=2
	.deletemark=.f.
	.gridlines=0
	.themes=.f.
	.setall("backcolor",0,"header")
	.setall("forecolor",rgb(0,255,0),"header")
	.setall("fontbold",.t.,"header")
	.SetAll("DynamicBackColor","IIF(MOD(RECNO( ), 2)=0, RGB(205,155,200), RGB(140,255,100))", "Column")
	locate
	endwith
ENDPROC

ENDDEFINE
*
*-- EndDefine: ytitlebar

Define class ycontainer as container
ADD OBJECT image1 AS image WITH ;
	Picture = home(1)+"graphics\icons\win95\entirnet.ico", ;
	Stretch = 2, ;
	BackStyle = 0, ;
	Height = 41, ;
	Left = 3, ;
	MousePointer = 15, ;
	Top = 3, ;
	Width = 49, ;
	Name = "Image1"
    
ADD OBJECT ydate AS label with ;
    AutoSize = .T., ;
	FontSize = 8, ;
	Caption = "Label1", ;
	Height = 16, ;
	Left = 70, ;
	Top = 33 , ;
	Width = 34 , ;
	Name = "ydate"	

ADD OBJECT command1 AS commandbutton WITH ;
	Top = 7, ;
	Left = 245, ;
	Height = 25, ;
	Width = 72, ;
	FontBold = .T., ;
	FontSize = 10, ;
	Caption = "Menu", ;
	SpecialEffect = 2, ;
	BackColor = RGB(128,255,0), ;
	Name = "Command1"


ADD OBJECT combo1 AS combobox WITH ;
	FontBold = .T., ;
	RowSourceType = 1, ;
	RowSource = "1,2,3,4,5", ;
	Height = 25, ;
	Left = 329, ;
	SpecialEffect = 2, ;
	Top = 7, ;
	Width = 85, ;
	Name = "Combo1"


ADD OBJECT spinner1 AS spinner WITH ;
	FontBold = .T., ;
	Height = 24, ;
	Left = 516, ;
	SpecialEffect = 2, ;
	Top = 7, ;
	Width = 43, ;
	Name = "Spinner1"
	
ADD OBJECT optiongroup1 AS optiongroup WITH ;
	AutoSize = .T., ;
	ButtonCount = 1, ;
	BackStyle = 0, ;
	Value = 1, ;
	Height = 27, ;
	Left = 436, ;
	SpecialEffect = 0, ;
	Top = 7, ;
	Width = 72, ;
	Name = "Optiongroup1", ;
	Option1.FontBold = .T., ;
	Option1.BackStyle = 0, ;
	Option1.Caption = "Option1", ;
	Option1.Value = 1, ;
	Option1.Height = 17, ;
	Option1.Left = 5, ;
	Option1.Top = 5, ;
	Option1.Width = 62, ;
	Option1.AutoSize = .T., ;
	Option1.ForeColor = RGB(0,255,255), ;
	Option1.Name = "Option1"

ADD OBJECT text1 AS textbox WITH ;
	FontBold = .T., ;
	FontSize = 10, ;
	BackStyle = 0, ;
	Enabled = .F., ;
	Height = 25, ;
	Left = 103, ;
	Top = 7, ;
	Width = 70, ;
	ForeColor = RGB(0,255,0), ;
	BackColor = RGB(0,0,0), ;
	DisabledBackColor = RGB(0,0,0), ;
	DisabledForeColor = RGB(0,255,0), ;
	Name = "Text1"

ADD OBJECT timer1 AS timer WITH ;
	Top = 9, ;
	Left = 81, ;
	Height = 23, ;
	Width = 23, ;
	Interval = 1000, ;
	Name = "Timer1"

ADD OBJECT list1 AS listbox WITH ;
	FontBold = .T., ;
	FontSize = 8, ;
	RowSourceType = 2, ;
	Height = 36, ;
	Left = 564, ;
	Top = 3, ;
	Width = 192, ;
	Name = "List1"
    
PROCEDURE ydate.Init
    	with this
		.autosize=.t.
		.backstyle=0
		.forecolor=255
		.fontname="segoe script"
		.fontbold=.t.
		.caption=dtoc(date())
		.anchor=768
		endwith
ENDPROC	    
	
PROCEDURE MouseDown
	LPARAMETERS nButton, nShift, nXCoord, nYCoord
	lnHandle = THISFORM.HWND
	param1 = 274
	param2 = 0xF012
	DECLARE INTEGER ReleaseCapture IN WIN32API
	DECLARE INTEGER SendMessage IN WIN32API INTEGER, INTEGER, INTEGER, INTEGER
	bb=ReleaseCapture()
	bb=SendMessage(lnHandle, param1, param2,0)
ENDPROC

PROCEDURE image1.Click
	text to m.myvar noshow
this is a new vfp titlebar available on top level form (only).
-one solution is to cut the form titlebar and subclass it (by a container...)
thats was done in http://yousfi.over-blog.com/2015/02/subclassing-the-form-titlebar-other-stuffs.html

-another solution is to traverse the native titlebar and add controls on it.its not done with vfp9 at
this time

-And this is an hybrid solution with native titlebar+an extension as container.
its an extension to actual form titlebar painted with API DwmExtendFrameIntoClientArea
(initially destined to vista aero-Infortunatly this aero effect  dont works in windows 10).
can build a container under the form titlebar and fill it with vfp controls wanted(each control with PEM...)
it preserves the native window titlebar and extends it to other area and other functionalities.

Added API to move the form by mousedown on this container (same as titlebar).
problems: when show or when another window is activated  the form is disabled (its not a normal behavior in win10? miss some message?).at start i activated it with firing windowstate :(1,0)
The API applies also some transparency on the form & embeded controls.
the form.BackColor must be black Rgb(0,0,0),mandatory to have unique color for titlebar+container even if windows themes changed (see images below when win themes change)

endtext

#define MB_ICONINFORMATION 0x00000040
#define MB_OK 0x00000000
#define MB_APPLMODAL 0x00000000
#define  MB_DEFBUTTON1 0x00000000

MessageBoxA(thisform.hwnd,m.myvar,"Summary Help",MB_APPLMODAL+MB_OK +MB_ICONINFORMATION +MB_DEFBUTTON1 )

ENDPROC

PROCEDURE IMAGE1.MOUSEENTER
LPARAMETERS nButton, nShift, nXCoord, nYCoord
with this
.left=.left-2
.TOP=.TOP-2
endwith
endproc

PROCEDURE IMAGE1.MOUSELEAVE
LPARAMETERS nButton, nShift, nXCoord, nYCoord
with this
.left=.left+2
.top=.top+2
endwith
endproc

PROCEDURE command1.Click
	DEFINE POPUP raccourci SHORTCUT RELATIVE FROM MROW(),MCOL()
	DEFINE BAR _med_slcta OF raccourci PROMPT "Sélectionner tout" ;
		KEY CTRL+A, "Ctrl+A" ;
		PICTRES _med_slcta ;
		MESSAGE "Sélectionne tout le texte ou tous les éléments de la fenêtre active"
	DEFINE BAR _med_paste OF raccourci PROMPT "Coller" ;
		KEY CTRL+V, "Ctrl+V" ;
		PICTRES _med_paste ;
		MESSAGE "Place le contenu du Presse-papiers au point d'insertion"
	DEFINE BAR _med_copy OF raccourci PROMPT "Copier" ;
		KEY CTRL+C, "Ctrl+C" ;
		PICTRES _med_copy ;
		MESSAGE "Copie la sélection et la place dans le Presse-papiers"
	DEFINE BAR _med_cut OF raccourci PROMPT "Couper" ;
		KEY CTRL+X, "Ctrl+X" ;
		PICTRES _med_cut ;
		MESSAGE "Enlève la sélection et la place dans le Presse-papiers"
	DEFINE BAR _med_redo OF raccourci PROMPT "Rétablir" ;
		KEY CTRL+R, "Ctrl+R" ;
		PICTRES _med_redo
	DEFINE BAR _med_undo OF raccourci PROMPT "Annuler" ;
		KEY CTRL+Z, "Ctrl+Z" ;
		PICTRES _med_undo ;
		MESSAGE "Annule la dernière modification"
	ACTIVATE POPUP raccourci
ENDPROC

PROCEDURE combo1.Init
	this.listindex=1
ENDPROC

PROCEDURE text1.Init
	this.value=time()
ENDPROC

PROCEDURE timer1.Timer
	this.parent.text1.value=time()
ENDPROC

PROCEDURE list1.Init
	Sele company From Home(1)+"samples\data\customer" Into Cursor ycurs

	With This
	   .RowSource = "ycurs.company"
	   .RowSourceType=2
	   .Visible=.T.
	   .SelectedItemBackColor=Rgb(70,60,50)
	   .SelectedItemForeColor=Rgb(10,191,160)
	   .SpecialEffect=1
	   .FontSize=8
	   .ItemBackColor=Rgb(40,40,40)
	   .ItemForeColor=Rgb(255,204,153)
	   .BorderColor=Rgb(235,132,0)
	   .ItemTips=.T.
	    .MousePointer=15
  Endwith
ENDPROC
	
	
endDefine		

