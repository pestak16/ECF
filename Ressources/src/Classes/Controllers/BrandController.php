<?php


namespace Classes\Controllers;
use Classes\Models\BrandManager;


class BrandController
{
    protected $manager;

    public function __construct()
    {
        $this->manager = new BrandManager();
    }

    public function index()
    {
        $data = $this->manager->findAll();
        require_once ROOT . '/views/marques.index.php';
        
    }


    public function add()
    {
        if($_SERVER['REQUEST_METHOD'] === 'GET')
        {
            require_once ROOT .'/views/marques.add.php';
        }

        if($_SERVER['REQUEST_METHOD'] === 'POST'){
            'on implémentera plus tard';
        }

    }
}