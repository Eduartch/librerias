
*Updated on 19 september 2015 10h20 
*adding a class combo based for 12 color themes

Publi yform
yform=Newobject("ypageFrame")
yform.Show
Read Events
Retu
*
Define Class ypageframe As Form
    BorderStyle = 0
	Top = -1
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
		Top = 18, ;
		Left = 5, ;
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

	Add Object label1 As Label With ;
		AutoSize = .T., ;
		FontBold = .T., ;
		FontSize = 12, ;
		Anchor = 768, ;
		BackStyle = 0, ;
		BorderStyle = 0, ;
		Caption = "--", ;
		Height = 20, ;
		Left = 908+70, ;
		MousePointer = 15, ;
		Top = -0, ;
		Width = 14, ;
		ForeColor = Rgb(255,0,0), ;
		ToolTipText = "Reduce", ;
		Name = "Label1"

	Add Object label2 As Label With ;
		AutoSize = .T., ;
		FontBold = .T., ;
		FontSize = 12, ;
		Anchor = 768, ;
		BackStyle = 0, ;
		BorderStyle = 0, ;
		Caption = "X", ;
		Height = 20, ;
		Left = 928+70, ;
		MousePointer = 15, ;
		Top = -0, ;
		Width = 15, ;
		ForeColor = Rgb(255,0,0), ;
		ToolTipText = "Close", ;
		Name = "Label2"

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
	Endwith
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
			.Left = 119
			.Top = 81
			.Width = 552
			.ForeColor = Rgb(255,255,255)
			.Name = "Label1"
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
			.Left = 106
			.Top = 80
			.Width = 552
			.ForeColor = Rgb(255,255,255)
			.Name = "Label1"
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
			.Left = 106
			.Top = 76
			.Width = 552
			.ForeColor = Rgb(255,255,255)
			.Name = "Label1"
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
	= SetLayeredWindowAttributes(Thisform.HWnd, 0,240,LWA_ALPHA)  &&LWA_COLORKEY+

	With Thisform.pageframe1
		.Height=Thisform.Height-30
		.Top=Thisform.label1.Top+Thisform.label1.Height+1


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
				.BackColor=0   &&rgb(255*rand(),255*rand(),255*rand())  &&random backcolor
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

	Procedure label1.Click
	Thisform.WindowState=1
	Endproc

	Procedure label2.Click
	Thisform.Release
	Endproc
	&&a prototype menu only for demo
	Procedure ympr()
	Define Popup raccourci SHORTCUT Relative From Mrow(),Mcol()
	Define Bar _Med_find Of raccourci Prompt "Rec\<hercher..." ;
		KEY CTRL+F, "Ctrl+F" ;
		MESSAGE "Recherche le texte spécifié"
	Define Bar _Med_paste Of raccourci Prompt "C\<oller" ;
		KEY CTRL+V, "Ctrl+V" ;
		MESSAGE "Place le contenu du Presse-papiers au point d'insertion"
	Define Bar _Med_copy Of raccourci Prompt "Co\<pier" ;
		KEY CTRL+C, "Ctrl+C" ;
		MESSAGE "Copie la sélection et la place dans le Presse-papiers"
	Define Bar _Med_cut Of raccourci Prompt "\<Couper" ;
		KEY CTRL+x, "Ctrl+X" ;
		MESSAGE "Enlève la sélection et la place dans le Presse-papiers"
	Define Bar _Med_redo Of raccourci Prompt "\<Rétablir" ;
		KEY CTRL+R, "Ctrl+R" ;
		MESSAGE "Rétablit la dernière opération annulée"
	Define Bar _Med_undo Of raccourci Prompt "\<Annuler" ;
		KEY CTRL+Z, "Ctrl+Z" ;
		MESSAGE "Annule la dernière modification"
	Define Bar _mfi_sysprint Of raccourci Prompt "\<Imprimer..." ;
		KEY CTRL+P, "Ctrl+P" ;
		MESSAGE "Imprime un fichier texte, un état, une étiquette ou le contenu de la fenêtre Commande ou du Presse-papiers"
	Define Bar _Mfi_prevu Of raccourci Prompt "Aperçu a\<vant impression" ;
		MESSAGE "Affiche les pages telles qu'elles seront imprimées"
	Define Bar _Mfi_pgset Of raccourci Prompt "\<Mise en page..." ;
		MESSAGE "Modifie la mise en page et les options d'impression"
	Define Bar _mfi_saveashtml Of raccourci Prompt "Enregistrer au format \<HTML..." ;
		MESSAGE "Enregistre le fichier en cours en HTML"
	Define Bar _Mfi_savas Of raccourci Prompt "En\<registrer sous..." ;
		MESSAGE "Enregistre le fichier en cours sous un nouveau nom"
	Define Bar _Mfi_save Of raccourci Prompt "\<Enregistrer" ;
		KEY CTRL+S, "Ctrl+S" ;
		MESSAGE "Enregistre le fichier en cours"
	Define Bar _Mfi_open Of raccourci Prompt "\<Ouvrir..." ;
		KEY CTRL+O, "Ctrl+O" ;
		MESSAGE "Ouvre un fichier existant"

	Activate Popup raccourci
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


	With Thisform
		.BackColor=m.xcolor
		With .pageframe1
			*.themes=.f.  &&already set
			For i=1 To .PageCount
				.Pages(i).BackColor=m.xcolor
			Endfor
			.Refresh
		Endwith
	Endwith
	Endproc

Enddefine
*
*-- EndDefine: ycombo
