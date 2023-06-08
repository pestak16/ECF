<?php

use Classes\Autoloader;



define('ROOT', __DIR__);
define('FROM_INDEX', true);

require_once ROOT . '/Classes/Autoloader.php';
Autoloader::register();


require_once ROOT . '/vendor/altorouter/altorouter/AltoRouter.php';
require_once ROOT .'/routes.php';





//$brand = new Brand();
//$brand->hydrate(['name'=>'une marque en ECF']);

//var_dump($brand->isNew());

//var_dump($brand);
//$manager = new BrandManager();
//var_dump($manager->findAll());
//var_dump($manager->find(2));
//var_dump($manager->create($brand));