#Define ERRORPROC "NO SE EJECUTO CORRECTAMENTE EL PROCEDIMIENTO"
#Define MSGTITULO "Sisven"
***********************
Function GeneraPlE5Compras(np1,np2,nmes,na)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As periodo,;
		Auto As nrolote,;
		Trim('M'+Alltrim(Str(Recno()))) As esta,;
		fech As fechae,;
		fech As fvto,;
		tdoc As tipocomp,;
		IIF(tdoc="10",'1683',Iif(tdoc='50',Left(Alltrim(Str(Val(serie))),3),Iif(Len(Alltrim(serie))<=3,'0','')+serie)) As serie,;
		Iif(tdoc='50',na,0000) As fdua,;
		ndoc As nrocomp,;
		'' As n1,;
		6 As tipodocp,;
		nruc As nruc,;
		razo As proveedor,;
		valorg As Base,;
		igvg As igv,;
		0 As Exon1,;
		0.00 As igvng,;
		0.00  As inafecta,;
		0.00 As igv1,;
		Exon,;
		0.00 As isc,;
		0 As otros,;
		importe As Total,;
		IIF(Mone='S','PEN','USD') As Mone,;
		dola As tipocambio,;
		Iif(Empty(fechn),Ctod("01/01/0001"),fechn) As fechn,;
		tref As tipon,;
		Iif(Empty(Left(Refe,4)),'-'+Space(4),Left(Refe,4)) As serien,;
		'   ' As dadu,;
		IIF(Empty(Refe),'-'+Space(8),Substr(Refe,5)) As ndocn,;
		Iif(Empty(fechad),Ctod("01/01/0001"),fechad) As fechad,;
		IIF(Empty(detra),'0'+Space(20),detra) As nrod,;
		' ' As reten,;
		tipo As tipobien,;
		'   ' As proy,;
		'1' As errtc,;
		'1' As errpro1,;
		'1' As errpro2,;
		'1' As errpro3,;
		IIF(importe>3500,'1',' ') As Mpago,;
		Icase(tdoc='01',Iif(Month(fech)=nmes,'1','6'),;
		tdoc='02',Iif(Month(fech)=nmes,'0','0'),;
		tdoc='03',Iif(Month(fech)=nmes,'0','0'),;
		tdoc='05',Iif(Month(fech)=nmes,'1','6'),;
		tdoc='06',Iif(Month(fech)=nmes,'1','6'),;
		tdoc='07',Iif(Month(fech)=nmes,'1','6'),;
		tdoc='08',Iif(Month(fech)=nmes,'1','6'),;
		tdoc='10','0',;
		tdoc='12',Iif(Month(fech)=nmes,'1','6'),;
		tdoc='13',Iif(Month(fech)=nmes,'1','6'),;
		tdoc='14',Iif(Month(fech)=nmes,'1','6'),;
		tdoc='16','0',;
		tdoc='50',Iif(Month(fech)=nmes,'1','6'),;
		Iif(Month(fech)=nmes,'1','9')) As estado;
		From registro Where Left(razo,5)<>'-----'  Into Cursor lreg
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		nlote=nrolote
		If nl=0 Then
    \\<<periodo>>|<<nrolote>>|<<esta>>|<<fechae>>|<<fvto>>|<<tipocomp>>|<<serie>>|<<fdua>>|<<nrocomp>>|<<n1>>|<<tipodocp>>|<<nruc>>|<<alltrim(proveedor)>>|<<base>>|<<igv>>|<<exon1>>|<<igvng>>|<<inafecta>>|<<igv1>>|<<exon>>|<<isc>>|<<otros>>|<<total>>|<<mone>>|<<tipocambio>>|<<fechn>>|<<tipon>>|<<serien>>|<<dadu>>|<<ndocn>>|<<fechad>>|<<nrod>>|<<reten>>|<<tipobien>>|<<proy>>|<<errtc>>|<<errpro1>>|<<errpro2>>|<<errpro3>>|<<mpago>>|<<estado>>|
		Else
     \<<periodo>>|<<nrolote>>|<<esta>>|<<fechae>>|<<fvto>>|<<tipocomp>>|<<serie>>|<<fdua>>|<<nrocomp>>|<<n1>>|<<tipodocp>>|<<nruc>>|<<alltrim(proveedor)>>|<<base>>|<<igv>>|<<exon1>>|<<igvng>>|<<inafecta>>|<<igv1>>|<<exon>>|<<isc>>|<<otros>>|<<total>>|<<mone>>|<<tipocambio>>|<<fechn>>|<<tipon>>|<<serien>>|<<dadu>>|<<ndocn>>|<<fechad>>|<<nrod>>|<<reten>>|<<tipobien>>|<<proy>>|<<errtc>>|<<errpro1>>|<<errpro2>>|<<errpro3>>|<<mpago>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
*********************************************
Function GeneraPLE5VENTAS(np1,np2)
	*	*IIF(tdoc='01',Iif(Left(nruc,1)='*','0','6'),Iif(Len(Alltrim(ndni))<=8,'0',IIF(LEN(ALLTRIM(nruc))=11,'6','1'))) As tipodocc,
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(Year(fech)))+Iif(Month(fech)<=9,'0'+Alltrim(Str(Month(fech))),Alltrim(Str(Month(fech))))+'00' As Integer) As periodo,;
		Auto As nrolote,;
		Trim('M'+Alltrim(Str(Recno()))) As esta,;
		fech As fecha,;
		fech As fvto,;
		tdoc As tipocomp,;
		IIF(Len(Alltrim(serie))<=3,'0'+Trim(serie),Trim(serie)) As serie,;
		Round(Val(ndoc),0) As nrocomp,;
		' ' As consolidado,;
		ICASE(tdoc='01',Iif(Left(nruc,1)='*','0','6'),;
		tdoc='03',Iif(Len(Alltrim(ndni))<8,'0','1'),;
		tdoc='07',Iif(Len(Alltrim(nruc))=11,'6','1'),;
		tdoc='08',Iif(Len(Alltrim(nruc))=11,'6','1'),'1') As tipodocc,;
		ICASE(tdoc='03',Iif(Empty(ndni),'0'+Space(11),ndni+Space(3)),tdoc='01',Iif(Left(nruc,1)='*','0'+Space(11),nruc),Iif(Empty(nruc),ndni+Space(3),Iif(Left(nruc,1)='*','-'+Space(11),nruc))) As nruc,;
		IIF(tdoc='03',Iif(Empty(ndni),'-'+Space(40),razo),Iif(Left(nruc,1)='*','-'+Space(40),razo)) As cliente,;
		0.00 As exporta,;
		valorg As Base,;
		0.00 As dsctoigv,;
		igvg As igv,;
		0.00 As dsctoigv1,;
		Exon As Exon,;
		0.00 As inafecta,;
		0.00 As isc,;
		0.00 As pilado,;
		0.00 As igvp,;
		0.00 As otros,;
		importe As Total,;
		IIF(Mone='S','PEN','USD') As Mone,;
		IIF(dola>0,dola,3.305) As tipocambio,;
		Iif(Empty(fechn),Ctod("01/01/0001"),fechn) As fechn,;
		Iif(Empty(tref),'00',tref) As tipon,;
		Iif(Empty(Left(Refe,4)),'-'+Space(3),Iif(Len(Alltrim(Refe))<3,'0'+Left(Refe,3),Left(Refe,4))) As serien,;
		IIF(Empty(Refe),'-'+Space(10),Substr(Refe,4,7)) As ndocn,;
		' ' As contrato,;
		'1' As errtc,;
		IIF(importe>3500,'1',' ') As Mpago,;
		Iif(Left(nruc,1)='*','2','1') As estado From registro Where Left(razo,5)<>'-----'  Into Cursor lreg
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
   \\<<periodo>>|<<nrolote>>|<<esta>>|<<fecha>>|<<fvto>>|<<tipocomp>>|<<serie>>|<<nrocomp>>|<<consolidado>>|<<tipodocc>>|<<nruc>>|<<ALLTRIM(cliente)>>|<<exporta>>|<<base>>|<<dsctoigv>>|<<igv>>|<<dsctoigv1>>|<<exon>>|<<inafecta>>|<<isc>>|<<pilado>>|<<igvp>>|<<otros>>|<<total>>|<<mone>>|<<tipocambio>>|<<fechn>>|<<tipon>>|<<serien>>|<<ndocn>>|<<contrato>>|<<errtc>>|<<mpago>>|<<estado>>|
		Else
    \<<periodo>>|<<nrolote>>|<<esta>>|<<fecha>>|<<fvto>>|<<tipocomp>>|<<serie>>|<<nrocomp>>|<<consolidado>>|<<tipodocc>>|<<nruc>>|<<ALLTRIM(cliente)>>|<<exporta>>|<<base>>|<<dsctoigv>>|<<igv>>|<<dsctoigv1>>|<<exon>>|<<inafecta>>|<<isc>>|<<pilado>>|<<igvp>>|<<otros>>|<<total>>|<<mone>>|<<tipocambio>>|<<fechn>>|<<tipon>>|<<serien>>|<<ndocn>>|<<contrato>>|<<errtc>>|<<mpago>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
***********************
Function GeneraPlE5Compras1(np1,np2,nmes,na)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As c1,;
		Auto As c2,;
		Trim('M'+Alltrim(Str(Recno()))) As c3,;
		com1_fech As c4,;
		com1_tdoc As c5,;
		com1_ser1 As c6,;
		com1_ndoc As c7,;
		com1_valo As c8,;
		com1_otro As c9,;
		com1_impo As c10,;
		com1_tdoc1 As c11,;
		com1_serie1 As c12,;
		com1_año As c13,;
		com1_ndoc1 As c14,;
		com1_rete As c15,;
		com1_mone As c16,;
		com1_dola As c17,;
		com1_pais As c18,;
		razo As c19,;
		dire As c20,;
		nruc As c21,;
		ndni As c22,;
		razo1 As c23,;
		com1_pais1 As c24,;
		com1_vinc As c25,;
		com1_renta As c26,;
		com1_cost As c27,;
		com1_rneta As c28,;
		com1_vrenta As c29,;
		com1_irete As c30,;
		com1_conv As c31,;
		com1_exon As c32,;
		com1_trta As c33,;
		com1_modo As c34,;
		com1_aplica As c35,;
		IIF(Month(com1_fech)=nmes,'1','6') As c36;
		From lnd Into Cursor lreg
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
    \\<<c1>>|<<c2>>|<<c3>>|<<c4>>|<<c5>>|<<c6>>|<<c7>>|<<c8>>|<<c9>>|<<c10>>|<<c11>>|<<c12>>|<<c13>>|<<c14>>|<<c15>>|<<c16>>|<<c17>>|<<c18>>|<<TRIM(c19)>>|<<TRIM(c20)>>|<<c21>>|<<c22>>|<<TRIM(c23)>>|<<c24>>|<<c25>>|<<c26>>|<<c27>>|<<c28>>|<<c29>>|<<c30>>|<<c30>>|<<c31>>|<<c32>>|<<c33>>|<<c34>>|<<c35>>|<<c36>>|

		Else
     \<<c1>>|<<c2>>|<<c3>>|<<c4>>|<<c5>>|<<c6>>|<<c7>>|<<c8>>|<<c9>>|<<c10>>|<<c11>>|<<c12>>|<<c13>>|<<c14>>|<<c15>>|<<c16>>|<<c17>>|<<c18>>|<<TRIM(c19)>>|<<TRIM(c20)>>|<<c21>>|<<c22>>|<<TRIM(c23)>>|<<c24>>|<<c25>>|<<c26>>|<<c27>>|<<c28>>|<<c29>>|<<c30>>|<<c30>>|<<c31>>|<<c32>>|<<c33>>|<<c34>>|<<c35>>|<<c36>>|
		Endif
		nl=nl+1
	Endscan
	*<<c21>>|<<c22>>|<<TRIM(c23)>>|<<c24>>|<<c25>>|<<c26>>|<<c27>>|<<c28>>|<<c29>>|<<c30>>|<<c30>>|<<c31>>|<<c32>>|<<c33>>|<<c34>>|<<c35>>|<<c36>>|
	Set Textmerge To
	Set Textmerge Off
