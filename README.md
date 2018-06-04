# Extraer-Datos-XML-Micros-POS
Clase para extraer datos de un string en forma de XML, para el POS Micros 3700

# Modo de uso
- Extraer_Datos_Arbol_XML( ref xml_string, var etiqueta_a_buscar: a50 ) 

Método invocado desde otra parte del código para obtener el cuerpo de una etiqueta en un XML

Nota: si se tienen 2 o más nombre de etiquetas iguales, sólo obtendrá el cuerpo de la primer etiqueta.

- Extraer_Datos_Arbol_Array_XML( var xml_string_array: a10000, var etiqueta_a_buscar_single: a50 )

Método invocado desde otra parte del código para obtener el cuerpo de una etiqueta en un XML; esta etiqueta estaría dentro de un array.
Ejemplo: <hola><mundo>1</mundo><mundo>2</mundo></hola>

Nota: para poder usar este método, desde otra parte del código se debe crear un array con el número de items, según se esperen, ejemplo:
var Array_Item[5]               : A100
    Array_Item[1]                      = "" 
    Array_Item[2]                      = "" 
    Array_Item[3]                      = "" 
    Array_Item[4]                      = "" 
    Array_Item[5]                      = ""
    
En este ejemplo sólo esperamos 5 items.
