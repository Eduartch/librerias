Define Class Precios  As Odata Of 'd:\capass\database\data.prg'
	codigo = 0
	CodProducto = 0
	CodCliente = 0
	Nprecio = 0
	Cestado = ""
	Nopcion = 0
	placa = ""
	Function RegistraPreciosXCliente
	lc = 'ProIngresaPrecioxCliente'
	cur = ""
	goapp.npara1 = This.CodProducto
	goapp.npara2 = This.CodCliente
	goapp.npara3 = This.Nprecio
	Text To lp Noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3)
	Endtext
	If this.EJECUTARP(lc, lp, cur) < 1 Then
		Return 0
	Endif
	Return 1
	Endfunc
	Function RegistraPreciosXCliente20
	lc = 'ProIngresaPrecioxCliente'
	cur = ""
	goapp.npara1 = This.CodProducto
	goapp.npara2 = This.CodCliente
	goapp.npara3 = This.Nprecio
	goapp.npara4 = This.placa
	Text To lp Noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4)
	Endtext
	If This.EJECUTARP(lc, lp, cur) < 1 Then
		Return 0
	Endif
	Return 1
	Endfunc
	Procedure ActualizaPreciosPorCliente
	lc = 'ProActualizaPrecioxCliente'
	cur = ""
	goapp.npara1 = This.CodProducto
	goapp.npara2 = This.CodCliente
	goapp.npara3 = This.Nprecio
	goapp.npara4 = This.codigo
	goapp.npara5 = This.Nopcion
	Text To lp Noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5)
	Endtext
	If This.EJECUTARP(lc, lp, cur) < 1 Then
		Return 0
	Endif
	Return  1
	Endproc
	Procedure ActualizaPreciosPorCliente20
	lc = 'ProActualizaPrecioxCliente'
	cur = ""
	goapp.npara1 = This.CodProducto
	goapp.npara2 = This.CodCliente
	goapp.npara3 = This.Nprecio
	goapp.npara4 = This.codigo
	goapp.npara5 = This.Nopcion
	goapp.npara6 = This.placa
	Text To lp Noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6)
	Endtext
	If This.EJECUTARP(lc, lp, cur) < 1 Then
		Return 0
	Endif
	Return  1
	Endproc
	Procedure ListarPreciosclientes
	Lparameters	np1, ccursor
	lc = 'ProListarPrecioxCliente'
	goapp.npara1 = np1
	Text To lp Noshow
          (?goapp.npara1)
	Endtext
	If This.EJECUTARP(lc, lp, ccursor) < 1 Then
		Return 0
	Endif
	Return 1
	Endproc
	Procedure ObtenerPrecioCliente
	Lparameters	np1, np2, ccursor
	lc = 'ProListarPrecioxClienteproducto'
	goapp.npara1 = np1
	goapp.npara2 = np2
	Text To lp Noshow
          (?goapp.npara1,?goapp.npara2)
	Endtext
	If This.EJECUTARP(lc, lp, ccursor) < 1 Then
		Return 0
	Endif
	Return 1
	Endproc
	Procedure ObtenerPrecioCliente20
	Lparameters	np1, np2, np3, ccursor
	lc = 'ProListarPrecioxClienteproductoxplaca'
	goapp.npara1 = np1
	goapp.npara2 = np2
	goapp.npara3 = np3
	Text To lp Noshow
          (?goapp.npara1,?goapp.npara2,?goapp.npara3)
	Endtext
	If This.EJECUTARP(lc, lp, ccursor) < 1 Then
		Return 0
	Endif
	Return 1
	Endproc
	Procedure ListarPreciosclientesxplaca
	Lparameters	np1, np2, ccursor
	lc = 'ProListarPrecioxClientexplaca'
	goapp.npara1 = np1
	goapp.npara2 = np2
	Text To lp Noshow
          (?goapp.npara1,?goapp.npara2)
	Endtext
	If This.EJECUTARP(lc, lp, ccursor) < 1 Then
		Return 0
	Endif
	Return 1
	Endproc
Enddefine


