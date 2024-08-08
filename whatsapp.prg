Declare Integer FindWindow In WIN32API String, String
Declare Integer SetForegroundWindow In WIN32API Integer
Declare Integer ShowWindow In WIN32API Integer, Integer
Declare Integer ShellExecute In shell32.Dll ;
	Integer hndWin, ;
	String cAction, ;
	String cFileName, ;
	String cParams, ;
	String cDir, ;
	Integer nShowWin
Local lt, lhwnd
**************************
*** Carga Whatsapp
**************************
* CON ADJUNTO SUBIR AL DRIVE/ONE NUBE / UBICACION LOCAL
*comando='whatsapp://send?phone=54xxxxxxxxxxx&text=Mensaje%0Ahttps://drive.google.com/file/d/xxxxxxxxxxxxxxxxxxxxx=sharing'
* sin adjunto
comando = 'whatsapp://send?phone=51994592115&text=hola desde vfp%0AWhatsapp%20 Prueba '
= ShellExecute(0, 'open', comando, '', '', 1)
**************************
Wait "" Timeout 1
lt = "Whatsapp"
lhwnd = FindWindow (0, lt)
If lhwnd!= 0 && Comprueba si la ventana está activada
	SetForegroundWindow (lhwnd) && Establece el foco en la ventana de la aplicación donde Tú envías la llave.
	ShowWindow (lhwnd, 1)
	ox = Createobject ( "Wscript.Shell" )
	ox.sendKeys ( '{ENTER}' )
	ox.sendKeys ( '{ENTER}' )
Else
	Messagebox ( "Whatsapp no activada!" )
Endif

