Define Class Ldiario As Odata Of "d:\capass\database\data.prg"
	Procedure BuscaProvision
	Lparameters	np1,np2
	ccursor='bpr'
	lc='PROBuscaProvisionDiario'
	goapp.npara1=np1
	goapp.npara2=np2
	TEXT to lp noshow
          (?goapp.npara1,?goapp.npara2)
	ENDTEXT
	If This.EJECUTARP(lc,lp,ccursor)<1 Then

		Return 0
	Else
		If bpr.idb>0 Then
			This.Cmensaje="Ya existe La provisión"
			Return 0
		Else
			Return 1
		Endif
	Endif
	Endproc
	Procedure  IngresaDatosDiarioBProvision(np1,np2,np3,np4,np5,np6,np7,np8,np9,np10,np11,np12,np13,np14,np15,np16,np17)
	cur="rild"
	lc="FunIngresaDatosLibroDiarioBP"
	goapp.npara1=np1
	goapp.npara2=np2
	goapp.npara3=np3
	goapp.npara4=np4
	goapp.npara5=np5
	goapp.npara6=np6
	goapp.npara7=np7
	goapp.npara8=np8
	goapp.npara9=np9
	goapp.npara10=np10
	goapp.npara11=np11
	goapp.npara12=np12
	goapp.npara13=np13
	goapp.npara14=np14
	goapp.npara15=np15
	goapp.npara16=np16
	goapp.npara17=np17
	TEXT to lp noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,
	      ?goapp.npara10,?goapp.npara11,?goapp.npara12,?goapp.npara13,?goapp.npara14,?goapp.npara15,?goapp.npara16,?goapp.npara17)
	ENDTEXT
	nidl=This.EJECUTARF(lc,lp,cur)
	If nidl<1 Then
		Return 0
	Else
		Return nidl
	Endif
	Endproc
