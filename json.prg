*
* vfpjson
*
* ----------------------------------
* Ignacio Gutiérrez Torrero
* SAIT Software Administrativo
* www.sait.com.mx
* +52(653)534-8800
* Monterrey México
* -----------------------------------
*
* JSON Library in VFP
* Libreria para el manejo de JSON en VFP
*
* http://code.google.com/p/dart/source/browse/trunk/dart/lib/json/json.dart
* Thanks Google for the code in Json Dart
* Gracias a Google por el codigo de Json de Dart
*
* json_encode(xExpr)
* returns a string, that is the json of any expression passed
*
* json_decode(cJson)
* returns an object, from the string passed
*
* json_getErrorMsg()
* returns empty if no error found in last decode.
*
*
*
* Examples:
*
* set procedure json additive
* oPerson = json_decode(' { "name":"Ignacio" , "lastname":"Gutierrez", "age":33 } ')
* if not empty(json_getErrorMsg())
*	? 'Error in decode:'+json_getErrorMsg())
*	return
* endif
* ? oPerson.get('name') , oPerson.get('lastname')
*
*
* oJson = newobject('json','json.prg')
* oCustomer = oJson.decode( ' { "name":"Ignacio" , "lastname":"Gutierrez", "age":33 } ')
* ? oJson.encode(oCustomer)
* ? oCustomer.get('name')
* ? oCustomer.get('lastname')
*

* obj = oJson.decode('{"jsonrpc":"1.0", "id":1, "method":"sumArray", "params":[3.1415,2.14,10],"version":1.0}')
* ? obj.get('jsonrpc'), obj._jsonrpc
* ? obj.get('id'), obj._id
* ? obj.get('method'), obj._method
* ? obj._Params.array[1], obj._Params.get(1)
*
*

*
*
lRunTest = .T.
If lRunTest
	testJsonClass()
Endif
Return


Function json_encode(xExpr)
If Vartype(_json)<>'O'
	Public _json
	_json = Newobject('json')
Endif
Return _json.encode(@xExpr)


Function json_decode(cJson)
Local retval
If Vartype(_json)<>'O'
	Public _json
	_json = Newobject('json')
Endif
retval = _json.decode(cJson)
If Not Empty(_json.cError)
	Return Null
Endif
Return retval

Function json_getErrorMsg()
Return _json.cError





*
* recordToJson()
*
* Returns the json representation for current record
* Try it:
* 		use c:\mydir\mytable
*		cInfo = recordToJson()
*		? cInfo
*
Function recordToJson
Local nRecno,i,oObj, cRetVal
If Alias()==''
	Return ''
Endif
oObj = Newobject('myObj')
For i=1 To Fcount()
	oObj.Set(Field(i),Eval(Field(i)))
Next
cRetVal = json_encode(oObj)
If Not Empty(json_getErrorMsg())
	cRetVal = 'ERROR:'+json_getErrorMsg()
Endif
Return cRetVal




*
* tableToJson()
*
* Returns the json representation for current table
* Warning need to be changed for large table, because use dimension aInfo[reccount()]
* For large table should change to create the string record by record.
*
* Try it:
* 		use c:\mydir\mytable
*		cInfo = tableToJson()
*		? cInfo
*		_cliptext = strtran(cInfo, ',{"', ','+chr(13)+'{"')
*		Go to Any Editor and Paste the information
*
Function tableToJson
Local nRecno,i,oObj, cRetVal,nRec
If Alias()==''
	Return ''
Endif
nRecno = Recno()
nRec = 1
Dimension aInfo[1]
Scan
	oObj = Newobject('myObj')
	For i=1 To Fcount()
		oObj.Set(Field(i),Eval(Field(i)))
	Next
	Dimension aInfo[nRec]
	aInfo[nRec] = oObj
	nRec = nRec+1
Endscan
Goto nRecno
cRetVal = json_encode(@aInfo)
If Not Empty(json_getErrorMsg())
	cRetVal = 'ERROR:'+json_getErrorMsg()
Endif
Return cRetVal





