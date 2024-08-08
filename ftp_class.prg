*-------------------------------------------------------------------------------------------------------------------------------------------
* Nombre del Programa   : FTP_CLASS.PRG
* Nombre del Programador: Walter R. Ojeda Valiente
* Fecha                 : 11/AGO/2019
* Tarea realizada       : Clase para conectar/desconectar a un Servidor FTP y enviarle comandos
* Dirección en el blog  : https://vfpavanzado.wordpress.com/2019/08/12/usar-ftp-para-enviar-y-recibir-archivos-de-una-computadora-remota/
*-------------------------------------------------------------------------------------------------------------------------------------------
*
*
#Define BIT_ATTRIBUTE_READONLY       0
#Define BIT_ATTRIBUTE_HIDDEN         1
#Define BIT_ATTRIBUTE_SYSTEM         2
#Define BIT_ATTRIBUTE_DIRECTORY      4
#Define BIT_ATTRIBUTE_ARCHIVE        5
#Define BIT_ATTRIBUTE_ENCRYPTED      6
#Define BIT_ATTRIBUTE_NORMAL         7
#Define BIT_ATTRIBUTE_TEMPORARY      8
#Define BIT_ATTRIBUTE_SPARSE_FILE    9
#Define BIT_ATTRIBUTE_REPARSE_POINT 10
#Define BIT_ATTRIBUTE_COMPRESSED    11
#Define BIT_ATTRIBUTE_OFFLINE       12

#Define BYTE_1 1
#Define BYTE_2 256
#Define BYTE_3 65536
#Define BYTE_4 16777216
#Define BYTE_M 4294967295

#Define ERROR_NO_HAY_MAS_ARCHIVOS 18

#Define FILE_ATTRIBUTE_NORMAL    128

#Define FTP_TRANSFER_TYPE_BINARY   2

#Define INTERNET_OPEN_TYPE_DIRECT 1
#Define INTERNET_SERVICE_FTP      1

#Define VAR_MAX_BYTES 260
#Define VAR_NULL      Chr(0)
*
*

Procedure mensaje
Lparameters lcMess
If Type("lcMess") = "L"
	Return .F.
Endif
Wait Window lcMess At Srows() / 2, (Scols() / 2 - (Len(lcMess) / 2)) Timeout 1
Endproc
Define Class CLASE_FTP As Custom

	cAgente          = "Sysven" + VAR_NULL
	cCarpetaRemota   = ""
	cContrasena      = ""
	cDatosArchivo    = ""
	cMensajeError    = ""
	cNombreUsuario   = ""
	cPuertoNro       = "21"
	cServidorFTP     = ""

	lApiCargadas     = .F.     && Para no volver a cargar las DLL en la memoria, si es que ya estaban cargadas

	nCodigoResultado = 0       && El kernel del Windows32 devuelve un número indicando cual fue el último error ocurrido
	nInternetHandle  = 0       && El handle a una conexión de Internet
	nFtpHandle       = 0       && El handle a una conexión FTP
*
*
	Function BORRAR_ARCHIVO_REMOTO
	Lparameters tcArchivo
	Local lnResultado

	lnResultado = 0

	If This.nFtpHandle > 0 Then
		tcArchivo   = tcArchivo + VAR_NULL
		lnResultado = FtpDeleteFile(This.nFtpHandle, @tcArchivo)
		This.OBTENER_ERROR(lnResultado = 0, "No pude borrar el archivo remoto")
	Endif

	Return (lnResultado = 1)     && lnResultado = 1 significa que el archivo remoto fue borrado exitosamente

	Endfunc
*
*
	Function BORRAR_CARPETA_REMOTA
	Lparameters tcCarpeta
	Local lnResultado

	lnResultado = 0

	If This.nFtpHandle > 0 Then
		tcCarpeta   = tcCarpeta + VAR_NULL
		lnResultado = FtpRemoveDirectory(This.nFtpHandle, @tcCarpeta)
		This.OBTENER_ERROR(lnResultado = 0, "No pude borrar la carpeta remota")
	Endif

	Return (lnResultado = 1)     && lnResultado = 1 significa que la carpeta remota fue borrada exitosamente

	Endfunc
