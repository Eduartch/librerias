************************************************************************************
*
* Program created by Marco Plaza , 2013-2016
* revision 2016/02/22
*
************************************************************************************

Parameters vXml,atributosComoNodos,xpathExp,returnXml

Private All

* falta implementar returnXml


oVfp = Createobject('empty')

Do Case
Case Vartype(vXml) = 'O'

	oXml = vXml

Case Vartype(vXml) = 'C'

	oXml = Createobject('microsoft.xmldom')
	oXml.Async = .F.

	If Len(vXml) < 255 And File(vXml)
		oXml.Load(vXml)
	Else
		oXml.LoadXML(vXml)
	Endif

Otherwise
	Return .Null.

Endcase

If Vartype(xpathExp) = 'L'

	=recnodo(oXml.childnodes(),oVfp,atributosComoNodos)

	If Type('oVfp.xml') = 'O'
		Return oVfp.XML
	Else
		Return oVfp
	Endif

Else

	Try

		oResXml = oXml.selectNodes(xpathExp)
		resul=oResXml.Item(0).Text

	Catch
		resul=.Null.

	Endtry

	Return resul

Endif


*-------------------------------------------
Procedure recnodo( oNodos, esteo, atributosComoNodos )
*-------------------------------------------

Private All


For Each nodo In oNodos

	With nodo

		If .nodeType # 1
			Loop
		Endif

		esTextNode = .childnodes.Length = 1 And ( .firstchild.nodeType = 3 Or .firstchild.nodeType = 4 )

		emptyNode = .childnodes.Length = 0

		tieneAtributos = .Attributes.Length > 0

		NombreNodo = conv2asc(.nodeName)
		NombreNodoFix = '_'+m.NombreNodo

		nuevoNodo = Type('esteo.&nombreNodo') = 'U' And Type('esteo.&nombreNodoFix') = 'U'

	Do case
	 Case m.emptyNode
	 	m.nuevoValor = ''
	 Case m.esTextNode And !m.tieneAtributos
		nuevoValor = .firstchild.nodeValue
	 Otherwise
		nuevoValor = Createobject('empty')
	EndCase
		

		If m.nuevoNodo

			If .selectNodes('../'+.nodeName).Length =  1

				AddProperty(m.esteo,m.NombreNodo,m.nuevoValor)
				elemProc = 'esteo.'+m.NombreNodo

			Else

				Try
					AddProperty(m.esteo,(m.NombreNodo+'(1)'))

				Catch

					NombreNodo = m.NombreNodoFix

					AddProperty(m.esteo,(m.NombreNodo+'(1)'))

				Endtry

				esteo.&NombreNodo(1) = m.nuevoValor
				elemProc = 'esteo.'+m.NombreNodo+'(1)'

			Endif

		Else

			If Type('esteo.&nombreNodoFix') = 'U'
				nombreArray = m.NombreNodo
			Else
				nombreArray = m.NombreNodoFix
			Endif

			nvoelem = Alen(esteo.&nombreArray)+1
			nelemx = Alen(esteo.&nombreArray)

			Dimension esteo.&nombreArray( m.nvoelem )
			esteo.&nombreArray( nvoelem ) = m.nuevoValor
			elemProc = 'esteo.'+m.nombreArray+'('+Transform(m.nvoelem)+')'

		Endif

		If tieneAtributos

			If atributosComoNodos

				oa = elemProc

			Else

				#Define nodeAttributeTag '_attributes_'

				If esTextNode
					AddProperty(&elemProc,'value',.firstchild.nodeValue)
				Endif

				AddProperty(&elemProc,nodeAttributeTag,Createobject('empty'))

				oa=elemProc+'.'+nodeAttributeTag

			Endif

			For Each atributo In .Attributes

				nombreAtr = conv2asc(atributo.Name)
				AddProperty(&oa,nombreAtr,atributo.Value)

			Endfor


		Endif

		If !m.esTextNode And .childnodes.Length > 0
			=recnodo( .childnodes(), &elemProc, atributosComoNodos )
		Endif

	Endwith

Endfor

*---------------------------
Function conv2asc( cTag )
*---------------------------
cTag = Strtran(m.cTag,':','_58_')
cTag = Strtran(m.cTag,'(','_40_')
cTag = Strtran(m.cTag,')','_41_')
cTag = Strtran(m.cTag,'-','_45_')
Return cTag


*************************************************************************
