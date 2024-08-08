WAIT WINDOW 'Consultando Tipo de Cambio!' NOWAIT 
		
		cUrl = NVL(f_get_data_select("select valor as dato from parametros where codigo = 'LTC'"), '')                                                                                                                                                     
		oHttp = CREATEOBJECT("CURL")  && CGR - 20200225
		oHttp.open("post", cUrl , .f.)

		oHttp.setRequestHeader("Content-Type", "application/json;utf-8")
		oHttp.Send(cData)		
		cRpta = oHttp.ResponseText		

		SELECT &cCurTemp 
		GO TOP  
		SET DECIMALS TO 3
		IF 	(ATC("compra", cRpta) > 0) && si tiene la palabra compra es válido	 					
			oJson = json_decode(cRpta)
			dfecha = dini 
			DO WHILE (dfecha <= dfin)								
				cfecha = DTOS(dfecha)				
				oValor = oJson.get(cfecha)			
				IF (VARTYPE(oValor) = 'O') THEN &&Objeto Fecha 
					ls_compra = oValor.get('compra')
					ls_venta  = oValor.get('venta')									
					APPEND BLANK
					REPLACE fecha WITH stod(cfecha)
					REPLACE compra WITH VAL(ls_compra) 
					REPLACE venta WITH VAL(ls_venta) 								
				ENDIF
				dfecha = dfecha + 1 
			ENDDO	
		ELSE 	
			WAIT WINDOW 'No se encontro información para Tipo de Cambio' NOWAIT 
		ENDIF		
		SET DECIMALS TO			