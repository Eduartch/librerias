#Define MSGTITULO  'Sisven'
#Define ERRORPROC "Error "
Set Procedure To CAPADATOS,ple5 Additive
Define Class Creditos As Custom
	cdocp=""
	codc=0
	moneda=""
	fecha=Date()
	tipo=""
	dolar=0
	situacion=""
	inic=0
	vendedor=0
	idauto=0
	cest=""
	nimpoo=0
	ndscto=0
	nroletras=0
	nimporte=0
	ndscto=0
	idaval=0
	referencia=""
	avnombre=""
	avdire=""
	avfono=""
	avnruc=""
	nacta=0
	Cliente=""
	ImprimeLetra=""
	dfevto=Date()
	nidrc=0
	letra=""
	mensaje=""
	Function SoloCabeceraCreditos(np1,np2,np3,np4,np5,np6,np7,np8,np9)
	nidcredito=IngresaCabeceraCreditos(np1,np2,np3,np4,np5,np6,np7,np8,np9)
	Return nidcredito
	Endfunc



Enddefine

Define Class CreditosNeumaticos As Creditos

	Function Registra

	x=0
	np1=This.cdocp
	np2=This.moneda
	np3=This.fecha
	np4=This.tipo
	np5=This.dolar
	np6=This.situacion
	np7=This.inic
	np8=This.vendedor
	np9=This.idauto

	cest="C"
	cusua=goapp.usuario
	np10=This.nimporte
	np11=This.ndscto
	ncodc=.codp
	crazo=""
	cnruc=""
	cdire=""
	cdni=""
	np12=goapp.tienda
	cpc=Id()
	np13=goapp.nidusua
	np14=This.idaval
	np15=This.referencia
	swcr=1
	If IniciaTransaccion()=0 Then
		DeshacerCambios()
		Return 0
	Endif

	This.nidrc=	this.SoloCabeceraCreditos(this.idauto,this.codc,this.fecha,this.vendedor,this.nimporte,goapp.nidusua,goapp.tienda,this.inic,cpc)
	If This.nidrc<=0 Then
		DeshacerCambios()
		Return 0
	Endif

	Select tmpd
	Go Top
	Do While !Eof()
		ccimporte=retcimporte(tmpd.Impo,This.moneda)
		crefe=Iif(Empty(This.referencia),tmpd.detalle,This.referencia)
		Replace cimporte With ccimporte,;
			anombre With This.avnombre,adire With This.avdire,afono With This.avfono,anruc With This.avnruc,moneda WITH this.moneda,mensaje WITH this.mensaje In tmpd
		x=x+1
		cndoc=tmpd.ndoc
		nimpo=tmpd.Impo
		dfevto=tmpd.fevto
		If x=1
			ni=This.inic
		Else
			ni=0
		Endif
		nidcr=This.RegistradetalleCreditosNeumaticos(This.idauto,This.codc,cndoc,'C',This.moneda,crefe,This.fecha,dfevto,This.tipo,This.cdocp,This.dolar,This.situacion,nimpo,ni,This.vendedor,This.nimpoo,goapp.nidusua,This.idaval,This.ndscto,cpc,goapp.tienda,0,0,This.nidrc)
		If nidcr=0 Then
			swcr=0
			Exit
		Endif
		If tmpd.sw>0 And tmpd.mrete>0 Then
			nmontor=tmpd.mrete
			nidcr=This.RegistradetalleCreditosNeumaticos(This.idauto,This.codc,"Retencion",'C',This.moneda,'Monto Por Retención',This.fecha,dfevto,This.tipo,This.cdocp,This.dolar,This.situacion,nmontor,ni,This.vendedor,This.nimpoo,goapp.nidusua,This.idaval,This.ndscto,cpc,goapp.tienda,0,0,This.nidrc)
			If nidcr=0 Then
				swcr=0
				Exit
			Endif
		Endif
		If x=1 And  This.nacta>0
			If This.RegistraPagoActaCaja(This.idauto,This.codc,This.fecha,0,This.inic,crefe,This.moneda,nidcr,'E',0,This.moneda,This.dolar,goapp.tienda,goapp.nidusua)=0 Then
				swcr=0
				Exit
			Endif
		Endif
		Select tmpd
		Skip
	Enddo
    RELEASE ocreditos
	If swcr=1
		GrabarCambios()
		If This.ImprimeLetra='S'
			Report Form (This.letra) To Printer Prompt Noconsole
		Endif
		Return 1
	Else
		DeshacerCambios()
		Return 0
	Endif
	Endfunc
**************************
	Function  RegistradetalleCreditosNeumaticos(np1,np2,np3,np4,np5,np6,np7,np8,np9,np10,np11,np12,np13,np14,np15,np16,np17,np18,np19,np20,np21,np22,np23,np24)
	Local cur As String
	lc='FUNINGRESACREDITOSx'
	cur="yy"
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
	goapp.npara18=np18
	goapp.npara19=np19
	goapp.npara20=np20
	goapp.npara21=np21
	goapp.npara22=np22
	goapp.npara23=np23
	goapp.npara24=np24
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,
      ?goapp.npara10,?goapp.npara11,?goapp.npara12,?goapp.npara13,?goapp.npara14,?goapp.npara15,?goapp.npara16,?goapp.npara17,
      ?goapp.npara18,?goapp.npara19,?goapp.npara20,?goapp.npara21,?goapp.npara22,?goapp.npara23,?goapp.npara24)
	ENDTEXT
	If EJECUTARF(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ 'Ingresando Cuentas ')
		Return 0
	Else
		Return yy.Id
	Endif
	Endfunc
	Function RegistraPagoActaCaja(np1,np2,np3,np4,np5,np6,np7,np8,np9,np10,np11,np12,np13,np14,np15)
	Local cur As String
	lc='  PROingresacaja'
	cur=""
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
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,
      ?goapp.npara10,?goapp.npara11,?goapp.npara12,?goapp.npara13,?goapp.npara14,?goapp.npara15)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ 'Ingresando Pago a Cuenta  ')
		Return 0
	Else
		Return 1
	Endif

	Endfunc
Enddefine

