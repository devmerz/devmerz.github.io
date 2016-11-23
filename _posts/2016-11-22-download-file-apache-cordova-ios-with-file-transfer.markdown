---
layout: post
title: Download files in Apache cordova with "File Transfer" on IOS
categories: apache cordova download files file transfer ios iphone
permalink: :title
---

Hi there !!!

In this tutorial we are going to download a image of internet to an Iphone, then show the image downloaded in a **img** tag of html.


## Create the application

{% highlight ruby %}
cordova create MyApp
cd MyApp
{% endhighlight %}

## Install the Plugin : Cordova Plugin File Transfer

{% highlight ruby %}
cordova plugin add cordova-plugin-file-transfer
{% endhighlight %}


We will use the plugin **Cordova Plugin File Transfer**, you can read more about this plugin in : <a href="https://github.com/apache/cordova-plugin-file-transfer" target="_blank">Cordova Plugin File Transfer</a>


## Time to Coding :D

On index.js file, we need add the next code:

{% highlight javascript %}
var url = "www.google.com/path/to/img.png";
var nombre = "img.png";

var fileTransfer = new FileTransfer();
var uri = encodeURI(url);
var fileURL = "///storage/emulated/0/DCIM/SYNC/AFP/" + nombre;

fileTransfer.download(
        uri, fileURL, function(entry) {
            console.info("Download complete: " + entry.toURL());
        },
        function(error) {
            console.warn("Download error source " + error.source);
        },
        false, {
            headers: {
                "Authorization": "Basic dGVzdHVzZXJuYW1lOnRlc3RwYXNzd29yZA=="
            }
        }
);
{% endhighlight %}


In the index.html you need add a tag **img**, here show the image to download.
{% highlight html %}
<img id="" src=""/>
{% endhighlight %}

Ok, This simple code download an image and show it on a **img** tag in the index.html page of the Project apache cordova, Just before the brand.

## Result

Put here the screenshots...


# Repository on Github

<a href="https://github.com/apache/cordova-plugin-file-transfer" target="_blank"> GET CODE HERE</a>

