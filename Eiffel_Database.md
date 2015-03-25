# Introducción #
Ejemplo de acceso a la Base desde Eiffel. Antes de escribir algun código vamos a tratar de
ejecutar algun ejemplo que viene con la distribución de Eiffel57. Esto nos va a permitir chequear que la coneccion a la Base de Datos via ODBC funciona correctamente, ademas de
ver como configurar un simple ejemplo de acceso a la DB en Eiffel.

A continuación describimos como utilizar el acceso a datos con EiffelStore basado en el contenido definido en el proyecto origo<sup>[2]</sup>

EiffelStore provee una interface entre Eiffel y un Sistema de Gestión de Base de Datos (SGBD o DBMS). Las aplicaciones escritas con EiffelStore son independientes del SGBD, lo cual permite almacenar y recuperar objetos desde diferentes bases de datos.

Para los ejemplos sobre la capa del SGDB usamos ODBC el cual provee una API procedural para usar consultas SQL para acceder a los datos independientemente del lenguaje de programacion, el sistema operativo y el sistema de bases de datos. Como Base de Datos usamos MySQL, por lo cual necesitamos el driver ODBC del m ismo para conectarnos por ODBC al MySQL.

El Mapeo entre Eiffel y MySQL es realizado de la siguiente manera.


Eiffel -> EiffelStore -> ODBC -> myODBC -> MySQL



## Usando EiffelStore y ODBC ##

Antes de utilizar ODBC es necesario compilar e instalar _libodbc. Moverse al direcotorio  y despues ejecutar el siguiente comando_


```
    $ISE_EIFFEL/library/store/dbms/rdbms/odbc/Clib>finish_freezing -library
```

Una ves compilado exitosamente la libreria _libodbc.a_  queda instalada en el siguiente
directorio ${ISE\_EIFFEL}/library/store/spec/${ISE\_PLATFORM}/lib/.

Agregar al archivo de configuracion ecf las siguientes librerias.

```
<library name="base" location="$ISE_LIBRARY\library\base\base.ecf"/>
<library name="time" location="$ISE_LIBRARY\library\time\time.ecf"/>
```

y los siguientes recursos externos

```
<external_include location="$(ISE_EIFFEL)/library/store/dbms/rdbms/odbc/Clib"/>
<external_object location="$(ISE_EIFFEL)/library/store/spec/$(ISE_PLATFORM)/lib/libodbc.a -liodbc"/>
```

The project file should also include following cluster

El archivo del proyecto deberia tambien incluir el siguiente cluster

```
<cluster name="eiffel_store" location="${ISE_EIFFEL}\library\store\" recursive="true"/>
```


Las clases principales para acceder a la Base de Datos usando ODBC son

  * DATABASE\_APPL[ODBC ](.md)
  * DB\_CONTROL
  * DB\_RESULT
  * DB\_SELECTION

Para conectarnos a la Base de datos, necesitamos crear un _handle_; este handle vinculara las clases de la interface con las clases de implementacion correspondiente mapeadas a la BD actual. El handle es implementado por DATABASE\_APPL[ODBC ](.md)

`database_appl: DATABASE_APPL [ ODBC ] `
> `-- Database handle.`
> `...`

> `create database_appl.login (a_name, a_psswd)`

> `database_appl.set_base`

El metodo `set_base` vincula la interface de EiffelStore a su especifico handle
El parametro generico de DATABASE\_APPL especifica el DBMS actualmente usado.

Una ves que el handle esta creado, necesitamos crear un session manager, el que nos permitira manejar la DB, especialmente para manejar la coneccion, deconeccion y manejo de errores. La clase encargada de esto es DB\_CONTROL.

> `session_control: DB_CONTROL`

> `-- Session control.`

> `create session_control.make`

> `session_control.connect`


El primer ejemplo que vamos a utilizar es ESQL"${ISE\_EIFFEL}/examples/store/esql"<sup>[3]</sup>, basicamente como describe la documentación

esql: A command line SQL parser: very useful to test your Database connection!

Editar el archivo esql.ecf