Endfunc
****************************************
Function GeneraDiarioPle5(np1,np2,mes,na)
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As periodo,;
		TRIM(Auto)+Alltrim(Str(Recno())) As nrolote,;
		AllTrim(Iif(rdiario.estado='I','A','M')+Alltrim(Str(ldia_idld))) As esta,;
		Left(ncta,2)+Substr(ncta,4,2)+Substr(ncta,7,2) As ncta,;
		' ' As Codigo1,;
		' ' As Ccostos,;
		'PEN' As Moneda,;
		'6' As tipodcto,;
		ALLTRIM(fe_gene.nruc)+Space(4) As nruc,;
		'00' As tdoc,;
		'     ' As  serie,;
		auto As ndoc,;
		Ttod(fech) As fecha,;
		Ttod(fech) As fechavto,;
		Ttod(fech) As fechar,;
		Iif(Empty(detalle),Left(nomb,100),Left(detalle,100)) As detalle,;
		' ' As desc1,;
		debe,;
		haber,;
		'' As estructura,;
		1 As estado From rdiario Into Cursor lreg
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
        \\<<periodo>>|<<nrolote>>|<<esta>>|<<ncta>>|<<codigo1>>|<<ccostos>>|<<moneda>>|<<tipodcto>>|<<nruc>>|<<tdoc>>|<<serie>>|<<ndoc>>|<<fecha>>|<<fechavto>>|<<fechar>>|<<detalle>>|<<desc1>>|<<debe>>|<<haber>>|<<estructura>>|<<estado>>|
		Else
         \<<periodo>>|<<nrolote>>|<<esta>>|<<ncta>>|<<codigo1>>|<<ccostos>>|<<moneda>>|<<tipodcto>>|<<nruc>>|<<tdoc>>|<<serie>>|<<ndoc>>|<<fecha>>|<<fechavto>>|<<fechar>>|<<detalle>>|<<desc1>>|<<debe>>|<<haber>>|<<estructura>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
****************************************
Function GeneraPlanCuentasPle5(np1,np2)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'01' As Integer) As periodo,;
		Left(ncta,2)+Substr(ncta,4,2)+Substr(ncta,7,2) As ncta,;
		nomb As nombrecta,;
		'01' As tplan,;
		'       ' As descPlan,;
		' ' As Codigo1,;
		' ' As desc1,;
		1 As estado;
		From rdiario Into Cursor lreg Group By ncta
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
          \\<<periodo>>|<<ncta>>|<<nombrecta>>|<<tplan>>|<<descPlan>>|<<codigo1>>|<<desc1>>|<<estado>>|
		Else
           \<<periodo>>|<<ncta>>|<<nombrecta>>|<<tplan>>|<<descPlan>>|<<codigo1>>|<<desc1>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
****************************************
Function GeneraMayorPle5(np1,np2,nmes,na)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As periodo,;
		ldia_nume As nrolote,;
		Trim(Iif(rld.estado='I','A','M')+Alltrim(Str(Recno()))) As esta,;
		Left(ncta,2)+Substr(ncta,4,2)+Substr(ncta,7,2) As ncta,;
		' ' As Codigo1,;
		' ' As Ccostos,;
		'PEN' As Moneda,;
		'6' As tipodcto,;
		fe_gene.nruc As nruc,;
		'00' As tdoc,;
		'      ' As serie,;
		ldia_nume As ndoc,;
		ldia_fech As fecha,;
		ldia_fech As fechavto,;
		ldia_fech As fechar,;
		Left(nomb,100) As detalle,;
		'  ' As detalle1,;
		deudor,;
		acreedor,;
		'' As estructura,;
		1 As estado;
		From rld  Where deudor >0 Or acreedor>0 Into Cursor lreg Order By ldia_fech
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
          \\<<periodo>>|<<nrolote>>|<<esta>>|<<ncta>>|<<codigo1>>|<<ccostos>>|<<moneda>>|<<tipodcto>>|<<nruc>>|<<tdoc>>|<<serie>>|<<ndoc>>|<<fecha>>|<<fechavto>>|<<fechar>>|<<detalle>>|<<detalle1>>|<<deudor>>|<<acreedor>>|<<estructura>>|<<estado>>|
		Else
           \<<periodo>>|<<nrolote>>|<<esta>>|<<ncta>>|<<codigo1>>|<<ccostos>>|<<moneda>>|<<tipodcto>>|<<nruc>>|<<tdoc>>|<<serie>>|<<ndoc>>|<<fecha>>|<<fechavto>>|<<fechar>>|<<detalle>>|<<detalle1>>|<<deudor>>|<<acreedor>>|<<estructura>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
****************************************
Function GeneraLCajaEPle5(np1,np2,nmes,na)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As periodo,;
		'M'+Alltrim(Str(Recno())) As esta,Trim(Auto)+Alltrim(Str(Recno())) As nrolote,Left(ncta,2)+Substr(ncta,4,2)+Substr(ncta,7,2) As ncta,' ' As Codigo1,' ' As Ccostos,'PEN' As Moneda,;
		'00' As tdoc,Iif(Empty(Auto),'SD  ','0'+Left(rcaja.Auto,3)) As serie,Iif(Empty(Auto),'SD         ',Substr(rcaja.Auto,4)) As ndoc,;
		rcaja.fech As fechar,rcaja.fech As fechavto,rcaja.fech As fecha,Left(detalle,100) As detalle,'  ' As detalle1,;
		Iif(debe<0,Abs(debe),debe) As debe,Iif(haber<0,Abs(haber),haber) As haber,' ' As estructura,;
		1 As estado From rcaja  Where xtipo<>'.' Into Cursor lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Select lreg
	Scan
		If nl=0 Then
          \\<<periodo>>|<<nrolote>>|<<esta>>|<<ncta>>|<<codigo1>>|<<ccostos>>|<<moneda>>|<<tdoc>>|<<serie>>|<<ndoc>>|<<fecha>>|<<fechavto>>|<<fechar>>|<<detalle>>|<<detalle1>>|<<debe>>|<<haber>>|<<estructura>>|<<estado>>|
		Else
           \<<periodo>>|<<nrolote>>|<<esta>>|<<ncta>>|<<codigo1>>|<<ccostos>>|<<moneda>>|<<tdoc>>|<<serie>>|<<ndoc>>|<<fecha>>|<<fechavto>>|<<fechar>>|<<detalle>>|<<detalle1>>|<<debe>>|<<haber>>|<<estructura>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
****************************************
Function MuesTraTiposBienes(lista)
	Dimension lista[4]
	lista[0]="1	Mercaderia,Materia Prima,Suministro,Envases y Embalajes"
	lista[1]="2	Activo Fijo"
	lista[2]="3	Otros Gastos No Considerados en 1 y 2"
	lista[3]="4	Gastos de Educación,Recreación, Salud, Culturales Representación,Capacitación,De Viaje,Mantenimiento de Vehiculo Y de Premios"
	lista[4]="5	Otros Gastos No Incluidos en el Numeral 4"
	Return
Endfunc
*****************************************
Function IngresaDatosDiarioPle5(np1,np2,np3,np4,np5,np6,np7,np8,np9,np10,np11,np12,np13,np14,np15,np16,np17)
	cur="l"
	lc="FunIngresaDatosLibroDiarioPLe5"
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
	If EJECUTARF(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' '+' Ingresando Asientos  a Libro Diario')
		Return 0
	Else
		Return 1
	Endif
Endfunc
******************
Function AnularComprasLibroDiario(np1,np2,np3)
	cur=""
	lc="ProAnulaDatosLibroDiarioPLe5"
	goapp.npara1=np1
	goapp.npara2=np2
	goapp.npara3=np3
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' '+' Ingresando Asientos  a Libro Diario')
		Return 0
	Else
		Return 1
	Endif
Endfunc
*********************************
Function GeneraTxtRetenciones(np1,np2)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select '6' As motivo,Left(rete_ndoc,4) As serie,;
		SUBSTR(rete_ndoc,5) As ndoc,rete_fech As fecha,nruc,'6' As tipodoc,rete_impo,;
		razo,'01' As codret,dret_valor,tpagado,tdoc,Iif(Len(Alltrim(ndoc))<10,Left(ndoc,3),Left(ndoc,4)) As seried,;
		IIF(Len(Alltrim(ndoc))<10,Substr(ndoc,4),Substr(ndoc,5)) As ndocd,fech,dret_impo,'PEN' As Moneda,Impo,rete_dola,dret_iddr As numerop,;
		impo-dret_impo As neto From lr Into Cursor lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Select lreg
	Scan
		If nl=0 Then
          \\<<motivo>>|<<serie>>|<<ndoc>>|<<fech>>|<<nruc>>|<<tipodoc>>|<<razo>>|<<codret>>|<<dret_valor>>|<<rete_impo>>|<<tpagado>>|<<tdoc>>|<<seried>>|<<ndocd>>|<<fech>>|<<dret_impo>>|<<moneda>>|<<fecha>>|<<numerop>>|<<impo>>|<<moneda>>|<<impo>>|<<dret_impo>>|<<fech>>|<<neto>>|<<moneda>>|<<rete_dola>>|<<fecha>>|
		Else
           \<<motivo>>|<<serie>>|<<ndoc>>|<<fech>>|<<nruc>>|<<tipodoc>>|<<razo>>|<<codret>>|<<dret_valor>>|<<rete_impo>>|<<tpagado>>|<<tdoc>>|<<seried>>|<<ndocd>>|<<fech>>|<<dret_impo>>|<<moneda>>|<<fecha>>|<<numerop>>|<<impo>>|<<moneda>>|<<impo>>|<<dret_impo>>|<<fech>>|<<neto>>|<<moneda>>|<<rete_dola>>|<<fecha>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
*******************************************
Function MuestraTabla4(cur)
	lc="ProMuestraTabla4"
	lp=""
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' '+' Mostrando el Contenido de Tabla 4')
		Return 0
	Else
		Return 1
	Endif
Endfunc
**************************
Function MuestraTabla35(cur)
	lc="ProMuestraTabla35"
	lp=""
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' '+' Mostrando el Contenido de Tabla 35')
		Return 0
	Else
		Return 1
	Endif
Endfunc
***************************
Function RegistraComprasNOdomicilado(oret)
	cur="Uy"
	lc="FunIngresaND"
	goapp.npara1=oret.np1
	goapp.npara2=oret.np2
	goapp.npara3=oret.np3
	goapp.npara4=oret.np4
	goapp.npara5=oret.np5
	goapp.npara6=oret.np6
	goapp.npara7=oret.np7
	goapp.npara8=oret.np8
	goapp.npara9=oret.np9
	goapp.npara10=oret.np10
	goapp.npara11=oret.np11
	goapp.npara12=oret.np12
	goapp.npara13=oret.np13
	goapp.npara14=oret.np14
	goapp.npara15=oret.np15
	goapp.npara16=oret.np16
	goapp.npara17=oret.np17
	goapp.npara18=oret.np18
	goapp.npara19=oret.np19
	goapp.npara20=oret.np20
	goapp.npara21=oret.np21
	goapp.npara22=oret.np22
	goapp.npara23=oret.np23
	goapp.npara24=oret.np24
	goapp.npara25=oret.np25
	goapp.npara26=oret.np26
	goapp.npara27=oret.np27
	goapp.npara28=oret.np28
	goapp.npara29=oret.np29
	goapp.npara30=oret.np30
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,
      ?goapp.npara10,?goapp.npara11,?goapp.npara12,?goapp.npara13,?goapp.npara14,?goapp.npara15,?goapp.npara16,?goapp.npara17,
      ?goapp.npara18,?goapp.npara19,?goapp.npara20,?goapp.npara21,?goapp.npara22,?goapp.npara23,?goapp.npara24,?goapp.npara25,
      ?goapp.npara26,?goapp.npara27,?goapp.npara28,?goapp.npara29,?goapp.npara30)
	ENDTEXT
	If EJECUTARF(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' '+' Ingresando Documentos a Registros de No Domicilados')
		Return 0
	Else
		Return 1
	Endif
Endfunc
*********************************
Function  ActualizaComprasNOdomicilado(oret)
	cur=""
	lc="ActualizaND"
	goapp.npara1=oret.np1
	goapp.npara2=oret.np2
	goapp.npara3=oret.np3
	goapp.npara4=oret.np4
	goapp.npara5=oret.np5
	goapp.npara6=oret.np6
	goapp.npara7=oret.np7
	goapp.npara8=oret.np8
	goapp.npara9=oret.np9
	goapp.npara10=oret.np10
	goapp.npara11=oret.np11
	goapp.npara12=oret.np12
	goapp.npara13=oret.np13
	goapp.npara14=oret.np14
	goapp.npara15=oret.np15
	goapp.npara16=oret.np16
	goapp.npara17=oret.np17
	goapp.npara18=oret.np18
	goapp.npara19=oret.np19
	goapp.npara20=oret.np20
	goapp.npara21=oret.np21
	goapp.npara22=oret.np22
	goapp.npara23=oret.np23
	goapp.npara24=oret.np24
	goapp.npara25=oret.np25
	goapp.npara26=oret.np26
	goapp.npara27=oret.np27
	goapp.npara28=oret.np28
	goapp.npara29=oret.np29
	goapp.npara30=oret.np30
	goapp.npara31=oret.np31
	goapp.npara32=oret.np32
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,
      ?goapp.npara10,?goapp.npara11,?goapp.npara12,?goapp.npara13,?goapp.npara14,?goapp.npara15,?goapp.npara16,?goapp.npara17,
      ?goapp.npara18,?goapp.npara19,?goapp.npara20,?goapp.npara21,?goapp.npara22,?goapp.npara23,?goapp.npara24,?goapp.npara25,
      ?goapp.npara26,?goapp.npara27,?goapp.npara28,?goapp.npara29,?goapp.npara30,?goapp.npara31,?goapp.npara32)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' '+' Ingresando Documentos a Registros de No Domicilados')
		Return 0
	Else
		Return 1
	Endif