*
*
	Function CAMBIAR_A_LA_CARPETA_REMOTA
	Lparameters tcNombreCarpeta
	Local lnResultado, lcCarpetaTemporal

	lnResultado = 0

	tcNombreCarpeta   = tcNombreCarpeta + VAR_NULL
	lcCarpetaTemporal = Space(VAR_MAX_BYTES)

	lnResultado = FtpSetCurrentDirectory(This.nFtpHandle, @tcNombreCarpeta)

	This.OBTENER_ERROR(lnResultado <> 1, "No me pude cambiar a la carpeta*" + tcNombreCarpeta)

	If lnResultado = 1 Then
		This.cCarpetaRemota = tcNombreCarpeta
	Endif

	Endfunc
*
*
	Function CARGAR_FUNCIONES_API

	If This.lApiCargadas Then     && Si ya se habían declarado y cargado en la memoria las funciones API, no es necesario volver a hacerlo
		Return(.T.)
	Endif

	Declare Integer FileTimeToSystemTime In KERNEL32 ;
		STRING @lpcBuffer, ;
		STRING @lpcBuffer

	Declare Integer GetLastError In KERNEL32

	Declare Integer FtpCreateDirectory In WININET ;
		INTEGER nConnect_Handle, ;
		STRING  @lpcDirectory

	Declare Integer FtpDeleteFile In WININET ;
		INTEGER nConnect_Handle, ;
		STRING  @lpcFileName

	Declare Integer FtpFindFirstFile In WININET ;
		INTEGER nConnect_Handle    , ;
		STRING  @lpcSearchStr      , ;
		STRING  @lpcWIN32_FIND_DATA, ;
		INTEGER nFlags             , ;
		INTEGER nContext

	Declare Integer FtpGetCurrentDirectory In WININET ;
		INTEGER nConnectHandle, ;
		STRING  @lpcDirectory , ;
		INTEGER @nMax_Path

	Declare Integer FtpGetFile In WININET ;
		INTEGER nConnect_Handle, ;
		STRING  @lpcRemoteFile, ;
		STRING  @lpcNewFile, ;
		INTEGER nFailIfExists, ;
		INTEGER nAttributes, ;
		INTEGER nFlags, ;
		INTEGER nContext

	Declare Integer FtpPutFile In WININET ;
		INTEGER nConnect_Handle, ;
		STRING  @lpcNewFile, ;
		STRING  @lpcRemoteFile, ;
		INTEGER nFlags, ;
		INTEGER nContext

	Declare Integer FtpRemoveDirectory In WININET ;
		INTEGER nConnect_Handle, ;
		STRING  @lpcDirectory

	Declare Integer FtpRenameFile In WININET ;
		INTEGER nConnect_Handle, ;
		STRING  @lpcRemoteFile, ;
		STRING  @lpcNewFile

	Declare Integer FtpSetCurrentDirectory In WININET ;
		INTEGER nConnect_Handle, ;
		STRING  @lpcDirectory

	Declare Integer InternetCloseHandle    In WININET ;
		INTEGER nConnect_Handle

	Declare Integer InternetConnect        In WININET ;
		INTEGER nInet_Handle, ;
		STRING  @lpcServer  , ;
		SHORT   nPort       , ;
		STRING  @lpcUserName, ;
		STRING  @lpcPassword, ;
		INTEGER nService    , ;
		INTEGER nFlags      , ;
		INTEGER nContext

	Declare Integer InternetFindNextFile In WININET ;
		INTEGER nConnect_Handle, ;
		STRING  @lpcWIN32_FIND_DATA

	Declare Integer InternetOpen           In WININET ;
		STRING  @lpcAgent      , ;
		INTEGER nAccessType    , ;
		STRING  @lpcProxyName  , ;
		STRING  @lpcProxyBypass, ;
		INTEGER nFlags

	This.lApiCargadas = .T.

	Return(.T.)

	Endfunc
