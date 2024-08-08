*updated on 29 of march 2017---add getdir() to point to any disc folder images PNgs 
*1* SPS vfpScrollbar class as prg class  added to code(to make one standalone code).
*this class as flat text is used to make a kind of menu or toolbar with some PNGs to fire any action.
*point to a folder of PNG images and the code makes the rest.

Publi yform
yform=Newobject("ymenu_form")
yform.Show
Read Events
Retu
*
Define Class ymenu_form As Form
	Height = 397
	Width = 818
	ShowWindow = 2
	ShowTips = .T.
	AutoCenter = .T.
	Caption = "A menu with icones with a scrollable container class"
	Name = "Form1"

	Add Object sbscrollcontainer1 As sbscrollcontainer With ;
		Top = 0, ;
		Left = 0, ;
		Width = 816, ;
		Height = 252, ;
		BorderWidth = 2, ;
		BackColor = Rgb(0,0,0), ;
		scrollbars = 1, ;
		scrollableheight = 0, ;
		Name = "Sbscrollcontainer1"

	Procedure my
	Lparameters nButton, nShift, nXCoord, nYCoord
*--- aevent create an array laEvents
	Aevents( myArray, 0)
*--- reference the calling object
	loObject = myArray[1]
	Do Case
	Case Lower(loObject.Name)=="img1"
		Messagebox("do something from "+loObject.Name,0+32+4096,'',1000)
*.......
	Otherwise
		Messagebox("do something from "+loObject.Name,0+32+4096,'',1000)

	Endcase
	Endproc

	Procedure my1
	Lparameters nButton, nShift, nXCoord, nYCoord
*--- aevent create an array laEvents
	Aevents( myArray, 0)
*--- reference the calling object
	loObject = myArray[1]
	For i=1 To 6
		loObject.RotateFlip=i
	Endfor
	Endproc

	Procedure my2
	Lparameters nButton, nShift, nXCoord, nYCoord
*--- aevent create an array laEvents
	Aevents( myArray, 0)
*--- reference the calling object
	loObject = myArray[1]
	loObject.RotateFlip=0
	Endproc


	Procedure Resize
	With This.sbscrollcontainer1
		.Left=1
		.Top=1
		.Width=Thisform.Width-2
		.Refresh
	Endwith
	Endproc

	Procedure Init
	This.ShowTips=.T.
	Endproc

	Procedure sbscrollcontainer1.Init
	DoDefault()

	Local m.myrep
	m.yrep=Getdir("","folder of pngs images","Get folder with PNGs icons")&&PNGs folder
	If Empty(m.yrep)
		Return .F.
	Endi
	m.yrep=Addbs(m.yrep)

	Local m.xint
	m.xint=5
	Local m.gnbre
	gnbre=Adir(gabase,m.yrep+"*.png")   &&PNGs icons
*messagebox(trans(gnbre))
	If gnbre=0
		Return .F.
	Endi

	With This
		.ScrollBars=1   &&horizontal only
		Local m.xbackcolor    &&color theme here
		m.xbackcolor=Rgb(0,0,0)   && getcolor()
		.BackColor=m.xbackcolor
*local m.xpict
*	m.xpict="E:\____YMEDIA\BACKGROUND\FONDS_8.JPG"        &&getpict()   &&add a background container picture
*.picture=m.xpict
		.Scrollbarhorizontal1.Sbshape1.BackColor = m.xbackcolor
		.Height=85
		For i=1 To m.gnbre
			.AddObject("img"+Trans(i),"image")
			With Eval(".img"+Trans(i))
				.Top=4
				If i=1
					.Left=1
				Else
					.Left=Eval(".parent.img"+Trans(i-1)+".left")+Eval(".parent.img"+Trans(i-1)+".width")+m.xint
				Endi
				.Stretch=2
				.Width=64
				.Height=64
				.Picture=m.yrep+gabase(i,1)
				.MousePointer=15
				.ToolTipText=gabase(i,1)+"...[do action"+Trans(i)+"]"
				.Name="img"+Trans(i)
				.Visible=.T.
			Endwith
			Bindevent(Eval(".img"+Trans(i)),"mousedown",Thisform,"my")
			Bindevent(Eval(".img"+Trans(i)),"mouseEnter",Thisform,"my1")
			Bindevent(Eval(".img"+Trans(i)),"mouseLeave",Thisform,"my2")
		Endfor
		DoDefault()
		.scrollableheight=0
		.scrollableWidth=Eval(".img"+Trans(gnbre-1)+".left")+Eval(".img"+Trans(gnbre)+".width")+m.xint
	Endwith
	Endproc

	Procedure Destroy
	Clea Events
	Endproc

Enddefine
*
*-- EndDefine: ymenu_form

**************************************

*SPS vfpscroll class converted as prg class
*it can replace the vfpscrollbar.vcx in flat code text and avoid to carry the physical visual class (vcx+vct)
*make it at the end of a calling prg,use it with createObject,newObject or set procedure to...(if saved as prg).

Define Class sbcontainer As Container
	Width = 200
	Height = 200
	Name = "sbcontainer"
Enddefine

Define Class sbscrollcontainer As Container
	Width = 212
	Height = 211
	BorderWidth = 0