Endfunc
*************************************
Function GeneraFacturaElectronicaTxt(np1,np2)
	Local cont1,cont2,car1,car2 As Character
	TEXT TO lc noshow
        SELECT '01' as TipoOperacion,fech as fecEmision,'0001' as codLocalEmisor,
		'6' as tipDocUsuario,nruc as numDocUsuario,razo as rznSocialUsuario,if(mone='S','PEN','USD') as tipMoneda,
		cast(0 as decimal(12,2)) as sumDsctoGlobal,cast(0 as decimal(12,2)) as sumOtrosCargos,
		cast(0 as decimal(12,2)) as mtoDescuentos,valor as mtoOperGravadas,cast(0 as decimal(12,2)) as mtoOperInafectas,
		cast(0 as decimal(12,2)) as mtoOperExoneradas,igv as mtoIGV,cast(0 as decimal(10,2)) as mtoISC,
		cast(0 as decimal(10,2)) as mtoOtrosTributos,impo as mtoImpVenta,ndoc,tdoc
		FROM fe_rcom f inner join fe_clie c on c.idclie=f.idcliente where idauto=?np1 and acti='A'
	ENDTEXT
	TEXT TO lc1 noshow
		select 'NIU' as codUnidadMedida,cant as ctdUnidadItem,k.idart as codProducto,
		"" as codProductoSUNAT,descri as desItem,k.prec as mtoValorUnitario,
		cast(0 as decimal(10,2)) as mtoDsctoItem,round(k.prec-(k.prec/v.vigv),2) as mtoIgvItem,'10' as tipAfeIGV,
		cast(0 as decimal(10,2)) as mtoIscItem,cast(0 as decimal(10,2)) as tipSisISC,k.prec as mtoPrecioVentaItem,
		round(k.prec/v.vigv,2) as mtoValorVentaItem from fe_kar k inner join fe_art a on a.idart=k.idart
		inner join fe_rcom v on v.idauto=k.idauto where k.idauto=?np1 and k.acti='A'

	ENDTEXT
	ncon=Abreconexion()
	If SQLExec(ncon,lc,'resumen')<0 Then
		errorbd(lc)
		Return -1
	Endif
	If SQLExec(ncon,lc1,'detalle')<0 Then
		errorbd(lc)
		Return -1
	Endif
	CierraConexion(ncon)
	Select resumen
	crutaenvio=Sys(5)+"\data0\facturador\data\"
	car1=Alltrim(crutaenvio)+Alltrim(fe_gene.nruc)+'-'+resumen.tdoc+'-'+"F"+Left(resumen.ndoc,3)+"-"+Alltrim(Substr(resumen.ndoc,4))+".Cab"
	car2=Alltrim(crutaenvio)+Alltrim(fe_gene.nruc)+'-'+resumen.tdoc+'-'+"F"+Left(resumen.ndoc,3)+"-"+Alltrim(Substr(resumen.ndoc,4))+".det"
	dfecha=Alltrim(Str(Year(fecEmision)))+'-'+Alltrim(Str(Month(fecEmision)))+'-'+Alltrim(Str(Day(fecEmision)))
	cont1  = ""
	cont1=TipoOperacion+"|"+dfecha+"|"+codLocalEmisor+"|"+tipDocUsuario+"|"+numDocUsuario+"|"+Alltrim(rznSocialUsuario)+"|"+tipMoneda+"|"+Alltrim(Str(sumDsctoGlobal,12,2))+"|"+Alltrim(Str(sumOtrosCargos,12,2))+"|"+Alltrim(Str(mtoDescuentos,12,2))+"|"+Alltrim(Str(mtoOperGravadas,12,2))+"|"+Alltrim(Str(mtoOperInafectas,12,2))+"|"+Alltrim(Str(mtoOperExoneradas,12,2))+"|"+Alltrim(Str(mtoIGV,12,2))+"|"+Alltrim(Str(mtoISC,12,2))+"|"+Alltrim(Str(mtoOtrosTributos,12,2))+"|"+Alltrim(Str(mtoImpVenta,12,2))+"|"
	If Strtofile(cont1,car1)<0 Then
		Messagebox("No Se Genero el Archivo de Envio",16,"SISVEN")
		Return -1
	Else
		Select detalle
		cont2=codUnidadMedida+"|"+Alltrim(Str(ctdUnidadItem,12,2))+"|"+Alltrim(Str(codProducto))+"|"+codProductoSUNAT+"|"+Alltrim(desItem)+"|"+Alltrim(Str(mtoValorUnitario,12,2))+"|"+Alltrim(Str(mtoDsctoItem))+"|"+Alltrim(Str(mtoIgvItem,10,2))+"|"+Alltrim(tipAfeIGV)+"|"+Alltrim(Str(mtoIscItem,12,2))+"|"+Alltrim(Str(tipSisISC,12,2))+"|"+Alltrim(Str(mtoPrecioVentaItem,12,2))+"|"+Alltrim(Str(mtoValorVentaItem,12,2))+"|"
		If Strtofile(cont2,car2)<0 Then
			Messagebox("No Se Genero el Archivo de Envio",16,"SISVEN")
			Return -1
		Else
			Return 0
			*crutarpta=Sys(5)+"\data0\facturador\rpta\"
		Endif
	Endif

Endfunc
************************************
Function GeneraPlE5IPV(np1,np2,nmes,na)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As periodo,;
		nreg As nrolote,;
		Trim('M'+Alltrim(Str(nreg))) As esta,;
		fe_gene.ubigeo As codest,;
		'9' As codcatalogo,;
		'01' As tipoexistencia,;
		coda,;
		'' As coda1,;
		fech As fechae,;
		ICASE(tdoc='II','00',tdoc='GI','00',tdoc='TT','00',tdoc) As tipocomp,;
		iif(tdoc='50',Substr(serie,2,3),Right("0000"+Alltrim(serie),4)) As serie,;
		IIF(tdoc='50',Right(ndoc,6),ndoc) As ndoc,;
		iif(ingr>0,Iif(tdoc='50','18','02'),'01') As TipoOperacion,;
		DESC As Descripcion,;
		'NIU' As UnidadMedida,;
		'1' As tipovaluacion,;
		ingr,;
		prei,;
		impi,;
		egre,;
		pree,;
		impe,;
		stock,;
		IIF(cost<0,0000000.00,cost) As costo,;
		saldo,;
		'1' As estado;
		From k Where nreg>0 Into Cursor lreg
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		nlote=nrolote
		If nl=0 Then
    \\<<periodo>>|<<nrolote>>|<<esta>>|<<codest>>|<<codcatalogo>>|<<tipoexistencia>>|<<coda>>|<<coda1>>|<<fechae>>|<<tipocomp>>|<<serie>>|<<ndoc>>|<<tipooperacion>>|<<descripcion>>|<<unidadmedida>>|<<tipovaluacion>>|<<ingr>>|<<prei>>|<<impi>>|<<egre>>|<<pree>>|<<impe>>|<<stock>>|<<costo>>|<<saldo>>|<<estado>>|
		Else
     \<<periodo>>|<<nrolote>>|<<esta>>|<<codest>>|<<codcatalogo>>|<<tipoexistencia>>|<<coda>>|<<coda1>>|<<fechae>>|<<tipocomp>>|<<serie>>|<<ndoc>>|<<tipooperacion>>|<<descripcion>>|<<unidadmedida>>|<<tipovaluacion>>|<<ingr>>|<<prei>>|<<impi>>|<<egre>>|<<pree>>|<<impe>>|<<stock>>|<<costo>>|<<saldo>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
