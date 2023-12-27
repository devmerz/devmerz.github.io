---
layout: post
title: "Probando las Instancias Reservadas de EC2 - AWS"
date: 2023-12-23 12:23:11 -0400
categories: aws ec2
---

Despues de probar la [instancia más económica de EC2](https://devmerz.github.io/probando-instancia-ec2-mas-economica-aws-t4gnano){:target="\_blank"} que aws nos puede ofrecer me decidí por ir un poco mas allá y ver cuando más se pueden abaratar costos. Hoy vamos a hablar de las [Instancias Reservadas](https://aws.amazon.com/es/ec2/pricing/reserved-instances/){:target="\_blank"} que basicamente son:

![Que es una instancia reservada](/assets/probando-aws-instancias-reservadas-ec2/que-es-intancia-reservada-aws.png "Que es una instancia reservada")

Como dice en la descripción, Las instancias reservadas **proporcionan un descuento**.

## Como comprar una Instancia Reservada EC2

Primero debes acceder a la consola de AWS, Ir al servicio de EC2, En el menú de la izquierda selecciona `Instancias Reservadas`y presiona el botón `Comprar instancias reservadas`, Luego se te desplegará un modal como este:

![instancia reservada](/assets/probando-aws-instancias-reservadas-ec2/instancias-reservadas.png "instancia reservada")

Donde podrás elegir las caracteristicas que quieres usar en tu instancia EC2. Teniendo las siguientes opciones:

- Sistema Operativo
- Zona de disponibilidad
- Tenencia
- Clase de oferta
- Tipo de instancia
- El tiempo el cuál tendrás el descuento
- Modalida de paga

Selecciona estos campos ya depende de tus necesidades, En mi caso yo elegí con las siguiente configuraciones, presionamos "Search":
![oferta elegida](/assets/probando-aws-instancias-reservadas-ec2/oferta-elegida.png "oferta elegida")

Y como puedes ver tengo una oferta donde por 1 año con las especificaciones requeridas me cobrarán 22$. Presta atención a que yo elegi la modalida de pago `All upfront` que significa `pagar los 22$ todo de una sola vez.`

Sobre las demás opciones de pago:

- No upfront: Significa que no pagas nada al inicio y tendrás que pagar mensualmente, pero ese pago **tendrá un descuento** mejor que usar la instancia on-demand.

- Partial upfront: Significa que tendrás que hacer un pago inicial y ademas tendrás que pagar mensualmente, pero ese pago mensual tendrá un descuento mejor que el pago "No upfront"

- All upfront: Significa que haces un pago único con un descuento mejor que "Partial upfront". La mejor oferta suele estar en esta opcion de pago.

Y bueno, Para comprarlo solo lo añades al carrito y pagas, bastante rápido y directo. Después de la compra tardará un poco en estar "Activa". también en el resumen puedes ver la fecha de inicio y fecha de finalización. Durando en mi caso 1 año.
![instancia reservada comprada](/assets/probando-aws-instancias-reservadas-ec2/instancia-reservada-comprada.png "instancia reservada comprada")

### ¿Y ahora, como se usa?

Esto fue dificil de entender para mi porque yo pensaba que habia una instancia especial llamada "t4g.nano Instancia reservada" o algo asi, Pero no.

Para usarlo solo debes levantar una instancia del **tipo**, **zona de disponibilidad** y **tenencia** que tu elegiste en el form de arriba. Eso es todo. Automaticamente esa instancia tendrá el descuento que AWS promete. En mi caso como yo pague todo por adelantado, entonces no pagaré nada más por esa instancia EC2 durante el año.

### On-demand vs Instancia reservada

Hagamos un poco de matemáticas para ver cuanto me saldría la misma instancia usando On-demand vs Instancia Reservada.

**Usando On-demand**: La instancia t4g.nano cuesta 0.0042 \* hora. En promedio un mes tiene 724 horas. Tendriamos un gasto de aprox 3$ por mes. Entonces tendriamos un gasto de 36$ anual.

**Usando Instancia reservada**: El gasto anual será de 22$

`36$ - 22$ = 14$`

Tenemos 14$ de ahorro que se pueden invertir en otro servicios como Route54 o más almacenamiento usando EBS o s3.

#### ¿Y si levanto 2 instancias con las mismas caracteristicas?

Una de ellas tendrá descuento de Instancia Reservada y la otra no.

#### ¿Hay algún costo extra al comprar la instancia bajo la opción de paga "All Upfront"?

No, no hubo más cobros de la intancia EC2, Solo 22$. Pero toma en cuenta que: El descuento solo afectá a la instancia EC2, **no a su almacenamiento (SSD)**.

En mi caso mi instancia EC2 usa un EBS de 8GB. Su costo actual es de: `0.08$ per GB-mes`, Entonces por mes deberiamos pagar `8 * 0.08 = 0.64$`, Teniendo un gasto de `0.64 * 12 = 7.68$` por año.

En los cálculos que hicimos más arriba nos sobraba 14$ del descuento que tranquilamente se puede ir al almacenamiento EBS o a otro servicio.

### Conclusión

Haciendo calculos si se nota el descuento proporcionados por las "instancias reservadas". Toma en cuenta que yo estoy haciendo los calculos en una instancia muy muy pequeña, en instancias más grandes el descuento sí debe marcar una gran diferencia de ahorro.