*-- 0 = None 1 = Horizontal 2 = Vertical 3 = Both
	ScrollBars = 3
	scrollableWidth = 400
	scrollableheight = 400
	baselinetop = 0
	baselineleft = 0
	Name = "sbscrollcontainer"

	Add Object scrollbarvertical1 As scrollbarvertical With ;
		Tag = "SkipScrollbar", ;
		Top = 1, ;
		Left = 194, ;
		Name = "Scrollbarvertical1", ;
		Sbshape1.Name = "Sbshape1", ;
		Scrollendup1.Sbshape2.Name = "Sbshape2", ;
		Scrollendup1.Sbshape1.Name = "Sbshape1", ;
		Scrollendup1.Sbshape3.Name = "Sbshape3", ;
		Scrollendup1.Splabel1.Name = "Splabel1", ;
		Scrollendup1.Spline9.Name = "Spline9", ;
		Scrollendup1.Spline10.Name = "Spline10", ;
		Scrollendup1.Spline12.Name = "Spline12", ;
		Scrollendup1.Spline11.Name = "Spline11", ;
		Scrollendup1.Spline13.Name = "Spline13", ;
		Scrollendup1.Spline14.Name = "Spline14", ;
		Scrollendup1.Sbshape4.Name = "Sbshape4", ;
		Scrollendup1.Name = "Scrollendup1", ;
		Scrollenddown1.Sbshape2.Name = "Sbshape2", ;
		Scrollenddown1.Sbshape1.Name = "Sbshape1", ;
		Scrollenddown1.Sbshape3.Name = "Sbshape3", ;
		Scrollenddown1.Splabel1.Name = "Splabel1", ;
		Scrollenddown1.Spline9.Name = "Spline9", ;
		Scrollenddown1.Spline10.Name = "Spline10", ;
		Scrollenddown1.Spline12.Name = "Spline12", ;
		Scrollenddown1.Spline11.Name = "Spline11", ;
		Scrollenddown1.Spline13.Name = "Spline13", ;
		Scrollenddown1.Spline14.Name = "Spline14", ;
		Scrollenddown1.Sbshape4.Name = "Sbshape4", ;
		Scrollenddown1.Name = "Scrollenddown1", ;
		Scrollthumbvertical1.Sbshape2.Name = "Sbshape2", ;
		Scrollthumbvertical1.Sbshape1.Name = "Sbshape1", ;
		Scrollthumbvertical1.Sbshape3.Name = "Sbshape3", ;
		Scrollthumbvertical1.Spline9.Name = "Spline9", ;
		Scrollthumbvertical1.Spline10.Name = "Spline10", ;
		Scrollthumbvertical1.Spline11.Name = "Spline11", ;
		Scrollthumbvertical1.Spline12.Name = "Spline12", ;
		Scrollthumbvertical1.Spline13.Name = "Spline13", ;
		Scrollthumbvertical1.Spline14.Name = "Spline14", ;
		Scrollthumbvertical1.Sbshape4.Name = "Sbshape4", ;
		Scrollthumbvertical1.Name = "Scrollthumbvertical1"

	Add Object Scrollbarhorizontal1 As scrollbarhorizontal With ;
		Tag = "SkipScrollbar", ;
		Top = 193, ;
		Left = 1, ;
		Name = "Scrollbarhorizontal1", ;
		Sbshape1.Name = "Sbshape1", ;
		Scrollendleft1.Sbshape2.Name = "Sbshape2", ;
		Scrollendleft1.Sbshape1.Name = "Sbshape1", ;
		Scrollendleft1.Sbshape3.Name = "Sbshape3", ;
		Scrollendleft1.Splabel1.Name = "Splabel1", ;
		Scrollendleft1.Spline12.Name = "Spline12", ;
		Scrollendleft1.Spline11.Name = "Spline11", ;
		Scrollendleft1.Spline13.Name = "Spline13", ;
		Scrollendleft1.Spline14.Name = "Spline14", ;
		Scrollendleft1.Spline10.Name = "Spline10", ;
		Scrollendleft1.Sbshape4.Name = "Sbshape4", ;
		Scrollendleft1.Spline9.Name = "Spline9", ;
		Scrollendleft1.Name = "Scrollendleft1", ;
		Scrollendright1.Sbshape2.Name = "Sbshape2", ;
		Scrollendright1.Sbshape1.Name = "Sbshape1", ;
		Scrollendright1.Sbshape3.Name = "Sbshape3", ;
		Scrollendright1.Splabel1.Name = "Splabel1", ;
		Scrollendright1.Spline9.Name = "Spline9", ;
		Scrollendright1.Spline12.Name = "Spline12", ;
		Scrollendright1.Spline11.Name = "Spline11", ;
		Scrollendright1.Spline13.Name = "Spline13", ;
		Scrollendright1.Spline14.Name = "Spline14", ;
		Scrollendright1.Sbshape4.Name = "Sbshape4", ;
		Scrollendright1.Spline10.Name = "Spline10", ;
		Scrollendright1.Name = "Scrollendright1", ;
		Scrollthumbhorizontal1.Sbshape2.Name = "Sbshape2", ;
		Scrollthumbhorizontal1.Sbshape1.Name = "Sbshape1", ;
		Scrollthumbhorizontal1.Sbshape3.Name = "Sbshape3", ;
		Scrollthumbhorizontal1.Spline9.Name = "Spline9", ;
		Scrollthumbhorizontal1.Spline11.Name = "Spline11", ;
		Scrollthumbhorizontal1.Spline12.Name = "Spline12", ;
		Scrollthumbhorizontal1.Spline13.Name = "Spline13", ;
		Scrollthumbhorizontal1.Spline14.Name = "Spline14", ;
		Scrollthumbhorizontal1.Spline10.Name = "Spline10", ;
		Scrollthumbhorizontal1.Sbshape4.Name = "Sbshape4", ;
		Scrollthumbhorizontal1.Name = "Scrollthumbhorizontal1"

	Procedure  MouseWheel   &&i added this to mouseWheel event in scrolling container (mouseWheel out or on images area)
	Lparameters nDirection, nShift, nXCoord, nYCoord
	DoDefault()
	Local m.n
	m.n=10
	If nDirection>0
		For i=1 To m.n
			This.scrollbarvertical1.Scrollendup1.Sbshape4.Click
		Endfor
	Else
		For i=1 To m.n
			This.scrollbarvertical1.Scrollenddown1.Sbshape4.Click
		Endfor
	Endi
	Endproc

	Procedure Setup
	This.positionscrollbars()
	This.ScrollBars = This.ScrollBars
	This.scrollableheight = This.scrollableheight
	This.scrollableWidth = This.scrollableWidth

	Endproc

	Procedure positionscrollbars
	This.Scrollbarhorizontal1.Left = 0
	This.Scrollbarhorizontal1.Width = This.Width - This.scrollbarvertical1.Width
	This.Scrollbarhorizontal1.Top = This.Height - This.Scrollbarhorizontal1.Height

	This.scrollbarvertical1.Top = 0
	This.scrollbarvertical1.Height = This.Height - This.Scrollbarhorizontal1.Height
	This.scrollbarvertical1.Left = This.Width - This.scrollbarvertical1.Width

	This.Scrollbarhorizontal1.Anchor = 14
	This.scrollbarvertical1.Anchor = 13

	This.Scrollbarhorizontal1.ZOrder(0)
	This.scrollbarvertical1.ZOrder(0)
	Endproc

	Procedure scrollbars_assign
	Lparameters vNewVal
	This.ScrollBars = m.vNewVal
	Do Case
	Case m.vNewVal = 1
		This.Scrollbarhorizontal1.Visible = .T.
		This.scrollbarvertical1.Visible = .F.
	Case m.vNewVal = 2
		This.Scrollbarhorizontal1.Visible = .F.
		This.scrollbarvertical1.Visible = .T.
	Case m.vNewVal = 3
		This.Scrollbarhorizontal1.Visible = .T.
		This.scrollbarvertical1.Visible = .T.
	Otherwise && None
		This.Scrollbarhorizontal1.Visible = .F.
		This.scrollbarvertical1.Visible = .F.
	Endcase
	Endproc

	Procedure scrollablewidth_assign
	Lparameters vNewVal
	This.scrollableWidth = m.vNewVal
	This.Scrollbarhorizontal1.Max = m.vNewVal
	Endproc

	Procedure scrollableheight_assign
	Lparameters vNewVal
	This.scrollableheight = m.vNewVal
	This.scrollbarvertical1.Max = m.vNewVal
	Endproc


	Procedure Init
	This.Setup()
	Endproc


	Procedure scrollbarvertical1.Change
	Local loControl, lnChange, lnAnchorWas
	lnChange = This.Parent.baselinetop - Int(This.Value)
	If lnChange != 0
		loControl = .Null.
		For Each loControl In This.Parent.Controls
			lnAnchorWas = 0
			If loControl.Tag != "SkipScrollbar"
				If Pemstatus(loControl, "Anchor", 5)
					lnAnchorWas = loControl.Anchor
					loControl.Anchor = 0
				Endif
				loControl.Top = loControl.Top + lnChange
				If lnAnchorWas > 0
					loControl.Anchor = lnAnchorWas
				Endif
			Endif
		Next
		This.Parent.baselinetop = Int(This.Value)
	Endif
	Endproc

	Procedure Scrollbarhorizontal1.Change
	Local loControl, lnChange, lnAnchorWas
	lnChange = This.Parent.baselineleft - Int(This.Value)
	If lnChange != 0
		loControl = .Null.
		For Each loControl In This.Parent.Controls
			lnAnchorWas = 0
			If loControl.Tag != "SkipScrollbar"
				If Pemstatus(loControl, "Anchor", 5)
					lnAnchorWas = loControl.Anchor
					loControl.Anchor = 0
				Endif
				loControl.Left = loControl.Left + lnChange
				If lnAnchorWas > 0
					loControl.Anchor = lnAnchorWas
				Endif
			Endif
		Next
		This.Parent.baselineleft = Int(This.Value)
	Endif
	Endproc