***************************************
Procedure EnviarSunat(pk,crptahash)
	Declare Integer CryptBinaryToString In Crypt32;
		STRING @pbBinary, Long cbBinary, Long dwFlags,;
		STRING @pszString, Long @pcchString

	Declare Integer CryptStringToBinary In crypt32;
		STRING @pszString, Long cchString, Long dwFlags,;
		STRING @pbBinary, Long @pcbBinary,;
		LONG pdwSkip, Long pdwFlags

	#Define SXH_SERVER_CERT_IGNORE_ALL_SERVER_ERRORS    13056
	Set Library To Locfile("vfpcompression.fll")
	ZipfileQuick(goapp.carchivo)
	zipclose()
	Do Case
		Case goapp.tipoh=='B'
			lsURL   = "https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService"
			ls_ruc_emisor=fe_gene.nruc
			ls_pwd_sol = 'moddatos'
			ls_user = ls_ruc_emisor + 'MODDATOS'
		Case goapp.tipoh=='H'
			lsURL   = "https://www.sunat.gob.pe/ol-ti-itcpgem-sqa/billService"
			ls_ruc_emisor=fe_gene.nruc
			ls_pwd_sol = Alltrim(fe_gene.gene_csol)
			ls_user = ls_ruc_emisor + Alltrim(fe_gene.gene_usol)
		Case goapp.tipoh='P'
			lsURL   = "https://www.sunat.gob.pe/ol-ti-itcpfegem/billService"
			ls_ruc_emisor=fe_gene.nruc
			ls_pwd_sol = Alltrim(fe_gene.gene_csol)
			ls_user = ls_ruc_emisor + Alltrim(fe_gene.gene_usol)
		Otherwise
			lsURL   = "https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService"
			ls_ruc_emisor=fe_gene.nruc
			ls_pwd_sol = Alltrim(fe_gene.gene_csol)
			ls_user = ls_ruc_emisor + Alltrim(fe_gene.gene_usol)
	Endcase
	npos=At('.',goapp.carchivo)
	carchivozip=Substr(goapp.carchivo,1,npos-1)
	ps_fileZip = carchivozip+'.zip'
	ls_fileName = Justfname(ps_fileZip)
	ls_contentFile = Filetostr(ps_fileZip)
	crespuesta=ls_fileName
	ls_base64 = Strconv(ls_contentFile, 13) && Encoding base 64
	TEXT TO ls_envioXML TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2+4+8
			<soapenv:Envelope xmlns:ser="http://service.sunat.gob.pe" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
					xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">
				<soapenv:Header>
					<wsse:Security>
						<wsse:UsernameToken>
							<wsse:Username><<ls_user>></wsse:Username>
							<wsse:Password><<ls_pwd_sol>></wsse:Password>
						</wsse:UsernameToken>
					</wsse:Security>
				</soapenv:Header>
				<soapenv:Body>
					<ser:sendBill>
						<fileName><<ls_fileName>></fileName>
						<contentFile><<ls_base64>></contentFile>
					</ser:sendBill>
				</soapenv:Body>
			</soapenv:Envelope>
	ENDTEXT
	oXMLHttp=Createobject("MSXML2.ServerXMLHTTP.6.0")
	oXMLBody=Createobject('MSXML2.DOMDocument.6.0')
	If !(oXMLBody.LoadXML(ls_envioXML)) Then
		oResp.mensaje = "No se cargo XML: " + oXMLBody.parseError.reason
		Return 0
	Endif
	oXMLHttp.Open('POST', lsURL, .F.)
	oXMLHttp.setRequestHeader( "Content-Type", "text/xml" )
	oXMLHttp.setRequestHeader( "Content-Type", "text/xml;charset=ISO-8859-1" )
	oXMLHttp.setRequestHeader( "Content-Length", Len(ls_envioXML) )
	oXMLHttp.setRequestHeader( "SOAPAction" , "sendBill" )
	oXMLHttp.setOption(2, SXH_SERVER_CERT_IGNORE_ALL_SERVER_ERRORS)
	oXMLHttp.Send(oXMLBody.documentElement.XML)
	If (oXMLHttp.Status <> 200) Then
		Messagebox('Estado ' + Alltrim(Str(oXMLHttp.Status)) + '-' + Nvl(oXMLHttp.responseText,''))
		Return 0
	Endif
	loXMLResp = Createobject("MSXML2.DOMDocument.6.0")
	loXMLResp.LoadXML(oXMLHttp.responseText)
	ArchivoRespuestaSunat = Createobject("MSXML2.DOMDocument.6.0")  &&Creamos el archivo de respuesta
	ArchivoRespuestaSunat.LoadXML(oXMLHttp.responseText)			&&Llenamos el archivo de respuesta
	TxtB64 = ArchivoRespuestaSunat.selectSingleNode("//applicationResponse")  &&Ahora Buscamos el nodo "applicationResponse" llenamos la variable TxtB64 con el contenido del nodo "applicationResponse"
	cnombre=Sys(5)+Sys(2003)+'\SunatXml\'+crespuesta
	decodefile(TxtB64.Text,cnombre)
	cDirDesti = Sys(5)+Sys(2003)+'\SunatXML\'
	oShell = Createobject("Shell.Application")
	For Each oArchi In oShell.NameSpace(cnombre).Items
		If Left(oArchi.Name,1)='R' Then
			oShell.NameSpace(cDirDesti).CopyHere(oArchi)
			cfilerpta=Juststem(oArchi.Name)+'.XML'
		Endif
	Endfor
	rptaSunat=LeerRespuestaSunat(Sys(5)+Sys(2003)+'\SunatXML\'+cfilerpta)
	GuardaPk(pk,crptahash,rptaSunat)
	Do Case
		Case Left(rptaSunat,1)='0'
			mensaje(rptaSunat)
			Return 1
		Case Empty(rptaSunat)
			Messagebox(rptaSunat,64,'Sisven')
			Return 5000
		Otherwise
			Messagebox(rptaSunat,64,'Sisven')
			Return 0
	Endcase
Endproc
&&Rutina para decodificar el base64 a zip este codigo lo obtuve de la pagina de Victor Espina el link directo esta aca(http://victorespina.com.ve/wiki/index.php?title=Parser_Base64_para_VFP_usando_CryptoAPI)
******************************
Function decodeString(pcB64)
	Local nFlags, nBufsize, cDst
	nFlags=1  && base64
	nBufsize=0
	pcB64 = Strt(Strt(Strt(pcB64,"\/","/"),"\u000d",Chr(13)),"\u000a",Chr(10))
	CryptStringToBinary(@pcB64, Len(m.pcB64),nFlags, Null, @nBufsize, 0,0)
	cDst = Replicate(Chr(0), m.nBufsize)
	If CryptStringToBinary(@pcB64, Len(m.pcB64),nFlags, @cDst, @nBufsize, 0,0) = 0
		Return ""
	Endif
	Return m.cDst
Endproc
*****************************
Procedure decodefile(pcB64, pcFile)
	Local cBuff
	cBuff = decodeString(pcB64)
	Strtofile(cBuff, pcFile)
Endproc
**************************
Function LeerCodigoHash(lCfileName)
	Local lnCount As Integer, ;
		lcXML As String, ;
		lcString As String

	If Not File(lCfileName)
		Return []
	Endif
	lcXML = Filetostr(lCfileName)
	If "<DigestValue>" $ lcXML
		lnCount = 1
	Else
		lnCount = 2
	Endif
	chash=""
	For lnI = 1 To Occurs('<DigestValue>', lcXML)
		chash = Strextract(lcXML, '<DigestValue>','</DigestValue>',lnI)
	Next lnI
	Return chash
Endfunc
************************************
Function LeerRespuestaSunat(cfilerpta)
	Local lnCount As Integer, ;
		lcXML As String, ;
		lcString As String
	If Not File(cfilerpta) Then
		Return []
	Endif
	lcXML = Filetostr(cfilerpta)
	If "<cbc:Description>" $ lcXML
		lnCount = 1
	Else
		lnCount = 2
	Endif
	cresp=""
	For lnI = 1 To Occurs('<cbc:Description>', lcXML)
		cresp = Strextract(lcXML, '<cbc:Description>', '</cbc:Description>',lnI)
	Next lnI
	*Leer Codigo de Respuesta*
	If "<cbc:ResponseCode>" $ lcXML
		lnCount = 1
	Else
		lnCount = 2
	Endif
	resp1=""
	For lnI = 1 To Occurs('<cbc:ResponseCode>', lcXML)
		resp1 = Strextract(lcXML, '<cbc:ResponseCode>', '</cbc:ResponseCode>',lnI)
	Next lnI
	Return resp1+' '+cresp
Endfunc
******************************
Procedure EnviarSunat1(pk,crhash)
	#Define SXH_SERVER_CERT_IGNORE_ALL_SERVER_ERRORS    13056
	Set Library To Locfile("vfpcompression.fll")
	ZipfileQuick(goapp.carchivo)
	zipclose()
	Do Case
		Case goapp.tipoh=='B'
			lsURL   = "https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService"
			ls_ruc_emisor=fe_gene.nruc
			ls_pwd_sol = 'moddatos'
			ls_user = ls_ruc_emisor + 'MODDATOS'
		Case goapp.tipoh=='H'
			lsURL   = "https://www.sunat.gob.pe/ol-ti-itcpgem-sqa/billService"
			ls_ruc_emisor=fe_gene.nruc
			ls_pwd_sol = Alltrim(fe_gene.gene_csol)
			ls_user = ls_ruc_emisor + Alltrim(fe_gene.gene_usol)
		Case goapp.tipoh='P'
			lsURL   = "https://www.sunat.gob.pe/ol-ti-itcpfegem/billService"
			ls_ruc_emisor=fe_gene.nruc
			ls_pwd_sol = Alltrim(fe_gene.gene_csol)
			ls_user = ls_ruc_emisor + Alltrim(fe_gene.gene_usol)
		Otherwise
			lsURL   = "https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService"
			ls_ruc_emisor=fe_gene.nruc
			ls_pwd_sol = Alltrim(fe_gene.gene_csol)
			ls_user = ls_ruc_emisor + Alltrim(fe_gene.gene_usol)
	Endcase
	npos=At('.',goapp.carchivo)
	ctipoarchivo=Justfname(goapp.carchivo)
	carchivozip=Substr(goapp.carchivo,1,npos-1)
	ps_fileZip = carchivozip+'.zip'
	ls_fileName = Justfname(ps_fileZip)
	ls_contentFile = Filetostr(ps_fileZip)
	crespuesta=ls_fileName
	ls_base64 = Strconv(ls_contentFile, 13) && Encoding base 64
	TEXT TO ls_envioXML TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2+4+8
			<soapenv:Envelope xmlns:ser="http://service.sunat.gob.pe" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
					xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">
				<soapenv:Header>
					<wsse:Security>
						<wsse:UsernameToken>
							<wsse:Username><<ls_user>></wsse:Username>
							<wsse:Password><<ls_pwd_sol>></wsse:Password>
						</wsse:UsernameToken>
					</wsse:Security>
				</soapenv:Header>
				<soapenv:Body>
					<ser:sendSummary>
						<fileName><<ls_fileName>></fileName>
						<contentFile><<ls_base64>></contentFile>
					</ser:sendSummary>
				</soapenv:Body>
			</soapenv:Envelope>
	ENDTEXT

	oXMLHttp=Createobject("MSXML2.ServerXMLHTTP.6.0")
	oXMLBody=Createobject('MSXML2.DOMDocument.6.0')
	If !(oXMLBody.LoadXML(ls_envioXML)) Then
		oResp.mensaje = "No se cargo XML: " + oXMLBody.parseError.reason
		Return 0
	Endif
	oXMLHttp.Open('POST', lsURL, .F.)
	oXMLHttp.setRequestHeader( "Content-Type", "text/xml" )
	oXMLHttp.setRequestHeader( "Content-Type", "text/xml;charset=ISO-8859-1" )
	oXMLHttp.setRequestHeader( "Content-Length", Len(ls_envioXML) )
	oXMLHttp.setRequestHeader( "SOAPAction" , "sendSummary" )
	oXMLHttp.setOption(2, SXH_SERVER_CERT_IGNORE_ALL_SERVER_ERRORS)
	oXMLHttp.Send(oXMLBody.documentElement.XML)
	If (oXMLHttp.Status <> 200) Then
		Messagebox('ESTADO: ' + Alltrim(Str(oXMLHttp.Status)) + '-' + Nvl(oXMLHttp.responseText,''))
		Return 0
	Endif
	loXMLResp = Createobject("MSXML2.DOMDocument.6.0")
	loXMLResp.LoadXML(oXMLHttp.responseText)
	lcXML=oXMLHttp.responseText
	If "<ticket>" $ lcXML
		lnCount = 1
	Else
		lnCount = 2
	Endif
	cresp=""
	For lnI = 1 To Occurs('<ticket>', lcXML)
		cresp = Strextract(lcXML, '<ticket>', '</ticket>',lnI)
	Next lnI
	mensaje(cresp)
	goapp.ticket=Alltrim(cresp)
	Select curb
	Scan All
		If Substr(ctipoarchivo,13,2)='RA' Then
			If RegistraResumenBajas(curb.fech,curb.tdoc,curb.serie,curb.numero,curb.motivo,"",cresp,goapp.carchivo,crhash,curb.idauto)=0 Then
				Messagebox("NO se Grabo la Respuesta de SUNAT en nuestra Base de Datos",16,MSGTITULO)
				Exit
			Endif
		Else
			If RegistraResumenBoletas(curb.fech,curb.tdoc,curb.serie,curb.desde,curb.hasta,curb.Impo,curb.valor,curb.Exon,curb.inafectas,curb.igv,curb.gratificaciones,;
					"",crhash,goapp.carchivo,cresp)=0 Then
				Messagebox("NO se Grabo la Respuesta de SUNAT en nuestra Base de Datos",16,MSGTITULO)
				Exit
			Endif
		Endif
	Endscan
	Return 1
Endproc
************************************
Procedure ConsultaTicket(cticket,carchivo)
	Declare Integer CryptBinaryToString In Crypt32;
		STRING @pbBinary, Long cbBinary, Long dwFlags,;
		STRING @pszString, Long @pcchString

	Declare Integer CryptStringToBinary In crypt32;
		STRING @pszString, Long cchString, Long dwFlags,;
		STRING @pbBinary, Long @pcbBinary,;
		LONG pdwSkip, Long pdwFlags

	#Define SXH_SERVER_CERT_IGNORE_ALL_SERVER_ERRORS    13056
	Do Case
		Case goapp.tipoh=='B'
			lsURL   = "https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService"
			ls_ruc_emisor=fe_gene.nruc
			ls_pwd_sol = 'moddatos'
			ls_user = ls_ruc_emisor + 'MODDATOS'
		Case goapp.tipoh=='H'
			lsURL   = "https://www.sunat.gob.pe/ol-ti-itcpgem-sqa/billService"
			ls_ruc_emisor=fe_gene.nruc
			ls_pwd_sol = Alltrim(fe_gene.gene_csol)
			ls_user = ls_ruc_emisor + Alltrim(fe_gene.gene_usol)
		Case goapp.tipoh='P'
			lsURL   = "https://www.sunat.gob.pe/ol-ti-itcpfegem/billService"
			ls_ruc_emisor=fe_gene.nruc
			ls_pwd_sol = Alltrim(fe_gene.gene_csol)
			ls_user = ls_ruc_emisor + Alltrim(fe_gene.gene_usol)
		Otherwise
			lsURL   = "https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService"
			ls_ruc_emisor=fe_gene.nruc
			ls_pwd_sol = Alltrim(fe_gene.gene_csol)
			ls_user = ls_ruc_emisor + Alltrim(fe_gene.gene_usol)
	Endcase
	npos=At('.',carchivo)
	carchivozip=Substr(carchivo,1,npos-1)
	ps_fileZip = carchivozip+'.zip'
	ls_fileName = Justfname(ps_fileZip)
	ctipoarchivo=Justfname(carchivo)
	crespuesta=ls_fileName
	TEXT TO ls_envioXML TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2+4+8
			<soapenv:Envelope xmlns:ser="http://service.sunat.gob.pe" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
					xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">
				<soapenv:Header>
					<wsse:Security>
						<wsse:UsernameToken>
							<wsse:Username><<ls_user>></wsse:Username>
							<wsse:Password><<ls_pwd_sol>></wsse:Password>
						</wsse:UsernameToken>
					</wsse:Security>
				</soapenv:Header>
				<soapenv:Body>
					<ser:getStatus>
						<ticket><<cticket>></ticket>
					</ser:getStatus>
				</soapenv:Body>
			</soapenv:Envelope>
	ENDTEXT
	oXMLHttp=Createobject("MSXML2.ServerXMLHTTP.6.0")
	oXMLBody=Createobject('MSXML2.DOMDocument.6.0')
	If !(oXMLBody.LoadXML(ls_envioXML)) Then
		oResp.mensaje = "No se cargo XML: " + oXMLBody.parseError.reason
		Return 0
	Endif
	oXMLHttp.Open('POST', lsURL, .F.)
	oXMLHttp.setRequestHeader( "Content-Type", "text/xml" )
	oXMLHttp.setRequestHeader( "Content-Type", "text/xml;charset=ISO-8859-1" )
	oXMLHttp.setRequestHeader( "Content-Length", Len(ls_envioXML) )
	oXMLHttp.setRequestHeader( "SOAPAction" , "getStatus" )
	oXMLHttp.setOption(2, SXH_SERVER_CERT_IGNORE_ALL_SERVER_ERRORS)
	oXMLHttp.Send(oXMLBody.documentElement.XML)
	If (oXMLHttp.Status <> 200) Then
		Messagebox('STATUS: ' + Alltrim(Str(oXMLHttp.Status)) + '-' + Nvl(oXMLHttp.responseText,''))
		Return 0
	Endif
	loXMLResp = Createobject("MSXML2.DOMDocument.6.0")
	loXMLResp.LoadXML(oXMLHttp.responseText)
	*Messagebox(oXMLHttp.responseText)
	lcXML=oXMLHttp.responseText
	If "<statusCode>" $ lcXML
		lnCount = 1
	Else
		lnCount = 2
	Endif
	cresp=""
	For lnI = 1 To Occurs('<statusCode>', lcXML)
		cresp = Strextract(lcXML, '<statusCode>', '</statusCode>',lnI)
	Next lnI
	*	Messagebox(cresp)
	ArchivoRespuestaSunat =Createobject("MSXML2.DOMDocument.6.0")  &&Creamos el archivo de respuesta
	ArchivoRespuestaSunat.LoadXML(oXMLHttp.responseText)			&&Llenamos el archivo de respuesta
	TxtB64 = ArchivoRespuestaSunat.selectSingleNode("//content")  &&Ahora Buscamos el nodo "applicationResponse" llenamos la variable TxtB64 con el contenido del nodo "applicationResponse"
	cnombre=Sys(5)+Sys(2003)+'\SunatXml\'+crespuesta
	decodefile(TxtB64.Text,cnombre)
	cDirDesti = Sys(5)+Sys(2003)+'\SunatXML\'
	oShell = Createobject("Shell.Application")
	cfilerpta="R"
	For Each oArchi In oShell.NameSpace(cnombre).Items
		If Left(oArchi.Name,1)='R' Then
			oShell.NameSpace(cDirDesti).CopyHere(oArchi)
			cfilerpta=Juststem(oArchi.Name)+'.XML'
		Endif
	Endfor
	rptaSunat=LeerRespuestaSunat(Sys(5)+Sys(2003)+'\SunatXML\'+cfilerpta)
	If !Empty(rptaSunat)
		mensaje(rptaSunat)
	Endif
	If !Empty(rptaSunat) Then
		If Substr(ctipoarchivo,13,2)='RA' Then
			If ActualizaResumenBajas(cticket,rptaSunat)=0 Then
				Messagebox("NO se Grabo la Respuesta de SUNAT en nuestra Base de Datos",16,MSGTITULO)
			Endif
		Else
			If ActualizaResumenBoletas(cticket,rptaSunat)=0 Then
				Messagebox("NO se Grabo la Respuesta de SUNAT en nuestra Base de Datos",16,MSGTITULO)
			Endif
		Endif
		If Left(rptaSunat,1)=='0' Then
			Return 1
		Else
			Return 0
		Endif
	Else
		Return -1
	Endif
Endproc
***********************************
Procedure CrearPdf(np1,np2,np3)
	Private oFbc
	Obj=Createobject("custom")
	Obj.AddProperty("ArchivoXml")
	Obj.ArchivoXml=""
	Set Procedure To capadatos,foxbarcodeqr Additive
	m.oFbc = Createobject("FoxBarcodeQR")
	Do "FoxyPreviewer.App"
	carchivo = Addbs(Sys(5)+Sys(2003)+'\PDF\')+np2
	Report Form (np1) Object Type 10 To File (carchivo)
	Do foxypreviewer.App With "Release"
	If np3='S' Then
		Set Procedure To capadatos,abrirpdf Additive
		abrirpdf(carchivo)
	Endif
	m.oFbc=Null
	Release Obj
Endproc
***********************************
Procedure Reimprimir(np1,np2)
	If verificaAlias("tmpv")=0 Then
		Create Cursor tmpv(coda N(8),Desc c(120),unid c(4),Prec N(13,8),cant N(10,2),ndoc c(12),alma N(10,2),peso N(10,2),;
			Impo N(10,2),tipro c(1),ptoll c(50),fect d,perc N(5,2),cletras c(120),;
			nruc c(11),razon c(120),direccion c(190),fech d,fechav d,ndo2 c(12),vendedor c(50),Form c(20),;
			referencia c(120),hash c(30),dni c(8),Mone c(1),tdoc1 c(2),dcto c(12),fech1 d,detalle c(120),contacto c(120),archivo c(120))
	Else
		Zap In tmpv
	Endif
	Do Case
		Case np2='01' Or np2='03'
			TEXT TO lc noshow
			    SELECT a.codv,a.idauto,a.alma,a.idkar,a.idauto,a.idart,a.cant,a.prec,a.alma,c.tdoc as tdoc1,
			    c.ndoc as dcto,c.fech as fech1,rcom_arch,
			    c.fech,c.fecr,c.form,c.deta,c.exon,c.ndo2,c.igv,a.idclie,d.razo,d.nruc,d.dire,d.ciud,d.ndni,c.pimpo,ifnull(x.dpto_nomb,'') as dpto,d.clie_dist as distrito,
			    c.tdoc,c.ndoc,a.dola,c.mone,b.descri,b.unid,c.rcom_hash,v.nomv,c.impo FROM fe_art as b join fe_kar as a on(b.idart=a.idart)
			    inner join fe_vend as v on v.idven=a.codv  inner JOIN fe_rcom as c on(a.idauto=c.idauto) inner join fe_clie as d on(c.idcliente=d.idclie)
			    left join fe_dpto as x on x.dpto_idpt=d.clie_idpt
			    where c.idauto=?np1 and a.acti='A';
			ENDTEXT
		Case np2='08'
			TEXT TO lc noshow
			   SELECT r.idauto,r.ndoc,r.tdoc,r.fech,r.mone,abs(r.valor) as valor,r.ndo2,
		       r.vigv,c.nruc,c.razo,c.dire,c.ciud,c.ndni,' ' as nomv,r.form,ifnull(x.dpto_nomb,'') as dpto,c.clie_dist as distrito,
		       abs(r.igv) as igv,abs(r.impo) as impo,ifnull(k.cant,CAST(0 as decimal(12,2))) as cant,
		       ifnull(k.prec,ABS(r.impo)) as prec,LEFT(r.ndoc,4) as serie,SUBSTR(r.ndoc,5) as numero,
		       ifnull(a.unid,'') as unid,ifnull(a.descri,r.deta) as descri,r.deta,ifnull(k.idart,CAST(0 as decimal(8))) as idart,f.ndoc as dcto,
		       f.fech as fech1,w.tdoc as tdoc1,rcom_hash,rcom_arch
		       from fe_rcom r inner join fe_clie c on c.idclie=r.idcliente
		       left join fe_kar k on k.idauto=r.idauto left join fe_art a on a.idart=k.idart
		       inner join fe_rven as rv on rv.idauto=r.idauto inner join fe_refe f on f.idrven=rv.idrven inner join fe_tdoc as w on w.idtdoc=f.idtdoc
		       left join fe_dpto as x on x.dpto_idpt=c.clie_idpt
		       where r.idauto=?np1 and r.acti='A' and r.tdoc='08'
			ENDTEXT
		Case np2='07'
			TEXT TO lc noshow
			   SELECT r.idauto,r.ndoc,r.tdoc,r.fech,r.mone,abs(r.valor) as valor,r.ndo2,
		       r.vigv,c.nruc,c.razo,c.dire,c.ciud,c.ndni,' ' as nomv,r.form,ifnull(x.dpto_nomb,'') as dpto,c.clie_dist as distrito,
		       abs(r.igv) as igv,abs(r.impo) as impo,ifnull(k.cant,CAST(0 as decimal(12,2))) as cant,
		       ifnull(k.prec,ABS(r.impo)) as prec,LEFT(r.ndoc,4) as serie,SUBSTR(r.ndoc,5) as numero,
		       ifnull(a.unid,'') as unid,ifnull(a.descri,r.deta) as descri,r.deta,ifnull(k.idart,CAST(0 as decimal(8))) as idart,f.ndoc as dcto,
		       f.fech as fech1,w.tdoc as tdoc1,rcom_hash,rcom_arch
		       from fe_rcom r inner join fe_clie c on c.idclie=r.idcliente
		       left join fe_kar k on k.idauto=r.idauto left join fe_art a on a.idart=k.idart
		       inner join fe_rven as rv on rv.idauto=r.idauto inner join fe_refe f on f.idrven=rv.idrven inner join fe_tdoc as w on w.idtdoc=f.idtdoc
		       left join fe_dpto as x on x.dpto_idpt=c.clie_idpt
		       where r.idauto=?np1 and r.acti='A' and r.tdoc='07'
			ENDTEXT
	Endcase
	ncon=Abreconexion()
	If SQLExec(ncon,lc,'kardex')<0 Then
		errorbd(lc)
		Return
	Endif
	CierraConexion(ncon)
	nimpo=kardex.Impo
	cndoc=kardex.ndoc
	cmone=kardex.Mone
	ctdoc=kardex.tdoc
	chash=kardex.rcom_hash
	carchivo=Sys(5)+Sys(2003)+'\'+Justfname(kardex.rcom_arch)
	nf=0
	Select kardex
	Scan All
		nf=nf+1
		cciud=Iif(!Empty(kardex.distrito),"-"+Alltrim(kardex.distrito),"")+"-"+Alltrim(kardex.ciud)+""+Iif(!Empty(kardex.dpto),"-"+kardex.dpto,"")
		Insert Into tmpv(coda,Desc,unid,cant,Prec,ndoc,hash,nruc,razon,direccion,fech,fechav,ndo2,vendedor,Form,referencia,dni,Mone,dcto,tdoc1,fech1);
			values(kardex.idart,kardex.Descri,kardex.unid,Iif(kardex.cant=0,1,kardex.cant),kardex.Prec,;
			kardex.ndoc,kardex.rcom_hash,kardex.nruc,kardex.razo,Alltrim(kardex.Dire)+' '+Alltrim(cciud),kardex.fech,kardex.fech,;
			kardex.ndo2,kardex.nomv,Icase(kardex.Form='E','Efectivo',kardex.Form='C','Crédito',kardex.Form='T','Tarjeta',kardex.Form='D','Depósito','Cheque'),;
			kardex.Deta,kardex.ndni,kardex.Mone,kardex.dcto,kardex.tdoc1,kardex.fech1)
	Endscan
	Local cimporte
	cimporte=Diletras(nimpo,cmone)
	ni=nf
	Private oFbc
	Set Procedure To capadatos,foxbarcodeqr Additive
	m.oFbc = Createobject("FoxBarcodeQR")
	Select tmpv
	For x=1 To fe_gene.Items-nf
		ni=ni+1
		Insert Into tmpv(ndoc)Values(cndoc)
	Next
	Select tmpv
	Replace All ndoc With cndoc,cletras With cimporte,Mone With cmone,hash With chash,archivo With carchivo
	Go Top In tmpv
Endproc
*******************************
Function  generaCorrelativoEnvioResumenBoletas()
	TEXT TO lc noshow
	   UPDATE fe_gene  as f SET gene_nres=f.gene_nres+1 WHERE idgene=1
	ENDTEXT
	ncon=Abreconexion()
	If SQLExec(ncon,lc,'up')<0 Then
		errorbd(lc)
		Return 0
	Endif
	CierraConexion(ncon)
	Return 1
Endfunc
*****************************
Function  generaCorrelativoEnvioResumenBajas()
	TEXT TO lc noshow
	   UPDATE fe_gene  as f SET gene_nbaj=f.gene_nbaj+1 WHERE idgene=1
	ENDTEXT
	ncon=Abreconexion()
	If SQLExec(ncon,lc,'up')<0 Then
		errorbd(lc)
		Return 0
	Endif
	CierraConexion(ncon)
	Return 1
Endfunc
*********************************
Function RegistraResumenBajas(np1,np2,np3,np4,np5,np6,np7,np8,np9,np10)
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
	lc="proIngresaRbajas"
	cur=[]
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,?goapp.npara10)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' '+' Registrando el Informe de Bajas')
		Return 0
	Else
		Return 1
	Endif
Endfunc
***********************************
Function RegistraResumenBoletas(np1,np2,np3,np4,np5,np6,np7,np8,np9,np10,np11,np12,np13,np14,np15)
	cur=[]
	lc="proIngresaResumenBoletas"
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
		errorbd(ERRORPROC+' '+' Registrando Resumen de Boletas')
		Return 0
	Else
		Return 1
	Endif
Endfunc
*******************************
Function ActualizaResumenBoletas(np1,np2)
	cur=[]
	lc="ProactualizaResumenBoletas"
	goapp.npara1=np1
	goapp.npara2=np2
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Actualizando Respuesta de Sunat')
		Return 0
	Else
		Return 1
	Endif
Endfunc
****************************
Function ActualizaResumenBajas(np1,np2)
	cur=[]
	lc="ProactualizaRBajas"
	goapp.npara1=np1
	goapp.npara2=np2
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Actualizando Respuesta de Sunat')
		Return 0
	Else
		Return 1
	Endif
Endfunc
**************************
Procedure GuardaPk(np1,np2,np3)
	If np1>0 Then
		ncon=Abreconexion()
		carchivo=goapp.carchivo
		TEXT  TO lc noshow
               UPDATE fe_rcom SET rcom_hash=?np2,rcom_mens=?np3,rcom_arch=?carchivo WHERE idauto=?np1
		ENDTEXT
		If SQLExec(ncon,lc)<0 Then
			errorbd(lc)
			Return 0
		Endif
		CierraConexion(ncon)
		Return 1
	Endif
Endproc
***************************
Procedure ReimprimirStandar(np1,np2)
	If verificaAlias("tmpv")=0 Then
		Create Cursor tmpv(coda N(8),Desc c(120),unid c(4),Prec N(13,8),cant N(10,2),ndoc c(12),alma N(10,2),peso N(10,2),;
			Impo N(10,2),tipro c(1),ptoll c(50),fect d,perc N(5,2),cletras c(120),;
			nruc c(11),razon c(120),direccion c(190),fech d,fechav d,ndo2 c(12),vendedor c(50),Forma c(20),Form c(20),guia c(15),;
			referencia c(120),hash c(30),dni c(8),Mone c(1),tdoc1 c(2),dcto c(12),fech1 d,usuario c(30),tigv N(5,3),detalle c(120),contacto c(120))
	Else
		Zap In tmpv
	Endif
	Do Case
		Case np2='01' Or np2='03'
			TEXT TO lc noshow
			    SELECT a.codv,a.idauto,a.alma,a.idkar,a.idauto,a.idart,a.cant,a.prec,a.alma,c.tdoc as tdoc1,
			    c.ndoc as dcto,c.fech as fech1,c.vigv,
			    c.fech,c.fecr,c.form,c.deta,c.rcom_exon,c.ndo2,c.igv,c.idcliente,d.razo,d.nruc,d.dire,d.ciud,d.ndni,c.pimpo,u.nomb as usuario,
			    c.tdoc,c.ndoc,c.dolar as dola,c.mone,b.descri,b.unid,c.rcom_hash,v.nomv,c.impo FROM fe_art as b join fe_kar as a on(b.idart=a.idart)
			    inner join fe_vend as v on v.idven=a.codv  inner JOIN fe_rcom as c on(a.idauto=c.idauto) inner join fe_clie as d on(c.idcliente=d.idclie)
			    inner join fe_usua as u on u.idusua=c.idusua
			    where c.idauto=?np1 and a.acti='A';
			ENDTEXT
		Case np2='08'
			TEXT TO lc noshow
			   SELECT r.idauto,r.ndoc,r.tdoc,r.fech,r.mone,abs(r.valor) as valor,r.ndo2,
		       r.vigv,c.nruc,c.razo,c.dire,c.ciud,c.ndni,' ' as nomv,r.form,
		       abs(r.igv) as igv,abs(r.impo) as impo,ifnull(k.cant,CAST(0 as decimal(12,2))) as cant,
		       ifnull(k.prec,ABS(r.impo)) as prec,LEFT(r.ndoc,4) as serie,SUBSTR(r.ndoc,5) as numero,
		       ifnull(a.unid,'') as unid,ifnull(a.descri,r.deta) as descri,r.deta,ifnull(k.idart,CAST(0 as decimal(8))) as idart,w.ndoc as dcto,
		       w.fech as fech1,w.tdoc as tdoc1,r.rcom_hash,u.nomb as usuario
		       from fe_rcom r inner join fe_clie c on c.idclie=r.idcliente
		       left join fe_kar k on k.idauto=r.idauto left join fe_art a on a.idart=k.idart
		       inner join fe_ncven f on f.ncre_idan=r.idauto inner join fe_rcom as w on w.idauto=f.ncre_idau
		        inner join fe_usua as u on u.idusua=r.idusua
		       where r.idauto=?np1 and r.acti='A' and r.tdoc='08'
			ENDTEXT
		Case np2='07'
			TEXT TO lc noshow
			   SELECT r.idauto,r.ndoc,r.tdoc,r.fech,r.mone,abs(r.valor) as valor,r.ndo2,
		       r.vigv,c.nruc,c.razo,c.dire,c.ciud,c.ndni,' ' as nomv,r.form,u.nomb as usuario,
		       abs(r.igv) as igv,abs(r.impo) as impo,ifnull(k.cant,CAST(0 as decimal(12,2))) as cant,
		       ifnull(k.prec,ABS(r.impo)) as prec,LEFT(r.ndoc,4) as serie,SUBSTR(r.ndoc,5) as numero,
		       ifnull(a.unid,'') as unid,ifnull(a.descri,r.deta) as descri,r.deta,ifnull(k.idart,CAST(0 as decimal(8))) as idart,w.ndoc as dcto,
		       w.fech as fech1,w.tdoc as tdoc1,r.rcom_hash
		       from fe_rcom r inner join fe_clie c on c.idclie=r.idcliente
		       left join fe_kar k on k.idauto=r.idauto left join fe_art a on a.idart=k.idart
		       inner join fe_ncven f on f.ncre_idan=r.idauto inner join fe_rcom as w on w.idauto=f.ncre_idau
		        inner join fe_usua as u on u.idusua=r.idusua
		       where r.idauto=?np1 and r.acti='A' and r.tdoc='07'
			ENDTEXT
	Endcase
	ncon=Abreconexion()
	If SQLExec(ncon,lc,'kardex')<0 Then
		errorbd(lc)
		Return
	Endif
	CierraConexion(ncon)
	nimpo=kardex.Impo
	cndoc=kardex.ndoc
	cmone=kardex.Mone
	ctdoc=kardex.tdoc
	chash=kardex.rcom_hash
	cdeta1=kardex.Deta
	vvigv=kardex.vigv
	nf=0
	Select kardex
	Scan All
		nf=nf+1
		Insert Into tmpv(coda,Desc,unid,cant,Prec,ndoc,hash,nruc,razon,direccion,fech,fechav,ndo2,vendedor,Form,;
			referencia,dni,Mone,dcto,tdoc1,fech1,usuario,guia,Forma,tigv);
			values(kardex.idart,kardex.Descri,kardex.unid,Iif(kardex.cant=0,1,kardex.cant),kardex.Prec,;
			kardex.ndoc,kardex.rcom_hash,kardex.nruc,kardex.razo,Alltrim(kardex.Dire)+' '+Alltrim(kardex.ciud),kardex.fech,kardex.fech,;
			kardex.ndo2,kardex.nomv,Icase(kardex.Form='E','Efectivo',kardex.Form='C','Crédito',kardex.Form='T','Tarjeta',kardex.Form='D','Depósito','Cheque'),;
			kardex.Deta,kardex.ndni,kardex.Mone,kardex.dcto,kardex.tdoc1,kardex.fech1,kardex.usuario,kardex.ndo2,;
			Icase(kardex.Form='E','Efectivo',kardex.Form='C','Crédito',kardex.Form='T','Tarjeta',kardex.Form='D','Depósito','Cheque'),kardex.vigv)
	Endscan
	Local cimporte
	cimporte=Diletras(nimpo,cmone)
	ni=nf
	Select tmpv
	*Replace All ndoc With cndoc,cletras With cimporte,Mone With cmone,hash With chash
	For x=1 To fe_gene.Items-nf
		ni=ni+1
		Insert Into tmpv(ndoc)Values(cndoc)
	Next
	Select tmpv
	Replace All ndoc With cndoc,cletras With cimporte,Mone With cmone,hash With chash,referencia With cdeta1,tigv With vvigv
	Go Top In tmpv
Endproc
********************************
Function GeneraPLE5Contingencia(np1,np2)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select * From cont1;
		Into Cursor lreg
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
        \\<<motivo>>|<<fech>>|<<tdoc>>|<<serie>>|<<numero>>|<<ctik>>|<<tipodocc>>|<<nruc>>|<<ALLTRIM(razo)>>|<<valor>>|<<exon>>|<<inafecto>>|<<isc>>|<<igv>>|<<otros>>|<<impo>>|<<tref>>|<<serierefe>>|<<numerorefe>>|
		Else
         \<<motivo>>|<<fech>>|<<tdoc>>|<<serie>>|<<numero>>|<<ctik>>|<<tipodocc>>|<<nruc>>|<<ALLTRIM(razo)>>|<<valor>>|<<exon>>|<<inafecto>>|<<isc>>|<<igv>>|<<otros>>|<<impo>>|<<tref>>|<<serierefe>>|<<numerorefe>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
	Set Library To Locfile("vfpcompression.fll")
	ZipfileQuick(cr1)
	zipclose()
Endfunc
***********************************
Function GetFileX(tcRuta, tcExtension, tcLeyenda, tcBoton, tnBoton, tcTitulo)
	Local lcDirAnt, lcGetPict
	tcRuta = Iif(Not Empty(tcRuta) And Directory(tcRuta,1),tcRuta,"")
	tcExtension = Iif(Empty(tcExtension), "", tcExtension)
	tcLeyenda = Iif(Empty(tcLeyenda), "", tcLeyenda)
	tcBoton = Iif(Empty(tcBoton), "", tcBoton)
	tnBoton = Iif(Empty(tnBoton), 0, tnBoton)
	tcTitulo = Iif(Empty(tcTitulo), "", tcTitulo)
	lcDirAnt = Fullpath("")
	Set Default To (tcRuta)
	lcGetPict = Getfile(tcExtension, tcLeyenda, tcBoton, tnBoton, tcTitulo)
	Set Default To (lcDirAnt)
	Return lcGetPict
Endfunc

********************************************************************************
Function GetPictX(tcRuta, tcExtension, tcLeyenda, tcBoton)
	Local lcDirAnt, lcGetPict
	tcRuta = Iif(Not Empty(tcRuta) And Directory(tcRuta,1),tcRuta,"")
	tcExtension = Iif(Empty(tcExtension), "", tcExtension)
	tcLeyenda = Iif(Empty(tcLeyenda), "", tcLeyenda)
	tcBoton = Iif(Empty(tcBoton), "", tcBoton)
	lcDirAnt = Fullpath("")
	Set Default To (tcRuta)
	lcGetPict = Getpict(tcExtension, tcLeyenda, tcBoton)
	Set Default To (lcDirAnt)
	Return lcGetPict
Endfunc
*****************************
Procedure mensaje
	Lparameters lcMess
	If Type("lcMess") = "L"
		Return .F.
	Endif
	Wait Window lcMess At Srows()/2,(Scols()/2 - (Len(lcMess)/2)) Timeout 1
Endproc
************************************
Function MuestraTabla34(np1,np2,cur)
	lc="ProMuestratabla34"
	goapp.npara1=np1
	goapp.npara2=np2
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Mostrando Tabla 34')
		Return 0
	Else
		Return 1
	Endif
Endfunc
*********************************
Function GrabaTabla34PlanCuentas(np1,np2)
	lc="ProGrabatabla34PlanCuentas"
	cur=""
	goapp.npara1=np1
	goapp.npara2=np2
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Actualizando Plan de Cuentas con  Tabla 34')
		Return 0
	Else
		Return 1
	Endif
Endfunc
*************************************
Function GeneraCta10Ple5(np1,np2,nmes,na)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As periodo,;
		ncta,;
		banc_idco,;
		ctas_ctas,;
		ctas_mone,;
		deudor,;
		acreedor,;
		1 As estado;
		From cta10 Into Cursor lreg
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
          \\<<periodo>>|<<ncta>>|<<banc_idco>>|<<TRIM(ctas_ctas)>>|<<ctas_mone>>|<<deudor>>|<<acreedor>>|<<estado>>|
		Else
		  \<<periodo>>|<<ncta>>|<<banc_idco>>|<<TRIM(ctas_ctas)>>|<<ctas_mone>>|<<deudor>>|<<acreedor>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
*********************************
Function GeneraCta12Ple5(np1,np2,nmes,na)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As periodo,;
		idauto,;
		Trim('M'+Alltrim(Str(ncontrol))) As  ncontrol,;
		tipodcto,;
		ndcto,;
		razo,;
		fech,;
		saldo,;
		1 As estado;
		From cta12 Into Cursor lreg
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
          \\<<periodo>>|<<idauto>>|<<ALLTRIM(ncontrol)>>|<<tipodcto>>|<<ndcto>>|<<razo>>|<<fech>>|<<saldo>>|<<estado>>|
		Else
		  \<<periodo>>|<<idauto>>|<<ALLTRIM(ncontrol)>>|<<tipodcto>>|<<ndcto>>|<<razo>>|<<fech>>|<<saldo>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
*********************************
Function GeneraCtaIBPle5(np1,np2,nmes,na)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As periodo,;
		tabla22,;
		idcta34,;
		saldo,;
		1 As estado;
		From rld Into Cursor lreg
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
          \\<<periodo>>|<<tabla22>>|<<idcta34>>|<<saldo>>|<<estado>>|
		Else
		   \<<periodo>>|<<tabla22>>|<<idcta34>>|<<saldo>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
*********************************
Function GeneraCta19Ple5(np1,np2,nmes,na)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As periodo,;
		idauto,;
		ncontrol,;
		tipodcto,;
		ndcto,;
		razo,;
		tdoc,;
		serie,;
		fech,;
		dcto,;
		saldo,;
		1 As estado;
		From cta19 Into Cursor lreg
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
          \\<<periodo>>|<<idauto>>|<<ALLTRIM(ncontrol)>>|<<tipodcto>>|<<ndcto>>|<<razo>>|<<tdoc>>|<<serie>>|<<dcto>>|<<fech>>|<<saldo>>|<<estado>>|
		Else
		   \<<periodo>>|<<idauto>>|<<ALLTRIM(ncontrol)>>|<<tipodcto>>|<<ndcto>>|<<razo>>|<<tdoc>>|<<serie>>|<<dcto>>|<<fech>>|<<saldo>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
*********************************
Function GeneraCta20Ple5(np1,np2,nmes,na)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As periodo,;
		codic,;
		tipo,;
		idart,;
		codosce,;
		descr,;
		unid,;
		metodo,;
		stock,;
		costo,;
		importe,;
		1 As estado;
		From cta12 Into Cursor lreg
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
          \\<<periodo>>|<<idauto>>|<<codic>>|<<tipo>>|<<idart>>|<<codosce>>|<<descr>>|<<unid>>|<<metodo>>|<<stock>>|<<costo>>|<<importe>>|<<estado>>|
		Else
		   \<<periodo>>|<<idauto>>|<<codic>>|<<tipo>>|<<idart>>|<<codosce>>|<<descr>>|<<unid>>|<<metodo>>|<<stock>>|<<costo>>|<<importe>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
*********************************
Function GeneraCta34Ple5(np1,np2,nmes,na)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As periodo,;
		RECNO() As idauto,;
		TRIM('M'+Alltrim(Str(Recno()))) As ncontrol,;
		fech,;
		ncta,;
		deta,;
		valor,;
		amor,;
		1 As estado;
		From cta34 Into Cursor lreg
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
          \\<<periodo>>|<<idauto>>|<<ALLTRIM(ncontrol)>>|<<fech>>|<<ncta>>|<<deta>>|<<valor>>|<<amor>>|<<estado>>|
		Else
		  \<<periodo>>|<<idauto>>|<<ALLTRIM(ncontrol)>>|<<fech>>|<<ncta>>|<<deta>>|<<valor>>|<<amor>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
*********************************
Function GeneraCta37Ple5(np1,np2,nmes,na)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As periodo,;
		RECNO() As idauto,;
		TRIM('M'+Alltrim(Str(Recno()))) As ncontrol,;
		tdoc,;
		serie,;
		ndoc,;
		ncta,;
		Deta,;
		saldo,;
		adicional,;
		deduccion,;
		1 As estado;
		From cta37 Into Cursor lreg
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
          \\<<periodo>>|<<idauto>>|<<ALLTRIM(ncontrol)>>|<<tdoc>>|<<serie>>|<<ndoc>>|<<ncta>>|<<deta>>|<<saldo>>|<<adicional>>|<<deduccion>>|<<estado>>|
		Else
		  \<<periodo>>|<<idauto>>|<<ALLTRIM(ncontrol)>>|<<tdoc>>|<<serie>>|<<ndoc>>|<<ncta>>|<<deta>>|<<saldo>>|<<adicional>>|<<deduccion>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
*********************************
Function GeneraCta41Ple5(np1,np2,nmes,na)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As periodo,;
		codigo  As idauto,;
		TRIM('M'+Alltrim(Str(codigo))) As ncontrol,;
		'41.11.00' As ncta,;
		tipo,;
		ndni,;
		codigo,;
		nombre,;
		saldo,;
		1 As estado;
		From cta41 Into Cursor lreg
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
		    \\<<periodo>>|<<idauto>>|<<ALLTRIM(ncontrol)>>|<<ncta>>|<<tipo>>|<<ndni>>|<<codigo>>|<<nombre>>|<<saldo>>|<<estado>>|
		Else
			 \<<periodo>>|<<idauto>>|<<ALLTRIM(ncontrol)>>|<<ncta>>|<<tipo>>|<<ndni>>|<<codigo>>|<<nombre>>|<<saldo>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
*********************************
Function GeneraCta42Ple5(np1,np2,nmes,na)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As periodo,;
		idauto,;
		ncontrol,;
		tipodcto,;
		ndcto,;
		razo,;
		fech,;
		saldo,;
		1 As estado;
		From cta42 Into Cursor lreg
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
          \\<<periodo>>|<<idauto>>|<<ALLTRIM(ncontrol)>>|<<tipodcto>>|<<ndcto>>|<<razo>>|<<fech>>|<<saldo>>|<<estado>>|
		Else
		  \<<periodo>>|<<idauto>>|<<ALLTRIM(ncontrol)>>|<<tipodcto>>|<<ndcto>>|<<razo>>|<<fech>>|<<saldo>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
*********************************
Function GeneraCta46Ple5(np1,np2,nmes,na)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As periodo,;
		idauto,;
		ncontrol,;
		tipodcto,;
		ndcto,;
		fech,;
		razo,;
		Left(ncta,2)+Substr(ncta,4,2)+Substr(ncta,7,2) As ncta,;
		saldo,;
		1 As estado;
		From cta46 Into Cursor lreg
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
          \\<<periodo>>|<<idauto>>|<<ALLTRIM(ncontrol)>>|<<tipodcto>>|<<ndcto>>|<<fech>>|<<ncta>>|<<razo>>|<<saldo>>|<<estado>>|
		Else
		   \<<periodo>>|<<idauto>>|<<ALLTRIM(ncontrol)>>|<<tipodcto>>|<<ndcto>>|<<fech>>|<<ncta>>|<<razo>>|<<saldo>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
*********************************
Function GeneraCta50Ple5(np1,np2,nmes,na)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As periodo,;
		importe,;
		valor,;
		accs,;
		accp,;
		1 As estado;
		From cta50 Into Cursor lreg
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
          \\<<periodo>>|<<importe>>|<<valor>>|<<accs>>|<<accp>>|<<estado>>|
		Else
		   \<<periodo>>|<<importe>>|<<valor>>|<<accs>>|<<accp>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
*********************************
Function GeneraCtaBalancePle5(np1,np2,nmes,na)
	cruta=Addbs(Justpath(np1))+np2
	cr1=cruta+'.txt'
	Select;
		Cast(Alltrim(Str(na))+Iif(nmes<=9,'0'+Alltrim(Str(nmes)),Alltrim(Str(nmes)))+'00' As Integer) As periodo,;
		ncta,;
		adeudor,;
		aacreedor,;
		debe,;
		haber,;
		deudor,;
		acreedor,;
		deudor As saldofd,;
		acreedor As saldofh,;
		debet,;
		habert,;
		activo,;
		pasivo,;
		rpnperdida,;
		rpnganancia,;
		0 As adicionales,;
		0 As deducciones,;
		1 As estado;
		From rldbalance  Where estilo='S' Into Cursor lreg
	Select lreg
	Set Textmerge On Noshow
	Set Textmerge To ((cr1))
	nl=0
	Scan
		If nl=0 Then
          \\<<periodo>>|<<ncta>>|<<adeudor>>|<<aacreedor>>|<<debe>>|<<haber>>|<<deudor>>|<<acreedor>>|<<saldofd>>|<<saldofh>>|<<debet>>|<<habert>><<activo>>|<<pasivo>>|<<rpnperdida>>|<<rpnganancia>>|<<adicionales>>|<<deducciones>>|<<estado>>|
		Else
		   \<<periodo>>|<<ncta>>|<<adeudor>>|<<aacreedor>>|<<debe>>|<<haber>>|<<deudor>>|<<acreedor>>|<<saldofd>>|<<saldofh>>|<<debet>>|<<habert>><<activo>>|<<pasivo>>|<<rpnperdida>>|<<rpnganancia>>|<<adicionales>>|<<deducciones>>|<<estado>>|
		Endif
		nl=nl+1
	Endscan
	Set Textmerge To
	Set Textmerge Off
Endfunc
*********************************
Function GrabaDetalleCta37(np1,np2,np3,np4,np5,np6,np7,np8,np9,np10)
	cur=[]
	lc="ProIngresaDcta37"
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
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,?goapp.npara10)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Registrando Detalle de Cta.37')
		Return 0
	Else
		Return 1
	Endif
Endfunc
********************************
Function GrabaDetalleCta12(np1,np2,np3,np4,np5,np6,np7,np8,np9,np10)
	cur=[]
	lc="ProIngresaDcta12"
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
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,?goapp.npara10)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Registrando Detalle de Cta.12')
		Return 0
	Else
		Return 1
	Endif
