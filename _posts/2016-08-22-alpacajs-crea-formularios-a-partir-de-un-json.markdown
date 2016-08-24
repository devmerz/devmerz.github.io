---
layout: post
title: AlpacaJS. Crea formularios a partir de un JSON
categories: crear formulario dinamicamente json alpacajs
permalink: :title
---


AlpacaJS es una libreria que te permite generar formularios a partir de estructuras JSON, recuperar los valores de dichos campos e interactuar con el usuario (Validacion por tipo de campo). Una libreria bastante util a la hora de crear formularios dinamicamente.


**Instalacion y uso**

AlpacaJS requiere de las siguientes librerias:

* Jquery
* Boostrap
* Handlebar

Adicionamos estas librerias en la cabecera de nuestro archivo .html
{% highlight html %}
 <!-- Librerias CSS-->
<link type="text/css" rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
<link type="text/css" href="http://code.cloudcms.com/alpaca/1.5.17/bootstrap/alpaca.min.css" rel="stylesheet" />
 <!-- Librerias Javascript-->
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.3/handlebars.js"></script>
<script type="text/javascript" src="http://code.cloudcms.com/alpaca/1.5.17/bootstrap/alpaca.min.js"></script>
{% endhighlight %}


**Estructura basica del JSON**

**Ejemplos**

En los siguientes ejemplos hago uso de las librerias requeridas a travez de CDN, asi que procura estar conectado a internet para poder probarlas.

**Ejemplo 1**
{% highlight html %}
<html>
    <head>
        <link type="text/css" rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
        <link type="text/css" href="http://code.cloudcms.com/alpaca/1.5.17/bootstrap/alpaca.min.css" rel="stylesheet" />
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
        <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.3/handlebars.js"></script>
        <script type="text/javascript" src="http://code.cloudcms.com/alpaca/1.5.17/bootstrap/alpaca.min.js"></script>
    </head>
    <body>
        <div id="form"></div>
        <script type="text/javascript">
        	$(document).ready(function() {
                $("#form").alpaca({
                    "data": {
                        "nombre": "",
                        "comentario": ""
                    },
                    "schema": {
                        "title":"Formulario 1",
                        "type":"object",
                        "properties": {
                            "nombre": {
                                "type":"string",
                                "title":"Nombre",
                                "required":true
                            },
                            "comentario": {
                                "type":"string",
                                "title":"Comentarios"
                            }
                        }
                    },
                    "options": {
                        "fields": {
                            "nombre": {
                            },
                            "comentario" : {
                                "type": "textarea",
                                "rows": 5,
                                "cols": 40,
                            }
                        }
                    },
                    "view" : "bootstrap-edit"
                });
            });
        </script>
    </body>
</html>
{% endhighlight %}
El anterior ejemplo generara un formulario con 2 campos, un input y un textarea, el primero es requerido. Pruebalo !!!.

**Ejemplo 2**
{% highlight html %}
 in progress...
{% endhighlight %}
**Ejemplo 3**
{% highlight html %}
 in progress...
{% endhighlight %}


Personalmente la libreria me dejo un buen sabor de boca, es muy facil de implementar y da resultados bastante buenos. Aunque encontre pequenos bugs en los campos mas complejos que todavia se encuentran solucionando los desarrolladores, pero tranquilos no es nada para alarmarse.

En el caso de que desees hacer un formulario super complejo, tambien tiene disponible un "[Form builder](http://www.alpacajs.org/demos/form-builder/form-builder.html)" que te permite construir un json desde un entorno grafico.

