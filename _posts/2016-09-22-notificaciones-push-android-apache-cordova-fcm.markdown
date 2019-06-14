---
layout: post
title: Notificaciones Push en Android con Apache Cordova y FCM (Firebase Cloud Messaging)
categories: apache cordova android notificaciones push fcm gcm Firebase Cloud Messaging
permalink: :title
---

(Ultima actualización de este post: 22/07/2017) <br/>
Actualización: Amigos visitantes del blog y especificamente de este articulo. Al parecer hay muchas personas interesadas en este tema y ultimamente me llegan muchos mensajes indicando de que el procedimiento de este articulo no funciona, Deben comprender que este articulo fue escrito hace 2 años. En su tiempo funcionó a la perfección y es normal que ahora no funcione, Las librerias/plugins/frameworks tienden a cambiar el modo de implementarlos con el tiempo. Por ahora les pido que por favor no tomes el contenido de este articulo como algo que deba funcionar, quiza puedas revisarlo para darte una idea de las cosas que hice para implementarlo en mi aplicación.
<br>
<strong>Si quieres añadir Notificaciones Push a tu Aplicacion hecha con Cordova lo mejor que te recomiendo es que busques la documentacion directa de los plugins.</strong> <br/>
PD: Terminaré algunos trabajos que estoy realizando y escribiré una versión actualizada de este articulo ;)

<hr/>

<img src="/assets/apache-cordova-push-android-fcm/imagen-principal.png" />


En el siguiente articulo usted aprendera como Configurar un Proyecto en Console Developers Google y  <a href="https://firebase.google.com/docs/cloud-messaging/" target="_blank">Firebase Google Cloud Messaging</a> para enviar notificaciones PUSH a dispositivos Android, a traves de FCM.

<br />

## **Crear un nuevo proyecto**