Enddefine

Define Class sbshape As Shape
	Height = 17
	Width = 100
	Name = "sbshape"
Enddefine

Define Class ScrollBar As Container
	Width = 17
	Height = 195
	BackStyle = 0
	BorderWidth = 0
	BackColor = Rgb(255,255,255)
*-- 1 = Vertical 2 = Horizontal
	direction = 1
	Min = 0
	Max = 500
	largechange = 100
	smallchange = 25
*-- Specifies the current state of a control.
	Value = 0
	valueworth = 0
	Name = "scrollbar"

	Add Object Sbshape1 As sbshape With ;
		Top = 1, ;
		Left = 1, ;
		Height = 192, ;
		Width = 16, ;
		Anchor = 0, ;
		BorderStyle = 1, ;
		BorderWidth = 1, ;
		Curvature = 4, ;
		BackColor = Rgb(247,247,243), ;
		BorderColor = Rgb(239,239,236), ;
		Name = "Sbshape1"

	Procedure max_assign
	Lparameters vNewVal
	m.vNewVal = Max(This.Min, m.vNewVal)
	This.Max = m.vNewVal
	If m.vNewVal > This.Min
		This.changethumbsize(.T.)
	Else
		This.changethumbsize(.F.)
	Endif
	Endproc

	Procedure min_assign
	Lparameters vNewVal
	m.vNewVal = Min(This.Max, m.vNewVal)
	This.Min = m.vNewVal
	If m.vNewVal < This.Max
		This.changethumbsize(.T.)
	Else
		This.changethumbsize(.F.)
	Endif
	Endproc

	Procedure value_assign
	Lparameters vNewVal
	Local lnChange
	m.vNewVal = Min(This.Max, Max(This.Min, m.vNewVal))
	lnChange = m.vNewVal - This.Value
	This.Value = m.vNewVal
	If lnChange != 0
		If This.direction = 1
			This.Scrollthumbvertical1.Top = Min(This.Scrollenddown1.Top - This.Scrollthumbvertical1.Height, Max(This.Scrollthumbvertical1.Top + (lnChange * Max(0, This.valueworth)), This.Scrollendup1.Height + 1))
		Else
			This.Scrollthumbhorizontal1.Left = Min(This.Scrollendright1.Left - This.Scrollthumbhorizontal1.Width, Max(This.Scrollthumbhorizontal1.Left + (lnChange * Max(0, This.valueworth)), This.Scrollendleft1.Width))
		Endif
		This.Change()
	Endif
	Endproc

	Procedure changethumbsize
	Lparameters tlVisible
	Local lnMinSize, lnMaxSize, lnUnusedSpace
	lnMinSize = 24 && minimum thumb size

	If This.direction = 1
		lnUnusedSpace = This.Scrollenddown1.Top - (This.Scrollendup1.Top + This.Scrollendup1.Height)
		lnMinSize = Max(lnMinSize, 100 * (lnUnusedSpace/(This.Max - This.Min)))
		lnMaxSize = Min(lnMinSize, lnUnusedSpace)
		This.Scrollthumbvertical1.Height = lnMaxSize
		This.Scrollthumbvertical1.Visible = tlVisible
	Else
		lnUnusedSpace = This.Scrollendright1.Left - (This.Scrollendleft1.Left + This.Scrollendleft1.Width)
		lnMinSize = Max(lnMinSize, 100 * (lnUnusedSpace/(This.Max - This.Min)))
		lnMaxSize = Min(lnMinSize, lnUnusedSpace)
		This.Scrollthumbhorizontal1.Width = lnMaxSize
		This.Scrollthumbhorizontal1.Visible = tlVisible
	Endif
	Endproc

	Procedure valueworth_access
	Local lnValueWorth, lnTotalBetween
	lnTotalBetween = This.Max - This.Min
