---
layout: post
title: Notificaciones Push con Apache Cordova y FCM (Actualizado 2021)
categories: apache cordova android notificaciones push fcm gcm Firebase Cloud Messaging actualizado funciona 2021
permalink: :title
---


En el siguiente articulo aprenderás a configurar un proyecto en <a href="https://console.firebase.google.com" target="_blank">Firebase Console</a> para enviar notificaciones PUSH a dispositivos Android, La aplicación será construida usando Apache Cordova.

<img src="/assets/apache-cordova-push-android-fcm/imagen-principal.png" />



<br />
<br />
<br />

# Configurar proyecto en Firebase Console

Nos dirigimos a <a href="https://console.firebase.google.com" target="_blank">Firebase console</a> y creamos un nuevo proyecto;


<img src="/assets/push-apache-cordova-actualizado/crear-proyecto.png" width="100%">


Nuestro proyecto se llamará <code>Notificaciones push cordova</code>:

<img src="/assets/push-apache-cordova-actualizado/nombre-proyecto.png">


Presionamos en continuar y nos pedirá integrar el proyecto con Google Analytics, en este caso no lo habilitaremos, presionamos en **Crear proyecto**

<img src="/assets/push-apache-cordova-actualizado/analytics-proyecto.png">

Una vez terminado el proceso el proyecto estará creado, presionamos en continuar
<img src="/assets/push-apache-cordova-actualizado/proyecto-creado.png">

En el panel de administracion seleccionamos la opción <code>Configuración del proyecto</code>
<img src="/assets/push-apache-cordova-actualizado/configuracion-proyecto.png">

Nos vamos al pestaña <code>General</code> al final encontraremos la opcion para crear la configuración para la aplicacion, en este caso seleccionamos la opcion Android:

<img src="/assets/push-apache-cordova-actualizado/android-proyecto.png">


En el formulario que nos presenta llenaremos el campo <code>Nombre del paquete de android</code>, los demas campos son opcionales, Mas adelante crearemos el proyecto con el nombre de paquete igual a <code>com.notificacionespushcordova.app</code>

<br>
Presionamos **Registrar app**
<img src="/assets/push-apache-cordova-actualizado/registrar-app.png">

Debemos descargar el archivo google-services.json que no da:
<img src="/assets/push-apache-cordova-actualizado/descargar-google-services.png">
<br>
<br>
ok, guarda el archivo <code>google-services.json</code> que mas adelante lo debemos poner en la raiz del proyecto.

<br>
<br>
# Creamos la aplicación e instalamos todo lo necesario

Ejecutamos los siguientes comandos:

{% highlight ruby %}
cordova create miproyecto com.notificacionespushcordova.app miapp
cd miproyecto
cordova platform add android
cordova plugin add cordova-plugin-firebasex
cordova run android
{% endhighlight %}


Como puedes notar en este caso utilizamos un plugin diferente, el plugin que utilzaremos para las notificaciones push es: <a href="https://github.com/dpa99c/cordova-plugin-firebasex" target="_blank">cordova-plugin-firebasex</a>



Tambien notarás que si haces correr la aplicación te lanzará el siguiente error: 


> This project uses AndroidX dependencies, but the 'android.useAndroidX' property is not enabled. Set this property to true in the gradle.properties file and retry.

Para solucionar este error debemos habilitar AndroidX, tenemos que modificar el archivo config.xml y debemos adicionar la linea:
{% highlight ruby %}
<preference name="AndroidXEnabled" value="true" />
{% endhighlight %}

Quedando el archivo asi: 
{% highlight ruby %}
<?xml version='1.0' encoding='utf-8'?>
<widget id="com.notificacionespushcordova.app" version="1.0.0" xmlns="http://www.w3.org/ns/widgets" xmlns:cdv="http://cordova.apache.org/ns/1.0">
    <name>miapp</name>
    <description>
        A sample Apache Cordova application that responds to the deviceready event.
    </description>
    <author email="dev@cordova.apache.org" href="http://cordova.io">
        Apache Cordova Team
    </author>
    <content src="index.html" />
    <access origin="*" />
    <allow-intent href="http://*/*" />
    <allow-intent href="https://*/*" />
    <allow-intent href="tel:*" />
    <allow-intent href="sms:*" />
    <allow-intent href="mailto:*" />
    <allow-intent href="geo:*" />
    <platform name="android">
        <allow-intent href="market:*" />
    </platform>
    <platform name="ios">
        <allow-intent href="itms:*" />
        <allow-intent href="itms-apps:*" />
    </platform>
    <preference name="AndroidXEnabled" value="true" />
