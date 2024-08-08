Lparameters tcNombreSistema,cruta,crutaftp
Local lcNombreEXE, lcNombreTXT, lcNombreZIP, lcCarpetaFTP, lcMensajeError, loFTP, lcVersionRemota, lcVersionLocal, lnElementos, lcComando, loShell, lnResultado

#Define SW_SHOW_HIDDEN 0
#Define SW_SHOW_NORMAL 1
#Define MSGTITULO   'SYSVEN'
Do Case
Case Pcount() <> 3
	=Messagebox("Debes especificar el Nombre del Sistema",64,MSGTITULO)
	Return
Case Vartype(tcNombreSistema) <> "C" .Or. Empty(tcNombreSistema)
	=Messagebox("No has especificado correctamente el nombre del Sistema",64,MSGTITULO)
	Return
Endcase

tcNombreSistema = tcNombreSistema
tcNombreSistema = Strtran(tcNombreSistema, ".EXE", "")

lcMensajeError = ""

Set Procedure To d:\librerias\FTP_CLASS

lcNombreEXE  = tcNombreSistema + ".exe"
lcNombreTXT  = tcNombreSistema + "_version.txt"
lcNombreZIP  = tcNombreSistema + ".zip"
lcCarpetaFTP = "/sisven/" + Lower(crutaftp) + "/"


loFTP = Createobject("CLASE_FTP")
Set Default To Addbs((cruta))
If Vartype(loFTP) == "O" Then
	With loFTP
*!*	*.cServidorFTP   = "158.69.241.20"
*!*	*.cNombreUsuario = "factura"
*!*	*.cContrasena    = "P455w0rd18?!"
*!*			.cServidorFTP   = "ftp.compania-sysven.com"
*!*			.cNombreUsuario = "eduar"
*!*			.cContrasena    = ")B1kyMpx3[7VX8"

		.cServidorFTP   = "ftp.compania-sysven.com"
		.cNombreUsuario = "eduar"
		.cContrasena    = "N3wSyst3m21?!"

		.cPuertoNro     = "21"
		.CONECTAR_SERVIDOR_FTP()
		If Empty(.cMensajeError) Then
			Mensaje( "Obteniendo Actualizaciones")
			.CAMBIAR_A_LA_CARPETA_REMOTA(lcCarpetaFTP)
			If Empty(.cMensajeError) Then
				If .RECIBIR_ARCHIVO_REMOTO(lcNombreTXT, lcNombreTXT, .F.) Then
					lcVersionRemota = Filetostr(lcNombreTXT)
					lnElementos     = Agetfileversion(laVersion, lcNombreEXE)
					lcVersionLocal  = Iif(lnElementos > 0, laVersion[4], "ERROR")
					If lcVersionRemota > lcVersionLocal .Or. lcVersionLocal == "ERROR" Then
						If .RECIBIR_ARCHIVO_REMOTO(lcNombreZIP, lcNombreZIP, .F.) Then
							Mensaje("Recibido la actualización " + lcNombreZIP)
							Set Library To Locfile("vfpcompression.fll")
							carchivo=Addbs(cruta)
							lnResultado=UnzipQuick(lcNombreZIP,carchivo,.F.)
						Else
							lcMensajeError = "No pude recibir el archivo. " + lcNombreZIP
						Endif
					Endif
				Else
					lcMensajeError = "No pude recibir el archivo ... " + lcNombreTXT
				Endif
			Else
				lcMensajeError = "No pude cambiarme a la carpeta " + lcCarpetaFTP + ". Verifica que existe"
			Endif
		Else
			lcMensajeError = "No me pude conectar al Servidor FTP"
		Endif
		.DESCONECTAR_SERVIDOR_FTP()
	Endwith
Else
	lcMensajeError = "No pude crear un objeto FTP_CLASS"
Endif

loFTP = .Null.

Release loFTP

If Empty(lcMensajeError) Then
	Mensaje("Actualizado")
Else
	*=Messagebox(lcMensajeError,64,MSGTITULO)
	mensaje(lcMensajeError)
Endif
	Do (lcNombreEXE)
Close All
Clear All

Return
*
*
Procedure Mensaje
Lparameters lcMess
If Type("lcMess") = "L"
	Return .F.
Endif
Wait Window lcMess At Srows()/2,(Scols()/2 - (Len(lcMess)/2)) Timeout 1
Endproc





*						*	WAIT WINDOW lnResultado
* lcComando = "7za e -y " + lcNombreZIP + " " + lcNombreEXE
*  loShell   = CreateObject("WScript.Shell")
* TRY
*   lnResultado = loShell.RUN(lcComando, SW_SHOW_NORMAL, .T.)
*CATCH
*  lcMensajeError = "No pude extraer el archivo " + lcNombreEXE
* ENDTRY
*loShell = .NULL.
* RELEASE loShell