*!*	IF this.direction = 1
*!*		lnValueWorth = (this.Height - (this.scrollendup1.height + this.scrollthumbvertical1.height)) / lnTotalBetween
*!*	ELSE
*!*		lnValueWorth = (this.width - (this.scrollendleft1.width + this.scrollthumbhorizontal1.width)) / lnTotalBetween && + this.scrollendright1.width
*!*	ENDIF
	If This.direction = 1
		lnValueWorth = (This.Scrollenddown1.Top - ;
			(This.Scrollendup1.Top + This.Scrollendup1.Height) - ;
			this.Scrollthumbvertical1.Height) / lnTotalBetween
	Else
		lnValueWorth = (This.Scrollendright1.Left - ;
			(This.Scrollendleft1.Left + This.Scrollendleft1.Width) - ;
			this.Scrollthumbhorizontal1.Width) / lnTotalBetween
	Endif
	Return lnValueWorth
	Endproc

	Procedure Init
	Local loControl
	loControl = .Null.
	If This.direction = 1
		This.Sbshape1.Left = 1
		This.Sbshape1.Top = 1
		This.Sbshape1.Width = This.Width - 1
		This.Sbshape1.Height = This.Height - 2
	Else
		This.Sbshape1.Left = 1
		This.Sbshape1.Top = 1
		This.Sbshape1.Width = This.Width - 2
		This.Sbshape1.Height = This.Height - 1
	Endif
	This.Sbshape1.Anchor = 15

	For Each m.loControl In This.Controls
		If Inlist(m.loControl.Class, "Scrollendup", "Scrollenddown", "Scrollendleft", "Scrollendright", ;
				"Scrollthumbvertical", "Scrollthumbhorizontal")
			m.loControl.Setup()
		Endif
	Next
*!*	this.max = this.max
*!*	this.min = this.min
*!*	this.value = this.value
	Endproc

*-- Occurs when the user is dragging the scrollbar thumb (elevator).
	Procedure Scroll
	Endproc

*-- Occurs when the user has caused the value to of the scrollbar to change.
	Procedure Change
	Endproc

	Procedure Sbshape1.DblClick
	This.Click()
	Endproc

	Procedure Sbshape1.Click
	If Amouseobj(aryTemp) > 0
		If This.Parent.direction = 1
			This.Parent.Value = This.Parent.Value + Iif(aryTemp(4) <= This.Parent.Scrollthumbvertical1.Top, -(This.Parent.largechange), This.Parent.largechange)
		Else
			This.Parent.Value = This.Parent.Value + Iif(aryTemp(3) <= This.Parent.Scrollthumbhorizontal1.Left, -(This.Parent.largechange), This.Parent.largechange)
		Endif
	Endif
	Endproc

Enddefine

Define Class scrollbarhorizontal As ScrollBar
	Width = 195
	Height = 17
	direction = 2
	Name = "scrollbarhorizontal"
	Sbshape1.Top = 0
	Sbshape1.Left = 1
	Sbshape1.Height = 16
	Sbshape1.Width = 193
	Sbshape1.Name = "Sbshape1"

	Add Object Scrollendleft1 As scrollendleft With ;
		Top = 0, ;
		Left = 1, ;
		Name = "Scrollendleft1", ;
		Sbshape2.Name = "Sbshape2", ;
		Sbshape1.Name = "Sbshape1", ;
		Sbshape3.Name = "Sbshape3", ;
		Splabel1.Name = "Splabel1", ;
		Spline12.Name = "Spline12", ;
		Spline11.Name = "Spline11", ;
		Spline13.Name = "Spline13", ;
		Spline14.Name = "Spline14", ;
		Spline10.Name = "Spline10", ;
		Sbshape4.Name = "Sbshape4", ;
		Spline9.Name = "Spline9"

	Add Object Scrollendright1 As scrollendright With ;
		Top = 0, ;
		Left = 178, ;
		position = 2, ;
		Name = "Scrollendright1", ;
		Sbshape2.Name = "Sbshape2", ;
		Sbshape1.Name = "Sbshape1", ;
		Sbshape3.Name = "Sbshape3", ;
		Splabel1.Name = "Splabel1", ;
		Spline9.Name = "Spline9", ;
		Spline12.Name = "Spline12", ;
		Spline11.Name = "Spline11", ;
		Spline13.Name = "Spline13", ;
		Spline14.Name = "Spline14", ;
		Sbshape4.Name = "Sbshape4", ;
		Spline10.Name = "Spline10"

	Add Object Scrollthumbhorizontal1 As scrollthumbhorizontal With ;
		Top = 1, ;
		Left = 17, ;
		Name = "Scrollthumbhorizontal1", ;
		Sbshape2.Name = "Sbshape2", ;
		Sbshape1.Name = "Sbshape1", ;
		Sbshape3.Name = "Sbshape3", ;
		Sbshape4.Name = "Sbshape4"

Enddefine

Define Class scrollbarvertical As ScrollBar
	Width = 16
	Height = 195
	Name = "scrollbarvertical"
	Sbshape1.Top = 1
	Sbshape1.Left = 1
	Sbshape1.Name = "Sbshape1"

	Add Object Scrollendup1 As scrollendup With ;
		Top = 1, ;
		Left = 0, ;
		Name = "Scrollendup1", ;
		Sbshape2.Name = "Sbshape2", ;
		Sbshape1.Name = "Sbshape1", ;
		Sbshape3.Name = "Sbshape3", ;
		Splabel1.Name = "Splabel1", ;
		Spline9.Name = "Spline9", ;
		Spline10.Name = "Spline10", ;
		Spline12.Name = "Spline12", ;
		Spline11.Name = "Spline11", ;
		Spline13.Name = "Spline13", ;
		Spline14.Name = "Spline14", ;
		Sbshape4.Name = "Sbshape4"

	Add Object Scrollenddown1 As scrollenddown With ;
		Top = 177, ;
		Left = 0, ;
		position = 2, ;
		Name = "Scrollenddown1", ;
		Sbshape2.Name = "Sbshape2", ;
		Sbshape1.Name = "Sbshape1", ;
		Sbshape3.Name = "Sbshape3", ;
		Splabel1.Name = "Splabel1", ;
		Spline9.Name = "Spline9", ;
		Spline10.Name = "Spline10", ;
		Spline12.Name = "Spline12", ;
		Spline11.Name = "Spline11", ;
		Spline13.Name = "Spline13", ;
		Spline14.Name = "Spline14", ;
		Sbshape4.Name = "Sbshape4"

	Add Object Scrollthumbvertical1 As scrollthumbvertical With ;
		Top = 18, ;
		Left = 0, ;
		Name = "Scrollthumbvertical1", ;
		Sbshape2.Name = "Sbshape2", ;
		Sbshape1.Name = "Sbshape1", ;
		Sbshape3.Name = "Sbshape3", ;
		Spline9.Name = "Spline9", ;
		Spline10.Name = "Spline10", ;
		Spline11.Name = "Spline11", ;
		Spline12.Name = "Spline12", ;
		Spline13.Name = "Spline13", ;
		Spline14.Name = "Spline14", ;
		Sbshape4.Name = "Sbshape4"