</widget>
{% endhighlight %}

Si volvemos a ejecutar la aplicación, se ejecutara sin problemas:

<img src="/assets/push-apache-cordova-actualizado/app-proyecto.png">

Perfecto, ahora un poco de código. En el archivo index.js vamos a cambiar el contenido original por:

{% highlight ruby %}
document.addEventListener('deviceready', onDeviceReady, false);

function onDeviceReady() {
    document.getElementById('deviceready').classList.add('ready');

     window.FirebasePlugin.getToken(function(token) {
        document.getElementById("miToken").value = token;
    }, function(error) {
        console.error(error);
    });
    
    window.FirebasePlugin.onTokenRefresh(function(token) {
        console.log("Actualizar para obtener nuevo token: " + token);
    }, function(error) {
        alert(error);
    });
    
    window.FirebasePlugin.onMessageReceived(function(message) {
        if(message.messageType === "notification"){
            alert("Notificación recibida dentro de la aplicación");
            if(message.tap){
                alert("Presionada en: " + message.tap);
            }
        }
    }, function(error) {
        console.error(error);
    }); 
}
{% endhighlight %}

Las funciones de getToken, onTokenRefresh, onMessageReceived son proporcionadas por el plugin cordova-plugin-firebasex, puedes encontrar mas información acerca de estas y otras funciones en 
<a href="https://github.com/dpa99c/cordova-plugin-firebasex" target="_blank">cordova-plugin-firebasex</a>. En el archivo index.html vamos a insertar un textarea con un id llamado miToken, quedando asi:

{% highlight html %}
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Security-Policy" content="default-src 'self' data: gap: https://ssl.gstatic.com 'unsafe-eval'; style-src 'self' 'unsafe-inline'; media-src *; img-src 'self' data: content:;">
        <meta name="format-detection" content="telephone=no">
        <meta name="msapplication-tap-highlight" content="no">
        <meta name="viewport" content="initial-scale=1, width=device-width, viewport-fit=cover">
        <meta name="color-scheme" content="light dark">
        <link rel="stylesheet" href="css/index.css">
        <title>Hello World</title>
    </head>
    <body>
        <div class="app">
            <h1>Apache Cordova</h1>
            <div id="deviceready" class="blink">
                <textarea id="miToken" cols="30" rows="10"></textarea>
                <p class="event listening">Connecting to Device</p>
                <p class="event received">Device is Ready</p>
            </div>
        </div>
        <script src="cordova.js"></script>
        <script src="js/index.js"></script>
    </body>
</html>
{% endhighlight %}

El textarea nos servirá para visualizar el token de nuestro dispositivo. Si compilamos la aplicación veremos lo siguiente:

> No olvides poner el archivo google-services.json en la raiz de nuestro proyecto para que funcione sin problemas


<img src="/assets/push-apache-cordova-actualizado/app-con-token.png" />

Ok, entonces hasta este punto ya tenemos todo integrado y la aplicación ya genera un token para que podamos realizar las pruebas. Copia el token generado en el textarea.


# Pruebas

Para la prueba rápida volvemos a la consola de firebase y buscamos la seccion de Cloud messaging y presionamos el boton de **Send your first message**

<img src="/assets/push-apache-cordova-actualizado/send-first-message.png" />

En el formulario que nos aparece debemos llenar los campos: Titulo de la notificación y Texto de la notificación como campos requeridos. Luego presionamos en "Enviar mensaje de prueba" y nos pedirá un token, ese token es el token que copiamos de el textarea con anterioridad, lo pegamos, adicionamos y presionamos en el boton "Probar"

<img src="/assets/push-apache-cordova-actualizado/token-app.png" />

Funciona !!! Nos llegará la notificación a nuestro dispositivo sin problemas, puede ser que en la primera prueba la notificacion tarde unos minutos en llegar pero luego será con total normalidad.
<img src="/assets/push-apache-cordova-actualizado/notificacion-funciona.png" />

La notificación push llegará tanto si estamos con la aplicación abierta o cerrada.



