---
layout: post
title: Probando la instancia EC2 de tipo t4g.nano ¿Da buen rendimiento?
categories: instancia ec2 barato ecomomico barato blog t4g t4gnano
permalink: :title
---

Desde hace tiempo vengo a buscando un servidor de pruebas que me brinde buena potencia y bajo costo para tenerlo corriendo las 24 horas. Mientras investigaba me encuentro que **AWS** ofrece un tipo de instancias **EC2** que usa la arquitectura **ARM** y que te brindan **buen rendimiento** a **bajo costo**, Este tipo de instancias se llaman **T4g**:


<div class="contenedor-imagen">
    <img src="/assets/ec2-t4g/t4g.png" width="70%">
</div>
<br/>

Para probar el rendimiento de estos servidores se me ocurrió la idea de levantar un pequeño blog y ver como es su comportamiento en general en:
- Instalación de software
- Rendimiento para el admin y para el usuario
- Velocidad de respuesta
- Rendimiento corriendo contenedores docker

Tú sabes, Lo normal para poder trabajar sin ser ralentizado por temas del server.

Para este ejemplo voy a hacer uso de instancia llamada **t4g.nano**(la más básica de esta familia) que tiene un costo de **0.0042$ por hora**. Mensualmente nos costaría aprox **3$** por mes. Vamos a proceder creando la instancia EC2 con las siguientes configuraciones:


<div class="contenedor-imagen">
    <img src="/assets/ec2-t4g/arquitectura-arm.png" width="70%">
</div>
<br/>
<div class="contenedor-imagen">
    <img src="/assets/ec2-t4g/t4g-nano.png" width="70%">
</div>
<br/>

También vamos a permitir el tráfico desde cualquier lugar de internet via ssh, http y https:
<br/>
<br/>
<div class="contenedor-imagen">
    <img src="/assets/ec2-t4g/trafico-internet-ec2.png" width="70%">
</div>
<br/>

Es lo único que vamos a personalizar, todo las demás opciones las dejamos por defecto.


Para levantar el blog vamos a elegir wordpress ya que es una solución común para blogs, En mi caso lo voy a levantar usando **docker** con **docker-compose**. Voy a hacer uso de un archivo docker-compose.yml para levantar 2 servicio. Uno de MariaDB y otro de Wordpress:


{% highlight yml %}
version: '3'
    services:
    wordpress:
        image: wordpress
        links:
        - 'mariadb:mysql'
        environment:
        - WORDPRESS_DB_PASSWORD=password
        - WORDPRESS_DB_USER=root
        ports:
        - '80:80'
        volumes:
        - './html:/var/www/html'
    mariadb:
        image: mariadb
        environment:
        - MYSQL_ROOT_PASSWORD=password
        - MYSQL_DATABASE=wordpress
        volumes:
        - './database:/var/lib/mysql'
    volumes:
    data: 
{% endhighlight %}

Esta configuración la conseguí de internet solo para levantar los servicios, no prestes atención al detalle. Wordpress no es el fin de este post.

Levantamos los servicios con el comando:
{% highlight bash %}
docker-compose up -d
{% endhighlight %}


Podemos ver los contenedores que están corriendo ejecutando el comando **docker ps**:
<div class="contenedor-imagen">
    <img src="/assets/ec2-t4g/contenedores-docker.png" />
</div>

Revisamos nuestra ip pública:

<div class="contenedor-imagen">
    <img src="/assets/ec2-t4g/wordpress-instalacion.png" width="80%"/>
</div>
<br/>

Comenzamos con el instalador de wordpress:

<div class="contenedor-imagen">
    <img src="/assets/ec2-t4g/configuracion-wodpress.png" width="50%" />
</div>
<br/>

y voilá:

<div class="contenedor-imagen">
    <img src="/assets/ec2-t4g/wordpress-corriendo.png" width="80%" />
</div>
<br/>

Muy bien, hasta ahora no tuve ningún problema de instalación o rendimiento a la hora de instalar **docker** o **docker-compose**, el servidor fluye de maravilla.

### ¿Y como va el server hasta ahora?
Voy a usar **htop** para ver como va el servidor en cuando a consumo de **RAM** y **procesador**:

