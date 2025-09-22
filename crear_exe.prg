Lparameters tcNombreSistema,cruta,crutaftp
*DO d:\librerias\crear_exe WITH 'sisven','d:\psysg\','psysg'
Local lcMensajeError, lcNombreEXE, lcNombrePRY, lcNombreTXT, lcNombreZIP, lcCarpetaFTP, lnElementos, lcVersionNro, lnBytes, lcComando, loShell, lnResultado, loFTP

#Define KEY_ENTER  13

#Define SW_SHOW_HIDDEN 0
#Define SW_SHOW_NORMAL 1
#Define MSGTITULO   'sisven'

Do Case
Case Pcount() <> 3
	=Messagebox("Debes especificar el Nombre del Sistema")
	Return
Case Vartype(tcNombreSistema) <> "C" .Or. Empty(tcNombreSistema)
	=Messagebox("No has especificado correctamente el nombre del Sistema",16,MSGTITULO)
	Return
Endcase

lcMensajeError = ""

Set Procedure To d:\librerias\FTP_CLASS

lcNombreEXE  = tcNombreSistema + ".exe"
lcNombrePRY  = tcNombreSistema + ".PJX"
lcNombreTXT  = tcNombreSistema + "_version.txt"
lcNombreTXT  = "sisven" + "_version.txt"
lcNombreZIP  = tcNombreSistema + ".zip"
lcCarpetaFTP = "/sisven/" + Lower(crutaftp) + "/"

lnBytes     = -1
lnResultado = -1

*--- Se crea el ejecutable
*Build Exe (lcNombreEXE) From (lcNombrePRY) RECOMPILE

*--- Se obtiene la versión del ejecutable
lnElementos = Agetfileversion(laVersion, lcNombreEXE)
Set Default To Addbs((cruta))
If lnElementos > 0 Then     && Se crea el archivo .TXT
	lcVersionNro = laVersion[4]
	lnBytes      = Strtofile(lcVersionNro, lcNombreTXT, 0)
Endif

If lnBytes > 0 Then     && Se comprime el .EXE y se crea el .ZIP
	carchivo=Addbs(cruta)+lcNombreEXE
	Set Library To Locfile("vfpcompression.fll")
	lnResultado=ZipfileQuick(carchivo)
	zipclose()
Endif
If lnBytes > 0 And lnResultado Then     && Se envían los archivos al Servidor FTP
	loFTP = Createobject("CLASE_FTP")
	If Vartype(loFTP) == "O" Then
		With loFTP
			.cServidorFTP   = "ftp.companysysven.com"
			.cNombreUsuario = "syscom"
			.cContrasena    = "f2pwO0lao1D9"
*!*				.cServidorFTP   = "ftp.companiasysven.com"
*!*				.cNombreUsuario = "sysven"
*!*				.cContrasena    = "gkMLjR0HJ09I"
*!*				.cPuertoNro     = "21"

	
			.CONECTAR_SERVIDOR_FTP()
			If Empty(.cMensajeError) Then
				mensaje( "Conexión exitosa al Servidor FTP" )
				.CAMBIAR_A_LA_CARPETA_REMOTA(lcCarpetaFTP)
				If Empty(.cMensajeError) Then
					mensaje( "Cambio exitoso a la carpeta " + lcCarpetaFTP )
					lcNombreArchivoFTP = lcCarpetaFTP + lcNombreZIP
					.ENVIAR_ARCHIVO_AL_SERVIDOR_FTP(lcNombreZIP, lcNombreArchivoFTP)
					If Empty(.cMensajeError) Then
						mensaje("El archivo " + lcNombreZIP + " fue enviado exitosamente al Servidor FTP")
						lcNombreArchivoFTP = lcCarpetaFTP + lcNombreTXT
						.ENVIAR_ARCHIVO_AL_SERVIDOR_FTP(lcNombreTXT, lcNombreArchivoFTP)
						If Empty(.cMensajeError) Then
							mensaje("El archivo " + lcNombreTXT + " fue enviado exitosamente al Servidor FTP")
						Else
							lcMensajeError = "No pude enviar el archivo " + lcNombreTXT + " al Servidor FTP"
						Endif
					Else
						lcMensajeError = "No pude enviar el archivo " + lcNombreZIP + " al Servidor FTP"+ " "+ALLTRIM(.cMensajeError)
					Endif
				Else
					lcMensajeError = "No pude cambiarme a la carpeta " + lcCarpetaFTP
				Endif
			Else
				lcMensajeError = "No me pude conectar al Servidor FTP"
			Endif
			.DESCONECTAR_SERVIDOR_FTP()
		Endwith
	Else
		lcMensajeError = "No pude crear un objeto de clase FTP_CLASS"
	Endif
	loFTP = .Null.
	Release loFTP
Else
	If lnBytes <= 0 Then
		lcMensajeError = "El archivo ejecutable no tiene número de versión"
	Else
		lcMensajeError = "No pude comprimir el archivo " + lcNombreEXE  
	Endif
Endif

If Empty(lcMensajeError) Then
	=Messagebox("Fue creado el archivo " + lcNombreEXE + " y enviado al Servidor FTP",64,MSGTITULO)
Else
	=Messagebox(lcMensajeError,64,MSGTITULO)
Endif

Close All
Clear All

Return
*
*
