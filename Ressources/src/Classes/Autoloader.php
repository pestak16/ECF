<?php
namespace Classes;


defined('FROM_INDEX') or die('Mauvaise route');
class Autoloader
{
    public static function register()
    {
      spl_autoload_register([
          __CLASS__,
          'autoload'
      ]);
    }

    protected static function autoload($fqcn)
    {
        $class = str_replace(__NAMESPACE__ . '\\', '', $fqcn);
        $class = __DIR__ . '/' . str_replace('\\', '/', $class) . '.php';
       if(file_exists($class)){
           require_once $class;
       }
    }
}