*********************
	Procedure IngresaDatosDiarioCProvision(np1,np2,np3,np4,np5,np6,np7,np8,np9,np10,np11,np12,np13,np14,np15,np16,np17)
	cur="rild"
	lc="FunIngresaDatosLibroDiarioCP"
	goapp.npara1=np1
	goapp.npara2=np2
	goapp.npara3=np3
	goapp.npara4=np4
	goapp.npara5=np5
	goapp.npara6=np6
	goapp.npara7=np7
	goapp.npara8=np8
	goapp.npara9=np9
	goapp.npara10=np10
	goapp.npara11=np11
	goapp.npara12=np12
	goapp.npara13=np13
	goapp.npara14=np14
	goapp.npara15=np15
	goapp.npara16=np16
	goapp.npara17=np17
	TEXT to lp noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,
	      ?goapp.npara10,?goapp.npara11,?goapp.npara12,?goapp.npara13,?goapp.npara14,?goapp.npara15,?goapp.npara16,?goapp.npara17)
	ENDTEXT
	nidl=This.EJECUTARF(lc,lp,cur)
	If nidl<1 Then
		Return 0
	Else
		Return nidl
	Endif
	Endproc

	Function  IngresaDatosDiarioCanjes42(np1,np2,np3,np4,np5,np6,np7,np8,np9,np10,np11,np12,np13,np14,np15,np16)
	cur="rild"
	lc="FunIngresaDatosLibroDiarioCanjes42"
	goapp.npara1=np1
	goapp.npara2=np2
	goapp.npara3=np3
	goapp.npara4=np4
	goapp.npara5=np5
	goapp.npara6=np6
	goapp.npara7=np7
	goapp.npara8=np8
	goapp.npara9=np9
	goapp.npara10=np10
	goapp.npara11=np11
	goapp.npara12=np12
	goapp.npara13=np13
	goapp.npara14=np14
	goapp.npara15=np15
	goapp.npara16=np16
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,
      ?goapp.npara10,?goapp.npara11,?goapp.npara12,?goapp.npara13,?goapp.npara14,?goapp.npara15,?goapp.npara16)
	ENDTEXT
	nidl=This.EJECUTARF(lc,lp,cur)
	If nidl<1 Then
		Return 0
	Else
		Return rild.Id
	Endif
	Endfunc


	Function  IngresaDatosDiarioCanjes12(np1,np2,np3,np4,np5,np6,np7,np8,np9,np10,np11,np12,np13,np14,np15,np16)
	cur="rild"
	lc="FunIngresaDatosLibroDiarioCanjes12"
	goapp.npara1=np1
	goapp.npara2=np2
	goapp.npara3=np3
	goapp.npara4=np4
	goapp.npara5=np5
	goapp.npara6=np6
	goapp.npara7=np7
	goapp.npara8=np8
	goapp.npara9=np9
	goapp.npara10=np10
	goapp.npara11=np11
	goapp.npara12=np12
	goapp.npara13=np13
	goapp.npara14=np14
	goapp.npara15=np15
	goapp.npara16=np16
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,
      ?goapp.npara10,?goapp.npara11,?goapp.npara12,?goapp.npara13,?goapp.npara14,?goapp.npara15,?goapp.npara16)
	ENDTEXT
	nidl=This.EJECUTARF(lc,lp,cur)
	If nidl<1 Then
		Return 0
	Else
		Return nidl
	Endif
	Endfunc
	Function listar(f1,f2,ccursor)
	cpropiedad = "cdatos"
	If !Pemstatus(goapp, cpropiedad, 5)
		goapp.AddProperty("cdatos", "")
	Endif
	If goapp.cdatos<>'S' Then
		TEXT to lc NOSHOW TEXTMERGE PRETEXT 7
        SELECT  w.ldia_nume AS auto,ldia_fech AS fech,w.ldia_glosa AS detalle,'' AS e1,'' AS e2,'' AS e3,
		a.ncta,a.nomb,debe,haber,estado,ldia_idld FROM
		(SELECT ldia_idcta,ldia_nume,ldia_fech,ldia_glosa,SUM(ldia_debe) AS debe,
		SUM(w.ldia_haber) AS haber,ldia_inic AS estado,ldia_item,ldia_tipo,ldia_idld FROM fe_ldiario  AS w
		WHERE w.ldia_acti<>'I' AND w.ldia_fech between '<<f1>>' and '<<f2>>'
		GROUP BY w.ldia_nume,w.ldia_idcta,w.ldia_tipo,ldia_fech,ldia_glosa,ldia_inic,ldia_item,ldia_idld) AS w
		INNER JOIN fe_plan AS a ON a.idcta=w.ldia_idcta
		oRDER BY w.ldia_nume,w.ldia_item
		ENDTEXT
	Else
		TEXT to lc NOSHOW TEXTMERGE PRETEXT 7
        SELECT  w.ldia_nume AS auto,ldia_fech AS fech,w.ldia_glosa AS detalle,'' AS e1,'' AS e2,'' AS e3,
		a.ncta,a.nomb,debe,haber,estado,ldia_idld FROM
		(SELECT ldia_idcta,ldia_nume,ldia_fech,ldia_glosa,SUM(ldia_debe) AS debe,
		SUM(w.ldia_haber) AS haber,ldia_inic AS estado,ldia_item,ldia_tipo,ldia_idld FROM fe_ldiario  AS w
		WHERE w.ldia_acti<>'I' AND w.ldia_fech between '<<f1>>' and '<<f2>>'  and ldia_codt=<<goapp.tienda>>
		GROUP BY w.ldia_nume,w.ldia_idcta,w.ldia_tipo,ldia_fech,ldia_glosa,ldia_inic,ldia_item,ldia_idld) AS w
		INNER JOIN fe_plan AS a ON a.idcta=w.ldia_idcta
		oRDER BY w.ldia_nume,w.ldia_item
		ENDTEXT
	Endif
	If This.ejecutaconsulta(lc,ccursor)<1 Then
		Return 0
	Endif
	Return 1
	Endfunc


Enddefine
**************************************
