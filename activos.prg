#Define ERRORPROC "NO SE EJECUTO CORRECTAMENTE EL PROCEDIMIENTO"
#Define MSGTITULO "SISVEN-EtCh"
Define Class Activos As Custom
	dfecha=Date()
	ct13=""
	codi=""
	ct18=""
	ccta=""
	ct19=""
	cdescri=""
	cmarca=""
	cmodelo=""
	cplaca=""
	ninic=0
	nadqa=0
	nmejoras=0
	nretiros=0
	najustes=0
	nreva=0
	nreso=0
	noreva=0
	najustei=0
	dfadq=Date()
	dfi=Date()
	ct20=""
	cdcto=""
	npode=0
	ndacu=0
	nvade=0
	nvare=0
	ndore=0
	ndavo=0
	ndsoc=0
	ndoref=0
	ndein=0
	nidus=0
	nidau=0
	Procedure ObtenerImportesCta33
	Lparameters na,ccursor
	TEXT TO lc noshow
		select p.ncta as NroCuenta,n.ndoc as NroDocumento,n.fech as Fecha,r.razo as Referencia,
		CAST(if(n.mone='S',e.impo,round(e.impo*n.dolar,2)) as decimal(12,2)) as ImporteA,Cast(0 as decimal(12,2)) as ImporteB,
		n.idrcon as idauto,e.idcta
		From fe_rcon n inner join fe_ectasc e on e.idrcon=n.idrcon  inner join fe_plan p on p.idcta=e.idcta
		inner join fe_prov as r on r.idprov=n.idprov
		where YEAR(n.fecr)=?na and n.rcon_acti='A' and LEFT(p.ncta,2)='33' and e.ecta_acti='A' and e.impo<>0
		union all
		select p.ncta as NroCuenta,n.ndoc as NroDocumento,n.fech as Fecha,r.razo as Referencia,
		Cast(0 as decimal(12,2)) as ImporteA,CAST(if(n.mone='S',e.impo,round(e.impo*n.dolar,2)) as decimal(12,2)) as ImporteB,
		n.idrven as idauto,e.idcta
		From fe_rven n inner join fe_ectas e on e.idrven=n.idrven  inner join fe_plan p on p.idcta=e.idcta
		inner join fe_clie as r on r.idclie=n.idclie
		where YEAR(n.fecr)=?na and n.acti='A' and LEFT(p.ncta,2)='33' and e.acti='A' and e.impo<>0 order by fecha
	ENDTEXT
	ncon=Abreconexion()
	If SQLExec(ncon,lc,ccursor)<=0 Then
		errorbd(lc)
		Return 0
	Endif
	CierraConexion(ncon)
	Select (ccursor)
	Return 1
	Endproc

	Procedure ObtenerImportesCta
	Lparameters na,nidcta,'Mcta',ctipo
	If ctipo='C' Then
		TEXT TO lc noshow
		select CAST(if(n.mone='S',e.impo,round(e.impo*n.dolar,2)) as decimal(12,2)) as Importe
		From fe_rcon n inner join fe_ectasc e on e.idrcon=n.idrcon  inner join fe_plan p on p.idcta=e.idcta
		inner join fe_prov as r on r.idprov=n.idprov
		where YEAR(n.fecr)=?na and n.rcon_acti='A' and p.idcta=?nidcta e.ecta_acti='A' and e.impo<>0 group by idcta
		ENDTEXT
	Else
		TEXT TO lc NOSHOW
    	select CAST(if(n.mone='S',e.impo,round(e.impo*n.dolar,2)) as decimal(12,2)) as Importe
    	from fe_rven n inner join fe_ectas e on e.idrven=n.idrven  inner join fe_plan p on p.idcta=e.idcta
		inner join fe_clie as r on r.idclie=n.idclie
		where YEAR(n.fecr)=?na and n.acti='A' and p.idcta=?nidcta and e.acti='A' and e.impo<>0 order by fecha
		ENDTEXT
	Endif
	ncon=Abreconexion()
	If SQLExec(ncon,lc,ccursor)<=0 Then
		errorbd(lc)
		Return 0
	Endif
	CierraConexion(ncon)
	Select (ccursor)
	Return Importe
	Endproc



	Procedure DetalleCta
	Lparameters na,nidcta,ctipo,ccursor
	If ctipo='C' Then
		TEXT TO lc noshow
		select n.ndoc as NroDocumento,n.fech as Fecha,r.razo as Referencia,
		CAST(if(n.mone='S',e.impo,round(e.impo*n.dolar,2)) as decimal(12,2)) as Importe,p.ncta as NroCuenta,
		n.idrcon as idauto,e.idcta
		From fe_rcon n inner join fe_ectasc e on e.idrcon=n.idrcon  inner join fe_plan p on p.idcta=e.idcta
		inner join fe_prov as r on r.idprov=n.idprov
		where YEAR(n.fecr)=?na and n.rcon_acti='A' and e.idcta=?nidcta and e.ecta_acti='A' and e.impo<>0 order by fecha
		ENDTEXT
	Else
		TEXT TO lc noshow
		select n.ndoc as NroDocumento,n.fech as Fecha,r.razo as Referencia,
		CAST(if(n.mone='S',e.impo,round(e.impo*n.dolar,2)) as decimal(12,2)) as Importe,p.ncta as NroCuenta,
		n.idrven as idauto,e.idcta
		From fe_rven n inner join fe_ectas e on e.idrven=n.idrven  inner join fe_plan p on p.idcta=e.idcta
		inner join fe_clie as r on r.idclie=n.idclie
		where YEAR(n.fecr)=?na and n.acti='A' and e.idcta=?nidcta and e.acti='A' and e.impo<>0 order by fecha
		ENDTEXT
	Endif
	ncon=Abreconexion()
	If SQLExec(ncon,lc,ccursor)<=0 Then
		errorbd(lc)
		Return 0
	Endif
	CierraConexion(ncon)
	Return 1
	Endproc
	Procedure RegistraDetalleActivos
	cur=""
	lc='ProReiIstraDActivosI'
	goapp.npara1=This.dfecha
	goapp.npara2=This.ct13
	goapp.npara3=This.codi
	goapp.npara4=This.ct18
	goapp.npara5=This.ccta
	goapp.npara6=This.ct19
	goapp.npara7=This.cdescri
	goapp.npara8=This.cmarca
	goapp.npara9=This.cmodelo
	goapp.npara10=This.cplaca
	goapp.npara11=This.ninic
	goapp.npara12=This.nadqa
	goapp.npara13=This.nmejoras
	goapp.npara14=This.nretiros
	goapp.npara15=This.najustes
	goapp.npara16=This.nreva
	goapp.npara17=This.nreso
	goapp.npara18=This.noreva
	goapp.npara19=This.najustei
	goapp.npara20=This.dfadq
	goapp.npara21=This.dfi
	goapp.npara22=This.ct20
	goapp.npara23=This.cdcto
	goapp.npara24=This.npode
	goapp.npara25=This.ndacu
	goapp.npara26=This.nvade
	goapp.npara27=This.nvare
	goapp.npara28=This.ndore
	goapp.npara29=This.ndavo
	goapp.npara30=This.ndsoc
	goapp.npara31=This.ndoref
	goapp.npara32=This.ndein
	goapp.npara33=This.nidus
	goapp.npara34=This.nidau
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,
      ?goapp.npara10,?goapp.npara11,?goapp.npara12,?goapp.npara13,?goapp.npara14,?goapp.npara15,?goapp.npara16,?goapp.npara17,
      ?goapp.npara18,?goapp.npara19,?goapp.npara20,?goapp.npara21,?goapp.npara22,?goapp.npara23,?goapp.npara24,?goapp.npara25,?goapp.npara26,
      ?goapp.npara27,?goapp.npara28,?goapp.npara29,?goapp.npara30,?goapp.npara31,?goapp.npara32,?goapp.npara33,?goapp.npara34)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' Registrando Detalle de Cta.33 ')
		Return 0
	Else
		Return 1
	Endif
	Endproc

	Procedure ActualizaDetalleActivos
	Lparameters nid
	cur=""
	lc='ProActualizaDActivosI'
	goapp.npara1=This.dfecha
	goapp.npara2=This.ct13
	goapp.npara3=This.codi
	goapp.npara4=This.ct18
	goapp.npara5=This.ccta
	goapp.npara6=This.ct19
	goapp.npara7=This.cdescri
	goapp.npara8=This.cmarca
	goapp.npara9=This.cmodelo
	goapp.npara10=This.cplaca
	goapp.npara11=This.ninic
	goapp.npara12=This.nadqa
	goapp.npara13=This.nmejoras
	goapp.npara14=This.nretiros
	goapp.npara15=This.najustes
	goapp.npara16=This.nreva
	goapp.npara17=This.nreso
	goapp.npara18=This.noreva
	goapp.npara19=This.najustei
	goapp.npara20=This.dfadq
	goapp.npara21=This.dfi
	goapp.npara22=This.ct20
	goapp.npara23=This.cdcto
	goapp.npara24=This.npode
	goapp.npara25=This.ndacu
	goapp.npara26=This.nvade
	goapp.npara27=This.nvare
	goapp.npara28=This.ndore
	goapp.npara29=This.ndavo
	goapp.npara30=This.ndsoc
	goapp.npara31=This.ndoref
	goapp.npara32=This.ndein
	goapp.npara33=This.nidus
	goapp.npara34=This.nidau
	goapp.npara35=nid
	TEXT to lp noshow
     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9,
      ?goapp.npara10,?goapp.npara11,?goapp.npara12,?goapp.npara13,?goapp.npara14,?goapp.npara15,?goapp.npara16,?goapp.npara17,
      ?goapp.npara18,?goapp.npara19,?goapp.npara20,?goapp.npara21,?goapp.npara22,?goapp.npara23,?goapp.npara24,?goapp.npara25,?goapp.npara26,
      ?goapp.npara27,?goapp.npara28,?goapp.npara29,?goapp.npara30,?goapp.npara31,?goapp.npara32,?goapp.npara33,?goapp.npara34,?goapp.npara35)
	ENDTEXT
	If EJECUTARP(lc,lp,cur)=0 Then
		errorbd(ERRORPROC+ ' Modificando Detalle de Cta.33 ')
		Return 0
	Else
		Return 1
	Endif
	Endproc
	Procedure Listar
	Lparameters na,ccursor
	TEXT TO lc noshow
	    SELECT acti_fech as fecha,acti_ta13 as tabla13,acti_codi as codigo,acti_ta18 as tabla18,
	    p.ncta as Cuenta,acti_ta19 as tabla19,acti_desc as Descripcion,acti_marc as marca,
		acti_mode as modelo,acti_plac as placa,acti_inic as Saldo_inicial,acti_adqa as Valor_Adquirido,
		acti_mejo as Mejoras,acti_reti as Retiros,acti_ajus as Ajustes,acti_reva as ValorRevaluacion,
		acti_reso as RevaluacionRS,acti_orev as OtrasRevaluaciones,acti_vain as AjusteInflacion,acti_fadq as FechaAdquisicion,
		acti_fius as FechaUso,acti_ta20 as Tabla20,acti_dcto as Dcto,acti_pode as PorcentajeDep,
		acti_dacu as DepreacicionAcumulada,acti_vade as ValorDepreciacion,acti_vare as DepreciacionRetiros,
		acti_dore as DepreciacionOtrosAjustes,acti_davo as DepreciacionVoluntaria,acti_dsoc as DepreciacionPorSociedades,
		acti_doref as DepreciacionOtrasRevaluaciones,acti_dein as DepreciacionPorInflacion,
		u.nomb as Usuario,acti_fope as Ingreso,acti_idau as ID1,acti_idac as ID0,acti_idct from fe_dactivos d inner join fe_usua u on u.idusua=d.acti_idus
		inner join fe_plan p on p.idcta=d.acti_idct
		where acti_acti='A' and YEAR(acti_fech)=?na
	ENDTEXT
	ncon=Abreconexion()
	If SQLExec(ncon,lc,ccursor)<=0 Then
		errorbd(lc)
		Return 0
	Endif
	CierraConexion(ncon)
	Return 1
	Endproc
	Procedure Buscar
	Lparameters na,nidauto,ccursor
	TEXT TO lc noshow
	    SELECT acti_fech as fecha,acti_ta13 as tabla13,acti_codi as codigo,acti_ta18 as tabla18,
	    p.ncta as Cuenta,acti_ta19 as tabla19,acti_desc as Descripcion,acti_marc as marca,
		acti_mode as modelo,acti_plac as placa,acti_inic as Saldo_inicial,acti_adqa as Valor_Adquirido,
		acti_mejo as Mejoras,acti_reti as Retiros,acti_ajus as Ajustes,acti_reva as ValorRevaluacion,
		acti_reso as RevaluacionRS,acti_orev as OtrasRevaluaciones,acti_vain as AjusteInflacion,acti_fadq as FechaAdquisicion,
		acti_fius as FechaUso,acti_ta20 as Tabla20,acti_dcto as Dcto,acti_pode as PorcentajeDep,
		acti_dacu as DepreacicionAcumulada,acti_vade as ValorDepreciacion,acti_vare as DepreciacionRetiros,
		acti_dore as DepreciacionOtrosAjustes,acti_davo as DepreciacionVoluntaria,acti_dsoc as DepreciacionPorSociedades,
		acti_doref as DepreciacionOtrasRevaluaciones,acti_dein as DepreciacionPorInflacion,
		u.nomb as Usuario,acti_fope as Ingreso,acti_idau as ID1,acti_idac as ID0,acti_idct from fe_dactivos d inner join fe_usua u on u.idusua=d.acti_idus
		inner join fe_plan p on p.idcta=d.acti_idct
		where acti_acti='A' and YEAR(acti_fech)=?na and acti_idac=?nidauto
	ENDTEXT
	ncon=Abreconexion()
	If SQLExec(ncon,lc,ccursor)<=0 Then
		errorbd(lc)
		Return 0
	Endif
	CierraConexion(ncon)
	Select (ccursor)
	If id0>0 Then
		Return 1
	Else
		Return 0
	Endif
	ENDPROC
	
	Procedure BuscarXid
	Lparameters na,nidauto,ccursor
	TEXT TO lc noshow
	    SELECT acti_fech as fecha,acti_ta13 as tabla13,acti_codi as codigo,acti_ta18 as tabla18,
	    p.ncta as Cuenta,acti_ta19 as tabla19,acti_desc as Descripcion,acti_marc as marca,
		acti_mode as modelo,acti_plac as placa,acti_inic as Saldo_inicial,acti_adqa as Valor_Adquirido,
		acti_mejo as Mejoras,acti_reti as Retiros,acti_ajus as Ajustes,acti_reva as ValorRevaluacion,
		acti_reso as RevaluacionRS,acti_orev as OtrasRevaluaciones,acti_vain as AjusteInflacion,acti_fadq as FechaAdquisicion,
		acti_fius as FechaUso,acti_ta20 as Tabla20,acti_dcto as Dcto,acti_pode as PorcentajeDep,
		acti_dacu as DepreacicionAcumulada,acti_vade as ValorDepreciacion,acti_vare as DepreciacionRetiros,
		acti_dore as DepreciacionOtrosAjustes,acti_davo as DepreciacionVoluntaria,acti_dsoc as DepreciacionPorSociedades,
		acti_doref as DepreciacionOtrasRevaluaciones,acti_dein as DepreciacionPorInflacion,
		u.nomb as Usuario,acti_fope as Ingreso,acti_idau as ID1,acti_idac as ID0,acti_idct from fe_dactivos d inner join fe_usua u on u.idusua=d.acti_idus
		inner join fe_plan p on p.idcta=d.acti_idct
		where acti_acti='A' and YEAR(acti_fech)=?na and acti_idau=?nidauto
	ENDTEXT
	ncon=Abreconexion()
	If SQLExec(ncon,lc,ccursor)<=0 Then
		errorbd(lc)
		Return 0
	Endif
	CierraConexion(ncon)
	Select (ccursor)
	If id0>0 Then
		Return 1
	Else
		Return 0
	Endif
	Endproc

Enddefine
