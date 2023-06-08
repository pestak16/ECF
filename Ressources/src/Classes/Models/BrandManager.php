<?php
namespace Classes\Models;
use PDO;
use PDOException;

/**
 * Manager de brand en BDD
 */
class BrandManager{
    protected $pdo;

    /**
     * Crée une connexion à la base de données dans l'attribut $pdo
     *
     * @param string $dbhost
     * @param string $dbname
     * @param string $dbuser
     * @param string $dbpass
     */
    public function __construct(
        string $dbhost = 'localhost', 
        string $dbname = 'instruments',
        string $dbuser = 'root',
        string $dbpass = '')
        {
            $dsn = 'mysql:host='. $dbhost .';dbname=' . $dbname;
            try{
                $this->pdo = new PDO($dsn, $dbuser, $dbpass);
                $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            }catch(PDOException $e){
                die('Connexion à la BDD impossible ' . $e->getMessage());
            }
            
        }

    /**
     * REtourne un tableau de toutes les  Mark
     *
     * @return array Un tableau d'entité Mark
     */
    public function findAll():array
    {
        $q = $this->pdo->query('SELECT id, marque as `name`, date_modif as `update` FROM marques');
        return $q->fetchAll(PDO::FETCH_CLASS, '\Classes\Models\Brand');
    }


    /**
     * REtourne une marque
     *
     * @param integer $id
     * @return Brand
     */
    public function find(int $id):Brand
    {
        if($id<=0){
            throw new \Exception('Entier positif attendu', 127);
        }else{
            $q= $this->pdo->query('SELECT id, marque as `name`, date_modif as `update` 
            FROM marques 
            WHERE id=' . $id);
            return $q->fetchAll(PDO::FETCH_CLASS, '\Classes\Models\Brand')[0];
        }
    }


    /**
     * Ajoute une marque en BDD
     *
     * @param Brand $brand
     * @return Brand
     */
    public function create(Brand $brand): Brand
    {
        $sql = 'INSERT INTO marques(marque) VALUES(?)';
        $q = $this->pdo->prepare($sql);
       
        if($q->execute([$brand->getName()])){
            $id = $this->pdo->lastInsertId();
            return $this->find($id);
        }else{
            throw new PDOException('Un truc à la con pour inserton',200);
        }
    }
}