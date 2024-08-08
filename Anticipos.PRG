#Define ERRORPROC "NO SE EJECUTO CORRECTAMENTE El Proceso "
#Define MSGTITULO "SISVEN"
Define Class Anticipo As Custom
	dfecha=Ctod("  /  /    ")
	cndoc=""
	cmone=""
	ctipo=""
	cdeta=""
	nacta=0
	nidanticipo=0
	nControl=0
	nidr=0
	Montoc=0
	Procedure ConsultarAnticipo(nid,cur)
	TEXT TO lc noshow
       SELECT acta FROM fe_deu f
       inner join fe_rdeu g on g.rdeu_idrd=f.deud_idrd where ncontrol=-1 and acti='A' and rdeu_Acti='A'
       and rdeu_idpr=?nid;
	ENDTEXT
	ncon=Abreconexion()
	If SQLExec(ncon,lc,cur)<0 Then
		Errorbd(lc)
		CierraConexion()
		Return 0
	Else
		CierraConexion(ncon)
		Select (cur)
		Select * From (cur) Where acta>0 Into Cursor (cur)
		Select (cur)
		Go Top
		If acta>0 Then
			Return 1
		Else
			Return 0
		Endif
	Endif
	Endproc
	Procedure CompensaDcto
	dfech=OAnticipo.dfecha
	cndoc=OAnticipo.cndoc
	cmone=OAnticipo.cmone
	ctipo=OAnticipo.ctipo
	cdeta=OAnticipo.cdeta
	nacta=OAnticipo.nacta
	nctrol=OAnticipo.nControl
	nidrd=OAnticipo.nidr
	nid=OAnticipo.nidanticipo
	nmontoc=OAnticipo.Montoc
	nds=Iif(OAnticipo.nacta>OAnticipo.Montoc,OAnticipo.Montoc,OAnticipo.nacta)
	If CancelaDeudas(dfech,dfech,nds,cndoc,'P',cmone,cdeta,ctipo,nidrd,;
			goapp.nidusua,nctrol,'',Id(),fe_gene.dola)=0 Then
		Return  0
	Endif
	TEXT TO lc noshow
         UPDATE fe_deu as f SET acta=f.acta-?nds WHERE iddeu=?nid
	ENDTEXT
	If SQLExec(goapp.bdconn,lc)<0 Then
		Errorbd(lc)
		Return 0
	Endif
	Return 1
	Endproc
	Procedure Limpiar()
	dfecha=Ctod("  /  /    ")
	cndoc=""
	cmone=""
	ctipo=""
	cdeta=""
	nacta=0
	nidanticipo=0
	nControl=0
	nidr=0
	Montoc=0
	Endproc
Enddefine
***************************************