Enddefine

Define Class scrollend As Container
	Width = 16
	Height = 17
	BackStyle = 0
	BorderWidth = 0
	SpecialEffect = 0
	Style = 3
*-- 1 = Up/Left 2 = Down/Right
	position = 1
	Name = "scrollend"

	Add Object Sbshape2 As sbshape With ;
		Top = 1, ;
		Left = 1, ;
		Height = 16, ;
		Width = 15, ;
		Curvature = 4, ;
		BackColor = Rgb(184,203,246), ;
		BorderColor = Rgb(159,181,210), ;
		Name = "Sbshape2"

	Add Object Sbshape1 As sbshape With ;
		Top = 0, ;
		Left = 1, ;
		Height = 16, ;
		Width = 14, ;
		Curvature = 4, ;
		BackColor = Rgb(255,255,255), ;
		BorderColor = Rgb(255,255,255), ;
		Name = "Sbshape1"

	Add Object Sbshape3 As sbshape With ;
		Top = 1, ;
		Left = 2, ;
		Height = 14, ;
		Width = 12, ;
		Curvature = 4, ;
		BackColor = Rgb(200,219,253), ;
		BorderColor = Rgb(184,203,246), ;
		Name = "Sbshape3"

	Add Object Splabel1 As splabel With ;
		FontBold = .F., ;
		FontName = "Comic Sans MS", ;
		FontSize = 15, ;
		BackStyle = 0, ;
		Height = 17, ;
		Left = 3, ;
		Top = 0, ;
		Width = 9, ;
		ForeColor = Rgb(77,97,133), ;
		Name = "Splabel1"

	Add Object Spline9 As spline With ;
		BorderWidth = 1, ;
		DrawMode = 12, ;
		Height = 0, ;
		Left = 3, ;
		Top = 2, ;
		Width = 9, ;
		BorderColor = Rgb(214,231,255), ;
		Name = "Spline9"

	Add Object Spline10 As spline With ;
		BorderWidth = 1, ;
		DrawMode = 12, ;
		Height = 1, ;
		Left = 2, ;
		Top = 3, ;
		Width = 0, ;
		BorderColor = Rgb(214,231,255), ;
		Name = "Spline10"

	Add Object Spline12 As spline With ;
		Height = 0, ;
		Left = 3, ;
		Top = 1, ;
		Visible = .F., ;
		Width = 9, ;
		BorderColor = Rgb(147,167,219), ;
		Name = "Spline12"

	Add Object Spline11 As spline With ;
		Height = 11, ;
		Left = 1, ;
		Top = 2, ;
		Visible = .F., ;
		Width = 0, ;
		BorderColor = Rgb(147,167,219), ;
		Name = "Spline11"

	Add Object Spline13 As spline With ;
		Height = 0, ;
		Left = 3, ;
		Top = 2, ;
		Visible = .F., ;
		Width = 10, ;
		BorderColor = Rgb(147,167,219), ;
		Name = "Spline13"

	Add Object Spline14 As spline With ;
		Height = 0, ;
		Left = 2, ;
		Top = 3, ;
		Visible = .F., ;
		Width = 1, ;
		BorderColor = Rgb(147,167,219), ;
		Name = "Spline14"

	Add Object Sbshape4 As sbshape With ;
		Top = -1, ;
		Left = 0, ;
		Height = 19, ;
		Width = 17, ;
		BackStyle = 0, ;
		BorderStyle = 0, ;
		Name = "Sbshape4"

	Procedure Setup
	With This
		.Sbshape1.Anchor = 15
		.Sbshape2.Anchor = 15
		.Sbshape3.Anchor = 15
		.Sbshape4.Anchor = 15
		.Splabel1.Anchor = 768
		.Spline14.Anchor = 3
		If This.Parent.direction = 1
			.Left = 0
			If .position = 1
				.Top = 1
				.Anchor = 11
			Else
				.Top = .Parent.Height - .Height - 1
				.Anchor = 14
			Endif
			.Spline9.Anchor = 11
			.Spline10.Anchor = 3
			.Spline11.Anchor = 7
			.Spline12.Anchor = 11
			.Spline13.Anchor = 11
			.Width = This.Parent.Width - 1
		Else
			.Top = 0
			If .position = 1
				.Left = 1
				.Anchor = 7
			Else
				.Left = .Parent.Width - .Width
				.Anchor = 13
			Endif
			.Spline9.Anchor = 7
			.Spline10.Anchor = 6
			.Spline11.Anchor = 11
			.Spline12.Anchor = 7
			.Spline13.Anchor = 7
			.Height = This.Parent.Height - 1
		Endif
	Endwith
	Endproc

	Procedure Sbshape4.Click
	If This.Parent.position = 1
		This.Parent.Parent.Value = This.Parent.Parent.Value - This.Parent.Parent.smallchange
	Else
		This.Parent.Parent.Value = This.Parent.Parent.Value + This.Parent.Parent.smallchange
	Endif
	Endproc

	Procedure Sbshape4.MouseUp
	Lparameters nButton, nShift, nXCoord, nYCoord
	If m.nButton = 1
		This.Parent.Sbshape3.BackColor = Rgb(214, 231, 255)
		This.Parent.Spline11.Visible = .F.
		This.Parent.Spline12.Visible = .F.
		This.Parent.Spline13.Visible = .F.
		This.Parent.Spline14.Visible = .F.
	Endif
	Endproc

	Procedure Sbshape4.MouseDown
	Lparameters nButton, nShift, nXCoord, nYCoord
	If m.nButton = 1
		This.Parent.Sbshape3.BackColor = Rgb(165, 191, 251)
		This.Parent.Spline11.Visible = .T.
		This.Parent.Spline12.Visible = .T.
		This.Parent.Spline13.Visible = .T.
		This.Parent.Spline14.Visible = .T.
	Endif
	Endproc

	Procedure Sbshape4.MouseLeave
	Lparameters nButton, nShift, nXCoord, nYCoord
	This.Parent.Sbshape3.BackColor = Rgb(184,203,246)
	Endproc

	Procedure Sbshape4.MouseEnter
	Lparameters nButton, nShift, nXCoord, nYCoord
	This.Parent.Sbshape3.BackColor = Rgb(214, 231, 255)
	Endproc

	Procedure Sbshape4.DblClick
	This.Click()
	Endproc

