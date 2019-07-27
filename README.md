

# tzinm/descargas-bcpt

La creación de este bot se basa en la guía de "[Bot de descargas para NAS Synology](https://telegra.ph/Bot-de-descargas-para-NAS-Synology-10-13)" en la que se explica como aprovechar un bot de telegram para enviar ficheros **.torrent** y **zip** (que contengan ficheros torrent) a nuestro gestor de torrents (Transmission, Deluge, Download Station, etc.).

Este contenedor ha sido creado puesto que la guía no era aplicable para el Sistema Operativo OpenMediaVault y para simplificar los pasos a realizar.



## Parámetros

Para crear este contenedor debemos establecer los siguientes parámetros:

| Parámetro          | Función                                                      |
| ------------------ | ------------------------------------------------------------ |
| -e PUID=           | ID de usuario                                                |
| -e PGID=           | ID de grupo                                                  |
| -e usuario1=       | Se establece el id del usuario de telegram que tendrá permisos para interactuar con el bot. |
| -e token=          | Se establece el token del bot de telegram al que enviaremos el contenido a descargar (.torrent y zip). |
| -v /home/descargas | La ruta donde se almacenará el contenido que enviemos al bot. |

**¿Cómo obtenemos los parámetros que necesitamos?**

- ID de usuario e ID de grupo: para obtener estos datos basta con ejecutar el siguiente comando en una consola. Me consta que algunos Sistemas Operativos con interfaz gráfica además de mostrar el nombre de usuario también muestra su ID, con lo que no sería necesario ejecutar el siguiente comando.

````bash
id nombre_usuario
````

​		Es importante establecer el ID de usuario y el ID de grupo para no tener problemas cuando hacemos 		uso de los volúmenes en Docker.

​		Consultar [aquí](https://medium.com/@nielssj/docker-volumes-and-file-system-permissions-772c1aee23ca) para más información.



- Id de usuario de **Telegram**: para obtener nuestro id de usuario de telegram, utilizaremos el bot [@myidbot](https://t.me/myidbot). Pasos a seguir:

  - Iniciamos el bot
    
    ![Iniciar bot](https://dl.dropboxusercontent.com/s/v30meu6tperge3i/myidbot.png?dl=0)
   
  - Ejecutamos la acción getid

    ![getid](https://dl.dropboxusercontent.com/s/pkiuu4qabzg23p3/getid.png?dl=0)

  - Nos mostrará el id del usuario

    ![myid](https://dl.dropboxusercontent.com/s/lcg62ruhrb7wr76/idtzinm.png?dl=0)

- Token del bot: lo primero que debemos hacer es iniciar una conversación con el bot [@BotFather](https://t.me/BotFather) para crear un bot. Pasos a seguir:

  ​	

  - Ejecutamos el comando /newbot

    ![newbot](https://dl.dropboxusercontent.com/s/2taz8p8h5lisibp/botfathernewbot.png?dl=0)

  - Nos solicitará un nombre para el bot y un nombre de usuario que será el que identificará al bot que estamos creando. Una vez creado el bot, nos aparecerá un mensaje en el que aparece el token del bot que acabamos de crear.

    ![token](https://dl.dropbox.com/s/g4ro2s95pvv5krf/tokenbot.png?dl=0)

- Volumen: aquí indicaremos donde queremos que se almacenen los torrent dentro de nuestro sistema operativo (DSM, OpenMediaVault, QTS, etc.). Habitualmente será el directorio "caliente" que utiliza el cliente torrent para añadir los .torrent a la lista de descargas.


## Creación del contenedor vía cli

- Descargar la imagen

````bash
docker pull tzinm/descargas-bcpt
````

- Crear el contenedor

````bash
docker run -d \
-e usuario1=12345678 \
-e token=AA3322bb:9900AA \
--name bot-bcpt \
tzinm/descargas-bcpt
````



## Creación del contenedor vía gui

Mostraré como levantar el contenedor tanto en [OpenMediaVault](https://www.openmediavault.org/) como en Synology. Es posible que el modo de realizar este proceso varie de un sistema a otro.



### OpenMediaVault

1. Buscamos la imagen en los repositorio de Docker.

   ![Imagen repositorios docker](https://dl.dropboxusercontent.com/s/zurer37hq4wabj1/repositorio-docker.png?dl=0)

2. Vamos a la lista de imágenes que tenemos descargadas, buscamos la que acabamos de descargar, la seleccionamos y pulsamos en el botón ejecutar. 

![Listado de imágenes](https://dl.dropboxusercontent.com/s/lj8wb5irze53tcf/ejecutar-imagen.png?dl=0)

3. Establecemos los parámetros que necesitamos para que el contenedor funcione adecuadamente.

![Parámetros en docker](https://dl.dropboxusercontent.com/s/u5qkvo01unerhyt/bcpt-docker.png?dl=0)

4. Nos aparecerá en la lista de contenedores.

   ![Lista de contenedores](https://dl.dropboxusercontent.com/s/dpygsfwoddljqmd/docker-corriendo.png?dl=0)



### Synology

En este caso mostraré varias capturas de que parámetros debemos modificar. Las capturas que se muestran a continuación han sido aportadas por el compañero **Nawe18**.

1. **Configuración general**, donde otorgamos un nombre al contenedor (el que nosotros queramos) y habilitamos el reinicio automático, para que en caso de reinicio del servicio o del NAS el contenedor se inicie automáticamente. 

   ![Configuración General Synology](https://dl.dropbox.com/s/rdqopqb5mjrn9xc/confgener-synology.jpg?dl=0 "Configuración General")

   

2. Establecer el **volúmen**, en la parte izquierda el que corresponde a DSM, y en la parte derecha al correspondiente al contenedor. **NO** marcar la casilla **sólo lectura**. 


   ![Volumen](https://dl.dropbox.com/s/flrnv1y2lj9gayd/volumen-synology.jpg?dl=0 "Volumen")
   

3. Añadir las **variables de entorno** que hemos visto más arriba.

   
   ![Variables de entorno](https://dl.dropbox.com/s/3b57guj4g2zx0ov/medio-ambiente-synology.jpg?dl=0 "Variables de entorno")

   

### IMPORTANTE

**Para que el contenedor funcione es necesario iniciar el bot que hemos creado.**


