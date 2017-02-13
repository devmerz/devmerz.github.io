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

A continuación, escribiré un parche temporal y por supuesto la solucion para este problema.


<br/>

# **Porque ocurre esto ???**

**Apache Cordova no permite llamadas HTTPS a servidores con certificados SSL no confiables instalados en ellos.**


Esto tambien ocurre cuando tienes un **certificado SSL autogenerado** instalado en tu servidor.

<br/>

# **Parche temporal para Android**
Como siempre esto es un parche momentaneo y les recomiendo que solo lo usen para pruebas, no para la aplicación final.

Abre el archivo:

**“/cordova/platforms/android/CordovaLib/src/org/apache/cordova/engine/S‌​ystemWebViewClient.j‌​ava”**

Busca el método **onReceivedSslError** y dentro encontrarás un codigo similar a :

{% highlight java %}
try {
    appInfo = pm.getApplicationInfo(packageName, PackageManager.GET_META_DATA);
    if ((appInfo.flags & ApplicationInfo.FLAG_DEBUGGABLE) != 0) {
        // debug = true
        handler.proceed();
        return;
    } else {
        // debug = false
        super.onReceivedSslError(view, handler, error);
    }
} catch (NameNotFoundException e) {
    // When it doubt, lock it out!
    super.onReceivedSslError(view, handler, error);
}
{% endhighlight %}

Debes modificar este método, quedando asi :
{% highlight java %}
try {
    appInfo = pm.getApplicationInfo(packageName, PackageManager.GET_META_DATA);
    handler.proceed();

    return;

} catch (NameNotFoundException e) {
    super.onReceivedSslError(view, handler, error);
}
{% endhighlight %}


Eso es todo, con ese cambio estamos ignorando la validacion de seguridad hacia servidores con **certificados SSL autofirmado** o emitidos por **autoridades certificadoras que no son de confianza**.

**Utilizado solo para realizar pruebas !!!**

<br/>

# **La solución**
Pues la solucion es bastante simple. Instala en tu servidor un **Certificado SSL válido** emitido por una entidad **Certificadora de confianza**.

Aqui tienes una : <a href="https://amielynjunryl.wordpress.com/2014/03/01/list-of-well-known-ssl-certificate-provider/" target="_blank">lista de entidades que te pueden proporcionar un certificado SSL confiable, compatible con Android e iOS</a>


<br/>

# **Articulos en StackOverflow relacionados**

Si sabes ingles, estos articulos te pueden ser de mucha ayuda :)

<ol>
	<li>
		<a href="http://stackoverflow.com/questions/20036260/phonegap-android-app-ajax-requests-to-https-fail-with-status-0" target="_blank">Phonegap android app ajax requests to https fail with status 0</a>

	</li>

	<li>
		<a href="http://stackoverflow.com/questions/32148646/in-cordova-on-android-app-requests-with-https-fail-but-same-request-using-http-s" target="_blank">In cordova on android app requests with https fail but same request using http succeed</a>
		
	</li>
		
</ol>