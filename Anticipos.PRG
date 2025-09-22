Define Class anticipo As OData Of 'd:\capass\database\data.prg'
	dFecha = Ctod("  /  /    ")
	cndoc = ""
	cmone = ""
	Ctipo = ""
	cdeta = ""
	nacta = 0
	NidAnticipo = 0
	Ncontrol = 0
	nidr = 0
	Montoc = 0
	Function  ConsultarAnticipo(nid, cur)
	Text To lC Noshow
       SELECT acta FROM fe_deu f
       inner join fe_rdeu g on g.rdeu_idrd=f.deud_idrd 
       where ncontrol=-1 and acti='A' and rdeu_Acti='A'  and rdeu_idpr=?nid;
	Endtext
	If This.EJECutaconsulta(lC, cur) < 1 Then
		Return 0
	Endif
	Select (cur)
	Select * From (cur) Where Acta > 0 Into Cursor (cur)
	Select (cur)
	Go Top
	If Acta > 0 Then
		Return 1
	Else
		Return 0
	Endif
	Endfunc
	FUNCTION  CompensaDcto
	dFech = this.dFecha
	cndoc = this.cndoc
	cmone = this.cmone
	Ctipo = this.Ctipo
	cdeta = this.cdeta
	nacta = this.nacta
	nctrol = this.Ncontrol
	nidrd = this.nidr
	nid = this.NidAnticipo
	nmontoc = this.Montoc
	nds = Iif(this.nacta > this.Montoc, this.Montoc, this.nacta)
	If CancelaDeudas(dFech, dFech, nds, cndoc, 'P', cmone, cdeta, Ctipo, nidrd, goApp.nidusua, nctrol, '', Id(), fe_gene.dola) = 0 Then
		Return  0
	Endif
	Text To lC Noshow
         UPDATE fe_deu as f SET acta=f.acta-?nds WHERE iddeu=?nid
	Endtext
	If this.ejecutarsql(lC) < 1 Then
		Return 0
	Endif
	Return 1
	ENDFUNC 
	FUNCTION Limpiar()
	dFecha = Ctod("  /  /    ")
	cndoc = ""
	cmone = ""
	Ctipo = ""
	cdeta = ""
	nacta = 0
	NidAnticipo = 0
	Ncontrol = 0
	nidr = 0
	Montoc = 0
	ENDFUNC 
Enddefine
***************************************

