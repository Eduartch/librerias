Define Class Ldiario As Odata Of "d:\capass\database\data.prg"
	nmes = 0
	Na = 0
	ncodt = 0
	Procedure BuscaProvision
	Lparameters	np1, np2
	Ccursor = 'bpr'
	lC = 'PROBuscaProvisionDiario'
	goApp.npara1 = np1
	goApp.npara2 = np2
	Text To lp Noshow
          (?goapp.npara1,?goapp.npara2)
	Endtext
	If This.EJECUTARP(lC, lp, Ccursor) < 1 Then

		Return 0
	Else
		If bpr.idb > 0 Then
			This.Cmensaje = "Ya existe La provisión"
			Return 0
		Else
			Return 1
		Endif
	Endif
	Endproc
	Procedure  IngresaDatosDiarioBProvision(np1, np2, np3, np4, np5, np6, np7, np8, np9, np10, np11, np12, np13, np14, np15, np16, np17)
	cur = "rild"
	lC = "FunIngresaDatosLibroDiarioBP"
	goApp.npara1 = np1
	goApp.npara2 = np2
	goApp.npara3 = np3
	goApp.npara4 = np4
	goApp.npara5 = np5
	goApp.npara6 = np6
	goApp.npara7 = np7
	goApp.npara8 = np8
	goApp.npara9 = np9
	goApp.npara10 = np10
	goApp.npara11 = np11
	goApp.npara12 = np12
	goApp.npara13 = np13
	goApp.npara14 = np14
	goApp.npara15 = np15
	goApp.npara16 = np16
	goApp.npara17 = np17
	Text To lp Noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,
	      ?goapp.npara10,?goapp.npara11,?goapp.npara12,?goapp.npara13,?goapp.npara14,?goapp.npara15,?goapp.npara16,?goapp.npara17)
	Endtext
	nidl = This.EJECUTARf(lC, lp, cur)
	If nidl < 1 Then
		Return 0
	Else
		Return nidl
	Endif
	Endproc