Endfunc
********************************
Function AnulaDetalleCta12(np1)
	cur=[]
	lc="ProAnulaDcta12"
	goapp.npara1=np1
	TEXT to lp noshow
     (?goapp.npara1)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Anulando Detalle de Cta.12')
		Return 0
	Else
		Return 1
	Endif
Endfunc
********************************
Function AnulaDetalleCta37(np1)
	cur=[]
	lc="ProAnulaDcta37"
	goapp.npara1=np1
	TEXT to lp noshow
     (?goapp.npara1)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Anulando Detalle de Cta.37')
		Return 0
	Else
		Return 1
	Endif
Endfunc
***********************
Function GrabaDetalleCta34(np1,np2,np3,np4,np5,np6)
	cur=[]
	lc="ProIngresaDcta34"
	goapp.npara1=np1
	goapp.npara2=np2
	goapp.npara3=np3
	goapp.npara4=np4
	goapp.npara5=np5
	goapp.npara6=np6
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Registrando Detalle de Cta.34')
		Return 0
	Else
		Return 1
	Endif
Endfunc
***********************
Function AnulaDetalleCta34(np1)
	cur=[]
	lc="ProAnulaDcta34"
	goapp.npara1=np1
	TEXT to lp noshow
     (?goapp.npara1)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Anulando Detalle de Cta.34')
		Return 0
	Else
		Return 1
	Endif
