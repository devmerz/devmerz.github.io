---
layout: post
title: Notificaciones push en android con Apache Cordova
categories: android apache cordova notificaciones push
permalink: :title
---


**Crear proyecto**

Debemos dirigirnos a la pagina [Console Developers Google](https://console.developers.google.com), Una vez dentro:

* Crearemos un nuevo proyecto
* El proyecto se llamara: notificaciones-push-android

<img src="/assets/apache-cordova-push-android/gcm-crear-proyecto.png" />

**Habilitar GCM para nuestro proyecto**

Una vez creado el proyecto debemos habilitar GCM para este proyecto. Nos dirigimos al menu lateral, opcion Biblioteca.
<img src="/assets/apache-cordova-push-android/activar-gcm-proyecto.png" />
Ingresamos a la opcion Google Cloud Messaging para Android. y lo Habilitamos.

El API esta habilitado pero todavia no lo podemos utilizar, primero debemos crear Credenciales.

**Creando credenciales**

En el menu principal -> Click en Credenciales -> Crear credenciales -> Clave de API (API Key) -> Clave de Servidor (Server Key) -> Copiar la clave de API.

<img src="/assets/apache-cordova-push-android/crear-credenciales.png" />

<img src="/assets/apache-cordova-push-android/clave-servidor.png" />

Nos pedira una nombre para la clave de Servidor, lo dejamos por defecto (Clave de servidor 1). Aceptamos.

Ahora si esto es MUY IMPORTANTE.
<img src="/assets/apache-cordova-push-android/clave-de-api.png" />
Copia la clave de API


**Obteniendo el Número del proyecto**

Nos dirigimos a la Configuracion del proyecto
<img src="/assets/apache-cordova-push-android/configuracion-proyecto.png" />
Copia el Número del proyecto.

~~~
Entonces !!!
Todo el proceso que hicimos hasta el momento fue para obtener : 
	Api Key : AIzaSyD5lRMJ0asKRmkIpkZAcTJilWNFIdk8xOY
	Número de proyecto : 270019172244
Con estos datos ahora si podemos ponernos a trabajar en la aplicacion Android.
~~~


**Creando aplicacion y adicionando plataforma Android**
{% highlight ruby %}
cordova create MiAppPush
cd MiAppPush
cordova platform add android
{% endhighlight %}
**Adicionando plugin para las notificaciones PUSH**
{% highlight ruby %}
cordova plugin add phonegap-plugin-push --variable SENDER_ID="TU_NUMERO_DE_PROYECTO"
{% endhighlight %}
Para mas informacion sobre este plugin, puedes revisar su [repositorio de Github](https://github.com/phonegap/phonegap-plugin-push)

**Codigo**

Crearemos un archivo index.js dentro de la carpeta js y adicionamos la referencia a este archivo dentro de index.html

{% highlight ruby %}
<script type="text/javascript" src="js/index.js"></script>
{% endhighlight %}

Mi index.html se ve asi:
{% highlight html %}
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Security-Policy" content="default-src 'self' data: gap: https://ssl.gstatic.com 'unsafe-eval'; style-src 'self' 'unsafe-inline'; media-src *">
        <meta name="format-detection" content="telephone=no">
        <meta name="msapplication-tap-highlight" content="no">
        <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width">
        <link rel="stylesheet" type="text/css" href="css/index.css">
        <title>Notificaciones Push</title>
    </head>
    <body>
        <div class="app">
            <h1>Apache Cordova</h1>
            <div id="deviceready" class="blink">
                <p class="event listening">Connecting to Device</p>
                <p class="event received">Device is Ready</p>
            </div>
        </div>
        <script type="text/javascript" src="js/index.js"></script>
        <script type="text/javascript" src="cordova.js"></script>
        <script type="text/javascript" src="js/index.js"></script>
    </body>
</html>

{% endhighlight %}

Y dentro index.js adicionamos el codigo referente a las notificaciones push:

{% highlight js %}
var id_gcm = -1;

var push = PushNotification.init({
    android: {
        senderID: "TU_NUMERO_DE_PROYECTO"
    }
});

push.on('registration', function(data) {  
    id_gcm = data.registrationId; // data.registrationId contiene el ID que GCM le asigno a nuestro dispositivo.
});
push.on('notification', function(data) {
    // data.message,
    // data.title,
    // data.count,
    // data.sound,
    // data.image,
    // data.additionalData
});
push.on('error', function(e) {
    // e.message
});
{% endhighlight %}

**Compilando app en Dispositivo android para primera prueba**
{% highlight ruby %}
cordova run android
{% endhighlight %}

cuando la aplicacion inicie veras que en el campo textarea aparecera un ID. Este es el ID asigando a tu dispositivo por GCM. Deberias verse similar a este:
{% highlight ruby %}
APA91bHMaA-R0eZrPisZCGfwwd7z1EzL7P7Q7cyocVkxBU3nXWed1cQYCYvF glMHIJ40knjZENQ62UFgg5QnEcqwB5dFZ-AmNZjATO8QObGp0p1S6Rq2tcCu UibjnyaS0UF1gIM1mPeM25MdZdNVLG3dM6ZSfxV8itpihroEN5ANj9A26RU2Uw
{% endhighlight %}
Y gracias a este ID, GCM sabra a que dispotivos enviar las notificaciones.

Ahora es el momento de enviar las notificaciones. COPIA EL ID DE TU DISPOSITIVO.

**Probando con Curl**

En una aplicacion real, existira un backend que se comunicara con GCM para que este ultimo envie las notificaciones a los dispotivos moviles.

Como este es un ejemplo simple, simulare el envio que deberia realizar un Backend usando CURL.

{% highlight ruby %}
curl --header "Authorization: key=AIzaSyD5lRMJ0asKRmkIpkZAcTJilWNFIdk8xOY" --header "Content-Type: application/json" https://android.googleapis.com/gcm/send -d "{\"registration_ids\":[\"fs...Tw:APA...SzXha\"]}"
{% endhighlight %}


* Authorization : Es el Api Key (Clave de API) que recuperamos en la configuracion de proyecto.

El json que debemos enviarle a GCM debe tener la siguiente estructura:

{% highlight ruby %}
{
    "registration_ids":["ID_DE_DISPOSITIVO_1","ID_DE_DISPOSITIVO_2"],
    "data":{
        "title":"Mi Notificacion Push !!!",
        "message":"Nueva notificacion registrada"
    }
}
{% endhighlight %}

**Probando desde Postman**

Si prefieres un entorno grafico, Postman es un plugin que te puede ayudar.
{% highlight ruby %}
in progress
{% endhighlight %}
**Requerimientos para que funcione en Android**

Antes de compilar tu aplicacion, asegurate de que tienes instalados los siguiente elementos, en el SDK de android.

* Android Support Library version 23 or greater
* Local Maven repository for Support Libraries (formerly Android Support Repository) version 20 or greater
* Google Play Services version 27 or greater
* Google Repository version 22 or greater

Para detalles en su [repositorio de Github](https://github.com/phonegap/phonegap-plugin-push/blob/master/docs/INSTALLATION.md)


Y bueno esto es todo !!! 
Saludos !!! 