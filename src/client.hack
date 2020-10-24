use namespace HH\Lib\{Str,Dict};
class Client {
      
  private string $endpoint; 
  private vec<string> $headers;
  private bool $selfSigned;
  public function __construct() { // instance method
        $this->endpoint = 'http://localhost:4000/v1';
        $this->headers = vec[
            'content-type:\'\'',
            'x-sdk-version:appwrite:hack:1.1.0',
        ];
        $this->selfSigned = false;
  }
    

    /**
     * Set Project
     *
     * Your project ID
     *
     * @param string value
     *
     * @return self
     */
    public function setProject(string $value): this {
        $this->addHeader('X-Appwrite-Project', $value);

        return $this;
    }

    /**
     * Set Key
     *
     * Your secret API key
     *
     * @param string value
     *
     * @return self
     */
    public function setKey(string $value) : this{
        $this->addHeader('X-Appwrite-Key', $value);

        return $this;
    }

    /**
     * Set Locale
     *
     * @param string value
     *
     * @return self
     */
    public function setLocale(string $value) : this{
        $this->addHeader('X-Appwrite-Locale', $value);

        return $this;
    }

    /***
     * @param bool status
     * @return this
     */
    public function setSelfSigned(bool $status = true):this {
        $this->selfSigned = $status;

        return $this;
    }

    /***
     * @param endpoint
     * @return this
     */
    public function setEndpoint(string $endpoint) : this
    {
        $this->endpoint = $endpoint;

        return $this;
    }

    /**
     * @param key string
     * @param value string
     */
    public function addHeader(string $key,string $value) :this{
        $this->headers[] = Str\lowercase($key).":".Str\lowercase($value);
        
        return $this;
    }
      
    public async function call(string $method,string $path = '',vec<string> $headers =vec[],dict<string,string> $params = dict[]) : Awaitable<string>{
        

        $headers = \HH\Lib\Dict\merge($this->headers,$headers);

               
        $ch = \curl_init($this->endpoint.$path);
        \curl_setopt($ch, \CURLOPT_CUSTOMREQUEST, HH\Lib\Str\uppercase($method));
        \curl_setopt($ch, \CURLOPT_HTTPHEADER, $headers);
        \curl_setopt($ch, \CURLOPT_POSTFIELDS, $params);
          $response = await \HH\Asio\curl_exec($ch);;

        

        return $response;
    }

}