*
*
	Function CONECTAR_SERVIDOR_FTP
	Local lnResultado, lcCarpetaTemporal, lnFtpHandle

	With This
*--- Trata de conectarse a Internet
		.nInternetHandle = InternetOpen((.cAgente), INTERNET_OPEN_TYPE_DIRECT, VAR_NULL, VAR_NULL, 0)
		.OBTENER_ERROR(.nInternetHandle = 0, "No pude conectarme a Internet**Verifica que haya una conexión")
*--- No se pudo conectar a Internet
		If .nInternetHandle <= 0 Then
			.CERRAR_FTP()
			Return(.F.)
		Endif
*--- Si se pudo conectar a Internet, trata de conectarse al Servidor FTP
		lnFtpHandle = InternetConnect(.nInternetHandle, (.cServidorFTP), Val(.cPuertoNro), (.cNombreUsuario), (.cContrasena), INTERNET_SERVICE_FTP, 0, 0)
		.OBTENER_ERROR(lnFtpHandle <= 0, "No me pude conectar al Servidor FTP*Probablemente los datos del Servidor o del usuario*son incorrectos")
*--- Si se pudo conectar al Servidor FTP, trata de obtener la carpeta remota raíz

		If lnFtpHandle > 0 Then
			.nFtpHandle       = lnFtpHandle
			lcCarpetaTemporal = .OBTENER_CARPETA_ACTUAL()
			If !Empty(lcCarpetaTemporal) Then
				.cCarpetaRemota = lcCarpetaTemporal
			Endif
		Endif
	Endwith

	Endfunc
*
*
	Function CREAR_CARPETA_REMOTA
	Lparameters tcNombreCarpeta
	Local lnResultado

	lnResultado = 0

	If This.nFtpHandle > 0 Then
		tcNombreCarpeta = tcNombreCarpeta + VAR_NULL
		lnResultado     = FtpCreateDirectory(This.nFtpHandle, @tcNombreCarpeta)
		This.OBTENER_ERROR(lnResultado <> 1, "No se pudo crear la carpeta remota")
	Endif

	Return (lnResultado = 1)     && lnResultado = 1 significa que la carpeta remota fue creada exitosamente

	Endfunc
*
*
	Function ENVIAR_ARCHIVO_AL_SERVIDOR_FTP
	Lparameters tcArchivoLocal, tcArchivoRemoto
	Local lnResultado

	lnResultado = 0

	If This.nFtpHandle > 0 Then
		tcArchivoRemoto = Iif(Vartype(tcArchivoRemoto) <> "C", tcArchivoLocal, tcArchivoRemoto)
		tcArchivoLocal  = tcArchivoLocal  + VAR_NULL
		tcArchivoRemoto = tcArchivoRemoto + VAR_NULL
		lnResultado      = FtpPutFile(This.nFtpHandle, @tcArchivoLocal, @tcArchivoRemoto, FTP_TRANSFER_TYPE_BINARY, 0)
		This.OBTENER_ERROR(lnResultado <> 1, "No pude enviar el archivo al Servidor FTP")
	Endif

	Return (lnResultado = 1)     && lnResultado = 1 significa que el archivo fue enviado exitosamente al Servidor FTP

	Endfunc
