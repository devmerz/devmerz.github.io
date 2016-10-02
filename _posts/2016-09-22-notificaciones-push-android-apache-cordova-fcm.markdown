---
layout: post
title: Notificaciones Push en Android con Apache Cordova y FCM (Firebase Cloud Messaging)
categories: apache cordova android notificaciones push fcm gcm Firebase Cloud Messaging
permalink: :title
---

En el siguiente articulo usted aprendera como Configurar un Proyecto en Console Developers Google y Firebase Google Cloud Messaging para enviar notificaciones PUSH a dispositivos Android, a traves de FCM.


**Crear un nuevo proyecto**

- Nos dirigimos a [Console Developers Google](https://console.developers.google.com/)

- Click en la opcion **Crear proyecto**.

- Nos pedira un nombre para nuestro proyecto, en nuestro caso se llamara **Notificacion push android fcm**, Creamos el proyecto.


<img src="/assets/apache-cordova-push-android-fcm/crear-proyecto notificaciones-push-android.png" />

**Firebase Cloud Messaging**

En el menu aparece la opcion Biblioteca. le damos click a **Google Cloud Messaging**. Esto nos llevara a la pagina de firebase de google.

<img src="/assets/apache-cordova-push-android-fcm/habilitando-fcm.png" />

El enlace nos llevara a [Firebase Google Cloud Messaging](https://firebase.google.com/docs/cloud-messaging/)

Ahora debemos **Ir a la consola**, que se encuentra en la esquina superios derecha.
<img src="/assets/apache-cordova-push-android-fcm/ir-a-la-consola.png" />


**Crear el proyecto en Firebase Console**

- Click en el boton **CREAR NUEVO PROYECTO**
- Nos pedira los siguientes campos **Nombre del proyecto** y **Pais/Region**

<img src="/assets/apache-cordova-push-android-fcm/nuevo-proyecto-fcm.png" />

Entonces el proyecto fue creado. y seremos redigidos a la siguiente pantalla:

<img src="/assets/apache-cordova-push-android-fcm/anade-firebase-a-tu-proyecto.png" />

- Click en: Añade Firebase a tu aplicacion de Android.
- En la pantalla que aparecera introducimos el Nombre del paquete (Package Name) de la aplicacion, en mi caso creare el APP con el package name igual a com.miappfcm.app.
- Click en Añadir Aplicacion.

<img src="/assets/apache-cordova-push-android-fcm/generando-el-json.png" />

**Descarga del archivo google-services.json**

Dando click en Añadir Aplicacion, se descargara un archivo llamado google-services.json. Este archivo contiene toda la informacion de nuestro proyecto(Google Firebase) y tambien nos ayudara a que el dispositivo pueda recibir las notificaciones.

Este archivo debemos ponerlo en la siguiente direccion del proyecto.


{% highlight ruby %}
MiApp/platforms/android/google-services.json
{% endhighlight %}


**Creando el Proyecto, Adicionando plataforma Android, Instalando plugin FCM**

{% highlight ruby %}
cordova create MiApp com.miappfcm.app MiAppPushFCM
cd MiAppPushFCM
cordova platform add android
cordova plugin add cordova-plugin-fcm
{% endhighlight %}

NO LO OLVIDES !!! El Package Name es : com.miappfcm.app y debes mover el archivo google-services.json a la direccion indicada mas arriba.

El repositorio del plugin que utilizaremos es [Cordova plugin FCM](https://github.com/fechanique/cordova-plugin-fcm)



**Probando la aplicacion**

Para la prueba simplemente utilizaremos POSTMAN.

Completando tutorial ... 
Si necesitas ayuda urgente, comenta, contactame.
