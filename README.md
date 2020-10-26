# Build an SDK for Appwrite Server Using Hack Programming Language

## Overview

In this tutorial, we will be creating an SDK that can access appwrite server. The app will be able to process every possible API appwrite server has. The key things we will explore is how to:

*   Setup hack programming language environment
*   Install the necessary tools
*   Create an SDK

## Prerequisites

*   Install appwrite server [Appwrite](https://appwrite.io/docs/installation) 
*   Download the [Sdk-for-hack](https://github.com/spiritbro1/sdk-for-hack) branch from GitHub
*   Download and install [Hack Programming Language](https://docs.hhvm.com/hack/getting-started/getting-started)

## Setup hack programming language environment

The prerequisites you need to write and execute Hack code are pretty straightforward:

- The HHVM runtime
- The Hack typechecker (included with HHVM packages/builds)
Optionally, a Hack-aware editor. We recommend Visual Studio Code with vscode-hack, and Vim with ALE also offers an excellent experience.

## Install the necessary tools

You need to install appwrite server in order to run this SDK [appwrite](https://appwrite.io/docs/installation) follow the documentation there, you also need [hack programming language](https://docs.hhvm.com/hack/getting-started/getting-started)

### Creating a client.hack for encapsulating our call to server
As you can see we have our client.hack in our app what this does is, it encapsulate our call as a wrapper so that later when we want to call a service we just need to extend this class to another service so we don't need to duplicate our call method just like coding paradigm KISS (Keep it simple stupid)

```
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

```
### Creating our Health services

As you can see here we extends the client.hack we create earlier to this class so that we can use one of the method of the appwrite server

```



class Health extends Client {

    /**
     * Get HTTP
     *
     * Check the Appwrite HTTP server is up and responsive.
     *
     * @throws Exception
     * @return {}
     */
     public async function get():Awaitable<string> {
        $path = '/health';
        
        return  await $this->call('get', $path, vec[
                    'content-type:application/json',
        ],
               dict[]);
    }

    /**
     * Get Anti virus
     *
     * Check the Appwrite Anti Virus server is up and connection is successful.
     *
     * @throws Exception
     * @return {}
     */
    // async getAntiVirus() {
    //     let path = '/health/anti-virus';
        
    //     return await this.client.call('get', path, {
    //                 'content-type': 'application/json',
    //            },
    //            {
    //         });
    // }

    /**
     * Get Cache
     *
     * Check the Appwrite in-memory cache server is up and connection is
     * successful.
     *
     * @throws Exception
     * @return {}
     */
    // async getCache() {
    //     let path = '/health/cache';
        
    //     return await this.client.call('get', path, {
    //                 'content-type': 'application/json',
    //            },
    //            {
    //         });
    // }

    /**
     * Get DB
     *
     * Check the Appwrite database server is up and connection is successful.
     *
     * @throws Exception
     * @return {}
     */
    // async getDB() {
    //     let path = '/health/db';
        
    //     return await this.client.call('get', path, {
    //                 'content-type': 'application/json',
    //            },
    //            {
    //         });
    // }

    /**
     * Get Certificate Queue
     *
     * Get the number of certificates that are waiting to be issued against
     * [Letsencrypt](https://letsencrypt.org/) in the Appwrite internal queue
     * server.
     *
     * @throws Exception
     * @return {}
     */
    // async getQueueCertificates() {
    //     let path = '/health/queue/certificates';
        
    //     return await this.client.call('get', path, {
    //                 'content-type': 'application/json',
    //            },
    //            {
    //         });
    // }

    /**
     * Get Functions Queue
     *
     * @throws Exception
     * @return {}
     */
    // async getQueueFunctions() {
    //     let path = '/health/queue/functions';
        
    //     return await this.client.call('get', path, {
    //                 'content-type': 'application/json',
    //            },
    //            {
    //         });
    // }

    /**
     * Get Logs Queue
     *
     * Get the number of logs that are waiting to be processed in the Appwrite
     * internal queue server.
     *
     * @throws Exception
     * @return {}
     */
    // async getQueueLogs() {
    //     let path = '/health/queue/logs';
        
    //     return await this.client.call('get', path, {
    //                 'content-type': 'application/json',
    //            },
    //            {
    //         });
    // }

    /**
     * Get Tasks Queue
     *
     * Get the number of tasks that are waiting to be processed in the Appwrite
     * internal queue server.
     *
     * @throws Exception
     * @return {}
     */
    // async getQueueTasks() {
    //     let path = '/health/queue/tasks';
        
    //     return await this.client.call('get', path, {
    //                 'content-type': 'application/json',
    //            },
    //            {
    //         });
    // }

    /**
     * Get Usage Queue
     *
     * Get the number of usage stats that are waiting to be processed in the
     * Appwrite internal queue server.
     *
     * @throws Exception
     * @return {}
     */
    // async getQueueUsage() {
    //     let path = '/health/queue/usage';
        
    //     return await this.client.call('get', path, {
    //                 'content-type': 'application/json',
    //            },
    //            {
    //         });
    // }

    /**
     * Get Webhooks Queue
     *
     * Get the number of webhooks that are waiting to be processed in the Appwrite
     * internal queue server.
     *
     * @throws Exception
     * @return {}
     */
    // async getQueueWebhooks() {
    //     let path = '/health/queue/webhooks';
        
    //     return await this.client.call('get', path, {
    //                 'content-type': 'application/json',
    //            },
    //            {
    //         });
    // }

    /**
     * Get Local Storage
     *
     * Check the Appwrite local storage device is up and connection is successful.
     *
     * @throws Exception
     * @return {}
     */
    // async getStorageLocal() {
    //     let path = '/health/storage/local';
        
    //     return await this.client.call('get', path, {
    //                 'content-type': 'application/json',
    //            },
    //            {
    //         });
    // }

    /**
     * Get Time
     *
     * Check the Appwrite server time is synced with Google remote NTP server. We
     * use this technology to smoothly handle leap seconds with no disruptive
     * events. The [Network Time
     * Protocol](https://en.wikipedia.org/wiki/Network_Time_Protocol) (NTP) is
     * used by hundreds of millions of computers and devices to synchronize their
     * clocks over the Internet. If your computer sets its own clock, it likely
     * uses NTP.
     *
     * @throws Exception
     * @return {}
     */
    // async getTime() {
    //     let path = '/health/time';
        
    //     return await this.client.call('get', path, {
    //                 'content-type': 'application/json',
    //            },
    //            {
    //         });
    // }
}


```

## Review and continue improving your SDK

You might notice that in this scenario i'm only using Health API you can add another layer of SDK using an already created wrapper of Health class service for other services like database or storage.


## Next Steps

You can create another SDK let's say for facebook to interact with user using hack programming language the possibility is limitless.


## Related Content

* [Hack Programming Language](https://docs.hhvm.com/hack/getting-started/getting-started)


## Contributing
See the [CONTRIBUTING](CONTRIBUTING.md) file for how to help out.

## License
Build an SDK for Appwrite Server Using Hack Programming Language is licensed, as found in the [LICENSE](LICENSE) file.