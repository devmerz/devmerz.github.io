---
layout: post
title: "Comandos utiles : Apache Cordova"
categories: comandos apache cordova
permalink: :title
---

<img src="/assets/comandos-utiles-apache-cordova/cordova-logo.png" />

<a href="https://cordova.apache.org/" target="_blank">Apache cordova</a> es una tecnologia que te permite crear aplicaciones moviles para multiples plataformas utilizando tecnologias estandar como HTML5, CSS3 y JAVASCRIPT.

A continuación veras los comandos que más utilizo a la hora de crear aplicaciones.

<br/>

## Iniciar un proyecto

Este comando iniciara un proyecto llamado `MiApp` dentro de una carpeta con el mismo nombre.

{% highlight ruby %}
cordova create MiApp
{% endhighlight %}

Si es que desea darle un identificador a su proyecto, el comando es el siguiente:
{% highlight ruby %}
cordova create CarpetaMiAplicacion com.miempresa.miapp MiApp
{% endhighlight %}

<br/>

## Plataformas

**Añadir plataformas**
{% highlight ruby %}
cd MiApp
cordova platform add android
cordova platform add ios
cordova platform add amazon-fireos
cordova platform add blackberry10
cordova platform add firefoxos
{% endhighlight %}


**Ver las plataformas instaladas**
{% highlight ruby %}
cordova platforms ls
{% endhighlight %}

**Eliminar una plataforma**
{% highlight ruby %}
cordova platform remove android
{% endhighlight %}

<br/>

## Plugins

**Añadir plugins**
{% highlight ruby %}
cordova plugin add cordova-plugin-network-information
{% endhighlight %}

**Ver los plugins instalados**
{% highlight ruby %}
cordova plugin list
{% endhighlight %}

**Eliminar plugins**

{% highlight ruby %}
cordova plugin remove cordova-plugin-network-information
{% endhighlight %}

<br/>

## Construir y compilar una aplicación
 
**Construir la aplicacion**
{% highlight ruby %}
cordova build
{% endhighlight %}


**Probar la aplicacion en un simulador (Android)**

{% highlight ruby %}
cordova emulate android
{% endhighlight %}


**Probar la aplicacion en un dispositivo**
{% highlight ruby %}
cordova run android
{% endhighlight %}
No olvides activar la `depuración USB` en el dispositivo, antes de probar en un dispositivo Android.