Endfunc
***********************
Procedure CrearQR(np1,np2)
	Set Procedure To foxbarcodeqr Additive
	loFbc = Createobject("FoxBarcodeQR")
	lcQRImage = loFbc.QRBarcodeImage(np1,np2,6,2)
Endproc
**************************
Function GrabaDetalleCta41(np1,np2,np3,np4,np5)
	cur=[]
	lc="ProIngresaDcta41"
	goapp.npara1=np1
	goapp.npara2=np2
	goapp.npara3=np3
	goapp.npara4=np4
	goapp.npara5=np5
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Registrando Detalle de Cta.41')
		Return 0
	Else
		Return 1
	Endif
Endfunc
********************************
Function AnulaDetalleCta41(np1)
	cur=[]
	lc="ProAnulaDcta41"
	goapp.npara1=np1
	TEXT to lp noshow
     (?goapp.npara1)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Anulando Detalle de Cta.41')
		Return 0
	Else
		Return 1
	Endif
Endfunc
***********************
**************************
Function GrabaDetalleCta42(np1,np2,np3,np4,np5,np6,np7,np8,np9,np10)
	cur=[]
	lc="ProIngresaDcta42"
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
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,?goapp.npara10)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Registrando Detalle de Cta.42')
		Return 0
	Else
		Return 1
	Endif