*
*
	Function EXISTE_EL_ARCHIVO_EN_EL_SERVIDOR_FTP
	Lparameters tcNombreArchivo
	Local lcEstructura, lnHandleTemp
	Local lcNombreArchivo, lcNombreAlternativo, lcTamano, lcDateTimeCreacion, lcDateTimeUltimoAcceso, lcDateTimeModificacion, lcAtributos

	This.cDatosArchivo = ""

	tcNombreArchivo = Strtran(tcNombreArchivo, VAR_NULL, "") + VAR_NULL

	lcEstructura = Space(319)     && Hay que alojar espacio para la estructura que se retornará
	lnHandleTemp = FtpFindFirstFile(This.nFtpHandle, @tcNombreArchivo, @lcEstructura, 0, 0)     && Se encuentra el primer archivo

	This.OBTENER_ERROR(lnHandleTemp = 0, "No existe el archivo en el Servidor FTP")

	If lnHandleTemp = 0 .Or. This.nCodigoResultado = ERROR_NO_HAY_MAS_ARCHIVOS Then
		Return (.F.)
	Endif

	Dimension taArrayCarpeta[1, 6]

	This.AGREGAR_AL_ARRAY(lcEstructura, @taArrayCarpeta)

	lcNombreArchivo        = Strtran(taArrayCarpeta[1, 1], VAR_NULL, "")
	lcTamano               = Transform(taArrayCarpeta[1, 2])
	lcDateTimeCreacion     = Ttoc(taArrayCarpeta[1, 3])
	lcDateTimeUltimoAcceso = Ttoc(taArrayCarpeta[1, 4])
	lcDateTimeModificacion = Ttoc(taArrayCarpeta[1, 5])
	lcAtributos            = taArrayCarpeta[1, 6]

	This.cDatosArchivo = lcNombreArchivo        + "|" ;
		+ lcTamano               + "|" ;
		+ lcDateTimeCreacion     + "|" ;
		+ lcDateTimeUltimoAcceso + "|" ;
		+ lcDateTimeModificacion + "|" ;
		+ lcAtributos

	This.DESCONECTAR_SERVIDOR_FTP()
	This.RECONECTAR_SERVIDOR_FTP()     && Se debe desconectar y volver a conectar al Servidor FTP para que se puedan volver a obtener los archivos

	Return (.T.)

	Endfunc
*
*
	Function OBTENER_ATRIBUTOS
	Lparameters tcBuffer
	Local lcAtributos, lnValor

	lcAtributos = ""

	lnValor = (Asc(Substr(tcBuffer, 1, 1)) * BYTE_1) ;
		+ (Asc(Substr(tcBuffer, 2, 1)) * BYTE_2) ;
		+ (Asc(Substr(tcBuffer, 3, 1)) * BYTE_3) ;
		+ (Asc(Substr(tcBuffer, 4, 1)) * BYTE_4)

	Do Case
	Case Bittest(lnValor, BIT_ATTRIBUTE_READONLY)
		lcAtributos = lcAtributos + 'R'
	Case Bittest(lnValor, BIT_ATTRIBUTE_HIDDEN)
		lcAtributos = lcAtributos + 'H'
	Case Bittest(lnValor, BIT_ATTRIBUTE_SYSTEM)
		lcAtributos = lcAtributos + 'S'
	Case Bittest(lnValor, BIT_ATTRIBUTE_DIRECTORY)
		lcAtributos = lcAtributos + 'D'
	Case Bittest(lnValor, BIT_ATTRIBUTE_ARCHIVE)
		lcAtributos = lcAtributos + 'A'
	Case Bittest(lnValor, BIT_ATTRIBUTE_NORMAL)
		lcAtributos = lcAtributos + 'N'
	Case Bittest(lnValor, BIT_ATTRIBUTE_TEMPORARY)
		lcAtributos = lcAtributos + 'T'
	Case Bittest(lnValor, BIT_ATTRIBUTE_COMPRESSED)
		lcAtributos = lcAtributos + 'C'
	Case Bittest(lnValor, BIT_ATTRIBUTE_OFFLINE)
		lcAtributos = lcAtributos + 'O'
	Endcase

	Return (lcAtributos)

	Endfunc
*
*
	Function OBTENER_CARPETA_ACTUAL
	Local lnResultado, lcCarpetaActual

	lcCarpetaActual = ""

	If This.nFtpHandle > 0 Then
		lcCarpetaActual = Space(VAR_MAX_BYTES)
		lnResultado     = FtpGetCurrentDirectory(This.nFtpHandle, @lcCarpetaActual, VAR_MAX_BYTES)
		If lnResultado > 0 Then
			lcCarpetaActual = Left(lcCarpetaActual, At(VAR_NULL, lcCarpetaActual) - 1)
		Endif
	Endif

	Return(lcCarpetaActual)

	Endfunc
