# Introducción #
Esta sección contiene la información necesaria para poder acceder a una base de datos por
ODBC<sup>[1]</sup> en un entorno Linux.
A continuación se describe
  * instalación de la base de datos en este caso MySQL<sup>[2]</sup>
  * instalación del driver de ODBC de MySQL<sup>[3]</sup>.
  * instalación del odbc driver manager (UnixOdbc<sup>[4]</sup>, iODBC<sup>[5]</sup>)
  * ejemplo de test de la conexión


## Instalación de MySQL ##
Hay varias opciones para instalar el servidor y cliente del MySQL.
El mas simple de todos es utilizar el **Synaptic Package Manager** (buscar mysql)
o utilizar **apt** o **aptitude**.
Si utilizamos **apt**
```
   //buscamos el el paquete
   $apt-cache search mysql
   // instalamos el servidor y el cliente
   $sudo apt-get install mysql-server-5.0 mysql-client-5.0
```

Es opcional instalar el MySQLBrowser, desde el Menu

```
     Apllications -->Add/Remove-->Programming //luego seleccion MySQLQueryBrowser
```

Finalmente uno podría bajarse los archivos y hacerlo manualmente.
En las siguientes instalaciones solo se describe una sola opción de instalación



## Instalacion del Driver de ODBC para MySQL ##
Para MySQL utilizamos el driver de ODBC

```
         $sudo apt-get install libmyodbc  
```


## Instalación del Driver Manager UnixODBC ##


En este caso usamos unixodbc.
```
      $sudo apt-get install unixodbc
```


Una ves realizada la instalación
Configuramos los archivos _odbc.ini_ y _odbcinst.ini_

```
      $sudo gedit /etc/odbc.ini
```

**odbc.ini**

```
   [mydb]
   Driver       = /usr/lib/odbc/libmyodbc.so
   Description  = Connector/ODBC 3.51 Driver DSN
   SERVER       = localhost
   PORT         =
   USER         = root
   Password     =
   Database     = mysql
   OPTION       = 3
   SOCKET       =
```




```
      $sudo gedit /etc/odbcinst.ini
```

**odbcinst.ini**

```
   [MySQL]
   Description	= MySQL driver
   Driver		= /usr/lib/odbc/libmyodbc.so
   Setup		= /usr/lib/odbc/libodbcmyS.so
   CPTimeout	=
   CPReuse		=
```

En caso de querer usar un pool de conexiones ver<sup>[6]</sup>

A continuación testeamos que drivers están definidos

```
jvelilla@jvelilla-desktop:/usr/local/lib$ odbcinst -j
unixODBC 2.2.11
DRIVERS............: /etc/odbcinst.ini
SYSTEM DATA SOURCES: /etc/odbc.ini
USER DATA SOURCES..: /home/jvelilla/.odbc.ini

```

Por último testeamos la conexión al DSN
usando el siguiente comando `isql -v DSN_NAME usr_db pwd_db`


```
jvelilla@jvelilla-desktop:/usr/local/lib$ isql -v mydb root
+---------------------------------------+
| Connected!                            |
|                                       |
| sql-statement                         |
| help [tablename]                      |
| quit                                  |
|                                       |
+---------------------------------------+
SQL> 

```


## Referencias ##
[1](1.md) http://en.wikipedia.org/wiki/Open_Database_Connectivity (ODBC)

[2](2.md) http://www.mysql.com/


[3](3.md) http://dev.mysql.com/downloads/connector/odbc/3.51.html

[4](4.md) http://www.unixodbc.org/

[5](5.md) http://www.iodbc.org/

[6](6.md) http://www.unixodbc.org/doc/conn_pool.html