Enddefine
*
Define Class scrollenddown As scrollend
	Name = "scrollenddown"
	Sbshape2.Name = "Sbshape2"
	Sbshape1.Name = "Sbshape1"
	Sbshape3.Name = "Sbshape3"
	Splabel1.Height = 23
	Splabel1.Left = 4
	Splabel1.Top = -8
	Splabel1.Width = 9
	Splabel1.Rotation = 180
	Splabel1.Name = "Splabel1"
	Spline9.Name = "Spline9"
	Spline10.Name = "Spline10"
	Spline12.Name = "Spline12"
	Spline11.Left = 2
	Spline11.Top = 2
	Spline11.Name = "Spline11"
	Spline13.Name = "Spline13"
	Spline14.Left = 3
	Spline14.Top = 3
	Spline14.Name = "Spline14"
	Sbshape4.Name = "Sbshape4"
Enddefine

Define Class scrollendleft As scrollend
	Width = 18
	Height = 16
	Name = "scrollendleft"
	Sbshape2.Top = 1
	Sbshape2.Left = 1
	Sbshape2.Height = 15
	Sbshape2.Width = 16
	Sbshape2.ZOrderSet = 0
	Sbshape2.Name = "Sbshape2"
	Sbshape1.Top = 1
	Sbshape1.Left = 0
	Sbshape1.Height = 14
	Sbshape1.Width = 16
	Sbshape1.ZOrderSet = 1
	Sbshape1.Name = "Sbshape1"
	Sbshape3.Top = 2
	Sbshape3.Left = 1
	Sbshape3.Height = 12
	Sbshape3.Width = 14
	Sbshape3.ZOrderSet = 2
	Sbshape3.Name = "Sbshape3"
	Splabel1.Height = 17
	Splabel1.Left = 3
	Splabel1.Top = 0
	Splabel1.Width = 22
	Splabel1.ZOrderSet = 3
	Splabel1.Rotation = 90
	Splabel1.Name = "Splabel1"
	Spline9.Height = 9
	Spline9.Left = 2
	Spline9.Top = 4
	Spline9.Width = 0
	Spline9.ZOrderSet = 9
	Spline9.Name = "Spline9"
	Spline10.Left = 3
	Spline10.Top = 12
	Spline10.ZOrderSet = 8
	Spline10.Name = "Spline10"
	Spline12.Height = 9
	Spline12.Left = 1
	Spline12.Top = 4
	Spline12.Width = 0
	Spline12.ZOrderSet = 4
	Spline12.Name = "Spline12"
	Spline11.Height = 0
	Spline11.Left = 2
	Spline11.Top = 2
	Spline11.Width = 11
	Spline11.ZOrderSet = 5
	Spline11.Name = "Spline11"
	Spline13.Height = 10
	Spline13.Left = 2
	Spline13.Top = 3
	Spline13.Width = 0
	Spline13.ZOrderSet = 6
	Spline13.Name = "Spline13"
	Spline14.Left = 3
	Spline14.Top = 3
	Spline14.ZOrderSet = 7
	Spline14.Name = "Spline14"
	Sbshape4.Top = -1
	Sbshape4.Left = -1
	Sbshape4.Height = 17
	Sbshape4.Width = 19
	Sbshape4.ZOrderSet = 10
	Sbshape4.Name = "Sbshape4"
Enddefine

Define Class scrollendright As scrollend
	Width = 18
	Height = 16
	Name = "scrollendright"
	Sbshape2.Left = 1
	Sbshape2.Height = 15
	Sbshape2.Width = 16
	Sbshape2.ZOrderSet = 0
	Sbshape2.Name = "Sbshape2"
	Sbshape1.Top = 1
	Sbshape1.Left = 0
	Sbshape1.Height = 14
	Sbshape1.Width = 16
	Sbshape1.ZOrderSet = 1
	Sbshape1.Name = "Sbshape1"
	Sbshape3.Top = 2
	Sbshape3.Left = 1
	Sbshape3.Height = 12
	Sbshape3.Width = 14
	Sbshape3.ZOrderSet = 2
	Sbshape3.Name = "Sbshape3"
	Splabel1.Height = 16
	Splabel1.Left = -9
	Splabel1.Top = 1
	Splabel1.Width = 23
	Splabel1.ZOrderSet = 3
	Splabel1.Rotation = 270
	Splabel1.Name = "Splabel1"
	Spline9.Height = 9
	Spline9.Left = 2
	Spline9.Top = 4
	Spline9.Width = 0
	Spline9.ZOrderSet = 4
	Spline9.Name = "Spline9"
	Spline10.Left = 3
	Spline10.Top = 12
	Spline10.ZOrderSet = 9
	Spline10.Name = "Spline10"
	Spline12.Height = 9
	Spline12.Left = 1
	Spline12.Top = 4
	Spline12.Width = 0
	Spline12.ZOrderSet = 5
	Spline12.Name = "Spline12"
	Spline11.Height = 0
	Spline11.Left = 2
	Spline11.Top = 2
	Spline11.Width = 11
	Spline11.ZOrderSet = 6
	Spline11.Name = "Spline11"
	Spline13.Height = 10
	Spline13.Left = 2
	Spline13.Top = 3
	Spline13.Width = 0
	Spline13.ZOrderSet = 7
	Spline13.Name = "Spline13"
	Spline14.Left = 3
	Spline14.Top = 3
	Spline14.ZOrderSet = 8
	Spline14.Name = "Spline14"
	Sbshape4.Left = -1
	Sbshape4.Height = 17
	Sbshape4.Width = 19
	Sbshape4.ZOrderSet = 10
	Sbshape4.Name = "Sbshape4"
Enddefine

