                        

*Updated on tuesday 6 october 2015; 23:11:20
*adding a main menu on the top lebvel form  and coloring the menu bar
Publi yform
yform=Newobject("ypageFrame")
yform.Show
Read Events
Retu
*
Define Class ypageframe As Form
    BorderStyle = 0
	Top = 20
	Left = 0
	Height =200
	Width = 1024
	ShowWindow = 2
	Caption = "yPageFrame"
	TitleBar = 1
	BackColor = Rgb(0,0,0)
	ytooltip = .F.
	Name = "Form1"

	Add Object pageframe1 As PageFrame With ;
		ErasePage = .T., ;
		PageCount = 4, ;
		TabStretch = 0, ;
		Anchor = 768, ;
		Top = 30, ;
		Left = 0, ;
		Width = 1022, ;
		Height = 140, ;
		Themes = .F., ;
		Name = "Pageframe1", ;
		Page1.FontBold = .T., ;
		Page1.FontItalic = .T., ;
		Page1.FontSize = 10, ;
		Page1.Caption = "Page1", ;
		Page1.BackColor = Rgb(0,0,0), ;
		Page1.ForeColor = Rgb(0,0,255), ;
		Page1.MousePointer = 15, ;
		Page1.Name = "Page1", ;
		Page2.FontBold = .T., ;
		Page2.Caption = "Page2", ;
		Page2.Name = "Page2", ;
		Page3.FontBold = .T., ;
		Page3.Caption = "Page3", ;
		Page3.Name = "Page3", ;
		Page4.FontBold = .T., ;
		Page4.Caption = "Page4", ;
		Page4.BackColor = Rgb(0,0,0), ;
		Page4.ForeColor = Rgb(255,255,255), ;
		Page4.Name = "Page4"


	Procedure ymenu
	Lparameters oFormRef, getMenuName, lUniquePopups, parm4, parm5, parm6, parm7, parm8, parm9
	Local cMenuName, nTotPops, a_menupops, cTypeParm2, cSaveFormName
	If Type("m.oFormRef") # "O" Or ;
			LOWER(m.oFormRef.BaseClass) # 'form' Or ;
			m.oFormRef.ShowWindow # 2
		Messagebox([This menu can only be called from a Top-Level form. Ensure that your form's ShowWindow property is set to 2. Read the header section of the menu's MPR file for more details.])
		Return
	Endif
	m.cTypeParm2 = Type("m.getMenuName")
	m.cMenuName = Sys(2015)
	m.cSaveFormName = m.oFormRef.Name
	If m.cTypeParm2 = "C" Or (m.cTypeParm2 = "L" And m.getMenuName)
		m.oFormRef.Name = m.cMenuName
	Endif
	If m.cTypeParm2 = "C" And !Empty(m.getMenuName)
		m.cMenuName = m.getMenuName
	Endif
	Dimension a_menupops[4]
	If Type("m.lUniquePopups")="L" And m.lUniquePopups
		For nTotPops = 1 To Alen(a_menupops)
			a_menupops[m.nTotPops]= Sys(2015)
		Endfor
	Else
		a_menupops[1]="foods"
		a_menupops[2]="buffalowin"
		a_menupops[3]="animals"
		a_menupops[4]="sports"

	Endif


	Define Menu (m.cMenuName) In (m.oFormRef.Name) Bar        &&at line ...dont work with drawmenu API !

	Define Pad _08i0obyaa Of (m.cMenuName) Prompt "\<Foods" Color Scheme 3 ;
		KEY Alt+F, ""
	Define Pad _08i0obyb4 Of (m.cMenuName) Prompt "\<Animals" Color Scheme 3 ;
		KEY Alt+A, ""
	Define Pad _08i0obyb5 Of (m.cMenuName) Prompt "\<Sports" Color Scheme 3 ;
		KEY Alt+S, ""
	Define Pad _4go1dd43k Of (m.cMenuName) Prompt "Reduce" Color Scheme 3 ;
		KEY Alt+R, ""
	Define Pad _4go1dd43l Of (m.cMenuName) Prompt "Quit" Color Scheme 3 ;
		KEY Alt+Q, ""

	On Pad _08i0obyaa Of (m.cMenuName) Activate Popup (a_menupops[1])
	On Pad _08i0obyb4 Of (m.cMenuName) Activate Popup (a_menupops[3])
	On Pad _08i0obyb5 Of (m.cMenuName) Activate Popup (a_menupops[4])
	On Selection Pad _4go1dd43k Of (m.cMenuName) _Screen.ActiveForm.WindowState=1
	On Selection Pad _4go1dd43l Of (m.cMenuName) _Screen.ActiveForm.Release


	Define Popup (a_menupops[1]) Margin Relative Shadow Color Scheme 4
	Define Bar 1 Of (a_menupops[1]) Prompt "Bananas";
		FONT "Courier New", 8 Style "BI"  Color G/W*, B/W*,,,,W+/GR Picture  Home(1)+"GRAPHICS\ICONS\MISC\MISC15.ICO"

	Define Bar 2 Of (a_menupops[1]) Prompt "Salsa";
		FONT "Courier New", 8 Style "BI"  Color G/W*, B/W*,,,,W+/GR Picture  Home(1)+"GRAPHICS\ICONS\MISC\MISC14.ICO"

	Define Bar 3 Of (a_menupops[1]) Prompt "Buffalo WIngs";
		FONT "Courier New", 8 Style "BI"  Color G/W*, B/W*,,,,W+/GR Picture  Home(1)+"GRAPHICS\ICONS\MISC\MISC04.ICO"

	Define Bar 4 Of (a_menupops[1]) Prompt "\-";
		FONT "Courier New", 8 Style "BI"  Color G/W*, B/W*,,,,W+/GR Picture  Home(1)+"GRAPHICS\ICONS\MISC\MISC10.ICO"
	Define Bar 5 Of (a_menupops[1]) Prompt "Pizza";
		FONT "Courier New", 8 Style "BI"  Color G/W*, B/W*,,,,W+/GR Picture  Home(1)+"GRAPHICS\ICONS\MISC\MISC12.ICO"
	Define Bar 6 Of (a_menupops[1]) Prompt "Espresso";
		FONT "Courier New", 8 Style "BI"  Color G/W*, B/W*,,,,W+/GR Picture  Home(1)+"GRAPHICS\ICONS\MISC\MISC04.ICO"
	On Bar 3 Of (a_menupops[1]) Activate Popup (a_menupops[2])

	Define Popup (a_menupops[2]) Margin Relative Shadow Color Scheme 4
	Define Bar 1 Of (a_menupops[2]) Prompt "Hot";
		FONT "Courier New", 8 Style "BI"  Color G/W*, B/W*,,,,W+/GR Picture  Home(1)+"GRAPHICS\ICONS\MISC\MISC02.ICO"
	Define Bar 2 Of (a_menupops[2]) Prompt "Medium";
		FONT "Courier New", 8 Style "BI"  Color G/W*, B/W*,,,,W+/GR Picture  Home(1)+"GRAPHICS\ICONS\MISC\MISC03.ICO"
	Define Bar 3 Of (a_menupops[2]) Prompt "Mild";
		FONT "Courier New", 8 Style "BI"  Color G/W*, B/W*,,,,W+/GR Picture  Home(1)+"GRAPHICS\ICONS\MISC\MISC05.ICO"
	Define Bar 4 Of (a_menupops[2]) Prompt "Garlic";
		FONT "Courier New", 8 Style "BI"  Color G/W*, B/W*,,,,W+/GR Picture  Home(1)+"GRAPHICS\ICONS\MISC\MISC07.ICO"

	Define Popup (a_menupops[3]) Margin Relative Shadow Color Scheme 4
	Define Bar 1 Of (a_menupops[3]) Prompt "Dogs";
		FONT "Courier New", 8 Style "BI"  Color G/W*, B/W*,,,,W+/GR Picture  Home(1)+"GRAPHICS\ICONS\MISC\MISC01.ICO"
	Define Bar 2 Of (a_menupops[3]) Prompt "Cats";
		FONT "Courier New", 8 Style "BI"  Color G/W*, B/W*,,,,W+/GR Picture  Home(1)+"GRAPHICS\ICONS\MISC\MISC02.ICO"
	Define Bar 3 Of (a_menupops[3]) Prompt "Elephants";
		FONT "Courier New", 8 Style "BI"  Color G/W*, B/W*,,,,W+/GR Picture  Home(1)+"GRAPHICS\ICONS\MISC\MISC11.ICO"
	Define Bar 4 Of (a_menupops[3]) Prompt "Pigs";
		FONT "Courier New", 8 Style "BI"  Color G/W*, B/W*,,,,W+/GR Picture  Home(1)+"GRAPHICS\ICONS\MISC\MISC06.ICO"

	Define Popup (a_menupops[4]) Margin Relative Shadow Color Scheme 4
	Define Bar 1 Of (a_menupops[4]) Prompt "Football";
		FONT "Courier New", 8 Style "BI"  Color G/W*, B/W*,,,,W+/GR Picture  Home(1)+"GRAPHICS\ICONS\MISC\MISC04.ICO"
	Define Bar 2 Of (a_menupops[4]) Prompt "Rugby";
		FONT "Courier New", 8 Style "BI"  Color G/W*, B/W*,,,,W+/GR Picture  Home(1)+"GRAPHICS\ICONS\MISC\MISC13.ICO"
	Define Bar 3 Of (a_menupops[4]) Prompt "Bowling";
		FONT "Courier New", 8 Style "BI"  Color G/W*, B/W*,,,,W+/GR Picture  Home(1)+"GRAPHICS\ICONS\MISC\MISC11.ICO"

	Activate Menu (m.cMenuName) Nowait

	If m.cTypeParm2 = "C"
		m.getMenuName = m.cMenuName
		m.oFormRef.Name = m.cSaveFormName
	Endif
	********************************************************
	Endproc

	Procedure my
	Lparameters nButton, nShift, nXCoord, nYCoord
	*--- aevent create an array laEvents
	Aevents( myArray, 0)
	*--- reference the calling object
	loObject = myArray[1]
	&&make actions to do here
	Do Case
	Case Lower(loObject.Name)=="command1"
		With Thisform.pageframe1
			.Tabs=Iif(.Tabs=.T.,.F.,.T.)
			If .Tabs=.F.
				Thisform.Height=Thisform.Height-20
			Else
				Thisform.Height=Thisform.Height+20
			Endi
			.Refresh
		Endwith

	Case Lower(loObject.Name)=="image9"      &&and lower(loObject.parent.name)=="page1"
		Thisform. Release

	Case  Lower(loObject.Name)=="image2"  And Lower(loObject.Parent.Name)=="page1"
		With Thisform.pageframe1
			.TabStyle=Iif(.TabStyle=0,1,0)
			.Refresh
		Endwith
	Case  Lower(loObject.Name)=="image3"  And Lower(loObject.Parent.Name)=="page1"
		Thisform.ympr()
	Case  Lower(loObject.Name)=="image4"  And Lower(loObject.Parent.Name)=="page1"
		Run/N notepad.Exe

	Case  Lower(loObject.Name)=="ybk"  And Lower(loObject.Parent.Name)=="page1"
		DoDefault()  &&execute the class code

		*........put codes of controls here....
	Otherwise
		Messagebox("this is an item menu as ["+loObject.Parent.Name+"  "+loObject.Name+"].....can populate it to do something...",0+32+4096,"",1000)
	Endcase
	Endproc

	Procedure my1
	Lparameters nButton, nShift, nXCoord, nYCoord
	*--- aevent create an array laEvents
	Aevents( myArray, 0)
	*--- reference the calling object
	loObject = myArray[1]

	With loObject
		.Left=.Left+2
		.Top=.Top+2
	Endwith
	Local m.x
	m.x=Thisform.pageframe1.ActivePage
	Thisform.pageframe1.Pages(m.x).label1.Caption=loObject.ToolTipText
	Endproc

	Procedure my2
	Lparameters nButton, nShift, nXCoord, nYCoord
	*--- aevent create an array laEvents
	Aevents( myArray, 0)
	*--- reference the calling object
	loObject = myArray[1]

	With loObject
		.Left=.Left-2
		.Top=.Top-2
	Endwith
	Local m.x
	m.x=Thisform.pageframe1.ActivePage
	Thisform.pageframe1.Pages(m.x).label1.Caption=""
	Endproc

	Procedure Load
	Declare Integer Sleep In kernel32 Integer

	Declare Integer GetWindowLong In user32;
		INTEGER HWnd, Integer nIndex
	Declare Integer SetWindowLong In user32;
		INTEGER HWnd, Integer nIndex, Integer dwNewLong
	Declare Integer SetLayeredWindowAttributes In user32;
		INTEGER HWnd, Integer crKey,;
		SHORT bAlpha, Integer dwFlags
	Declare Integer ReleaseCapture In WIN32API
	Declare Integer SendMessage In WIN32API Integer, Integer, Integer, Integer
	Declare Integer GetMenu In user32 Integer HWnd
	Declare Integer CreateSolidBrush In gdi32 Integer crColor
	Declare Integer DrawMenuBar In user32 Integer HWnd
	Declare Integer SetMenuInfo In user32 Integer hmenu, String @mi
	Endproc

	Procedure Init
	_Screen.WindowState=1
	Set Safe Off
	Set Debug Off
	Set Talk Off

	With Thisform
		.BackColor=0
		.Top=1
		.Height=150
		.Width=Sysmetric(1)-1
		.AlwaysOnTop=.T.
		.ShowTips=.F.  &&label choosed instead
		.TitleBar=0
		.ymenu(Thisform,.T.)
	Endwith
	***********************
	*hppse a lighten color form color
	tnlevel=0.65
	m.tncolor=Thisform.BackColor
	Local lnRed,lnGreen,lnBlue
	lnRed	= Bitrshift(Bitand(m.tncolor, 0x0000FF),0)
	lnGreen	= Bitrshift(Bitand(m.tncolor, 0x00FF00),8)
	lnBlue	= Bitrshift(Bitand(m.tncolor, 0xFF0000),16)

	*lighten color :
	m.x='RGB('+Trans( lnRed     +(255 - lnRed  )*tnlevel,"999")+','+;
		trans( lnGreen +(255 - lnGreen)*tnlevel,"999")+ ','+ ;
		trans( lnBlue  +(255 - lnBlue )*tnlevel,"999")+')'

	Thisform.ymenu(Thisform,.T.)
	Thisform.ycolorM(Eval(m.x),Thisform.HWnd)
	*****************************
	With Thisform.pageframe1.Page1
		.AddObject("command1","commandbutton")
		With .command1
			.Top = 32
			.Left = 17
			.Height = 37
			.Width = 52
			.FontBold = .T.
			.FontSize = 11
			.Caption = "Tabs"
			.ToolTipText = "This show or hide the pageframe tabs"
			.ForeColor = Rgb(255,0,0)
			.BackColor = Rgb(0,255,0)
			.Name = "Command1"
			.Visible=.T.
		Endwith

		.AddObject("ybk","ycombo")
		With .ybk
			.Top = 8
			.Left = 7
			.Height = 22
			.Width = 80
			.FontBold = .T.
			.FontSize = 9
			.MousePointer=15
			.ToolTipText = "Choose the pages color theme"
			.ForeColor = Rgb(255,0,0)
			.BackColor = Rgb(255,255,0)
			.Name = "ybk"
			.Visible=.T.
		Endwith

		.AddObject("image2","image")
		With .image2
			.Picture = "e:\____ymedia\yicones\___yicones_png\1_island-12__.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 87
			.MousePointer = 15
			.ToolTipText = "Arrange pageframe tabs"
			.Top = 6
			.Width = 85
			.Name = "Image2"
			.Visible=.T.
		Endwith

		.AddObject("image3","image")
		With .image3
			.Picture = "e:\____ymedia\yicones\___yicones_png\1 - macbook pro.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 177
			.Top = 6
			.Width = 85
			.Name = "Image3"
			.ToolTipText="Menu mpr prototype only"
			.Visible=.T.
		Endwith

		.AddObject("image4","image")
		With .image4
			.Picture = "e:\____ymedia\yicones\___yicones_png\20.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 268
			.Top = 6
			.Width = 85
			.Name = "Image4"
			.ToolTipText="notepad"
			.Visible=.T.
		Endwith

		.AddObject("image5","image")
		With .image5
			.Picture = "e:\____ymedia\yicones\___yicones_png\19834-bubka-acrobat.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 360
			.Top = 5
			.Width = 85
			.Name = "Image5"
			.Visible=.T.
		Endwith

		.AddObject("image6" ,"image")
		With .image6
			.Picture = "e:\____ymedia\yicones\___yicones_png\adobe_pdf_reader.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 455
			.Top = 3
			.Width = 85
			.Name = "Image6"
			.Visible=.T.
		Endwith

		.AddObject("image1","image")
		With .image1
			.Picture = "e:\____ymedia\yicones\___yicones_png\emblem-library.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 549
			.MousePointer = 15
			.Top = 7
			.Width = 85
			.Name = "Image1"
			.Visible=.T.
		Endwith

		.AddObject("image7","image")
		With .image7
			.Picture = "e:\____ymedia\yicones\___yicones_png\digikamimageplugins.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 639
			.Top = 7
			.Width = 85
			.Name = "Image7"
			. Visible=.T.
		Endwith

		.AddObject("image8","image")
		With .image8
			.Picture = "e:\____ymedia\yicones\___yicones_png\calculator1.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 730
			.Top = 7
			.Width = 85
			.Name = "Image8"
			.Visible=.T.
		Endwith

		.AddObject("image10","image")
		With .image10
			.Picture = "e:\____ymedia\yicones\___yicones_png\adobe_pdf_reader.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 815
			.Top = 6
			.Width = 85
			.Name = "Image10"
			.Visible=.T.
		Endwith

		.AddObject("image9","image")
		With .image9
			.Picture = "e:\____ymedia\yicones\___yicones_png\button_cancel.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 900
			.Top = 4
			.Width = 85
			.ToolTipText = "Close"
			.Name = "Image9"
			.Visible=.T.
		Endwith
		.AddObject("label1","label")
		With .label1
			.FontBold = .T.
			.FontSize = 12
			.Alignment = 2
			.BackStyle = 0
			.Caption = ""
			.Height = 25
			.Left = 115
			.Top = 86
			.Width = 552
			.Anchor=768
			.ForeColor = Rgb(255,255,255)
			.Name= "Label1"
			.Visible=.T.
		Endwith
	Endwith
	***************************
	With Thisform.pageframe1.Page2
		.AddObject("command1","commandbutton")
		With .command1
			.Top = 19
			.Left = 17
			.Height = 37
			.Width = 52
			.FontBold = .T.
			.FontSize = 11
			.Caption = "Tabs"
			.ToolTipText = "This show or hide the pageframe tabs"
			.ForeColor = Rgb(255,0,0)
			.BackColor = Rgb(0,255,0)
			.Name = "Command1"
			.Visible=.T.
		Endwith

		.AddObject("image2","image")
		With .image2
			.Picture = "e:\____ymedia\yicones\___yicones_png\03.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 85
			.MousePointer = 15
			.Top = 10
			.Width = 85
			.Name = "Image2"
			.Visible=.T.
		Endwith

		.AddObject("image3","image")
		With .image3
			.Picture = "e:\____ymedia\yicones\___yicones_png\a_young_leo.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 175
			.Top = 10
			.Width = 85
			.Name = "Image3"
			.Visible=.T.
		Endwith
		.AddObject("image4","image")
		With .image4
			.Picture = "e:\____ymedia\yicones\___yicones_png\applications-graphics.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 266
			.Top = 10
			.Width = 85
			.Name = "Image4"
			.Visible=.T.
		Endwith
		.AddObject("image5","image")
		With .image5
			.Picture = "e:\____ymedia\yicones\___yicones_png\applications-office.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 358
			.Top = 9
			.Width = 85
			.Name = "Image5"
			.Visible=.T.
		Endwith

		.AddObject("image6","image")
		With .image6
			.Picture = "e:\____ymedia\yicones\___yicones_png\babelfish.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 453
			.Top = 7
			.Width = 85
			.Name = "Image6"
			.Visible=.T.
		Endwith
		.AddObject("image1","image")
		With .image1
			.Picture = "e:\____ymedia\yicones\___yicones_png\coconut_palm_zoom_touch.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 548
			.MousePointer = 15
			.Top = 12
			.Width = 85
			.Name = "Image1"
			.Visible=.T.
		Endwith

		.AddObject("image7","image")
		With .image7
			.Picture = "e:\____ymedia\yicones\___yicones_png\classic.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 638
			.Top = 12
			.Width = 85
			.Name = "Image7"
			.Visible=.T.
		Endwith

		.AddObject("image8","image")
		With .image8
			.Picture = "e:\____ymedia\yicones\___yicones_png\briefcase__.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 729
			.Top = 12
			.Width = 85
			.Name = "Image8"
			.Visible=.T.
		Endwith

		.AddObject("image10","image")
		With .image10
			.Picture = "e:\____ymedia\yicones\___yicones_png\adobe_pdf_reader.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 815
			.Top = 6
			.Width = 85
			.Name = "Image10"
			.Visible=.T.
		Endwith
		.AddObject("image9","image")
		With .image9
			.Picture = "e:\____ymedia\yicones\___yicones_png\button_cancel.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 900
			.Top = 4
			.Width = 85
			.ToolTipText = "Close"
			.Name = "Image9"
			.Visible=.T.
		Endwith

		.AddObject("label1","label")
		With .label1
			.FontBold = .T.
			.FontSize = 12
			.Alignment = 2
			.BackStyle = 0
			.Caption = ""
			.Height = 25
			.Left = 115
			.Top = 86
			.Width = 552
			.Anchor=768
			.ForeColor = Rgb(255,255,255)
			.Name= "Label1"
			.Visible=.T.
		Endwith
	Endwith

	************************
	With Thisform.pageframe1.Page3
		.AddObject("command1","commandbutton")
		With .command1
			.Top = 28
			.Left = 12
			.Height = 37
			.Width = 52
			.FontBold = .T.
			.FontSize = 11
			.Caption = "Tabs"
			.ToolTipText = "This show or hide the pageframe tabs"
			.ForeColor = Rgb(255,0,0)
			.BackColor = Rgb(0,255,0)
			.Name = "Command1"
			.Visible=.T.
		Endwith

		.AddObject("image2","image")
		With .image2
			.Picture = "e:\____ymedia\yicones\___yicones_png\beryl-manager.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 80
			.MousePointer = 15
			.Top = 7
			.Width = 85
			.Name = "Image2"
			.Visible=.T.
		Endwith


		.AddObject("image3","image")
		With .image3
			.Picture = "e:\____ymedia\yicones\___yicones_png\atom-128.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 170
			.Top = 7
			.Width = 85
			.Name = "Image3"
			.Visible=.T.
		Endwith

		.AddObject('image4','image')
		With .image4
			.Picture = "e:\____ymedia\yicones\___yicones_png\check.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 261
			.Top = 7
			.Width = 85
			.Name = "Image4"
			.Visible=.T.
		Endwith

		.AddObject('image5','image')
		With .image5
			.Picture = "e:\____ymedia\yicones\___yicones_png\art.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 353
			.Top = 6
			.Width = 85
			.Name = "Image5"
			.Visible=.T.
		Endwith

		.AddObject("image6","image")
		With .image6
			.Picture = "e:\____ymedia\yicones\___yicones_png\books.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 448
			.Top = 4
			.Width = 85
			.Name = "Image6"
			.Visible=.T.
		Endwith

		.AddObject('image1','image')
		With .image1
			.Picture = "e:\____ymedia\yicones\___yicones_png\photo.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 538
			.MousePointer = 15
			.Top = 10
			.Anchor=768
			.Width = 85
			.Name = "Image1"
			.Visible=.T.
		Endwith

		.AddObject('image7','image')
		With .image7
			.Picture = "e:\____ymedia\yicones\___yicones_png\h_-_algeria.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 628
			.Top = 10
			.Width = 85
			.Name = "Image7"
			.Visible=.T.
		Endwith

		.AddObject("image8","image")
		With .image8
			.Picture = "e:\____ymedia\yicones\___yicones_png\clock.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 719
			.Top = 10
			.Width = 85
			.Name = "Image8"
			.Visible=.T.
		Endwith

		.AddObject("image9","image")
		With .image9
			.Picture = "e:\____ymedia\yicones\___yicones_png\button_cancel.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 900
			.Top = 4
			.Width = 85
			.ToolTipText = "Close"
			.Name = "Image9"
			.Visible=.T.
		Endwith

		.AddObject("label1","label")
		With .label1
			.FontBold = .T.
			.FontSize = 12
			.Alignment = 2
			.BackStyle = 0
			.Caption = ""
			.Height = 25
			.Left = 115
			.Top = 86
			.Width = 552
			.Anchor=768
			.ForeColor = Rgb(255,255,255)
			.Name= "Label1"
			.Visible=.T.
		Endwith
	Endwith
	***********************
	With Thisform.pageframe1.Page4

		.AddObject("command1","commandbutton")
		With .command1
			.Top = 22
			.Left = 10
			.Height = 37
			.Width = 52
			.FontBold = .T.
			.FontSize = 11
			.Caption = "Tabs"
			.ToolTipText = "This show or hide the pageframe tabs"
			.ForeColor = Rgb(255,0,0)
			.BackColor = Rgb(0,255,0)
			.Name = "command1"
			.Visible=.T.
		Endwith

		.AddObject("image2","image")
		With .image2
			.Picture = "e:\____ymedia\yicones\___yicones_png\bug.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 80
			.MousePointer = 15
			.Top = 6
			.Width = 85
			.Name = "Image2"
			.Visible=.T.
		Endwith

		.AddObject("image3","image")
		With .image3
			.Picture = "e:\____ymedia\yicones\___yicones_png\briefcase.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 170
			.Top = 6
			.Width = 85
			.Name = "Image3"
			.Visible=.T.
		Endwith

		.AddObject("image4","image")
		With .image4
			.Picture = "e:\____ymedia\yicones\___yicones_png\bonobo-navigateur-icone-6807-96.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 261
			.Top = 6
			.Width = 85
			.Name = "Image4"
			.Visible=.T.
		Endwith

		.AddObject("image5","image")
		With .image5
			.Picture = "e:\____ymedia\yicones\___yicones_png\circle_green.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 353
			.Top = 5
			.Width = 85
			.Name = "Image5"
			.Visible=.T.
		Endwith

		.AddObject("image6","image")
		With .image6
			.Picture = "e:\____ymedia\yicones\___yicones_png\notepad++.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 448
			.Top = 3
			.Width = 85
			.Name = "Image6"
			.Visible=.T.
		Endwith


		.AddObject('image1','image')
		With .image1
			.Picture = "e:\____ymedia\yicones\___yicones_png\free_mp3_converter.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 544
			.MousePointer = 15
			.Top = 8
			.Width = 85
			.Name = "Image1"
			.Visible=.T.
		Endwith

		.AddObject("image7","image")
		With .image7
			.Picture = "e:\____ymedia\yicones\___yicones_png\library.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 634
			.Top = 8
			.Width = 85
			.Name = "Image7"
			.Visible=.T.
		Endwith

		.AddObject("image9","image")
		With .image9
			.Picture = "e:\____ymedia\yicones\___yicones_png\button_cancel.png"
			.Stretch = 2
			.BorderStyle = 1
			.Height = 85
			.Left = 830
			.Top = 9
			.Width = 85
			.ToolTipText = "Close"
			.Name = "Image9"
			.Visible=.T.
		Endwith

		.AddObject("label1","label")
		With .label1
			.FontBold = .T.
			.FontSize = 12
			.Alignment = 2
			.BackStyle = 0
			.Caption = ""
			.Height = 25
			.Left = 115
			.Top = 86
			.Width = 552
			.Anchor=768
			.ForeColor = Rgb(255,255,255)
			.Name= "Label1"
			.Visible=.T.
		Endwith
	Endwith


	Thisform.TitleBar=0
	Thisform.BorderStyle=0
	#Define GWL_EXSTYLE -20
	#Define WS_EX_LAYERED 0x80000
	#Define LWA_COLORKEY 1
	#Define LWA_ALPHA 2
	Local nExStyle, nRgb, nAlpha, nFlags
	nExStyle = GetWindowLong(Thisform.HWnd, GWL_EXSTYLE)
	nExStyle = Bitor(nExStyle, WS_EX_LAYERED)
	= SetWindowLong(Thisform.HWnd, GWL_EXSTYLE, nExStyle)
	= SetLayeredWindowAttributes(Thisform.HWnd, 0,250,LWA_ALPHA)  && 98% opaque form

	With Thisform.pageframe1
		.Height=Thisform.Height-30
		.Top=1

		For j=1 To .PageCount
			With .Pages(j)

				.SetAll("borderstyle",0,"image")
				.SetAll("mousepointer",15,"commandbutton")
				.SetAll("mousepointer",15,"image")
				.SetAll("width",60,"image")
				.SetAll("height",60,"image")
				.SetAll("stretch",2,"image")
				.SetAll("top",8,"image")
				.SetAll("borderstyle",0,"image")
				.SetAll('left',0,"label")
				.label1.Top=Thisform.Height-80
				.BackColor=0
				.ForeColor=Rgb(255,255,255)
				.FontBold=.T.
				For i=1 To .ControlCount
					If Empty(.Controls(i).ToolTipText)
						.Controls(i).ToolTipText=.Controls(i).Parent.Name+"-"+.Controls(i).Name+"-Can put here code to make some actions... "
					Endi
					Bindevent(.Controls(i),"mousedown",Thisform,"my")
					Bindevent(.Controls(i),"mouseenter",Thisform,"my1")
					Bindevent(.Controls(i),"mouseleave",Thisform,"my2")
				Endfor
			Endwith
		Endfor
		.Refresh
	Endwith
	Endproc

	Procedure pageframe1.Init
	With This
		.Page1.Caption="Menu1"
		.Page2.Caption="Menu2"
		.Page3.Caption="Menu3"
		.Page4.Caption="Menu4"
	Endwith
	Endproc

	&&a prototype menu only for demo
	Procedure ympr()
	Define Popup raccourci SHORTCUT Relative From Mrow(),Mcol()
	Define Bar _Med_find Of raccourci Prompt "Rec\<hercher..." ;
		KEY CTRL+F, "Ctrl+F" PICTRES _Med_find;
		MESSAGE "Recherche le texte sp�cifi�"
	Define Bar _Med_paste Of raccourci Prompt "C\<oller" ;
		KEY CTRL+V, "Ctrl+V"  PICTRES _Med_paste ;
		MESSAGE "Place le contenu du Presse-papiers au point d'insertion"
	Define Bar _Med_copy Of raccourci Prompt "Co\<pier" ;
		KEY CTRL+C, "Ctrl+C" PICTRES _Med_copy ;
		MESSAGE "Copie la s�lection et la place dans le Presse-papiers"
	Define Bar _Med_cut Of raccourci Prompt "\<Couper" ;
		KEY CTRL+x, "Ctrl+X"  PICTRES _Med_cut  ;
		MESSAGE "Enl�ve la s�lection et la place dans le Presse-papiers"
	Define Bar _Med_redo Of raccourci Prompt "\<R�tablir" ;
		KEY CTRL+R, "Ctrl+R" PICTRES _Med_redo;
		MESSAGE "R�tablit la derni�re op�ration annul�e"
	Define Bar _Med_undo Of raccourci Prompt "\<Annuler" ;
		KEY CTRL+Z, "Ctrl+Z" PICTRES _Med_undo ;
		MESSAGE "Annule la derni�re modification"
	Define Bar _mfi_sysprint Of raccourci Prompt "\<Imprimer..." ;
		KEY CTRL+P, "Ctrl+P" PICTRES  _mfi_sysprint ;
		MESSAGE "Imprime un fichier texte, un �tat, une �tiquette ou le contenu de la fen�tre Commande ou du Presse-papiers"
	Define Bar _Mfi_prevu Of raccourci Prompt "Aper�u a\<vant impression"   ;
		MESSAGE "Affiche les pages telles qu'elles seront imprim�es"
	Define Bar _Mfi_pgset Of raccourci Prompt "\<Mise en page..."  PICTRES _Mfi_pgset ;
		MESSAGE "Modifie la mise en page et les options d'impression"
	Define Bar _mfi_saveashtml Of raccourci Prompt "Enregistrer au format \<HTML..."   ;
		MESSAGE "Enregistre le fichier en cours en HTML"
	Define Bar _Mfi_savas Of raccourci Prompt "En\<registrer sous..."  PICTRES _Mfi_savas ;
		MESSAGE "Enregistre le fichier en cours sous un nouveau nom"
	Define Bar _Mfi_save Of raccourci Prompt "\<Enregistrer" PICTRES _Mfi_save;
		KEY CTRL+S, "Ctrl+S"  ;
		MESSAGE "Enregistre le fichier en cours"
	Define Bar _Mfi_open Of raccourci Prompt "\<Ouvrir..." ;
		KEY CTRL+O, "Ctrl+O"  PICTRES _Mfi_open;
		MESSAGE "Ouvre un fichier existant"

	Activate Popup raccourci
	Endproc

	Procedure ycolorM
	*works only if the titlebar=0 on top level form
	Lparameters xcolor,HWnd

	If Pcount()#2
		Messagebox("two parameters required",0+32)
		Return
	Endi


	**** ****
	*menuinfo_styles * menuinfo_styles
	mns_nocheck = 0x80000000
	mns_nocheck = 0x80000000
	mns_modeless = 0x40000000
	mns_modeless = 0x40000000
	mns_dragdrop = 0x20000000
	mns_dragdrop = 0x20000000
	mns_autodismiss = 0x10000000
	mns_autodismiss = 0x10000000
	mns_notifybypos = 0x8000000
	mns_notifybypos = 0x8000000
	mns_checkorbmp =0x4000000
	mns_checkorbmp = 0x4000000

	mim_maxheight = 0x1
	mim_maxheight = 0x1
	mim_background = 0x2
	mim_background = 0x2
	mim_helpid = 0x4
	mim_helpid = 0x4
	mim_menudata = 0x8
	mim_menudata = 0x8
	mim_style = 0x10
	mim_style = 0x10
	mim_applytosubmenus = 0x80000000
	mim_applytosubmenus = 0x80000000
	**** ****

	uc_hwnd=HWnd
	uc_menuh=GetMenu(uc_hwnd)
	uc_fmask=mim_background
	uc_dwstyle=mns_nocheck
	uc_cymax=0
	uc_hbrback=CreateSolidBrush(xcolor)
	uc_dwcontexthelpid=0
	uc_dwmenudata=0
	uc_len = 28
	menuinfo = Thisform.num2dword (uc_len) + Thisform.num2dword (uc_fmask) + Thisform.num2dword (uc_dwstyle) + Thisform.num2dword (uc_cymax) + Thisform.num2dword (uc_hbrback) + Thisform.num2dword (uc_dwcontexthelpid) + Thisform.num2dword (uc_dwmenudata)
	=SetMenuInfo(uc_menuh,@menuinfo)
	=DrawMenuBar(uc_hwnd)

	*The DrawMenuBar function redraws the menu bar of the specified window. If the menu bar changes after
	*the system has created the window, this function must be called to draw the changed menu bar.
	*http://msdn.microsoft.com/en-us/library/ms647633.aspx
	Endproc
	Procedure num2dword
	Lparameters lnvalue
	#Define m0 0x0000100
	#Define m1 0x0010000
	#Define m2 0x1000000
	If lnvalue < 0
		lnvalue = 0x100000000 + lnvalue
	Endif Endif
	Local b0, b1, b2, b3
	b3 = Int(lnvalue/m2)
	b2 = Int((lnvalue - b3*m2)/m1)
	b1 = Int((lnvalue - b3*m2 - b2*m1)/m0)
	b0 = Mod(lnvalue, m0)
	Return Chr(b0)+Chr(b1)+Chr(b2)+Chr(b3)
	Endproc

	Procedure Destroy
	Clea Events
	Endproc
