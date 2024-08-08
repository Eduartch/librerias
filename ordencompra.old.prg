#Define MSGTITULO "SISVEN"
Define Class OrdendeCompra As Custom
	CodProducto=0
	Codproveedor=0
	Nprecio=0
	Ncantidad=0
	Cestado=""
	AutoC=0
	Accion=""
	Idr=0
	dfecha=Ctod("  /  /    ")
	cmone=""
	cndoc=""
	ctigv=""
	cobse=""
	caten=""
	cdeta=""
	cdesp=""
	cforma=""
	nv=0
	nigv=0
	nimpo=0
	Function Registraocompra
	lc='FUNINGRESAORDENCOMPRA'
	cur="oc"
	goapp.npara1=This.dfecha
	goapp.npara2=This.Codproveedor
	goapp.npara3=This.cmone
	goapp.npara4=This.cndoc
	goapp.npara5=This.ctigv
	goapp.npara1=This.cobse
	goapp.npara2=This.caten
	goapp.npara3=This.cdeta
	goapp.npara4=Id()
	goapp.npara5=goapp.nidusua
	goapp.npara1=This.cdesp
	goapp.npara2=This.cforma
	goapp.npara3=This.nv
	goapp.npara4=This.nigv
	goapp.npara5=This.nimpo
	TEXT to lp noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,?goapp.npara10,?goapp.npara11,?goapp.npara12,?goapp.npara13,?goapp.npara14,?goapp.npara15)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' Registrando Detalle Orden de Compra')
		Return 0
	Else
		Return oc.nid
	Endif

	Endfunc
	Function IngresaDetalleOrdendeCompra
	lc='PROINGRESADETALLEOCOMPRA'
	cur=""
	goapp.npara1=This.AutoC
	goapp.npara2=This.CodProducto
	goapp.npara3=This.Ncantidad
	goapp.npara4=This.Nprecio
	goapp.npara5=This.Cestado
	TEXT to lp noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' Registrando Detalle Orden de Compra')
		Return 0
	Else
		Return 1
	Endif
	Endfunc
	Function DesactivaPedidoOrdendeCompra
	lc='PROActualizaOCOMPRAXD'
	cur=""
	goapp.npara1=This.AutoC
	goapp.npara2=This.CodProducto
	TEXT to lp noshow
	     (?goapp.npara1,?goapp.npara2)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' Actualizando Detalle Orden de Compra por Pedidos No Despachado')
		Return 0
	Else
		Return 1
	Endif
	Endfunc
	Procedure ActualizaDetalleOrdendeCompra
	lc='PROACTUALIZAOCOMPRA'
	cur=""
	goapp.npara1=This.Idr
	goapp.npara2=This.Accion
	goapp.npara3=This.CodProducto
	goapp.npara4=This.Ncantidad
	goapp.npara5=This.Nprecio
	TEXT to lp noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' Actualizando Detalle de Orden de Compra')
		Return 0
	Else
		Return  1
	Endif
	Endproc
	Procedure PendientesPorRecibir
	Lparameters nidoc,ccursor
	TEXT TO lc NOSHOW
	    select idart as coda,descri,unid,sum(pedido) as pedido,sum(recibido) as recibido,sum(pedido)-sum(recibido) as saldo,ocom_fech as fecha,
		p.razo,ocom_ndoc as NumeroOC,ocom_idroc,prec from(
		SELECT idart,descri,unid,case doco_tipo when 'I' then doco_cant else 0 end as Pedido,
		case doco_tipo when 'S' then doco_cant else 0 end as Recibido,doco_idro,doco_prec as prec
		FROM fe_docom f inner join fe_art g on g.idart=f.doco_coda where doco_acti='A' and doco_tipo in ("I","S") and doco_idro=?nidoc) as q
		inner join fe_rocom r on r.ocom_idroc=q.doco_idro inner join fe_prov p on p.idprov=r.ocom_idpr group by idart having saldo>0
	ENDTEXT
	ncon=AbreConexion()
	If SQLExec(ncon,lc,ccursor)<1 Then
		errorbd(lc)
		Return
	Endif
	CierraConexion(ncon)
	Endproc
	Procedure PendientesPorRecibir1
	Lparameters ccursor
	TEXT TO lc NOSHOW
	    select idart as codigo,descri,unid,sum(pedido) as pedido,sum(recibido) as recibido,sum(pedido)-sum(recibido) as saldo,ocom_fech as fecha,
		p.razo,ocom_ndoc as NumeroOC,prec,ocom_idroc from(
		SELECT idart,descri,unid,case doco_tipo when 'I' then doco_cant else 0 end as Pedido,
		case doco_tipo when 'S' then doco_cant else 0 end as Recibido,doco_idro,doco_prec as prec
		FROM fe_docom f inner join fe_art g on g.idart=f.doco_coda where doco_acti='A' and doco_tipo in ("I","S")) as q
		inner join fe_rocom r on r.ocom_idroc=q.doco_idro inner join fe_prov p on p.idprov=r.ocom_idpr group by idart having saldo>0
	ENDTEXT
	ncon=AbreConexion()
	If SQLExec(ncon,lc,ccursor)<1 Then
		errorbd(lc)
		Return
	Endif
	CierraConexion(ncon)
	Endproc
	Procedure ProductoPedido
	Lparameters nidart,ccursor
	TEXT TO lc NOSHOW
	    select idart as codigo,descri as Producto,unid,sum(pedido) as pedido,sum(recibido) as recibido,sum(pedido)-sum(recibido) as saldo,ocom_fech as fecha,
		p.razo,ocom_ndoc as NumeroOC,ocom_mone as MOneda,prec as Precio,ocom_idroc from(
		SELECT idart,descri,unid,case doco_tipo when 'I' then doco_cant else 0 end as Pedido,
		case doco_tipo when 'S' then doco_cant else 0 end as Recibido,doco_idro,doco_prec as prec
		FROM fe_docom f inner join fe_art g on g.idart=f.doco_coda where doco_acti='A' and doco_tipo in ("I","S") and doco_coda=?nidart) as q
		inner join fe_rocom r on r.ocom_idroc=q.doco_idro inner join fe_prov p on p.idprov=r.ocom_idpr group by idart having saldo>0
	ENDTEXT
	ncon=AbreConexion()
	If SQLExec(ncon,lc,ccursor)<1 Then
		errorbd(lc)
		Return
	Endif
	CierraConexion(ncon)
	Endproc
	Procedure GeneraVoc
	Lparameters cserie,cnumero
	Create Cursor votmp(coda N(8),Descri c(100),unid c(4),cant N(10,3),Prec N(13,3), d1 N(7,4),nreg N(8),ndoc c(10))
	cn=Val(cnumero)
	Select loc1
	Go Top
	x=1
	F=loc1.idprov
	cdcto=cserie+cnumero
	Do While !Eof()
		If F<>loc1.idprov Then
			F=loc1.idprov
			x=x+1
			cn=cn+1
			cdcto=cserie+Right("00000000"+Alltrim(Str(cn)),8)
		Endif
		If loc1.tmon='S' Then
			nprec=loc1.costosf
		Else
			nprec=loc1.costosf/fe_gene.dola
		Endif
		Insert Into votmp(coda,Descri,unid,ndoc,Prec,cant)Values(loc1.idart,;
			loc1.Descri,loc1.unid,cdcto,nprec/fe_gene.igv,loc1.cant)
		Skip
	Enddo
	Endproc
Enddefine
