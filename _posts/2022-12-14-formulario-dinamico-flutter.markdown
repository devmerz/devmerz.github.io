---
layout: post
title: Formulario (Textfield) dinámico en Flutter
categories: formulario dinámico flutter textfield
permalink: :title
---


A continuación vamos a hacer la funcionalidad de crear y eliminar **TextField** dinámicamente, por su puesto también esta funcionalidad implica que cada **Textfield** mantenga su valor y nos permita recuperarlo más adelante:

<div class="contenedor-imagen">
    <img src="/assets/formulario-dinamico-flutter/formulario-dinamico-flutter.png">
</div>
<br/>

Comencemos!

Vamos a crear una clase para representar el formulario (a partir de ahora le llamaré formulario porque podría tener más campos, por ahora solo tendrá uno) ... en este caso mi formulario solo tendra un campo que se llamará **_name**, Si tu formulario tiene mas campos puedes crear nuevos atributos (y sus respectivos Getters) en esta clase:

{% highlight java %}
class BasicForm {
  final TextEditingController _name = TextEditingController();

  // Getter
  TextEditingController get name => _name;
}
{% endhighlight %}



Ahora vamos a crear una lista de tipo **BasicForm**:
{% highlight java %}
final List<BasicForm> _arrBasicForm = [];
{% endhighlight %}


Definimos tres funciones:
- La primera será para adicionar un formulario al array de formularios. 
- La segunda función la usaremos para mostrar los valores actuales que tiene el array(en este caso solo lo mostraremos por consola). 
- Y la tercera función sera para eliminar 1 formulario del array de formularios

{% highlight java %}
void _add() {
    setState(() {
      _arrBasicForm.add(BasicForm());
    });
}

void _get() {
    for (var i = 0; i < _arrBasicForm.length; i++) {
        print(_arrBasicForm[i].name.text);
    }
}

void _remove(int index) {
    setState(() {
      _arrBasicForm.removeAt(index);
    });
}
{% endhighlight %}

Para la UI haremos uso de un **ListView.builder** que recorrerá el array y por cada **BasicForm** retornará un Widget que tendrá un **TextField** y un boton de eliminar:

{% highlight java %}
ListView.builder(
    itemCount: _arrBasicForm.length,
    itemBuilder: (BuildContext context, int index) {
    return Row(children: [
        Expanded(
            flex: 4,
            child: TextField(controller: _arrBasicForm[index].name)),
        Expanded(
            flex: 2,
            child: ElevatedButton.icon(
            onPressed: () => _remove(index),
            icon: const Icon(Icons.delete),
            label: const Text('Borrar'),
            ))
    ]);
    },
)
{% endhighlight %}


Ahora simplemente hacemos correr la aplicacion y podremos ver lo siguiente:


<div class="contenedor-imagen">
    <img src="/assets/formulario-dinamico-flutter/formulario-dinamico-flutter-textfield.png">
</div>
<br/>
El botón al lado del + sirve para mostrar el valor de los **TextField** actuales en la consola.