<div class="contenedor-imagen">
    <img src="/assets/ec2-t4g/htop.png" width="70%" />
</div>
<br/>


El servidor antes de levantar mis contenedores consume un total de 154Mb de RAM. Con dos contenedores docker corriendo tenemos un consumo de 246Mb de RAM. Me parece bien para la prueba. Aunque considera que si levantas los servicios sin docker podrias ganar un poco de memoria ahí.

<br/>
### ¿Y como responde la página?

Pues bastante bien. El tiempo de respuesta es bastante veloz incluso tomando en cuenta que mi instancia EC2 lo creé en **us-east-1** (Norte de Virginia) y no en Sao Paulo que es el datacenter más cercano a mi posición actual:

<div class="contenedor-imagen">
    <img src="/assets/ec2-t4g/velocidad-blog.gif" width="80%" />
</div>
<br/>
Cabe recalcar que aunque la página tenga muchas imagenes la velocidad de carga sigue siendo bastante buena.

### ¿Cuántas peticiones simultáneas soporta?

Vamos a hacer una pruebas más técnica viendo cuantas peticiones simultáneas soporta nuestro server, Para esto vamos hacer uso de **Apache benchmark**. Lo instalamos y ejecutamos con el comando: 

{% highlight bash %}
ab -n 100 -c 100 http://3.84.109.77/
{% endhighlight %}

Siendo: 
- -n es la cantidad de request que debe hacer en esta sesión
- -c es la cantidad de conexiones simultáneas que debe ejecutar al mismo tiempo


Despues de hacer un rato  de pruebas te puedo comentar que el servidor puede manejar 100 conexiones al mismo tiempo **sin ningun problema**. a partir de 100 conexiones simultáneas al mismo tiempo ya comienza a tener problemas de rendimiento como puedes ver a continuación:

<div class="contenedor-imagen">
    <img src="/assets/ec2-t4g/limite.png" width="70%" />
</div>
<br/>

Pero hey !!!  
Soportar 100 conexiones simultaneas en un server de 3$ que tiene Docker, Wordpress y MariaDB corriendo. Me parece excelente la verdad.



### Probando con 5 contenedores docker

Y que tal si corremos más contenedores docker como una aplicación real que usa la arquitectura de microservicios?

Vamos a probar levantando 5 contenedores que usan: **nginx**, **mysql**, **alpine**, **redis** y **postgres** y veamos que como se comporta el server.

Nota: Para esta prueba he bajado los contenedores del blog. Este es el docker-compose.yml que usaré:

{% highlight yml %}
version: '3'
    services:
    web-app:
        image: nginx:latest
        ports:
        - "80:80"
        networks:
        - my_network

    database:
        image: mysql:latest
        environment:
        MYSQL_ROOT_PASSWORD: root_password
        MYSQL_DATABASE: my_database
        MYSQL_USER: user
        MYSQL_PASSWORD: password
        networks:
        - my_network

    backend-server:
        image: alpine:latest
        command: tail -f /dev/null
        networks:
        - my_network

    cache-server:
        image: redis:latest
        networks:
        - my_network

    postgres-db:
        image: postgres:latest
        environment:
        POSTGRES_USER: user
        POSTGRES_PASSWORD: password
        POSTGRES_DB: my_postgres_db
        networks:
        - my_network

    networks:
    my_network:
        driver: bridge
{% endhighlight %}

Todo levanto sin absolutamente ningun problema, Podemos ver un incremento en el uso de memoria RAM, lo cual era esperado:

<div class="contenedor-imagen">
    <img src="/assets/ec2-t4g/5-contenedores.png" width="70%" />
</div>
<br/>
Podemos ver que tranquilamente podría soportar una aplicación pequeña/mediana que usa la arquitectura de microservicios.

<br/>
### Conclusión

Despues de tener el blog funcionando por dos meses puedo decir que: **Sí, Si vale la pena** las instancias de tipo **t4g** con arquitectura **ARM**. Y que la instancia más económica **t4g.nano** si da buen rendimiento si buscas un server para hacer pruebas o tener algún servicio corriendo ahí.