Endfunc
********************************
Function AnulaDetalleCta42(np1)
	cur=[]
	lc="ProAnulaDcta42"
	goapp.npara1=np1
	TEXT to lp noshow
     (?goapp.npara1)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Anulando Detalle de Cta.42')
		Return 0
	Else
		Return 1
	Endif
Endfunc
***********************
Function GrabaDetalleCta46(np1,np2,np3,np4,np5,np6,np7,np8,np9,np10)
	cur=[]
	lc="ProIngresaDcta46"
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
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,?goapp.npara10)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Registrando Detalle de Cta.46')
		Return 0
	Else
		Return 1
	Endif
Endfunc
********************************
Function GrabaDetalleCta50(np1,np2,np3,np4,np5,np6)
	cur=[]
	lc="ProIngresaDcta50"
	goapp.npara1=np1
	goapp.npara2=np2
	goapp.npara3=np3
	goapp.npara4=np4
	goapp.npara5=np5
	goapp.npara6=np6
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Registrando Detalle de Cta.50')
		Return 0
	Else
		Return 1
	Endif
Endfunc
********************************
Function AnulaDetalleCta46(np1)
	cur=[]
	lc="ProAnulaDcta46"
	goapp.npara1=np1
	TEXT to lp noshow
     (?goapp.npara1)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Anulando Detalle de Cta.46')
		Return 0
	Else
		Return 1
	Endif
