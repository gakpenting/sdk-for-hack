#!/usr/bin/env hhvm

<<__EntryPoint>>
function main(): void {
 require_once(__DIR__.'/vendor/autoload.hack');
  \Facebook\AutoloadMap\initialize();
  

$client = new Health();
$client->setProject("5f91246e2dfcd");
$client->setKey("0ba7d715d05357762b6e81b158df7242aea2ab4237dbe9e8bbd8870a27b2bb85666ccc567cbeaaf97bf2272217bbc966d5908611f05069f7031f0783e87d6136038ca6fc979af17a9b92333eec0acf34034646dd921d64f362a63af065e4a54e8bd8e69b8e01c819b6c27d9eba26b925563a2366641377c9ad505991668a2aa5");
$pum=\HH\Asio\join($client->get());
$hai=json_decode($pum)->status;
  echo $hai;
}