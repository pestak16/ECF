<?php 
namespace Classes\Models;
use Exception;


/**
 * Classe représentant une marque
 */
class Brand
{
    /**
     * id en BDD
     *
     * @var integer|null
     */
    protected ?int $id = null;

    /**
     * Nom de la Marque
     *
     * @var string|null
     */
    protected ?string $name = null;

    /**
     * Date de la dernière modification
     *
     * @var string|null
     */
    protected ?string $update = null;


    public function __construct(array $data = null)
    {
        if(!is_null($data)){
            $this->hydrate($data);
        }
    }

    /**
     * Hydrate les attributs fournis par data
     *
     * @param array $data
     * @return self
     */
    public function hydrate(array $data): self
    {
        foreach($data as $key=>$value){
            $method = 'set' . ucfirst($key);
           
            if(method_exists(__CLASS__, $method)){
                $this->$method($value);
            }else{
                throw new Exception('L\'attibut n\'existe pas', 129);
            }
        }
        return $this;
    }

    /**
     * Retourne vrai si l'id est vide
     *
     * @return boolean
     */
    public function isNew():bool
    {
        return is_null($this->getId());
    }

	/**
	 * retourne l'id en BDD
	 * 
	 * @return int|null 
	 */
	public function getId(): ?int {
		return $this->id;
	}
	
	/**
	 * Modifie id en BDD
	 * 
	 * @param  $id id en BDD
	 * @return self
	 */
	public function setId(int $id): self 
    {
        if($id>0){
            $this->id = $id;
		
        }else{
            throw new Exception('Le paramètre doit être strictement positif', 127);
        }
        return $this;
		
	}

	/**
	 * Nom de la Marque
	 * 
	 * @return 
	 */
	public function getName(): ?string 
    {
		return $this->name;
	}
	
	/**
	 * Modifie le nom de la Marque
	 * 
	 * @param  $name Nom de la Marque
	 * @return self
	 */
	public function setName(string $name): self 
    {
        if(empty($name)){
            throw new Exception('Chaine vide', 128);
        }else{
            $this->name = $name;
        }
		
		return $this;
	}

	/**
	 * Date de la dernière modification
	 * 
	 * @return 
	 */
	public function getUpdate(): ?string {
		return $this->update;
	}
	
	/**
	 * Modifie la Date de la dernière modification
	 * 
	 * @param  $update Date de la dernière modification
	 * @return self
	 */
	public function setUpdate(string $update): self 
    {
        if(empty($update)){
           throw new Exception('Chaine vide', 128);
        }else{
            $this->update = $update;
        }
		
		return $this;
	}
}