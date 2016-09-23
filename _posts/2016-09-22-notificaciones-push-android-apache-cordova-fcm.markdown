---
layout: post
title: Notificaciones Push en Android con Apache Cordova y FCM
categories: apache cordova android notificaciones push fcm gcm
permalink: :title
---


Aproximadamente en Junio del 2016, Google dejo obsoleto en envio de notificaciones push a dispositivos android via GCM.

Y puso en vigencia el servicio FCM, que realiza la misma labor, pero ahora hace uso de Firebase.


Lo primero que debemos hacer es conseguir el API KEY para poder hacer que las notificaciones funcionen en Android.

**Crear un proyecto**

Nos dirigimos a https://console.developers.google.com/
Buscamos la opcion **Crear proyecto** y le damos click.



Nos pedira un nombre para nuestro proyecto. Le damos Aceptar

**FCM**
En el menu aparece la opcion Biblioteca. le damos click a Google Cloud Messaging. Esto nos llevara a la pagina de firebase de google.

En la esquina superior derecha dar click en la opcion **Ir a la consola**.

PONER IMAGEN 3 AQUI

Necesitamos los siguientes campos:
Nombre del proyecto:
Pais/Region

PONER IMAGEN 4 AQUI


entonces el proyecto fue creado , Ahora le damos click a la opcion Anade firebase a tu aplicacion android

PONER IMAGEN 5 AQUI



**Pero Antes !!!**

Antes de continuar debemos generar la aplicacion con Apache Cordova, debido que necesitaremos el nombre del paquete de la aplicacion. Entonces procedemos a crearla.