- Nos dirigimos a [Console Developers Google](https://console.developers.google.com/)

- Click en la opción **Crear proyecto**.

- Nos pedirá un nombre para nuestro proyecto, en nuestro caso se llamara **Notificacion push android fcm**, Creamos el proyecto.


<img src="/assets/apache-cordova-push-android-fcm/crear-proyecto notificaciones-push-android.png" />

<br />

## **Firebase Cloud Messaging**

En el menú aparece la opción Biblioteca. le damos click a **Google Cloud Messaging**. Esto nos llevara a la pagina de firebase de google.

<img src="/assets/apache-cordova-push-android-fcm/habilitando-fcm.png" />

El enlace nos llevara a [Firebase Google Cloud Messaging](https://firebase.google.com/docs/cloud-messaging/)

Ahora debemos **Ir a la consola**, que se encuentra en la esquina superios derecha.
<img src="/assets/apache-cordova-push-android-fcm/ir-a-la-consola.png" />

<br />

## **Crear el proyecto en Firebase Console**

- Click en el botón **CREAR NUEVO PROYECTO**
- Nos pedirá los siguientes campos **Nombre del proyecto** y **Pais/Region**

<img src="/assets/apache-cordova-push-android-fcm/nuevo-proyecto-fcm.png" />

Entonces el proyecto fue creado. y seremos redirigidos a la siguiente pantalla:

<img src="/assets/apache-cordova-push-android-fcm/anade-firebase-a-tu-proyecto.png" />

- Click en: Añade Firebase a tu aplicación de Android.
- En la pantalla que aparecerá introducimos el Nombre del paquete (Package Name) de la aplicación, en mi caso creare el APP con el package name igual a com.miappfcm.app.
- Click en Añadir Aplicación.

<img src="/assets/apache-cordova-push-android-fcm/generando-el-json.png" />

<br />

## **Descarga del archivo google-services.json**

Dando click en Añadir Aplicación, se descargara un archivo llamado google-services.json. Este archivo contiene toda la información de nuestro proyecto(Google Firebase) y también nos ayudara a que el dispositivo pueda recibir las notificaciones.

Este archivo debemos ponerlo en **LA RAIZ DEL PROYECTO**.


{% highlight ruby %}
MiApp/google-services.json
{% endhighlight %}

<br />

### **Creando el Proyecto, Adicionando plataforma Android, Instalando plugin FCM**

{% highlight ruby %}
cordova create MiApp com.miappfcm.app MiAppPushFCM
cd MiAppPushFCM
cordova platform add android
cordova plugin add cordova-plugin-fcm
cordova run android
{% endhighlight %}

NO LO OLVIDES !!! El Package Name es : **com.miappfcm.app** y debes mover el archivo google-services.json a la dirección indicada mas arriba.

El repositorio del plugin que utilizaremos es [Cordova plugin FCM](https://github.com/fechanique/cordova-plugin-fcm)

Y no olvides probar tu app en tu smartphone ;)

<br />

## **Adicionando código**

Entonces dentro de nuestra estructura de proyectos, abrimos el archivo: **/www/js/index.js**

Creare una funcion llamada **pushNotification()**, y dentro pondre un codigo que: Muestra un "alert" con la informacion JSON que contiene la notificacion. El if/else indica si la notificacion se presiono desde la barra de notificaciones o no. 

Mi index.js quedaria asi:

{% highlight javascript %}
var app = {
    // Application Constructor
    initialize: function() {
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
    },

    // deviceready Event Handler
    onDeviceReady: function() {
        this.receivedEvent('deviceready');
        this.pushNotification();
    },

    // Update DOM on a Received Event
    receivedEvent: function(id) {
        var parentElement = document.getElementById(id);
        var listeningElement = parentElement.querySelector('.listening');
        var receivedElement = parentElement.querySelector('.received');
        listeningElement.setAttribute('style', 'display:none;');
        receivedElement.setAttribute('style', 'display:block;');
        console.log('Received Event: ' + id);
    },
    pushNotification: function(){
      FCMPlugin.onNotification(function(data){
        if(data.wasTapped){
          alert(JSON.stringify(data));
        }else{
          alert(JSON.stringify(data));
        }
      });
    }
};

app.initialize();

{% endhighlight %}

Esa función es lo único que necesitamos agregar ... por ahora. Para enriquecer más tu aplicación existen más funciones que encuentras en la <a href="https://github.com/fechanique/cordova-plugin-fcm" target="_blank">Documentación del plugin.</a>

Compilamos de nuevo la aplicación en nuestro smartphone.

<br />

## **Probando la aplicación**

Para realizar una prueba simple, utilizaremos una "app" que el plugin nos ofrece dentro de su pagina de github, Ingresa a : <a href="https://cordova-plugin-fcm.appspot.com" target="_blank">https://cordova-plugin-fcm.appspot.com</a>

1. En el primer campo ponemos el Nombre de paquete que usa nuestra aplicación.

2.	En el segundo campo debemos poner el **API KEY** de tu proyecto Firebase, esto lo obtenemos dentro de nuestro proyecto en la consola de Firebase: Ingresa a tu **Proyecto en Firebase** -> click en las opciones de tu aplicación Android -> click en **Configuración** -> Click en la pestaña **CLOUD MESSAGING** -> En el área **CREDENCIALES DEL PROYECTO**, copiar la **CLAVE DE SERVIDOR**.


3.	En el campo Title ponemos lo que queramos, este sera el titulo de la Notificación Push.
4.	En Message pues ponemos el mensaje de la notificación.

Los demás campos no lo llenaremos debido a que solo es una prueba.

En mi caso quedaría algo así:

<img src="/assets/apache-cordova-push-android-fcm/probando-fcm.png" />

Presionamos **SEND**. Si todo salio bien, deberíamos obtener el mensaje:

<img src="/assets/apache-cordova-push-android-fcm/notificacion-enviada.png" width="300" style="margin:0 auto;"/>

Y en la aplicación veríamos lo siguiente:

<div>
	<img src="/assets/apache-cordova-push-android-fcm/recibido-1.jpg" width="300" style="float:left;"/>
	<img src="/assets/apache-cordova-push-android-fcm/recibido-2.jpg" width="300" style="float:right;"/>
	<div style="clear:both;"></div>
</div>

<br />

La prueba de arriba fue cuando la aplicación estaba cerrada. 

**SI, LAS NOTIFICACIONES PUSH IGUAL DEBEN LLEGAR CUANDO LA APLICACION ESTA CERRADA.**

Ok pero que pasa cuando estamos dentro de la aplicación ??? ... pues esto:


<div>
	<img src="/assets/apache-cordova-push-android-fcm/fuera-app-android.jpg" width="300" style="float:left;"/>
	<img src="/assets/apache-cordova-push-android-fcm/dentro-app-android.jpg" width="300" style="float:right;"/>
	<div style="clear:both;"></div>
</div>

<br />
Recuerdan el trozo de codigo que adicionamos en index.js, Pues esto es lo que hace. Si presionamos la notificación push que llego desde la barra de notificaciones mostrara la segunda imagen, si estamos dentro de la aplicación y llega la notificación push se mostrara la primera imagen ... Lo importante que quería mostrar es que la información que llega de la notificación se puede "parsear" en un JSON y utilizarlo de la manera que nuestra aplicación lo necesite.


**Pues bien !!! Funciona !!!**

Y ahora ???

Verán, En la realidad para que una notificación llegue a los móviles, debe haber un "Disparador Del Evento". 
El **Back-end** de una aplicación sera quien sea el "Disparador". Como existen muchos lenguajes para back-end (Php, Java, Python), Y no puedo hacer un tutorial para cada uno. Pues te doy 1 consejo:

{% highlight ruby %}
Utiliza REST API. En la documentación del plugin encontraras mas información
{% endhighlight %}

Personalmente lo probé con un back-end hecho en PHP y otro en JAVA, Todo funciona perfectamente.

Y bien, Eso es todo !!!

Cualquier duda o consulta, en los comentarios por favor.

