#Define ERRORPROC "NO SE EJECUTO CORRECTAMENTE El Proceso "
#Define MSGTITULO "SISVEN"
Define Class Precios As Custom
	codigo=0
	CodProducto=0
	CodCliente=0
	Nprecio=0
	Cestado=""
	Nopcion=0
	placa=""
	Function RegistraPreciosXCliente
	lc='ProIngresaPrecioxCliente'
	cur=""
	goapp.npara1=This.CodProducto
	goapp.npara2=This.CodCliente
	goapp.npara3=This.Nprecio
	TEXT to lp noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' Creando Precios por Clientes')
		Return 0
	Else
		Return 1
	Endif
	Endfunc
	Function RegistraPreciosXCliente20
	lc='ProIngresaPrecioxCliente'
	cur=""
	goapp.npara1=This.CodProducto
	goapp.npara2=This.CodCliente
	goapp.npara3=This.Nprecio
	goapp.npara4=This.placa
	TEXT to lp noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' Creando Precios por Clientes')
		Return 0
	Else
		Return 1
	Endif
	Endfunc
	Procedure ActualizaPreciosPorCliente
	lc='ProActualizaPrecioxCliente'
	cur=""
	goapp.npara1=This.CodProducto
	goapp.npara2=This.CodCliente
	goapp.npara3=This.Nprecio
	goapp.npara4=This.codigo
	goapp.npara5=This.Nopcion
	TEXT to lp noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' Editando Precios Clientes')
		Return 0
	Else
		Return  1
	Endif
	ENDPROC
	
	Procedure ActualizaPreciosPorCliente20
    lc='ProActualizaPrecioxCliente'
	cur=""
	goapp.npara1=This.CodProducto
	goapp.npara2=This.CodCliente
	goapp.npara3=This.Nprecio
	goapp.npara4=This.codigo
	goapp.npara5=This.Nopcion
	goapp.npara6=this.placa
	TEXT to lp noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' Editando Precios Clientes')
		Return 0
	Else
		Return  1
	Endif
	Endproc
	
	Procedure ListarPreciosclientes
	Lparameters	np1,ccursor
	lc='ProListarPrecioxCliente'
	goapp.npara1=np1
	TEXT to lp noshow
          (?goapp.npara1)
	ENDTEXT
	If EJECUTARP(lc,lp,ccursor)=0 Then
		errorbd(ERRORPROC+ ' Mostrando Lista de Precios Por Clientes')
		Return 0
	Else
		Return 1
	Endif
	Endproc
	Procedure ObtenerPrecioCliente
	Lparameters	np1,np2,ccursor
	lc='ProListarPrecioxClienteproducto'
	goapp.npara1=np1
	goapp.npara2=np2
	TEXT to lp noshow
          (?goapp.npara1,?goapp.npara2)
	ENDTEXT
	If EJECUTARP(lc,lp,ccursor)=0 Then
		errorbd(ERRORPROC+ ' Mostrando Lista de Precios Por Clientes')
		Return 0
	Else
		Return 1
	Endif
	Endproc
	Procedure ObtenerPrecioCliente20
	Lparameters	np1,np2,np3,ccursor
	lc='ProListarPrecioxClienteproductoxplaca'
	goapp.npara1=np1
	goapp.npara2=np2
	goapp.npara3=np3
	TEXT to lp noshow
          (?goapp.npara1,?goapp.npara2,?goapp.npara3)
	ENDTEXT
	If EJECUTARP(lc,lp,ccursor)=0 Then
		errorbd(ERRORPROC+ ' Mostrando Lista de Precios Por Clientes')
		Return 0
	Else
		Return 1
	Endif
	Endproc
	Procedure ListarPreciosclientesxplaca
	Lparameters	np1,np2,ccursor
	lc='ProListarPrecioxClientexplaca'
	goapp.npara1=np1
	goapp.npara2=np2
	TEXT to lp noshow
          (?goapp.npara1,?goapp.npara2)
	ENDTEXT
	If EJECUTARP(lc,lp,ccursor)=0 Then
		errorbd(ERRORPROC+ ' Mostrando LIsta de Precios Por Clientes')
		Return 0
	Else
		Return 1
	Endif
	Endproc
Enddefine
