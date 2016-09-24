---
layout: post
title: Notificaciones Push en Android con Apache Cordova y FCM
categories: apache cordova android notificaciones push fcm gcm
permalink: :title
---


Aproximadamente en Junio del 2016, Google dejo obsoleto en envio de notificaciones push a dispositivos android via GCM. Y puso en vigencia el servicio FCM (Firebase Cloud Messaging), que realiza la misma labor (y puede hacer muchas cosas mas).

Lo primero que debemos hacer es conseguir el API KEY para poder hacer que las notificaciones funcionen en Android.

**Crear un proyecto**

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


**Añade firebase a tu aplicacion android**

OK !!!, Antes de continuar debemos crear la aplicacion android porque necesitaremos el 
**Package Name**. 



 Ahora le damos click a la opcion Anade firebase a tu aplicacion android

PONER IMAGEN 5 AQUI



**Pero Antes !!!**

Antes de continuar debemos generar la aplicacion con Apache Cordova, debido que necesitaremos el nombre del paquete de la aplicacion. Entonces procedemos a crearla.