*
*
	Function OBTENER_CONTENIDO_DE_LA_CARPETA_REMOTA
	Lparameters taArrayCarpeta, tcMascara
	Local lcEstructura, lnHandleTemp, lnResultado, lnFtpHandle

*--- taArrayCarpeta es un array donde se guardarán los datos de los archivos y carpetas encontrados
*--- tcMascara es la máscara para elegir cuales archivos se desea obtener, por ejemplo: *.*, *.PRG, *.SCX, etc.

	If This.nFtpHandle > 0 Then
		tcMascara = tcMascara + VAR_NULL
		Dimension taArrayCarpeta[1, 6]
* [x, 1] = Nombre del archivo o de la carpeta
* [x, 2] = Tamaño del archivo
* [x, 3] = Fecha de creación del archivo
* [x, 4] = Hora del último acceso al archivo
* [x, 5] = Hora de la última modificación al archivo
* [x, 6] = Atributos del archivo
		taArrayCarpeta[1, 1] = .F.
		lcEstructura = Space(319)     && Hay que alojar espacio para la estructura que se retornará
		lnHandleTemp = FtpFindFirstFile(This.nFtpHandle, @tcMascara, @lcEstructura, 0, 0)     && Se encuentra el primer archivo
		This.OBTENER_ERROR(lnHandleTemp = 0, "No pude obtener el primer archivo de la carpeta")
		If lnHandleTemp = 0 .Or. This.nCodigoResultado = ERROR_NO_HAY_MAS_ARCHIVOS Then
			Return (.F.)
		Endif
*--- Se agregan al array los datos del primer archivo obtenido (Nombre, tamaño, fecha de creación, atributos, etc.)
		This.AGREGAR_AL_ARRAY(lcEstructura, @taArrayCarpeta)
		lnResultado = 1
		Do While This.nCodigoResultado <> ERROR_NO_HAY_MAS_ARCHIVOS .And. lnResultado <> 0
			lcEstructura = Space(319)     && Hay que alojar espacio para la estructura que se retornará
			lnResultado  = InternetFindNextFile(lnHandleTemp, @lcEstructura)
			This.OBTENER_ERROR(.F.)
			If This.nCodigoResultado <> ERROR_NO_HAY_MAS_ARCHIVOS .And. lnResultado <> 0 Then
				This.AGREGAR_AL_ARRAY(lcEstructura, @taArrayCarpeta)
			Endif
		Enddo
		This.DESCONECTAR_SERVIDOR_FTP()
		This.RECONECTAR_SERVIDOR_FTP()     && Se debe desconectar y volver a conectar al Servidor FTP para que se puedan volver a obtener los archivos
	Else
		Return (.F.)
	Endif

	Return (.T.)

	Endfunc
*
*
	Function OBTENER_DATETIME
	Lparameters tcFecha
	Local lcBufferFecha, lnResultado, ltDateTime, lnAno, lnMes, lnDia, lnHor, lnMin, lnSeg, lcDateTime

	lcBufferFecha = Space(16)

	lnResultado = FileTimeToSystemTime(@tcFecha, @lcBufferFecha)
	This.OBTENER_ERROR(.F.)

	If lnResultado = 0 Then     && Si ocurrió un error, se devuelve una fecha por defecto
		ltDateTime = {^1901/01/01 00:00:01}
		Return (ltDateTime)
	Endif

	lnAno = Asc(Substr(lcBufferFecha,  1, 1)) + (Asc(Substr(lcBufferFecha,  2, 1)) * BYTE_2)
	lnMes = Asc(Substr(lcBufferFecha,  3, 1)) + (Asc(Substr(lcBufferFecha,  4, 1)) * BYTE_2)
	lnDia = Asc(Substr(lcBufferFecha,  7, 1)) + (Asc(Substr(lcBufferFecha,  8, 1)) * BYTE_2)
	lnHor = Asc(Substr(lcBufferFecha,  9, 1)) + (Asc(Substr(lcBufferFecha, 10, 1)) * BYTE_2)
	lnMin = Asc(Substr(lcBufferFecha, 11, 1)) + (Asc(Substr(lcBufferFecha, 12, 1)) * BYTE_2)
	lnSeg = Asc(Substr(lcBufferFecha, 13, 1)) + (Asc(Substr(lcBufferFecha, 13, 1)) * BYTE_2)

	lcDateTime = "^" + Transform(lnAno) + '/' + Transform(lnMes) + '/' + Transform(lnDia) + ' ' ;
		+       Transform(lnHor) + ':' + Transform(lnMin) + ':' + Transform(lnSeg)

	ltDateTime = {&lcDateTime }

	Return (ltDateTime)

	Endfunc
