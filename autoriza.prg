Define Class Autorizado As OData Of 'd:\capass\database\data.prg'
	coda = 0
	cant = 0
	Prec = 0
	Prea = 0
	unid = ""
	idusua = 0
	idusuaa = 0
	idauto = 0
	idautop = 0
	Procedure GrabaPreciosAutorizados()
	lc = 'ProPreciosAutorizados'
	cur = ""
	goapp.npara1 = This.coda
	goapp.npara2 = This.cant
	goapp.npara3 = This.Prec
	goapp.npara4 = This.Prea
	goapp.npara5 = This.unid
	goapp.npara6 = This.idusua
	goapp.npara7 = This.idusuaa
	goapp.npara8 = This.idautop
	goapp.npara9 = This.idauto
	Text To lp Noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9)
	Endtext
	If This.EJECUTARP(lc, lp, cur) < 1 Then
		Return 0
	Endif
	Return  1
	Endproc
	Procedure MostrarPreciosAutorizados(dfi, dff, cur)
	lc = 'ProMuestraPreciosAutorizados'
	goapp.npara1 = dfi
	goapp.npara2 = dff
	Text To lp Noshow
	     (?goapp.npara1,?goapp.npara2)
	Endtext
	If This.EJECUTARP(lc, lp, cur) < 1 Then
		Return 0
	Endif
	Return  1
	Endproc
	Procedure ActualizaAutorizados(np1, np2)
	lc = 'ProActualizaCanjesPreciosAutorizados'
	cur = ""
	goapp.npara1 = np1
	goapp.npara2 = np2
	Text To lp Noshow
	     (?goapp.npara1,?goapp.npara2)
	Endtext
	If This.EJECUTARP(lc, lp, cur) < 1 Then
		Return 0
	Endif
	Return  1
	Endproc
	Function ListaAutorizadoCotizacion(nid, ccursor)
	Text To lc NOSHOW TEXTMERGE 
	Select Descri, auto_cant As cant, auto_prec As Prec, auto_prea As precioa, u.nomb As Usuario,
	uu.nomb As usuarioa From fe_autorizado As a
	INNER Join fe_art As p On p.`idart` = a.`auto_idar`
	INNER Join fe_usua As u On u.`idusua` = a.`auto_idus`
	INNER Join fe_usua As uu On uu.`idusua` = a.`auto_idua`
	Where a.`auto_idpe` = <<m.nid>> And auto_acti = 'A'
	ENDTEXT 
	IF this.ejecutaconsulta(lc,ccursor)<1 then
	    RETURN 0
	ENDIF 
	RETURN 1    
	Endfunc
Enddefine
***************************************