Define Class scrollendup As scrollend
	Name = "scrollendup"
	Sbshape2.Name = "Sbshape2"
	Sbshape1.Name = "Sbshape1"
	Sbshape3.Name = "Sbshape3"
	Splabel1.Name = "Splabel1"
	Spline9.Name = "Spline9"
	Spline10.Name = "Spline10"
	Spline12.Name = "Spline12"
	Spline11.Left = 2
	Spline11.Top = 2
	Spline11.Name = "Spline11"
	Spline13.Name = "Spline13"
	Spline14.Left = 3
	Spline14.Top = 3
	Spline14.Name = "Spline14"
	Sbshape4.Name = "Sbshape4"
Enddefine

Define Class scrollthumb As Container
	Width = 16
	Height = 61
	BorderWidth = 0
	Style = 3
	mousedownat = 0
	Name = "scrollthumb"

	Add Object Sbshape2 As sbshape With ;
		Top = 1, ;
		Left = 1, ;
		Height = 60, ;
		Width = 15, ;
		Curvature = 4, ;
		BackColor = Rgb(184,203,246), ;
		BorderColor = Rgb(159,181,210), ;
		Name = "Sbshape2"

	Add Object Sbshape1 As sbshape With ;
		Top = 0, ;
		Left = 1, ;
		Height = 60, ;
		Width = 14, ;
		BorderWidth = 1, ;
		Curvature = 4, ;
		BackColor = Rgb(255,255,255), ;
		BorderColor = Rgb(255,255,255), ;
		Name = "Sbshape1"

	Add Object Sbshape3 As sbshape With ;
		Top = 1, ;
		Left = 2, ;
		Height = 58, ;
		Width = 12, ;
		BorderWidth = 1, ;
		Curvature = 4, ;
		BackColor = Rgb(200,219,253), ;
		BorderColor = Rgb(184,203,246), ;
		Name = "Sbshape3"

	Add Object Spline9 As spline With ;
		BorderWidth = 1, ;
		DrawMode = 12, ;
		Height = 0, ;
		Left = 3, ;
		Top = 2, ;
		Width = 9, ;
		BorderColor = Rgb(214,231,255), ;
		Name = "Spline9"

	Add Object Spline10 As spline With ;
		BorderWidth = 1, ;
		DrawMode = 12, ;
		Height = 1, ;
		Left = 2, ;
		Top = 3, ;
		Width = 0, ;
		BorderColor = Rgb(214,231,255), ;
		Name = "Spline10"


	Add Object Spline11 As spline With ;
		Height = 55, ;
		Left = 1, ;
		Top = 2, ;
		Visible = .F., ;
		Width = 0, ;
		BorderColor = Rgb(147,167,219), ;
		Name = "Spline11"

	Add Object Spline12 As spline With ;
		Height = 0, ;
		Left = 3, ;
		Top = 1, ;
		Visible = .F., ;
		Width = 9, ;
		BorderColor = Rgb(147,167,219), ;
		Name = "Spline12"

	Add Object Spline13 As spline With ;
		Height = 0, ;
		Left = 3, ;
		Top = 2, ;
		Visible = .F., ;
		Width = 10, ;
		BorderColor = Rgb(147,167,219), ;
		Name = "Spline13"

	Add Object Spline14 As spline With ;
		Height = 0, ;
		Left = 2, ;
		Top = 3, ;
		Visible = .F., ;
		Width = 1, ;
		BorderColor = Rgb(147,167,219), ;
		Name = "Spline14"

	Add Object Sbshape4 As sbshape With ;
		Top = -1, ;
		Left = 0, ;
		Height = 63, ;
		Width = 17, ;
		BackStyle = 0, ;
		BorderStyle = 0, ;
		Name = "Sbshape4"

	Add Object sbcontainer1 As sbcontainer With ;
		Top = 21, ;
		Left = 2, ;
		Width = 13, ;
		Height = 18, ;
		BackStyle = 0, ;
		BorderWidth = 0, ;
		Name = "Sbcontainer1"

	Procedure Setup
	With This
		.Sbshape1.Anchor = 15
		.Sbshape2.Anchor = 15
		.Sbshape3.Anchor = 15
		.Sbshape4.Anchor = 15

		.sbcontainer1.Anchor = 768

		.Spline10.Anchor = 3
		.Spline14.Anchor = 3
		If This.Parent.direction = 1
			.Top = 18
			.Left = 0
			.Spline9.Anchor = 11
			.Spline10.Anchor = 3
			.Spline11.Anchor = 7
			.Spline12.Anchor = 11
			.Spline13.Anchor = 11
			.Width = This.Parent.Width
		Else
			.Top = 1
			.Left = 18
			.Spline9.Anchor = 7
			.Spline10.Anchor = 6
			.Spline11.Anchor = 11
			.Spline12.Anchor = 7
			.Spline13.Anchor = 7
			.Height = This.Parent.Height - 1
		Endif
	Endwith
	Endproc

	Procedure Sbshape4.MouseEnter
	Lparameters nButton, nShift, nXCoord, nYCoord
	This.Parent.Sbshape3.BackColor = Rgb(214, 231, 255)
	Endproc

	Procedure Sbshape4.MouseLeave
	Lparameters nButton, nShift, nXCoord, nYCoord
	This.Parent.Sbshape3.BackColor = Rgb(184,203,246)
	This.Parent.mousedownat = 0
	Endproc


	Procedure Sbshape4.MouseDown
	Lparameters nButton, nShift, nXCoord, nYCoord
	If m.nButton = 1
		If This.Parent.Parent.direction = 1
			This.Parent.mousedownat = nYCoord
		Else
			This.Parent.mousedownat = nXCoord
		Endif
		This.Parent.Sbshape3.BackColor = Rgb(165, 191, 251)
		This.Parent.Spline11.Visible = .T.
		This.Parent.Spline12.Visible = .T.
		This.Parent.Spline13.Visible = .T.
		This.Parent.Spline14.Visible = .T.
	Endif
	Endproc

	Procedure Sbshape4.MouseUp
	Lparameters nButton, nShift, nXCoord, nYCoord
	If m.nButton = 1
		This.Parent.mousedownat = 0
		This.Parent.Sbshape3.BackColor = Rgb(214, 231, 255)
		This.Parent.Spline11.Visible = .F.
		This.Parent.Spline12.Visible = .F.
		This.Parent.Spline13.Visible = .F.
		This.Parent.Spline14.Visible = .F.
	Endif
	Endproc

	Procedure Sbshape4.MouseMove
	Lparameters nButton, nShift, nXCoord, nYCoord
	Local lnMovement, llMax, llMin, lnLimit

	If This.Parent.mousedownat != 0 And m.nButton = 1
		llMax = .F.
		llMin = .F.
		If This.Parent.Parent.direction = 1 && Vertical
			If m.nYCoord != This.Parent.mousedownat
				m.lnMovement = This.Parent.Top + (m.nYCoord - This.Parent.mousedownat)
				If m.lnMovement < 18
					m.lnMovement = 18
					llMin = .T.
				Else
					lnLimit = This.Parent.Parent.Scrollenddown1.Top - This.Parent.Height
					If m.lnMovement > lnLimit
						m.lnMovement = lnLimit
						llMax = .T.
					Endif
				Endif
				Do Case
				Case llMin
					This.Parent.Parent.Value = This.Parent.Parent.Min
				Case llMax
					This.Parent.Parent.Value = This.Parent.Parent.Max
				Otherwise
					This.Parent.Parent.Value = This.Parent.Parent.Value + ((m.lnMovement - This.Parent.Top) / This.Parent.Parent.valueworth)
				Endcase
				This.Parent.mousedownat = m.nYCoord
				This.Parent.Parent.Scroll
			Endif
		Else && Horizontal
			If m.nXCoord != This.Parent.mousedownat
				m.lnMovement = This.Parent.Left + (m.nXCoord - This.Parent.mousedownat)
				If m.lnMovement < 18
					m.lnMovement = 18
					llMin = .T.
				Else
					lnLimit = This.Parent.Parent.Scrollendright1.Left - This.Parent.Width
					If m.lnMovement > lnLimit
						m.lnMovement = lnLimit
						llMax = .T.
					Endif
				Endif
				Do Case
				Case llMin
					This.Parent.Parent.Value = This.Parent.Parent.Min
				Case llMax
					This.Parent.Parent.Value = This.Parent.Parent.Max
				Otherwise
					This.Parent.Parent.Value = This.Parent.Parent.Value + ((m.lnMovement - This.Parent.Left) / This.Parent.Parent.valueworth)
				Endcase
				This.Parent.mousedownat = m.nXCoord
				This.Parent.Parent.Scroll
			Endif
		Endif
	Endif
	Endproc

