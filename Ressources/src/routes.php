<?php

use Classes\Controllers\BrandController;

$router = new AltoRouter();


$router->map( 'GET', '/marques', function() {
    (new BrandController())->index();
});

$router->map( 'GET|POST', '/marques/add', function() {
    (new BrandController())->add();
});

$match = $router->match();

if( is_array($match) && is_callable( $match['target'] ) ) {
	call_user_func_array( $match['target'], $match['params'] ); 
} else {
	// no route was matched
	header( $_SERVER["SERVER_PROTOCOL"] . ' 404 Not Found');
}