Enddefine
*
*-- EndDefine: ypageframe
*****************************

Define Class ycombo As ComboBox
	Height = 25
	Left = 24
	Top = 60
	Width = 157
	Name = "Combo1"

	Procedure Init
	With This
		.AddItem("1.black ")
		.AddItem("2.aquamarine")
		.AddItem("3.bisque")
		.AddItem("4.blue")
		.AddItem("5.brown")
		.AddItem("6.chartreuse")
		.AddItem("8.darkblue")
		.AddItem("8.indigo ")
		.AddItem("9.navy ")
		.AddItem("10.maroon")
		.AddItem("11.gold")
		.AddItem("12.crimson")
		.ListIndex=1
		.Style=2
		.Value=1
	Endwith

	Endproc

	Procedure Click  &&12 colors for theme
	Local m.xcolor
	Do Case
	Case This.Value=1
		m.xcolor=0
	Case This.Value=2
		m.xcolor= Rgb(127,255,212 )
	Case This.Value=3
		m.xcolor= 	Rgb(255,228,196)
	Case This.Value=4
		m.xcolor=Rgb(0,0,255  )
	Case This.Value=5
		m.xcolor= Rgb(165,42,42 )
	Case This.Value=6
		m.xcolor=Rgb(127,255,0 )
	Case This.Value=7
		m.xcolor= Rgb(0,0,139 )
	Case This.Value=8
		m.xcolor=	Rgb(75,0,130 )
	Case This.Value=9
		m.xcolor= Rgb(0,0,128 )
	Case This.Value=10
		m.xcolor= 	Rgb(128,0,0 )
	Case This.Value=11
		m.xcolor=   Rgb(255,215,0)
	Case This.Value=12
		m.xcolor=Rgb(220,20,60)

	Endcase
	*lighten color form color
	tnlevel=0.65
	m.tncolor=Thisform.BackColor
	Local lnRed,lnGreen,lnBlue
	lnRed	= Bitrshift(Bitand(m.tncolor, 0x0000FF),0)
	lnGreen	= Bitrshift(Bitand(m.tncolor, 0x00FF00),8)
	lnBlue	= Bitrshift(Bitand(m.tncolor, 0xFF0000),16)

	*lighten color :
	m.x='RGB('+Trans( lnRed     +(255 - lnRed  )*tnlevel,"999")+','+;
		trans( lnGreen +(255 - lnGreen)*tnlevel,"999")+ ','+ ;
		trans( lnBlue  +(255 - lnBlue )*tnlevel,"999")+')'

	With Thisform
		.BackColor=m.xcolor
		With .pageframe1
			*.themes=.f.  &&already set
			For i=1 To .PageCount
				.Pages(i).BackColor=Eval(m.x )
			Endfor
			.Refresh
		Endwith
	Endwith
	Thisform.ymenu(Thisform,.T.)
	Thisform.ycolorM(Eval(m.x),Thisform.HWnd)

	Endproc

Enddefine
*
*-- EndDefine: ycombo
