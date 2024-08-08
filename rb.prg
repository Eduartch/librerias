Lparameters nopcion,cdatos
Set Classlib To d:\librerias\fe.vcx
Set Procedure To d:\capass\capadatos Additive
Set Procedure To d:\capass\ple5 Additive
goapp=Createobject("clx")
goapp.xopcion=nopcion
goapp.cdatos=cdatos
goapp.bdconn=ABRECONEXION()
goapp.tipoh='P'
Datosglobales()
#Define MSGTITULO "Sisven"
*Create Cursor rm1(dcto c(12),fech d,razo c(120),mone c(1),valor N(12,2),rcom_exon N(12,2),rcom_otro N(12,2),inafecto N(12,2),;
igv N(8,2),Impo N(12,2),rcom_arch c(120),tdoc c(2),ndoc c(12),dolar N(6,4),idauto N(12),ndni c(10),idcliente N(12),clie_corr c(100),;
ndo2 c(10),fono c(10),nruc c(11),direccion c(150),tcom c(1))
*Create Cursor rbxe(resu_fech d)

Settear()
df=fe_gene.fech

Use Addbs(Sys(5)+Sys(2003))+'rm1' In 0 Shared
Use Addbs(Sys(5)+Sys(2003))+'rbxe' In 0 Shared

oenvioBN=Createobject("EnvioBoletasyNotas")

EnviaFacturasGuiasNotasAutomatico1("rm1","","U","2.1")
Enviarboletasynotasautomatico("rbxe")
dfi=fe_gene.fech-60
dff=fe_gene.fech
f1=cfechas(dfi)
f2=cfechas(dff)

