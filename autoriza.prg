#Define ERRORPROC "NO SE EJECUTO CORRECTAMENTE El Proceso "
#Define MSGTITULO "SISVEN"
Define Class Autorizado As Custom
	coda=0
	cant=0
	Prec=0
	Prea=0
	unid=""
	idusua=0
	idusuaa=0
	idauto=0
	idautop=0
	Procedure GrabaPreciosAutorizados()
		lc='ProPreciosAutorizados'
		cur=""
		goapp.npara1=This.coda
		goapp.npara2=This.cant
		goapp.npara3=This.Prec
		goapp.npara4=This.Prea
		goapp.npara5=This.unid
		goapp.npara6=This.idusua
		goapp.npara7=This.idusuaa
		goapp.npara8=This.idautop
		goapp.npara9=This.idauto
		TEXT to lp noshow
	     (?goapp.npara1,?goapp.npara2,?goapp.npara3,?goapp.npara4,?goapp.npara5,?goapp.npara6,?goapp.npara7,?goapp.npara8,?goapp.npara9)
		ENDTEXT
		If EJECUTARP(lc,lp,cur)=0 Then
			errorbd(ERRORPROC+ ' Grabando Precios Autorizados')
			Return 0
		Else
			Return  1
		Endif
	Endproc
	Procedure MostrarPreciosAutorizados(dfi,dff,cur)
		lc='ProMuestraPreciosAutorizados'
		goapp.npara1=dfi
		goapp.npara2=dff
		TEXT to lp noshow
	     (?goapp.npara1,?goapp.npara2)
		ENDTEXT
		If EJECUTARP(lc,lp,cur)=0 Then
			errorbd(ERRORPROC+ ' Mostrando Precios Autorizados')
			Return 0
		Else
			Return  1
		Endif
	Endproc
    Procedure ActualizaAutorizados(np1,np2)
		lc='ProActualizaCanjesPreciosAutorizados'
		cur=""
		goapp.npara1=np1
		goapp.npara2=np2
		TEXT to lp noshow
	     (?goapp.npara1,?goapp.npara2)
		ENDTEXT
		If EJECUTARP(lc,lp,cur)=0 Then
			errorbd(ERRORPROC+ ' Actualizando Precios Autorizados')
			Return 0
		Else
			Return  1
		Endif
	Endproc 
Enddefine
***************************************