*
*
	Function RECIBIR_ARCHIVO_REMOTO
	Lparameters tcArchivoRemoto, tcArchivoLocal, tlErrorSiExiste
	Local lnResultado, lnError

	lnResultado = 0

	If This.nFtpHandle > 0 Then
		lnError         = Iif(tlErrorSiExiste, 1, 0)
		tcArchivoRemoto = tcArchivoRemoto + VAR_NULL
		tcArchivoLocal  = tcArchivoLocal  + VAR_NULL
		lnResultado     = FtpGetFile(This.nFtpHandle, @tcArchivoRemoto, @tcArchivoLocal, lnError, FILE_ATTRIBUTE_NORMAL, FTP_TRANSFER_TYPE_BINARY, 0)
		This.OBTENER_ERROR(lnResultado = 0, "No pude recibir el archivo")
	Endif

	Return (lnResultado = 1)     && lnResultado = 1 significa que el archivo fue recibido exitosamente desde el Servidor FTP

	Endfunc
*
*
	Function RENOMBRAR_ARCHIVO_REMOTO
	Lparameters tcNombreViejo, tcNombreNuevo
	Local lnResultado

	lnResultado = 0

	If This.nFtpHandle > 0 Then
		tcNombreViejo = tcNombreViejo + VAR_NULL
		tcNombreNuevo = tcNombreNuevo + VAR_NULL
		lnResultado   = FtpRenameFile(This.nFtpHandle, @tcNombreViejo, @tcNombreNuevo)
		This.OBTENER_ERROR(lnResultado = 0, "No pude renombrar el archivo")
	Endif

	Return (lnResultado = 1)     && lnResultado = 1 significa que el archivo fue renombrado exitosamente en el Servidor FTP

	Endfunc
*
*
	Procedure AGREGAR_AL_ARRAY
	Lparameters tcEstructura, taArrayDatos
	Local lcNombreArchivo, lcNombreAlternativo, lnTamanoArchivo, ltDateTimeCreacion, ltDateTimeUltimoAcceso, ltDateTimeModificacion, lcAtributos
	Local lnArrayLen, lnTamanoAlto, lnTamanoBajo, lcBufferDateTime

	If Vartype(taArrayDatos[1, 1]) == "L" Then     && El array nunca ha sido llenado con datos
		Dimension taArrayDatos[1, 6]
	Else
		Dimension taArrayDatos[Alen(taArrayDatos, 1) + 1 , 6]
	Endif

*--- Se obtiene la cantidad de filas del array
	lnArrayLen = Alen(taArrayDatos, 1)

*--- Nombre del archivo
	lcNombreArchivo = Substr(tcEstructura, 45, VAR_MAX_BYTES)
	lcNombreArchivo = Left(lcNombreArchivo, At(VAR_NULL, lcNombreArchivo) - 1)

*--- Nombre alternativo del archivo
	lcNombreAlternativo = Right(tcEstructura, 14)
	lcNombreAlternativo = Left(lcNombreAlternativo, At(VAR_NULL, lcNombreAlternativo) - 1)