*oenvioBN.ConsultarTicket()
*oenvioBN.EnviarBoletasyNotas()
Define Class EnvioBoletasyNotas As Custom
	Function ConsultarTicket
	TEXT TO lc NOSHOW TEXTMERGE
	  SELECT resu_tick,resu_arch,resu_desd,resu_hast FROM fe_resboletas f
	  where left(resu_mens,1)<>'0' and resu_acti='A' and length(resu_tick)>0 and resu_feen is null
	ENDTEXT
	If Ejecutaconsulta(lc,"tk")<1
		Return
	Endif
	If regdvto("tk")>0 Then
		Inkey(5)
	Else
		Return
	Endif
	Select tk
	Do While .T.
		ctik=Alltrim(tk.resu_tick)
		vdvto=ConsultaTicket(Alltrim(tk.resu_tick),tk.resu_arch)
		If vdvto=1 Then
			Do While !Eof() And Alltrim(tk.resu_tick)=ctik
				ActualizaBxb(tk.resu_desd,tk.resu_hast)
				Select tk
				Skip
			Enddo
		Else
			Select tk
			Skip
		Endif
	Enddo
	Endfunc
	Procedure EnviarBoletasyNotas
	TEXT TO lc NOSHOW TEXTMERGE PRETEXT  1+2+4
	resu_fech,sum(enviados) as enviados,sum(resumen) as resumen from(
	select resu_fech,case tipo when 1 then resu_impo else 0 end as enviados,
	case tipo when 2 then resu_impo else 0 end as Resumen,resu_mens,tipo from (
	SELECT resu_fech,sum(resu_impo) as resu_impo,resu_mens,1 as Tipo FROM fe_resboletas f
	where resu_fech between '<<f1>>' and '<<f2>>' and f.resu_acti='A' and left(resu_mens,1)='0'  group by resu_fech
	union all
	SELECT fech as resu_fech,sum(if(mone='S',impo,impo*dolar)) as resu_impo,' ' as resu_mens,2 as Tipo FROM fe_rcom f
	where fech between '<<f1>>' and '<<f2>>' and f.acti='A' and tdoc='03' and left(ndoc,1)='B' and idcliente>0  group by fech
	union all
	SELECT f.fech as resu_fech,sum(if(f.mone='S',abs(f.impo),abs(f.impo*f.dolar))) as resu_impo,' ' as resu_mens,2 as Tipo FROM fe_rcom f
	inner join fe_ncven g on g.ncre_idan=f.idauto inner join fe_rcom as w on w.idauto=g.ncre_idau
	where f.fech between '<<f1>>' and '<<f2>>'  and f.acti='A' and f.tdoc in ('07','08') and left(f.ndoc,1)='F' and w.tdoc='03' group by f.fech) as x) as y
	group by resu_fech order by resu_fech
	ENDTEXT
	If Ejecutaconsulta(lc,"rbolne")<1
		Return
	Endif
	Select resu_fech,resumen,dff-resu_fech As dias From rbolne Where (resumen-enviados)>1 And (dff-resu_fech)>=5 And (dff-resu_fech)>=8 Into Cursor rbolne
	Select rbolne
	Do While !Eof()
		df=cfechas(rbolne.resu_fech)
		TEXT TO lc NOSHOW TEXTMERGE PRETEXT 7
		fech,tdoc,
		left(ndoc,4) as serie,substr(ndoc,5) as numero,If(Length(trim(c.ndni))<8,'0','1') as tipodoc,c.ndni,
        c.razo,if(f.mone='S',valor,valor*dolar) as valor,rcom_exon,if(f.mone='S',igv,igv*dolar) as igv,
		if(f.mone='S',impo,impo*dolar) as impo,"" as trefe,"" as serieref,"" as numerorefe,f.idauto
		fROM fe_rcom f inner join fe_clie c on c.idclie=f.idcliente where tdoc="03" and fech='<<df>>' and acti='A' and idcliente>0 and LEFT(ndoc,1)='B'
		union all
		select f.fech,f.tdoc,
		concat("BC",SUBSTR(f.ndoc,3,2)) as serie,substr(f.ndoc,5) as numero,'1' as tipodoc,c.ndni,
        c.razo,abs(if(f.mone='S',f.valor,f.valor*f.dolar)) as valor,
		abs(f.rcom_exon) as rcom_exon,abs(if(f.mone='S',f.igv,f.igv*f.dolar)) as igv,
        abs(if(f.mone='S',f.impo,f.impo*f.dolar)) as impo,w.tdoc as trefe,left(w.ndoc,4) as serieref,substr(w.ndoc,5) as numerorefe,f.idauto
		FROM fe_rcom f
		inner join fe_ncven g on g.ncre_idan=f.idauto inner join fe_rcom as w on w.idauto=g.ncre_idau
        inner join fe_clie c on c.idclie=f.idcliente
		where f.tdoc="07"  and f.acti='A' and f.idcliente>0 and w.tdoc='03' and f.fech='<<df>>'
		union all
		select f.fech,f.tdoc,
		concat("BD",SUBSTR(f.ndoc,3,2)) as serie,substr(f.ndoc,5) as numero,'1' as tipodoc,c.ndni,
        c.razo,abs(if(f.mone='S',f.valor,f.valor*f.dolar)) as valor,
		abs(f.rcom_exon) as rcom_exon,abs(if(f.mone='S',f.igv,f.igv*f.dolar)) as igv,
        abs(if(f.mone='S',f.impo,f.impo*f.dolar)) as impo,w.tdoc as trefe,left(w.ndoc,4) as serieref,substr(w.ndoc,5) as numerorefe,f.idauto
		FROM fe_rcom f
		inner join fe_ncven g on g.ncre_idan=f.idauto inner join fe_rcom as w on w.idauto=g.ncre_idau
        inner join fe_clie c on c.idclie=f.idcliente
		where f.tdoc="08"  and f.acti='A' and f.idcliente>0 and w.tdoc='03' and f.fech='<<df>>'
		ENDTEXT
		dfecha=cfechas(Date())
		If Ejecutaconsulta(lc,"rmvtos")<1 Then
			Exit
		Endif
		TEXT TO lcx NOSHOW TEXTMERGE PRETEXT 7
		serie,tdoc,min(numero) as desde,max(numero) as hasta,sum(valor) as valor,SUM(rcom_exon) as exon,
		sum(igv) as igv,sum(impo) as impo
		from(select
		left(ndoc,4) as serie,substr(ndoc,5) as numero,if(f.mone='S',valor,valor*dolar) as valor,rcom_exon,if(f.mone='S',igv,igv*dolar) as igv,
		if(f.mone='S',impo,impo*dolar) as impo,tdoc
		fROM fe_rcom f where tdoc="03" and fech='<<df>>' and acti='A' and idcliente>0 order by ndoc) as x  group by serie
		union all
		SELECT serie,tdoc,min(numero) as desde,max(numero) as hasta,sum(valor) as valor,SUM(rcom_exon) as exon,
		sum(igv) as igv,sum(impo) as impo from(select
		concat("BC",SUBSTR(f.ndoc,3,2)) as serie,substr(f.ndoc,5) as numero,abs(if(f.mone='S',f.valor,f.valor*f.dolar)) as valor,
		abs(f.rcom_exon) as rcom_exon,abs(if(f.mone='S',f.igv,f.igv*f.dolar)) as igv,abs(if(f.mone='S',f.impo,f.impo*f.dolar)) as impo,f.tdoc
		FROM fe_rcom f
		inner join fe_ncven g on g.ncre_idan=f.idauto inner join fe_rcom as w on w.idauto=g.ncre_idau
		where f.tdoc="07"  and f.acti='A' and f.idcliente>0 and w.tdoc='03' and f.fech='<<df>>' order by f.ndoc) as x group by serie
		union all
		SELECT serie,tdoc,min(numero) as desde,max(numero) as hasta,sum(valor) as valor,SUM(rcom_exon) as exon,
		sum(igv) as igv,sum(impo) as impo  from(select
		concat("BD",SUBSTR(f.ndoc,3,2)) as serie,substr(f.ndoc,5) as numero,abs(if(f.mone='S',f.valor,f.valor*f.dolar)) as valor,
		abs(f.rcom_exon) as rcom_exon,abs(if(f.mone='S',f.igv,f.igv*f.dolar)) as igv,abs(if(f.mone='S',f.impo,f.impo*f.dolar)) as impo,f.tdoc
		FROM fe_rcom f
		inner join fe_ncven g on g.ncre_idan=f.idauto inner join fe_rcom as w on w.idauto=g.ncre_idau
		where f.tdoc="08"  and f.acti='A' and f.idcliente>0 and w.tdoc='03' and f.fech='<<df>>' order by f.ndoc) as x group by serie
		ENDTEXT
		If Ejecutaconsulta(lcx,"rb1")<0 Then
			Exit
		Endif

		Select tdoc,serie,desde,hasta,valor,exon,;
			000000.00 As inafectas,igv,Impo,0.00 As gratificaciones,df As fech;
			FROM rb1 Into Cursor curb


		Select fech,tdoc,serie,numero,tipodoc,ndni,valor,rcom_exon As exon,;
			000000.00 As inafectas,igv,Impo,0.00 As gratificaciones,trefe,serieref,numerorefe,idauto;
			FROM rmvtos Into Cursor crb


		Select crb
		ocomp.itemsdocumentos=Reccount()
		tr=ocomp.itemsdocumentos
		If tr=0 Then
			Exit
		Endif
		ocomp.fechadocumentos=Alltrim(Str(Year(df)))+'-'+Iif(Month(df)<=9,'0'+Alltrim(Str(Month(df))),Alltrim(Str(Month(df))))+'-'+Iif(Day(df)<=9,'0'+Alltrim(Str(Day(df))),Alltrim(Str(Day(df))))
		cnombreArchivo=Alltrim(Str(Year(dfecha)))+Iif(Month(dfecha)<=9,'0'+Alltrim(Str(Month(dfecha))),Alltrim(Str(Month(dfecha))))+Iif(Day(dfecha)<=9,'0'+Alltrim(Str(Day(dfecha))),Alltrim(Str(Day(dfecha))))
		ocomp.moneda='PEN'
		ocomp.tigv='10'
		ocomp.vigv='18'
		ocomp.fechaemision=Alltrim(Str(Year(dfecha)))+'-'+Iif(Month(dfecha)<=9,'0'+Alltrim(Str(Month(dfecha))),Alltrim(Str(Month(dfecha))))+'-'+Iif(Day(dfecha)<=9,'0'+Alltrim(Str(Day(dfecha))),Alltrim(Str(Day(dfecha))))
		ocomp.rucfirma=fe_gene.rucfirmad
		ocomp.nombrefirmadigital=fe_gene.razonfirmad
		ocomp.rucemisor=fe_gene.nruc
		ocomp.razonsocialempresa=fe_gene.empresa
		ocomp.ubigeo=fe_gene.ubigeo
		ocomp.direccionempresa=fe_gene.ptop
		ocomp.ciudademisor=fe_gene.ciudad
		ocomp.distritoemisor=fe_gene.distrito
		ocomp.pais='PE'
		Dimension ocomp.itemsfacturas[tr,16]
		i=0
		ta=1
		Select crb
		Scan All
			i=i+1
			ocomp.itemsfacturas[i,1]=crb.tdoc
			ocomp.itemsfacturas[i,2]=Alltrim(crb.serie)+'-'+Alltrim(Str(Val(crb.numero)))
			ocomp.itemsfacturas[i,3]=Alltrim(crb.ndni)
			ocomp.itemsfacturas[i,4]=crb.tipodoc
			ocomp.itemsfacturas[i,5]=crb.trefe
			ocomp.itemsfacturas[i,6]=Alltrim(crb.serieref)+'-'+Alltrim(crb.numerorefe)
			ocomp.itemsfacturas[i,7]=Alltrim(Str(crb.Impo,12,2))
			ocomp.itemsfacturas[i,8]=Alltrim(Str(crb.valor,12,2))
			ocomp.itemsfacturas[i,9]=Alltrim(Str(crb.exon,12,2))
			ocomp.itemsfacturas[i,10]=Alltrim(Str(crb.inafectas,12,2))
			ocomp.itemsfacturas[i,11]="0.00"
			ocomp.itemsfacturas[i,12]="0.00"
			ocomp.itemsfacturas[i,13]=Alltrim(Str(crb.igv,12,2))
			ocomp.itemsfacturas[i,14]="0.00"
			ocomp.itemsfacturas[i,15]="0.00"
			ocomp.itemsfacturas[i,16]=Alltrim(Str(crb.gratificaciones,12,2))
		Endscan
		cserie=cnombreArchivo+"-"+Alltrim(Str(fe_gene.gene_nres))
		If ocomp.generaxmlrboletas(fe_gene.nruc,cserie)=1 Then
			GeneraCorrelativoEnvioResumenBoletas()
		Endif
		Select rbolne
		Skip
	Enddo
Enddefine
************************
Define Class Clx As Custom
	bdconn=0
	Carchivo=""
	cdatos=""
	Ticket=""
	tipoh="P"
	xopcion=0
	npara1=.F.
	npara2=.F.
	npara3=.F.
	npara4=.F.
	npara5=.F.
	npara6=.F.
	npara7=.F.
	npara8=.F.
	npara9=.F.
	npara10=.F.
	npara11=.F.
	npara12=.F.
	npara13=.F.
	npara14=.F.
	npara15=.F.
	npara16=.F.
	npara17=.F.
	npara18=.F.
	npara19=.F.
	npara20=.F.
	npara21=.F.
	npara22=.F.
	npara23=.F.
Enddefine
***************************

