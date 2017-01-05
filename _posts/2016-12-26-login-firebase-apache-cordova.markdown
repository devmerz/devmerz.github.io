---
layout: post
title: Login con Firebase y Apache Cordova
categories: login firebase console apache cordova android
permalink: :title
---

Firebase es la mejorada plataforma de desarrollo móvil en la nube de Google. Se trata de una plataforma disponible para diferentes plataformas (Android, iOS, web).

Uno de los servicios que provee Firebase es el de Autenticacion sin necesidad en un "backend", La logica del backend se lo puede controlar a travez de la consola de firebase.

Realizaremos una simple aplicacion que permita a los usuarios:

- Hacer login en la aplicacion
- Registrar nuevos usuarios



## Crear y configurar un proyecto en Firebase

Para poder utilizar este servicio debemos crear un proyecto(en la consola de firebase). Para ellos nos dirigimos a <a href="https://console.firebase.google.com" target="_blank">console.firebase.google.com</a>.

1. Le damos click al boton "CREAR NUEVO PROYECTO"
2. Le asignamos un "Nombre del proyecto" y una "Región"
3. "CREAR PROYECTO"

<img src="/assets/login-firebase/FirebaseConsole.png" />


Una vez dentro del proyecto:

1. Nos dirigimos a la opcion "Authentication" en el menu lateral.
2. Vamos a la opcion "METODO DE INICIO DE SESION"
3. Habilitamos la opcion de inicio de sesion con "Correo electronico/contrasena"
4. Guardar

<img src="/assets/login-firebase/FirebaseConsoleConfiguracion.png" />


Perfecto !!!

Dentro de la misma pantalla nos dirigimos al tab "USUARIOS", añadiremos un usuario de prueba.
<img src="/assets/login-firebase/FirebaseConsoleNuevoUsuario.png" />


## Crear un nuevo proyecto Cordova

{% highlight ruby %}
cordova create LoginFirebase com.devmerz.loginfirebase LoginFirebase
cd LoginFirebase
cordova platform add browser
{% endhighlight %}

## Adicionando Firebase a nuestro proyecto

Dentro del archivo index.js que se nos creó por defecto adicionaremos el codigo necesario para que las funciones de firebase funcionen.

Dentro de la consola de Firebase, Debemos ir al area de configuracion del proyecto y buscar el area "Añade Firebase a tu aplicación web", esta opcion te generará algo similar a esto:

{% highlight javascript %}
<script src="https://www.gstatic.com/firebasejs/3.6.4/firebase.js"></script>
<script>
  // Initialize Firebase
  var config = {
    apiKey: "AIzaSyAq3COznvLM0rDSuuQUkW9PY3S4VxzAwNM",
    authDomain: "login-con-firebase-y-cordova.firebaseapp.com",
    databaseURL: "https://login-con-firebase-y-cordova.firebaseio.com",
    storageBucket: "login-con-firebase-y-cordova.appspot.com",
    messagingSenderId: "461793064207"
  };
  firebase.initializeApp(config);
</script>
{% endhighlight %}


1. El primer **script** debe ir dentro de **index.html**.

2. El **contenido** del segundo script debe ir dentro de la funcion "receivedEvent", que se encuentra en el archivo **index.js**

3. Para facilitar las cosas adicionamos Jquery al proyecto cordova.


Ahora creamos un archivo **funciones.js** donde estarán nuestran funciones, la primera funcion que crearemos sera **login()** , esta funcion simplemente verificará que un usuario es valido en Firebase.

{% highlight ruby %}
function login(){
    firebase.auth().signInWithEmailAndPassword($("#email").val(), $("#password").val()).catch(function(error) {
      var errorCode = error.code;
      var errorMessage = error.message;
      console.warn(errorMessage);
    });
};
{% endhighlight %}

Dentro de **index.html** crearemos un formulario simple (email, contraseña). y al boton "VERIFICAR USUARIO" de la aplicacion le adicionamos la siguiente funcion **onclick="login()"**

<img src="/assets/login-firebase/LoginAndroid.png" style="width:250px;"/>