*--- Tamaño del archivo
	lnTamanoAlto    = (Asc(Substr(tcEstructura, 29, 1)) * BYTE_1) ;
		+ (Asc(Substr(tcEstructura, 30, 1)) * BYTE_2) ;
		+ (Asc(Substr(tcEstructura, 31, 1)) * BYTE_3) ;
		+ (Asc(Substr(tcEstructura, 32, 1)) * BYTE_4)
	lnTamanoBajo    = (Asc(Substr(tcEstructura, 33, 1)) * BYTE_1) ;
		+ (Asc(Substr(tcEstructura, 34, 1)) * BYTE_2) ;
		+ (Asc(Substr(tcEstructura, 35, 1)) * BYTE_3) ;
		+ (Asc(Substr(tcEstructura, 36, 1)) * BYTE_4)
	lnTamanoArchivo = (lnTamanoAlto * BYTE_M) + lnTamanoBajo

*--- Fecha y hora de creación del archivo
	lcBufferDateTime   = Substr(tcEstructura, 5, 8)
	ltDateTimeCreacion = This.OBTENER_DATETIME(lcBufferDateTime )

*--- Fecha y hora de último acceso al archivo
	lcBufferDateTime       = Substr(tcEstructura, 13, 8)
	ltDateTimeUltimoAcceso = This.OBTENER_DATETIME(lcBufferDateTime )

*--- Fecha y hora de la última modificación al archivo
	lcBufferDateTime       = Substr(tcEstructura, 21, 8)
	ltDateTimeModificacion = This.OBTENER_DATETIME(lcBufferDateTime )

*--- Atributos del archivo
	lcAtributos = This.OBTENER_ATRIBUTOS(Left(tcEstructura, 4))

*--- Se agregan al array los datos obtenidos del archivo
	taArrayDatos[lnArrayLen, 1] = Strtran(Alltrim(lcNombreArchivo), VAR_NULL, "")
	taArrayDatos[lnArrayLen, 2] = lnTamanoArchivo
	taArrayDatos[lnArrayLen, 3] = ltDateTimeCreacion
	taArrayDatos[lnArrayLen, 4] = ltDateTimeUltimoAcceso
	taArrayDatos[lnArrayLen, 5] = ltDateTimeModificacion
	taArrayDatos[lnArrayLen, 6] = lcAtributos

	Endproc
*
*
	Procedure DESCONECTAR_SERVIDOR_FTP

	If This.nFtpHandle <> 0 Then
		InternetCloseHandle(This.nFtpHandle)
	Endif

	This.nFtpHandle = 0

	Endproc
*
*
	Procedure Init
*-- Se cargan las DLL que necesitará usar esta clase
	This.CARGAR_FUNCIONES_API()
	Endproc
*
*
	Procedure OBTENER_ERROR
	Lparameters tlHayError, tcMensajeError

	If tlHayError Then
		This.cMensajeError = tcMensajeError
	Endif

	This.nCodigoResultado = GetLastError()

	Do Case
	Case This.nCodigoResultado = 80
		This.cMensajeError = This.cMensajeError + "*Ya existe un archivo con el mismo nombre"
	Otherwise
		If This.nCodigoResultado <> 0 .And. !Empty(This.cMensajeError) Then
			This.cMensajeError = This.cMensajeError + "*Código del Resultado: " + Transform(This.nCodigoResultado)
		Endif
	Endcase

	Endproc
*
*
	Procedure RECONECTAR_SERVIDOR_FTP
	Local lnHandle, lcCarpetaActual, lnResultado

	With This
		.nFtpHandle = 0
		lnHandle = InternetConnect(.nInternetHandle, (.cServidorFTP), Val(.cPuertoNro), (.cNombreUsuario), (.cContrasena), INTERNET_SERVICE_FTP, 0, 0)
		.OBTENER_ERROR(lnHandle <= 0, "No me pude conectar al Servidor FTP**Verifica los datos de conexión")
		lcCarpetaActual = .cCarpetaRemota
		If lnHandle <> 0 Then
			lnResultado = FtpSetCurrentDirectory(lnHandle, @lcCarpetaActual)
			If lnResultado = 1 Then
				.nFtpHandle = lnHandle
				Return(.T.)
			Else
				.OBTENER_ERROR(lnResultado <> 1, "No pude establecer la carpeta remota")
				Return(.F.)
			Endif
		Else
			Return(.F.)
		Endif
	Endwith

	Endproc
*
*
Enddefine
*
*