Endfunc
********************************
Function AnulaDetalleCta50(np1)
	cur=[]
	lc="ProAnulaDcta50"
	goapp.npara1=np1
	TEXT to lp noshow
     (?goapp.npara1)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Anulando Detalle de Cta.50')
		Return 0
	Else
		Return 1
	Endif
Endfunc
********************************
Function GrabaDetalleCta19(np1,np2,np3,np4,np5,np6,np7,np8,np9,np10,np11)
	cur=[]
	lc="ProIngresaDcta19"
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
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,?goapp.npara10,?goapp.npara11)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Registrando Detalle de Cta.19')
		Return 0
	Else
		Return 1
	Endif
Endfunc
********************************
Function AnulaDetalleCta19(np1)
	cur=[]
	lc="ProAnulaDcta19"
	goapp.npara1=np1
	TEXT to lp noshow
     (?goapp.npara1)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Anulando Detalle de Cta.19')
		Return 0
	Else
		Return 1
	Endif
Endfunc
**************************
Function GrabaBalanceComprobacion(np1,np2,np3,np4,np5,np6,np7,np8,np9,np10,np11,np12,np13,np14,np15,np16,np17,np18,np19)
	cur=[]
	lc="ProIngresaBalanceComprobacion"
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
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,?goapp.npara10,
     ?goapp.npara11,?goapp.npara12,?goapp.npara13,?goapp.npara14,?goapp.npara15,?goapp.npara16,?goapp.npara17,?goapp.npara18,?goapp.npara19)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Registrando Balance de Comprobación')
		Return 0
	Else
		Return 1
	Endif
Endfunc
********************************
Function AnulaBalanceComprobacion(np1)
	cur=[]
	lc="ProAnulaBalanceComprobacion"
	goapp.npara1=np1
	TEXT to lp noshow
     (?goapp.npara1)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+' '+' Anulando Balance de Comprobación')
		Return 0
	Else
		Return 1
	Endif
Endfunc
********************************
Function Mayoriza(dfinicio,dff)
	If Vartype(dfinicio)<>'D' Then
		dfi=Ctod(dfinicio)
	Else
		dfi=dfinicio
	Endif
	df=dfi-1
	TEXT to lc noshow
       select z.ncta,z.nomb,if(z.debe>z.haber,z.debe-z.haber,0) as adeudor,
	   if(z.haber>z.debe,z.haber-z.debe,0) as aacreedor,idcta  from
	   (select b.ncta,b.nomb,SUM(a.ldia_debe-a.ldia_itrd) as debe,
	   SUM(a.ldia_haber-a.ldia_itrh) as haber,b.idcta,MAX(a.ldia_nume) as ldia_nume
	   from fe_ldiario as a inner join fe_plan as b on b.idcta=a.ldia_idcta
	   where a.ldia_acti='A' and ldia_fech<=?df and ldia_tran<>'T' group by a.ldia_idcta) as z
	ENDTEXT
	ncon=Abreconexion()
	If SQLExec(ncon,lc,'mayora')<0 Then
		errorbd(lc)
		Return
	Endif
	CierraConexion(ncon)
	Create Cursor mayor(ncta c(15),nomb c(60),adeudor N(12,2),aacreedor N(12,2),debe N(12,2),haber N(12,2),idcta N(10))
	Select * From mayora Where (adeudor+aacreedor)>0 Into Cursor rlmayora
	Select mayor
	Append From Dbf("rlmayora")
	TEXT to lc noshow
       select z.ncta,z.nomb,z.debe,z.haber,idcta  from
	   (select b.ncta,b.nomb,SUM(a.ldia_debe-a.ldia_itrd) as debe,
	   SUM(a.ldia_haber-a.ldia_itrh) as haber,b.idcta
	   from fe_ldiario as a inner join fe_plan as b on b.idcta=a.ldia_idcta
	   where a.ldia_acti='A' and ldia_fech between ?dfi and ?dff and ldia_tran<>'T' group by a.ldia_idcta) as z
	ENDTEXT
	ncon=Abreconexion()
	If SQLExec(ncon,lc,'rlmayor')<0 Then
		errorbd(lc)
		Return
	Endif
	CierraConexion(ncon)
	Select rlmayor
	Do While !Eof()
		Select mayor
		Locate For idcta=rlmayor.idcta
		If Found()
			Replace debe With rlmayor.debe,haber With rlmayor.haber In mayor
		Else
			Insert Into mayor(ncta,nomb,debe,haber,idcta)Values(rlmayor.ncta,rlmayor.nomb,rlmayor.debe,rlmayor.haber,rlmayor.idcta)
		Endif
		Select rlmayor
		Skip
	Enddo
	Select z.ncta,z.nomb,z.adeudor,z.aacreedor,z.debe,z.haber,;
		Iif((z.debe+z.adeudor)>(z.haber+z.aacreedor),(z.debe+z.adeudor)-(z.haber+z.aacreedor),000000000.00) As deudor,;
		iif((z.haber+z.aacreedor)>(z.debe+z.adeudor),(z.haber+z.aacreedor)-(z.debe+z.adeudor),000000000.00) As acreedor,idcta From mayor As z Into Cursor mayor Order By z.ncta
	Select * From mayor Into Cursor xdctas
	Return
Endfunc
***************************************************
Procedure ReimprimirStandarLopez(np1,np2)
	If verificaAlias("tmpv")=0 Then
		Create Cursor tmpv(coda N(8),Desc c(120),unid c(4),Prec N(13,8),cant N(10,2),ndoc c(12),alma N(10,2),peso N(10,2),;
			Impo N(10,2),tipro c(1),ptoll c(50),fect d,perc N(5,2),cletras c(120),;
			nruc c(11),razon c(120),direccion c(190),fech d,fechav d,ndo2 c(12),vendedor c(50),Forma c(20),Form c(20),guia c(15),;
			referencia c(120),hash c(30),dni c(8),Mone c(1),tdoc1 c(2),dcto c(12),fech1 d,usuario c(30),tigv N(5,3),detalle c(120),contacto c(120))
	Else
		Zap In tmpv
	Endif
	Do Case
		Case np2='01' Or np2='03'
			TEXT TO lc noshow
			    SELECT a.codv,a.idauto,a.alma,a.idkar,a.idauto,a.idart,a.cant,a.prec,a.alma,c.tdoc as tdoc1,
			    c.ndoc as dcto,c.fech as fech1,c.vigv,
			    c.fech,c.fecr,c.form,c.deta,c.rcom_exon,c.ndo2,c.igv,c.idcliente,d.razo,d.nruc,d.dire,d.ciud,d.ndni,c.pimpo,u.nomb as usuario,d.clie_conta,
			    c.tdoc,c.ndoc,c.dolar as dola,c.mone,b.descri,b.unid,c.rcom_hash,v.nomv,c.impo FROM fe_art as b join fe_kar as a on(b.idart=a.idart)
			    inner join fe_vend as v on v.idven=a.codv  inner JOIN fe_rcom as c on(a.idauto=c.idauto) inner join fe_clie as d on(c.idcliente=d.idclie)
			    inner join fe_usua as u on u.idusua=c.idusua
			    where c.idauto=?np1 and a.acti='A';
			ENDTEXT
		Case np2='08'
			TEXT TO lc noshow
			   SELECT r.idauto,r.ndoc,r.tdoc,r.fech,r.mone,abs(r.valor) as valor,r.ndo2,
		       r.vigv,c.nruc,c.razo,c.dire,c.ciud,c.ndni,' ' as nomv,r.form,
		       abs(r.igv) as igv,abs(r.impo) as impo,ifnull(k.cant,CAST(0 as decimal(12,2))) as cant,c.clie_conta,
		       ifnull(k.prec,ABS(r.impo)) as prec,LEFT(r.ndoc,4) as serie,SUBSTR(r.ndoc,5) as numero,
		       ifnull(a.unid,'') as unid,ifnull(a.descri,r.deta) as descri,r.deta,ifnull(k.idart,CAST(0 as decimal(8))) as idart,w.ndoc as dcto,
		       w.fech as fech1,w.tdoc as tdoc1,r.rcom_hash,u.nomb as usuario
		       from fe_rcom r inner join fe_clie c on c.idclie=r.idcliente
		       left join fe_kar k on k.idauto=r.idauto left join fe_art a on a.idart=k.idart
		       inner join fe_ncven f on f.ncre_idan=r.idauto inner join fe_rcom as w on w.idauto=f.ncre_idau
		        inner join fe_usua as u on u.idusua=r.idusua
		       where r.idauto=?np1 and r.acti='A' and r.tdoc='08'
			ENDTEXT
		Case np2='07'
			TEXT TO lc noshow
			   SELECT r.idauto,r.ndoc,r.tdoc,r.fech,r.mone,abs(r.valor) as valor,r.ndo2,
		       r.vigv,c.nruc,c.razo,c.dire,c.ciud,c.ndni,' ' as nomv,r.form,u.nomb as usuario,
		       abs(r.igv) as igv,abs(r.impo) as impo,ifnull(k.cant,CAST(0 as decimal(12,2))) as cant,
		       ifnull(k.prec,ABS(r.impo)) as prec,LEFT(r.ndoc,4) as serie,SUBSTR(r.ndoc,5) as numero,c.clie_conta,
		       ifnull(a.unid,'') as unid,ifnull(a.descri,r.deta) as descri,r.deta,ifnull(k.idart,CAST(0 as decimal(8))) as idart,w.ndoc as dcto,
		       w.fech as fech1,w.tdoc as tdoc1,r.rcom_hash
		       from fe_rcom r inner join fe_clie c on c.idclie=r.idcliente
		       left join fe_kar k on k.idauto=r.idauto left join fe_art a on a.idart=k.idart
		       inner join fe_ncven f on f.ncre_idan=r.idauto inner join fe_rcom as w on w.idauto=f.ncre_idau
		        inner join fe_usua as u on u.idusua=r.idusua
		       where r.idauto=?np1 and r.acti='A' and r.tdoc='07'
			ENDTEXT
	Endcase
	ncon=Abreconexion()
	If SQLExec(ncon,lc,'kardex')<0 Then
		errorbd(lc)
		Return
	Endif
	CierraConexion(ncon)
	nimpo=kardex.Impo
	cndoc=kardex.ndoc
	cmone=kardex.Mone
	ctdoc=kardex.tdoc
	chash=kardex.rcom_hash
	cdeta1=kardex.Deta
	vvigv=kardex.vigv
	cconta=kardex.clie_conta
	nf=0
	Select kardex
	Scan All
		nf=nf+1
		Insert Into tmpv(coda,Desc,unid,cant,Prec,ndoc,hash,nruc,razon,direccion,fech,fechav,ndo2,vendedor,Form,;
			referencia,dni,Mone,dcto,tdoc1,fech1,usuario,guia,Forma,tigv,contacto);
			values(kardex.idart,kardex.Descri,kardex.unid,Iif(kardex.cant=0,1,kardex.cant),kardex.Prec,;
			kardex.ndoc,kardex.rcom_hash,kardex.nruc,kardex.razo,Alltrim(kardex.Dire)+' '+Alltrim(kardex.ciud),kardex.fech,kardex.fech,;
			kardex.ndo2,kardex.nomv,Icase(kardex.Form='E','Efectivo',kardex.Form='C','Crédito',kardex.Form='T','Tarjeta',kardex.Form='D','Depósito','Cheque'),;
			kardex.Deta,kardex.ndni,kardex.Mone,kardex.dcto,kardex.tdoc1,kardex.fech1,kardex.usuario,kardex.ndo2,;
			Icase(kardex.Form='E','Efectivo',kardex.Form='C','Crédito',kardex.Form='T','Tarjeta',kardex.Form='D','Depósito','Cheque'),kardex.vigv,kardex.clie_conta)
	Endscan
	Local cimporte
	cimporte=Diletras(nimpo,cmone)
	ni=nf
	Select tmpv
	*Replace All ndoc With cndoc,cletras With cimporte,Mone With cmone,hash With chash
	For x=1 To fe_gene.Items-nf
		ni=ni+1
		Insert Into tmpv(ndoc)Values(cndoc)
	Next
	Select tmpv
	Replace All ndoc With cndoc,cletras With cimporte,Mone With cmone,hash With chash,referencia With cdeta1,detalle With cdeta1,tigv With vvigv
	Go Top In tmpv
Endproc
