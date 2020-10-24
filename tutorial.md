membuat sdk untuk appwrite menggunakan hack programming language 
cara menginstall hack hhvm
anda bisa mengacu pada dokumentasi resmi di https://docs.hhvm.com/hhvm/installation/

untuk tutorial ini saya akan menggunakan linux jadi jika kamu pengguna linux juga gunakan link berikut ini untuk men-setup hhvm https://docs.hhvm.com/hhvm/installation/linux

pertama tama buat folder lib yang digunakan untuk men-store library hack kita lalu kita buat file bernama `client.hack` 

`client.hack` disini digunakan untuk men-call API dari appwrite server ke hack server

pertama tama kita buat class `Client`

```
class Client {
    
}
```
class client disini digunakan untuk mengakses API appwrite server jadi kita menggunakan teknik OOP dimana class Client ini nantinya akan kita gunakan untuk meng-extend class lain yang mempunyai fungsi berbeda dalam penggunaan API

kita buat constructor

```
class Client{
    public function __construct(public string $endpoint,public dict<string,string> $headers,public bool $selfSigned) {
        $this->endpoint = 'https://localhost:4000/v1';
        $this->headers = dict[
            'content-type'=> '',
            'x-sdk-version'=> 'appwrite:hack:1.1.0',
        ];
        $this->selfSigned = false;
      }
}
```