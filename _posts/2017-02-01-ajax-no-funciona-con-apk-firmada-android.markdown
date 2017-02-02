---
layout: post
title: Cordova - Ajax no funciona con APK firmado en Android
categories: apache cordova ajax no funciona apk firmada android
permalink: :title
---


Si llegaste hasta aquí entonces lo mas probable es que te paso lo siguiente:

*	Desarrollaste una aplicacion Android con Apache Cordova.
*	Tu aplicacion consume un WebService, el protocolo que usa tu WebService es **https**
*	Cuando pruebas tu aplicacion en tu smartphone (**cordova run android**) funciona genial.
*	Cuando generas una apk en modo depuracion (**cordova build android**) todo funciona perfecto.
*	Cuando quieres subir tu aplicacion a Google Playstore y generas tu APK firmado (**cordova build android --release**), No funcionan los WebServices :(


Si ese es tu caso, dejame decirte que es un problema que afecta a muchos desarrolladores de Apache Cordova, es muy comun !!!

A continuacion, escribiré un parche temporal y por supuesto la solucion para este problema.



# **Porque ocurre esto ???**

Apache Cordova no permite llamadas **HTTPS** a servidores con certificados SSL no confiables instalados en ellos.

Esto tambien ocurre cuando tienes un **certificado SSL autogenerado** instalado en tu servidor.


# **Parche temporal**
Como siempre esto es un parche momentaneo y les recomiendo que solo lo usen para pruebas, no para la aplicacion final.


Modificando el WebView.java
{% highlight java %}
tutorial en progreso...
{% endhighlight %}

Tambien, Solo para realizar pruebas puedes remover el **https**.


# **Solucion**
Instalar en el servidor un **Certificado SSL válido** emitido por una entidad **Certificadora de confianza**.

Aqui tienes una : <a href="https://amielynjunryl.wordpress.com/2014/03/01/list-of-well-known-ssl-certificate-provider/" target="_blank">lista de entidades que te pueden proporcionar un certificado SSL confiable, compatible con Android e iOS</a>