```
//editar el archivo copiando el siguiente código de configuración
$>gedit $ISE_EIFFEL/examples/store/esql/esql.ecf

<?xml version="1.0" encoding="ISO-8859-1"?><system xmlns="http://www.eiffel.com/developers/xml/configuration-1-0-0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.eiffel.com/developers/xml/configuration-1-0-0 http://www.eiffel.com/developers/xml/configuration-1-0-0.xsd" name="esql" uuid="EFFCDC06-058C-4D61-A59F-195EF996CCB7">
	<target name="common" abstract="true">
		<root cluster="root_cluster" class="ESQL" feature="make"/>
		<option warning="true">
			<assertions precondition="true" postcondition="false" check="false" invariant="false" loop="false"/>
		</option>
		<setting name="console_application" value="true"/>
		<external_include location="$(ISE_EIFFEL)/library/store/dbms/rdbms/odbc/Clib"/>
		<external_object location="$(ISE_EIFFEL)/library/store/spec/$(ISE_PLATFORM)/lib/libodbc.a -liodbc"/>
		<library name="base" location="$ISE_LIBRARY\library\base\base.ecf"/>
		<library name="store" location="$ISE_LIBRARY\library\store\store.ecf">
			<option warning="false">
			</option>
		</library>
	</target>
	
	<target name="odbc" extends="common">
		<root cluster="root_cluster" class="ESQL_ODBC" feature="make"/>
		<precompile name="vision2_pre" location="$ISE_PRECOMP\vision2.ecf"/>
		<library name="odbc" location="$ISE_LIBRARY\library\store\dbms\rdbms\odbc\odbc.ecf"/>
		<cluster name="handle" location="..\Utilities\odbc\"/>
		<cluster name="root_cluster" location=".\"/>
		<cluster name="utilities" location="..\Utilities\"/>
	</target>
</system>


```

Una ves editado el archivo de configuración, abrir el proyecto con EiffelStudio
```

 $>cd $ISE_EIFFEL///studio/spec/$(ISE_PLATFORM)/bin
 $>estudio
```

Deberiamos ver el Entorno de Desarrollo

![http://farm1.static.flickr.com/159/401870829_bf80e39726_t.jpg](http://farm1.static.flickr.com/159/401870829_bf80e39726_t.jpg)
http://www.flickr.com/photos/27971095@N00/401870829/


Luego debemos Abrir el proyecto _esql_, usamos  **Add Proyect** buscamos el archivo **esql.ecf** desde el browser del file system y apretamos **Open**
Esperamos que el proyecto compile, y ahora podemos ejecutar el proyecto.

Al ejecutar el proyecto, se ejecuta en linea de comando, y deberíamos ver algo similar a
esto

```
Database user authentication:
Data Source Name: mydb    //ver LinuxODBC
Name: root
Password: 

Welcome to the SQL interpreter
Database used: ODBC
        Type 'exit' to terminate

SQL> 


```

Ahora vamos a crear la Base de Datos test y luego vamos a crear una tabla usando
esql. Usando los dos scripts siguientes


Ademas de esto vamos a crear un esquema llamado test y vamos a crear una tabla user
```
CREATE DATABASE test
```

```
CREATE TABLE user (
       id  		 int     NOT NULL 	AUTO_INCREMENT,
       username	 varchar(50)	 NOT NULL 	default '',
       password	 varchar(50)	 NOT NULL 	default '',
       firstname		 varchar(255)	 NOT NULL 	default '',
       lastname	 	         varchar(255)	 NOT NULL 	default '',
       email	 	         varchar(255)	 NOT NULL 	default '',
       description 	         varchar(255)	 NOT NULL 	default '',
       PRIMARY KEY (id),
       UNIQUE KEY (username)
);

```

Ahora si hacemos un `select * from user` no vamos a ver ningun dato dado que dentro del esquema test la base user esta sin datos

Entonces creamos un par de usuarios usando esql y el query browser.

```
 SQL> INSERT INTO test.user (id, username, password,firstname, lastname,email,   description) VALUES (2,"cmolina","pwd", "cristian", "molina", "cm@localhost","aggo");

SQL> select * from test.user
1       jvelilla        pwd     javier  velilla         jv@localhost    aggo 
2       cmolina         pwd     cristian        molina  cm@localhost    aggo 
SQL> 


```


## Referencias ##
[1](1.md) http://www.bon-method.com/index_normal.htm

Seamless Object-Oriented Software  Architecture Analysis and Design of Reliable Systems Capitulo 11

[2](2.md) http://origo.ethz.ch/index.php/DB
[3](3.md) http://docs.eiffel.com/eiffelstudio/docs_no_content.html