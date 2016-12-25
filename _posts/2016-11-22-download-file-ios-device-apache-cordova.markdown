---
layout: post
title: Download file on iOS device with Apache Cordova
categories: apache cordova download files file transfer ios iphone
permalink: :title
---

In this tutorial we are going to download a image of internet to a iOS device (Iphone 5s), then show the image downloaded in a **img** tag of html.


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


## Add Javascript code

We are going to download the logo of Github, from <a href="https://assets-cdn.github.com/images/modules/logos_page/Octocat.png" target="_blank">Here</a>, On index.js file, we need add the next code:

{% highlight javascript %}
var url = "https://assets-cdn.github.com/images/modules/logos_page/";
var filename = "Octocat.png";

var fileTransfer = new FileTransfer();
var uri = encodeURI(url + filename);
var fileURL = "cdvfile://localhost/persistent/" + filename;

fileTransfer.download(
        uri, fileURL, function(entry) {
            console.info("Download complete: " + entry.toURL());
            document.getElementById("imageDownloaded").src= cordova.file.applicationStorageDirectory + "Documents/"+ filename;
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


In the index.html file you need add a tag **img**, Here the downloaded image will be displayed

{% highlight html %}
<img id="imageDownloaded" src=""/>
{% endhighlight %}

Ok, this simple code downloads an image and shows it in an *img* tag on the index.html page.