*
* json class
*
*
Define Class json As Custom


	nPos=0
	nLen=0
	cJson=''
	cError=''


*
* Genera el codigo cJson para parametro que se manda
*
	Function encode(xExpr)
	Local cTipo
* Cuando se manda una arreglo,
	If Type('ALen(xExpr)')=='N'
		cTipo = 'A'
	Else
		cTipo = Vartype(xExpr)
	Endif

	Do Case
	Case cTipo=='D'
		Return '"'+Dtos(xExpr)+'"'
	Case cTipo=='N'
		Return Transform(xExpr)
	Case cTipo=='L'
		Return Iif(xExpr,'true','false')
	Case cTipo=='X'
		Return 'null'
	Case cTipo=='C'
		xExpr = Allt(xExpr)
		xExpr = Strtran(xExpr, '\', '\\' )
		xExpr = Strtran(xExpr, '/', '\/' )
		xExpr = Strtran(xExpr, Chr(9),  '\t' )
		xExpr = Strtran(xExpr, Chr(10), '\n' )
		xExpr = Strtran(xExpr, Chr(13), '\r' )
		xExpr = Strtran(xExpr, '"', '\"' )
		Return '"'+xExpr+'"'

	Case cTipo=='O'
		Local cProp, cJsonValue, cRetVal, aProp[1]
		=Amembers(aProp,xExpr)
		cRetVal = ''
		For Each cProp In aProp
*?? cProp,','
*? cRetVal
			If Type('xExpr.'+cProp)=='U' Or cProp=='CLASS'
* algunas propiedades pueden no estar definidas
* como: activecontrol, parent, etc
				Loop
			Endif
			If Type( 'ALen(xExpr.'+cProp+')' ) == 'N'
*
* es un arreglo, recorrerlo usando los [ ] y macro
*
				Local i,nTotElem
				cJsonValue = ''
				nTotElem = Eval('ALen(xExpr.'+cProp+')')
				For i=1 To nTotElem
					cmd = 'cJsonValue=cJsonValue+","+ this.encode( xExpr.'+cProp+'[i])'
					&cmd.
				Next
				cJsonValue = '[' + Substr(cJsonValue,2) + ']'
			Else
*
* es otro tipo de dato normal C, N, L
*
				cJsonValue = This.encode( Evaluate( 'xExpr.'+cProp ) )
			Endif
			If Left(cProp,1)=='_'
				cProp = Substr(cProp,2)
			Endif
			cRetVal = cRetVal + ',' + '"' + Lower(cProp) + '":' + cJsonValue
		Next
		Return '{' + Substr(cRetVal,2) + '}'

	Case cTipo=='A'
		Local valor, cRetVal
		cRetVal = ''
		For Each valor In xExpr
			cRetVal = cRetVal + ',' +  This.encode( valor )
		Next
		Return  '[' + Substr(cRetVal,2) + ']'

	Endcase

	Return ''





*
* regresa un elemento representado por la cadena json que se manda
*

	Function decode(cJson)
	Local retValue
	cJson = Strtran(cJson,Chr(9),'')
	cJson = Strtran(cJson,Chr(10),'')
	cJson = Strtran(cJson,Chr(13),'')
	cJson = This.fixUnicode(cJson)
	This.nPos  = 1
	This.cJson = cJson
	This.nLen  = Len(cJson)
	This.cError = ''
	retValue = This.parsevalue()
	If Not Empty(This.cError)
		Return Null
	Endif
	If This.getToken()<>Null
		This.setError('Junk at the end of JSON input')
		Return Null
	Endif
	Return retValue


	Function parsevalue()
	Local token
	token = This.getToken()
	If token==Null
		This.setError('Nothing to parse')
		Return Null
	Endif
	Do Case
	Case token=='"'
		Return This.parseString()
	Case Isdigit(token) Or token=='-'
		Return This.parseNumber()
	Case token=='n'
		Return This.expectedKeyword('null',Null)
	Case token=='f'
		Return This.expectedKeyword('false',.F.)
	Case token=='t'
		Return This.expectedKeyword('true',.T.)
	Case token=='{'
		Return This.parseObject()
	Case token=='['
		Return This.parseArray()
	Otherwise
		This.setError('Unexpected token')
	Endcase
	Return


	Function expectedKeyword(cWord,eValue)
	For i=1 To Len(cWord)
		cChar = This.getChar()
		If cChar <> Substr(cWord,i,1)
			This.setError("Expected keyword '" + cWord + "'")
			Return ''
		Endif
		This.nPos = This.nPos + 1
	Next
	Return eValue


	Function parseObject()
	Local retval, cPropName, xValue
	retval = Createobject('myObj')
	This.nPos = This.nPos + 1 && Eat {
	If This.getToken()<>'}'
		Do While .T.
			cPropName = This.parseString()
			If Not Empty(This.cError)
				Return Null
			Endif
			If This.getToken()<>':'
				This.setError("Expected ':' when parsing object")
				Return Null
			Endif
			This.nPos = This.nPos + 1
			xValue = This.parsevalue()
			If Not Empty(This.cError)
				Return Null
			Endif
** Debug ? cPropName, type('xValue')
			retval.Set(cPropName, xValue)
			If This.getToken()<>','
				Exit
			Endif
			This.nPos = This.nPos + 1
		Enddo
	Endif
	If This.getToken()<>'}'
		This.setError("Expected '}' at the end of object")
		Return Null
	Endif
	This.nPos = This.nPos + 1
	Return retval


	Function parseArray()
	Local retval, xValue
	retval = Createobject('MyArray')
	This.nPos = This.nPos + 1	&& Eat [
	If This.getToken() <> ']'
		Do While .T.
			xValue = This.parsevalue()
			If Not Empty(This.cError)
				Return Null
			Endif
			retval.Add( xValue )
			If This.getToken()<>','
				Exit
			Endif
			This.nPos = This.nPos + 1
		Enddo
		If This.getToken() <> ']'
			This.setError('Expected ] at the end of array')
			Return Null
		Endif
	Endif
	This.nPos = This.nPos + 1
	Return retval


	Function parseString()
	Local cRetVal, c
	If This.getToken()<>'"'
		This.setError('Expected "')
		Return ''
	Endif
	This.nPos = This.nPos + 1 	&& Eat "
	cRetVal = ''
	Do While .T.
		c = This.getChar()
		If c==''
			Return ''
		Endif
		If c == '"'
			This.nPos = This.nPos + 1
			Exit
		Endif
		If c == '\'
			This.nPos = This.nPos + 1
			If (This.nPos>This.nLen)
				This.setError('\\ at the end of input')
				Return ''
			Endif
			c = This.getChar()
			If c==''
				Return ''
			Endif
			Do Case
			Case c=='"'
				c='"'
			Case c=='\'
				c='\'
			Case c=='/'
				c='/'
			Case c=='b'
				c=Chr(8)
			Case c=='t'
				c=Chr(9)
			Case c=='n'
				c=Chr(10)
			Case c=='f'
				c=Chr(12)
			Case c=='r'
				c=Chr(13)
			CASE c=='ó'
			    c='o'
			CASE c=='é'
			    c='e'    
			Otherwise
******* FALTAN LOS UNICODE
				This.setError('Invalid escape sequence in string literal')
				Return ''
			Endcase
		Endif
		cRetVal = cRetVal + c
		This.nPos = This.nPos + 1
	Enddo
	Return cRetVal


**** Pendiente numeros con E
	Function parseNumber()
	Local nStartPos,c, isInt, cNumero
	If Not ( Isdigit(This.getToken()) Or This.getToken()=='-')
		This.setError('Expected number literal')
		Return 0
	Endif
	nStartPos = This.nPos
	c = This.getChar()
	If c == '-'
		c = This.nextChar()
	Endif
	If c == '0'
		c = This.nextChar()
	Else
		If Isdigit(c)
			c = This.nextChar()
			Do While Isdigit(c)
				c = This.nextChar()
			Enddo
		Else
			This.setError('Expected digit when parsing number')
			Return 0
		Endif
	Endif

	isInt = .T.
	If c=='.'
		c = This.nextChar()
		If Isdigit(c)
			c = This.nextChar()
			isInt = .F.
			Do While Isdigit(c)
				c = This.nextChar()
			Enddo
		Else
			This.setError('Expected digit following dot comma')
			Return 0
		Endif
	Endif

	cNumero = Substr(This.cJson, nStartPos, This.nPos - nStartPos)
	Return Val(cNumero)



	Function getToken()
	Local char1
	Do While .T.
		If This.nPos > This.nLen
			Return Null
		Endif
		char1 = Substr(This.cJson, This.nPos, 1)
		If char1==' '
			This.nPos = This.nPos + 1
			Loop
		Endif
		Return char1
	Enddo
	Return



	Function getChar()
	If This.nPos > This.nLen
		This.setError('Unexpected end of JSON stream')
		Return ''
	Endif
	Return Substr(This.cJson, This.nPos, 1)

	Function nextChar()
	This.nPos = This.nPos + 1
	If This.nPos > This.nLen
		Return ''
	Endif
	Return Substr(This.cJson, This.nPos, 1)

	Function setError(cMsg)
	This.cError= 'ERROR parsing JSON at Position:'+Allt(Str(This.nPos,6,0))+' '+cMsg
	Return

	Function getError()
	Return This.cError


	Function fixUnicode(cStr)
	cStr = Strtran(cStr,'\u00e1','á')
	cStr = Strtran(cStr,'\u00e9','é')
	cStr = Strtran(cStr,'\u00ed','í')
	cStr = Strtran(cStr,'\u00f3','ó')
	cStr = Strtran(cStr,'\u00fa','ú')
	cStr = Strtran(cStr,'\u00c1','Á')
	cStr = Strtran(cStr,'\u00c9','É')
	cStr = Strtran(cStr,'\u00cd','Í')
	cStr = Strtran(cStr,'\u00d3','Ó')
	cStr = Strtran(cStr,'\u00da','Ú')
	cStr = Strtran(cStr,'\u00f1','ñ')
	cStr = Strtran(cStr,'\u00d1','Ñ')
	Return cStr



Enddefine





*
* class used to return an array
*
Define Class myArray As Custom
	nSize = 0
	Dimension Array[1]

	Function Add(xExpr)
	This.nSize = This.nSize + 1
	Dimension This.Array[this.nSize]
	This.Array[this.nSize] = xExpr
	Return

	Function Get(N)
	Return This.Array[n]

	Function getsize()
	Return This.nSize

Enddefine



*
* class used to simulate an object
* all properties are prefixed with 'prop' to permit property names like: error, init
* that already exists like vfp methods
*
Define Class myObj As Custom
	Hidden ;
		ClassLibrary,Comment, ;
		BaseClass,ControlCount, ;
		Controls,Objects,Object,;
		Height,HelpContextID,Left,Name, ;
		Parent,ParentClass,Picture, ;
		Tag,Top,WhatsThisHelpID,Width

	Function Set(cPropName, xValue)
	cPropName = '_'+cPropName
	Do Case
	Case Type('ALen(xValue)')=='N'
* es un arreglo
		Local nLen,cmd,i
		This.AddProperty(cPropName+'(1)')
		nLen = Alen(xValue)
		cmd = 'Dimension This.'+cPropName+ ' [ '+Str(nLen,10,0)+']'
		&cmd.
		For i=1 To nLen
			cmd = 'This.'+cPropName+ ' [ '+Str(i,10,0)+'] = xValue[i]'
			&cmd.
		Next

	Case Type('this.'+cPropName)=='U'
* la propiedad no existe, definirla

		Try
			This.AddProperty(cPropName,@xValue)
		Catch to lEx WHEN lEx.ErrorNo = 1470
			This.AddProperty("Prop","")
		Finally
		Endtry
	Otherwise
* actualizar la propiedad
		Local cmd
		cmd = 'this.'+cPropName+'=xValue'
		&cmd
	Endcase
	Return

	Procedure Get (cPropName)
	cPropName = '_'+cPropName
	If Type('this.'+cPropName)=='U'
		Return ''
	Else
		Local cmd
		cmd = 'return this.'+cPropName
		&cmd
	Endif
	Return ''

Enddefine





Function testJsonClass
Clear
Set Decimal To 10
oJson = Newobject('json')


? 'Test Basic Types'
? '----------------'
? oJson.decode('null')
? oJson.decode('true')
? oJson.decode('false')
?
? oJson.decode('17311')
? oJson.decode('728.45')
? oJson.decode('88.45.')
? oJson.decode('"nacho gtz"')
If Not Empty(oJson.cError)
	? oJson.cError
	Return
Endif
? oJson.decode('"nacho gtz\nEs \"bueno\"\nMuy Bueno\ba"')
If Not Empty(oJson.cError)
	? oJson.cError
	Return
Endif

? 'Test Array'
? '----------'
arr = oJson.decode('[3.1416,"Ignacio",false,null]')
? arr.Get(1), arr.Get(2), arr.Get(3), arr.Get(4)
arr = oJson.decode('[ ["Hugo","Paco","Luis"] , [ 8,9,11] ] ')
nombres = arr.Get(1)
edades  = arr.Get(2)
? nombres.Get(1), edades.Get(1)
? nombres.Get(2), edades.Get(2)
? nombres.Get(3), edades.Get(3)
?
? 'Test Object'
? '-----------'
obj = oJson.decode('{"nombre":"Ignacio", "edad":33.17, "isGood":true}')
? obj.Get('nombre'), obj.Get('edad'), obj.Get('isGood')
? obj._Nombre, obj._Edad, obj._IsGood
obj = oJson.decode('{"jsonrpc":"1.0", "id":1, "method":"sumArray", "params":[3.1415,2.14,10],"version":1.0}')
? obj.Get('jsonrpc'), obj._jsonrpc
? obj.Get('id'), obj._id
? obj.Get('method'), obj._method
? obj._Params.Array[1], obj._Params.Get(1)

?
? 'Test nested object'
? '------------------'
cJson = '{"jsonrpc":"1.0", "id":1, "method":"upload", "params": {"data":{ "usrkey":"2415af77b", "sendto":"ignacio@sait.com.mx", "name":"Ignacio is \"Nacho\"","expires":"20120731" }}}'
obj = oJson.decode(cJson)
If Not Empty(oJson.cError)
	? oJson.cError
	Return
Endif
? cJson
? 'method -->',obj._method
? 'usrkey -->',obj._Params._data._usrkey
? 'sendto -->',obj._Params._data._sendto
? 'name  --->',obj._Params._data._name
? 'expires ->',obj._Params._data._expires

?
? 'Test empty object'
? '-----------------'
cJson = '{"result":null,"error":{"code":-3200.012,"message":"invalid usrkey","data":{}},"id":"1"}'
obj = oJson.decode(cJson)
If Not Empty(oJson.cError)
	? oJson.cError
	Return
Endif
? cJson
? 'result -->',obj._result, obj.Get('result')
oError = obj.Get('error')
? 'ErrCode ->',obj._error._code, oError.Get('code')
? 'ErrMsg -->',obj._error._message, oError.Get('message')
? 'id  ----->',obj._id, obj.Get('id')
?  Type("oError._code")

?
? 'Probar decode-enconde-decode-encode'
? '------------------------------------'
cJson = ' {"server":"", "user":"", "password":"" ,'+;
	' "port":0, "auth":false, "ssl":false, "timeout":20, "error":404}'
? cJson
oSmtp = json_decode(cJson)
cJson =  json_encode(oSmtp)
? cJson
oSmtp = json_decode(cJson)
cJson =  json_encode(oSmtp)
? cJson

* Probar falla
?
? 'Probar una falla en el json'
? '---------------------------'
cJson = ' {"server":"", "user":"", "password":"" ,'
oSmtp = json_decode(cJson)
If Not Empty(json_getErrorMsg())
	? json_getErrorMsg()
Endif

?
? 'Pruebas Finalizadas'
Return
