# JEFA

Un lenguaje para autómatas, expresiones regulares y más.


## Construccion:
-----------------------------

Es posible construir el proyecto con

```sh
$ make
```
Esto generara un binario llamado "jefa" que sera utilizado para compilar los programas

## Compilacion y Ejecución de los programas:
----------------------------------

Debe estar el binario "jefa" presente en el directorio actual.
Debe setear una variable de entorno JEFA con el path al .jar de la 
libreria de automatas.
Una vez realizado lo anterior, podra compilar sus programas con la ayuda del script "compile"
incluido en el directorio raiz del presente repositorio, de la siguiente manera:
```sh
$ sh compile ./path/a/su/programa
```
Lo anterior generara un archivo Main.class.
Para ejecutar su programa facilitamos otro script de ayuda "run" que tambien estara
disponible en el directorio raiz. Para utilizarlo ejecute:
```sh
$ sh run
```

## Requerimientos
----------------------------

- Libreria dk.brics.automaton con licencia MIT disponible en: <https://github.com/cs-au-dk/dk.brics.automaton>

## Ubicacion de los materiales
----------------------------
* Informe TPE: Se encuentra en la raiz del proyecto con el nombre: "Informe TPE.pdf"
* Programas ejemplo: Se encuentran en la carpeta ejemplos
* Los scripts de ayuda "compiler" y "run" se encuentran en la raiz del proyecto

## Graficador de automatas
-----------------------------
Es posible graficar los archivos .dot generados en sus programas por la utilizacion de la instruccion graph <automata>
mediante GraphViz disponible en <https://www.graphviz.org/>. Ejemplo:

```sh
$ dot -Tpng graph.dot -o graph.png
```

El comando anterior genera un archivo en formato png llamado graph.png a partir del archivo en formato dot llamado graph.dot

## Autores
-----------------------------

* **Francisco Perez Sammartino**
* **Agustin Lavarello**
* **Julian Palacci**
* **Esteban Kramer**
