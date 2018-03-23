Sub Extraer_Datos_Arbol_XML( ref xml_string, var etiqueta_a_buscar: a50 ) 
    
    //Transformar palabra a buscar por etiqueta:

    var busqueda_de_etiqueta: a50
    Format busqueda_de_etiqueta as "<", etiqueta_a_buscar, ">"

    var lista_palabra_a_buscar[ Len(busqueda_de_etiqueta) ]: A10// descomposicion de palabra a buscar en arreglo
    var counterPalabra: n4

    //for para llenar el array con las letras de la PALABRA A BUSCAR
    For counterPalabra = 1 To Len(busqueda_de_etiqueta)
        lista_palabra_a_buscar[ counterPalabra ] = Mid(busqueda_de_etiqueta, counterPalabra, 1)
    EndFor

    var busqueda_de_etiqueta_cierre: a50
    Format busqueda_de_etiqueta_cierre as "</", etiqueta_a_buscar, ">"

    var lista_palabra_a_buscar_cierre[ Len(busqueda_de_etiqueta_cierre) ]: A10// descomposicion de palabra a buscar en arreglo
    var counterPalabraCierre: n4

    //for para llenar el array con las letras de la PALABRA A BUSCAR
    For counterPalabraCierre = 1 To Len(busqueda_de_etiqueta_cierre)
        lista_palabra_a_buscar_cierre[ counterPalabraCierre ] = Mid(busqueda_de_etiqueta_cierre, counterPalabraCierre, 1)
    EndFor


    // Variables
    var contadorVerificador: n4 = 1
    var buscar_palabraSemi: a50 
    var bool_empieza_busqueda: n1 = 0

    var posicion_primer_etiqueta: n10
    var posicion_etiqueta_cierre: n10 
    var posicion_a_contar: n10
    var bool_cierre: n1 = 0

    var palabra_a_buscar: a50

    var actual_estado: n10
    var valorUno: A50
    var valorDos: A50

    var counter: n4
    var letraperletra: a1

    // Descomponer XML letra por letra
    For counter = 1 To Len(xml_string)
        letraperletra = Mid(xml_string, counter, 1) //lo importante es el counter, es el numero de espacio en el XML

        if bool_cierre = 0 //para buscar el primer array
            if letraperletra = lista_palabra_a_buscar[ contadorVerificador ]
                //
                palabra_a_buscar = busqueda_de_etiqueta
                bool_empieza_busqueda = 1
            endif
        else // buscar el segundo array
            if letraperletra = lista_palabra_a_buscar_cierre[ contadorVerificador ]
                //
                palabra_a_buscar = busqueda_de_etiqueta_cierre
                bool_empieza_busqueda = 1
            endif
        endif

        // La variable bool_empieza_busqueda determina si hay coincidencia con la etiqueta a buscar
        // Si hay coincidencia con el primer caracter, entonces empieza a agregar caracter por caracter
        // hasta formar una palabra con la misma longitud que la etiqueta a buscar.
        if bool_empieza_busqueda = 1

            // para sumar el indice en el arreglo en caso de que sea menor a la longitud de la palabra
            if contadorVerificador < Len(palabra_a_buscar)

                Format buscar_palabraSemi as buscar_palabraSemi, letraperletra
                //infomessage "semi" ,buscar_palabraSemi

                contadorVerificador = contadorVerificador + 1
            
            else // si llega al limite la longitud de la palabra
            
                //comparara el semi con la busqueda
                Format buscar_palabraSemi as buscar_palabraSemi, letraperletra // palabra final armada caracter por caracter
                //infomessage "semi last", buscar_palabraSemi

                // Compara si la etiqueta es igual a la palabra formada de caracter por caracter
                if buscar_palabraSemi = palabra_a_buscar 
                    if bool_cierre = 0
                        posicion_primer_etiqueta = counter + 1 //saber a donde va a cortar
                        
                        bool_cierre = 1
                        ClearArray lista_palabra_a_buscar
                        //infomessage "primer resultado tangible",Mid(xml_string,posicion_primer_etiqueta,20)
                    else
                        posicion_etiqueta_cierre = counter - Len(buscar_palabraSemi)

                        posicion_a_contar = (posicion_etiqueta_cierre+1) - posicion_primer_etiqueta

                        ClearArray lista_palabra_a_buscar_cierre
                        //infomessage "segundo resultado tangible",Mid(xml_string,posicion_primer_etiqueta,posicion_a_contar)
                    
                    ///////////////////
                        //DatoXML es el valor del resultado que se esta buscando, 
                        // - el valor en medio de los tags -
                        DatoXML = Mid(xml_string,posicion_primer_etiqueta,posicion_a_contar)
                        //infomessage "DatoXML", Mid(DatoXML, 1, 80)
                    //////////////////
                    endif

                    
                    buscar_palabraSemi = ""
                    bool_empieza_busqueda = 0
                    contadorVerificador = 1

                    ///
                    //otra vez se inicia el ciclo pero ahora para la etiqueta de cierre
                    ///

                else
                
                ////////////
                    // para descartar que haya encontrado dos o mas "<" en una misma oracion
                    // en caso de haber dos o mas "<", volvera a buscar desde ese punto + 1
                    actual_estado = counter - (Len(buscar_palabraSemi)-1)
                    
                    //infomessage "actual_estado", Mid( xml_string,actual_estado, Len(buscar_palabraSemi) )

                    Split buscar_palabraSemi, "<", valorUno, valorDos
                    
                    if Len(valorDos) < (Len(buscar_palabraSemi)-1)
                        //infomessage "aqui esta el pex"
                        counter = actual_estado
                    endif
                /////////////////


                    buscar_palabraSemi = ""
                    bool_empieza_busqueda = 0
                    contadorVerificador = 1
                endif
            endif
        endif

    EndFor
    //infomessage "termino el for wey", letraperletra
EndSub
