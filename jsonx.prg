Set Procedure To c:\librerias\json Additive

cruc="20480529244"
lcUrl="https://api.sunat.cloud/ruc/"+cruc
loXmlHttp = Createobject("Microsoft.XMLHTTP")
loXmlHttp.Open("POST" , lcUrl, .F.)
loXmlHttp.Send
If loXmlHttp.Status<>200 Then
	Messagebox("Servicio WEB NO Disponible.....",16,'Sisven')
	Return
Endif
lcHTML = loXmlHttp.Responsetext
oPersona = json_decode(lcHTML)
If Not Empty(json_getErrorMsg())
	? 'Error in decode:'+json_getErrorMsg())
	Return
Endif
? oPersona.Get("razon_social") , oPersona.Get("ruc")
