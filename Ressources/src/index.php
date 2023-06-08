<?php
use Classes\Models\Brand;
use Classes\Models\BrandManager;


require_once 'classes\Models\Brand.php';
require_once 'classes\Models\BrandManager.php';

$brand = new Brand();
$brand->hydrate(['name'=>'une marque en ECF']);

//var_dump($brand->isNew());

//var_dump($brand);
$manager = new BrandManager();
//var_dump($manager->findAll());
//var_dump($manager->find(2));
var_dump($manager->create($brand));