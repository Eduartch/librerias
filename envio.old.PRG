Set Procedure To d:\capass\capadatos,d:\librerias\json,d:\capass\modelos\comprobante Additive
Define Class envio As Custom
	nidauto=0

	Function generajson(nid)
	This.nidauto=nid
	Set Classlib To d:\librerias\fe Additive
	Endfunc
	Function consultardata()
	odata=Createobject("comprobante")
	If odata.consultardata(This.nidauto,'curf')<1 Then
		Return 0
	Endif
	Select curf
	cInfo = tableToJson()
	
	
	Endfunc
Enddefine
