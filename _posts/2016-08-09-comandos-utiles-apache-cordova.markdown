---
layout: post
title: "Comandos utiles : Apache Cordova"
categories: comandos apache cordova
---

**Iniciar un proyecto**

El siguiente comando iniciara un proyecto llamado `MiApp` dentro de una carpeta con el mismo nombre.

{% highlight ruby %}
cordova create MiApp
{% endhighlight %}

Si es que desea darle un identificador a su proyecto, el comando es el siguiente:
{% highlight ruby %}
cordova create CarpetaMiAplicacion com.miempresa.miapp MiApp
{% endhighlight %}

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

**Construir la aplicacion**
{% highlight ruby %}
cordova build
{% endhighlight %}


**Probar la aplicacion en un simulador**

{% highlight ruby %}
cordova emulate android
{% endhighlight %}


**Probar la aplicacion en un dispositivo**
{% highlight ruby %}
cordova run android
{% endhighlight %}
No olvides activar la `depuración USB` en el dispositivo.

Y bueno eso son los comandos que mas utilizo a la hora de crear aplicaciones con Apache Cordova, Espero haya sido de ayuda.

Saludos !!!