*********************
	Procedure IngresaDatosDiarioCProvision(np1, np2, np3, np4, np5, np6, np7, np8, np9, np10, np11, np12, np13, np14, np15, np16, np17)
	cur = "rild"
	lC = "FunIngresaDatosLibroDiarioCP"
	goApp.npara1 = np1
	goApp.npara2 = np2
	goApp.npara3 = np3
	goApp.npara4 = np4
	goApp.npara5 = np5
	goApp.npara6 = np6
	goApp.npara7 = np7
	goApp.npara8 = np8
	goApp.npara9 = np9
	goApp.npara10 = np10
	goApp.npara11 = np11
	goApp.npara12 = np12
	goApp.npara13 = np13
	goApp.npara14 = np14
	goApp.npara15 = np15
	goApp.npara16 = np16
	goApp.npara17 = np17
	Text To lp Noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,
	      ?goapp.npara10,?goapp.npara11,?goapp.npara12,?goapp.npara13,?goapp.npara14,?goapp.npara15,?goapp.npara16,?goapp.npara17)
	Endtext
	nidl = This.EJECUTARf(lC, lp, cur)
	If nidl < 1 Then
		Return 0
	Else
		Return nidl
	Endif
	Endproc

	Function  IngresaDatosDiarioCanjes42(np1, np2, np3, np4, np5, np6, np7, np8, np9, np10, np11, np12, np13, np14, np15, np16)
	cur = "rild"
	lC = "FunIngresaDatosLibroDiarioCanjes42"
	goApp.npara1 = np1
	goApp.npara2 = np2
	goApp.npara3 = np3
	goApp.npara4 = np4
	goApp.npara5 = np5
	goApp.npara6 = np6
	goApp.npara7 = np7
	goApp.npara8 = np8
	goApp.npara9 = np9
	goApp.npara10 = np10
	goApp.npara11 = np11
	goApp.npara12 = np12
	goApp.npara13 = np13
	goApp.npara14 = np14
	goApp.npara15 = np15
	goApp.npara16 = np16
	Text To lp Noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,
      ?goapp.npara10,?goapp.npara11,?goapp.npara12,?goapp.npara13,?goapp.npara14,?goapp.npara15,?goapp.npara16)
	Endtext
	nidl = This.EJECUTARf(lC, lp, cur)
	If nidl < 1 Then
		Return 0
	Else
		Return rild.Id
	Endif
	Endfunc


	Function  IngresaDatosDiarioCanjes12(np1, np2, np3, np4, np5, np6, np7, np8, np9, np10, np11, np12, np13, np14, np15, np16)
	cur = "rild"
	lC = "FunIngresaDatosLibroDiarioCanjes12"
	goApp.npara1 = np1
	goApp.npara2 = np2
	goApp.npara3 = np3
	goApp.npara4 = np4
	goApp.npara5 = np5
	goApp.npara6 = np6
	goApp.npara7 = np7
	goApp.npara8 = np8
	goApp.npara9 = np9
	goApp.npara10 = np10
	goApp.npara11 = np11
	goApp.npara12 = np12
	goApp.npara13 = np13
	goApp.npara14 = np14
	goApp.npara15 = np15
	goApp.npara16 = np16
	Text To lp Noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,
      ?goapp.npara10,?goapp.npara11,?goapp.npara12,?goapp.npara13,?goapp.npara14,?goapp.npara15,?goapp.npara16)
	Endtext
	nidl = This.EJECUTARf(lC, lp, cur)
	If nidl < 1 Then
		Return 0
	Else
		Return nidl
	Endif
	Endfunc
	Function Listar(f1, f2, Ccursor)
	cpropiedad = "cdatos"
	If !Pemstatus(goApp, cpropiedad, 5)
		goApp.AddProperty("cdatos", "")
	Endif
	Set Textmerge On
	Set Textmerge To Memvar lC Noshow Textmerge
    \    Select  w.ldia_nume As Auto,ldia_fech As fech,w.ldia_glosa As detalle,'' As e1,'' As e2,'' As e3,
	\	a.ncta,a.nomb,debe,haber,estado,ldia_idld From
	\	(Select ldia_idcta,ldia_nume,ldia_fech,ldia_glosa,Sum(ldia_debe) As debe,
	\	Sum(w.ldia_haber) As haber,ldia_inic As estado,ldia_item,ldia_tipo,ldia_idld From fe_ldiario  As w
	\	Where w.ldia_acti<>'I' And w.ldia_fech Between '<<f1>>' And '<<f2>>'
	If goApp.Cdatos = 'S' Then
	\	And ldia_codt=<<goApp.tienda>>
	Endif
	\	Group By w.ldia_nume,w.ldia_idcta,w.ldia_tipo,ldia_fech,ldia_glosa,ldia_inic,ldia_item,ldia_idld) As w
	\	INNER Join fe_plan As a On a.idcta=w.ldia_idcta
	\	Order By w.ldia_nume,w.ldia_item
	Set Textmerge Off
	Set Textmerge To
	If This.EjecutaConsulta(lC, Ccursor) < 1 Then
		Return 0
	Endif
	Return 1
	Endfunc
	Function listarOperacionesCompras(Ccursor)
	Set Textmerge On
	Set Textmerge To Memvar lC Noshow Textmerge
	   \Select b.fecr As fech,b.tdoc,a.ncta,Concat(Trim(c.razo),'-',Trim(b.ndoc)) As razo,
	   \(Case x.ecta_tipo When 'D' Then If((b.mone = 'S'),x.Impo,Round((x.Impo * b.dolar),2)) Else 0 End) As debe,
	   \(Case x.ecta_tipo When 'H' Then If((b.mone = 'S'),x.Impo,Round((x.Impo * b.dolar),2)) Else 0 End) As haber,
	   \a.idcta,a.nomb,x.ecta_tipo As tipo,Left(Concat("Com-",Cast(b.idauto As Char)),12) As ndoc,
	   \x.idectas,idauto,'N' As Tran,0 As itd,0 As ith,Cast(nitem As unsigned) As nitem,'Com' As tipomvto,'A' As cond
	   \From  fe_ectasc x
	   \Join fe_plan a On a.idcta = x.idcta
	   \Join fe_rcom b On b.idauto = x.idrcon
	   \Join fe_prov c On c.idprov = b.idprov Where  x.Impo <> 0 And b.Acti = 'A'
	   \And x.ecta_acti = 'A' And Month(b.fecr)=<<This.nmes>> And Year(b.fecr)=<<This.Na>>
	If goApp.Cdatos = 'S' Then
		\And b.codt =<<This.ncodt>>
	Endif
	   \Union All
	   \Select b.fecr As fech, b.tdoc,cdestinod As ncta,Concat(Trim(c.razo),'-',Trim(b.ndoc)) As razo,
	   \If(b.mone ='S',x.Impo,Round(x.Impo * b.dolar,2)) As debe,
	   \Cast(0 As Decimal(12,2)) As haber,
	   \0 As idcta,a.nomb,'D' As tipo,Left(Concat("Com-",Cast(b.idauto As Char)),12) As ndoc,
	    \x.idectas,idauto,'N' As Tran,0 As itd,0 As ith,Cast('9'  As signed) As nitem,'Com' As tipomvto,'D' As cond
	    \From  fe_ectasc x
		\Join fe_plan a On a.idcta = x.idcta
		\Join fe_rcom b On b.idauto = x.idrcon
		\Join fe_prov c On c.idprov = b.idprov Where  x.Impo <> 0 And b.Acti = 'A'
		\And x.ecta_acti = 'A' And Month(b.fecr)=<<This.nmes>> And Year(b.fecr)=<<This.Na>> And Length(Trim(cdestinod))>0
	If goApp.Cdatos = 'S' Then
		\And b.codt =<<This.ncodt>>
	Endif
		\Union All
		\Select b.fecr As fech,b.tdoc,cdestinoh As ncta,Concat(Trim(c.razo),'-',Trim(b.ndoc)) As razo,
		\Cast(0 As Decimal(12,2)) As debe,
		\If(b.mone = 'S',x.Impo,Round(x.Impo * b.dolar,2)) As haber,
		\0 As idcta,a.nomb,'H' As tipo,Left(Concat("Com-",Cast(b.idauto As Char)),12) As ndoc,
		\x.idectas,idauto,'N' As Tran,0 As itd,0 As ith,Cast('10' As signed) As nitem,'Com' As tipomvto,'D' As cond
		\From  fe_ectasc x
		\Join fe_plan a On a.idcta = x.idcta
		\Join fe_rcom b On b.idauto = x.idrcon
		\Join fe_prov c On c.idprov = b.idprov Where  x.Impo <> 0 And b.Acti = 'A'
		\And x.ecta_acti = 'A' And Month(b.fecr)=<<This.nmes>> And Year(b.fecr)=<<This.Na>> And Length(Trim(cdestinoh))>0
	If goApp.Cdatos = 'S' Then
		\And b.codt =<<This.ncodt>>
	Endif
		\Order By fech,idauto,nitem
	Set Textmerge Off
	Set Textmerge To
	If This.EjecutaConsulta(lC, Ccursor) < 1 Then
		Return 0
	Endif
	Return 1
	Endfunc
	Function listaroperacionescompras1(Ccursor)
	Text To lC Noshow Textmerge Pretext 7
    select b.tdoc,b.ndoc AS ndoc,b.fech,b.fecr AS fecr,a.ncta AS ncta,c.razo AS razo,
	(case x.ecta_tipo when 'D' then if((b.mone = 'S'),x.impo,round((x.impo * b.dolar),2)) else 0 end) AS Debe,
	(case x.ecta_tipo when 'H' then if((b.mone = 'S'),x.impo,round((x.impo * b.dolar),2)) else 0 end) AS Haber,
	a.idcta AS idcta,b.fech AS fech,a.nomb AS nomb,x.ecta_tipo AS tipo,DAY(fecr) as dia,
	b.mone AS mone,c.idprov AS idprov,x.idectas AS idectas,idauto,'N' as tran,0 as itd,0 as ith,nitem
	from  fe_ectasc x 
	inner join fe_plan a on a.idcta = x.idcta  
	inner join fe_rcom b on b.idauto = x.idrcon 
	inner join fe_prov c on c.idprov = b.idprov 
	where  x.impo <> 0 and b.acti = 'A' and x.ecta_acti = 'A' and MONTH(b.fecr)=<<this.nmes>> and YEAR(b.fecr)=<<this.na>> order by fecr,tdoc,idauto,tipo,nitem
	Endtext
	If This.EjecutaConsulta(lC, Ccursor) < 1 Then
		Return 0
	Endif
	Return 1
	Endfunc
Enddefine
**************************************






