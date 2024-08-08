<?php

if($_SERVER['REQUEST_METHOD'] == 'POST'){    
    $json = file_get_contents('php://input');
    $obj = json_decode($json);   
    $fecha = $obj->fecha;
    
    try{
        $url_tc = "https://api.sunat.online/cambio/$fecha?fbclid=IwAR01lnc_1Etx44fkVCgzNyaFnNISQthk0UjkSY0q6pdVeqMxziJqh2drYLU";

        $ctx = stream_context_create(['ssl' => [
                "verify_peer"=>false,
                "verify_peer_name"=>false,
            ]
        ]);

        $data = file_get_contents($url, false, $ctx);         
        print(str_replace('-', '',$data));
    }catch(Exception $ex){
        return '{"error":"No se pudo recuperar Tipo de Cambio!"}';
    }
}else{
    
    if($_SERVER['REQUEST_METHOD'] == 'OPTIONS'){
        die();
    }else{
        header("HTTP/1.0 404 Not Found");        
    }

}
return;
