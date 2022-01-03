# FlexProject-UGR

------

## Objetivo

Proyecto en C++, usando Flex para la asignatura Modelos de Computación UGR. El programa se conecta a los datos sobre el Covid de la Junta de Andalucía y organiza la información en vectores, siguiendo una serie de reglas léxicas, para una mayor facilidad de consulta para el usuario.

## Compilación

Una vez descargado el repositorio, para la compilación del programa, solo hace falta ejecutar

```bash
make
```

Debes asegurarte de tener **g++** y **flex** instalados en tu dispositivo.

En cualquier momento puedes eliminar los archivos resultantes de la compilación con

```bash
make clean
```

## Ejecución

Una vez compilado, podemos ejecutar el programa con 

```bash
./CoronaVirusBase
```

Puede ser que necesites darle permisos de ejecución. Para ello usa

```bash
chmod +x CoronaVirusBase
```

## Funcionamiento

El programa descarga una tabla de datos, en formato html, a través de una petición a la página web de la junta de Andalucía (https://www.juntadeandalucia.es/institutodeestadisticaycartografia/badea/operaciones/consulta/anual/42798?CodOper=b3_2314&codConsulta=42798). Al comenzar el programa, este pregunta al usuario si desea descargar dicha tabla. En caso afirmativo, el programa procederá su ejecución. En otro caso, aborta.

Las opciones disponibles para el usuario son:

| Opción                | Funcionamiento                                               |
| --------------------- | ------------------------------------------------------------ |
| 1) Lista de Distritos | Muestra todos los Distritos Sanitarios disponibles, junto a un identificador |
| 2) Elegir Distrito    | El usuario debe introducir el identificador del distrito (número asociado) para visualizar los datos sobre el mismo |
| 3) Borrar html        | Elimina la tabla html descargada previamente                 |
| 4) Limpiar terminal   | Ejecuta un system("clean") para limpiar la terminal          |
| 5) Salir              |                                                              |