Enddefine

Define Class scrollthumbhorizontal As scrollthumb
	Width = 62
	Height = 16
	Name = "scrollthumbhorizontal"
	Sbshape2.Top = 0
	Sbshape2.Left = 1
	Sbshape2.Height = 15
	Sbshape2.Width = 61
	Sbshape2.Visible = .T.
	Sbshape2.ZOrderSet = 0
	Sbshape2.Name = "Sbshape2"
	Sbshape1.Top = 0
	Sbshape1.Left = 1
	Sbshape1.Height = 14
	Sbshape1.Width = 60
	Sbshape1.Visible = .T.
	Sbshape1.ZOrderSet = 1
	Sbshape1.Name = "Sbshape1"
	Sbshape3.Top = 1
	Sbshape3.Left = 2
	Sbshape3.Height = 12
	Sbshape3.Width = 58
	Sbshape3.Visible = .T.
	Sbshape3.ZOrderSet = 2
	Sbshape3.Name = "Sbshape3"
	Spline9.Height = 9
	Spline9.Left = 3
	Spline9.Top = 3
	Spline9.Visible = .T.
	Spline9.Width = 0
	Spline9.ZOrderSet = 3
	Spline9.Name = "Spline9"
	Spline10.Height = 0
	Spline10.Left = 4
	Spline10.Top = 11
	Spline10.Width = 1
	Spline10.ZOrderSet = 8
	Spline10.Name = "Spline10"
	Spline11.Height = 0
	Spline11.Left = 3
	Spline11.Top = 1
	Spline11.Width = 55
	Spline11.ZOrderSet = 4
	Spline11.Name = "Spline11"
	Spline12.Height = 9
	Spline12.Left = 2
	Spline12.Top = 3
	Spline12.Width = 0
	Spline12.ZOrderSet = 5
	Spline12.Name = "Spline12"
	Spline13.Height = 10
	Spline13.Left = 3
	Spline13.Top = 2
	Spline13.Width = 0
	Spline13.ZOrderSet = 6
	Spline13.Name = "Spline13"
	Spline14.Left = 4
	Spline14.Top = 2
	Spline14.ZOrderSet = 7
	Spline14.Name = "Spline14"
	Sbshape4.Top = -1
	Sbshape4.Left = -1
	Sbshape4.Height = 17
	Sbshape4.Width = 63
	Sbshape4.Visible = .T.
	Sbshape4.ZOrderSet = 10
	Sbshape4.Name = "Sbshape4"
Enddefine

Define Class scrollthumbvertical As scrollthumb
	Name = "scrollthumbvertical"
	Sbshape2.ZOrderSet = 0
	Sbshape2.Name = "Sbshape2"
	Sbshape1.ZOrderSet = 1
	Sbshape1.Name = "Sbshape1"
	Sbshape3.ZOrderSet = 2
	Sbshape3.Name = "Sbshape3"
	Spline9.ZOrderSet = 3
	Spline9.Name = "Spline9"
	Spline10.ZOrderSet = 4
	Spline10.Name = "Spline10"
	Spline11.Height = 54
	Spline11.Left = 2
	Spline11.Top = 3
	Spline11.Width = 0
	Spline11.ZOrderSet = 5
	Spline11.Name = "Spline11"
	Spline12.ZOrderSet = 6
	Spline12.Name = "Spline12"
	Spline13.ZOrderSet = 7
	Spline13.Name = "Spline13"
	Spline14.Left = 3
	Spline14.Top = 3
	Spline14.ZOrderSet = 8
	Spline14.Name = "Spline14"
	Sbshape4.ZOrderSet = 10
	Sbshape4.Name = "Sbshape4"
	sbcontainer1.ZOrderSet = 9
Enddefine

Define Class splabel As Label
	FontBold = .T.
	FontName = "Courier New"
	FontSize = 16
	Alignment = 2
	Caption = "^"
	Height = 17
	Width = 40
	ForeColor = Rgb(0,0,160)
	Name = "splabel"
Enddefine

Define Class spline As Line
	Height = 17
	Width = 100
	Name = "spline"
Enddefine
