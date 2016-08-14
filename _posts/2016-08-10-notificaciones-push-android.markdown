---
layout: post
title: Notificaciones push en android con Apache Cordova
categories: android apache cordova notificaciones push
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

Perfecto !!!
Todo el proceso de mas arriba nos dejo una estructura similar a esta:

**Registrar nuestro dispositivo en GCM**
{% highlight ruby %}
var id_gcm = -1;

var push = PushNotification.init({
    android: {
        senderID: "ID_PROYECTO"
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
****



in progress ...