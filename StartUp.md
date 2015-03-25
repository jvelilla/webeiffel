# Introduccion a Eiffel #
Into Eiffel, por Ian Joyner http://web.mac.com/joynerian/iWeb/Ian%20Joyner/Into%20Eiffel.html

Why Eiffel, por Ian Joyner
http://web.mac.com/joynerian/iWeb/Ian%20Joyner/Eiffel.html

**Bibliography**

1.Object Oriented Software Construction (2nd edition),Bertrand Meyer, 1997.

2.Eiffel, The Language, Bertand Meyer.


3.Software Reuse, Bertand Meyer.

4.Design by Contract, by Example, James McKim and Richard Mitchell, 2001.



# Introduccion al Framework Goanna(Draft) #

Pagina en SourceForge http://sourceforge.net/projects/goanna

Introduccion al framework: http://goanna.sourceforge.net/application.htm

## Entorno de Desarrollo Linux ##
> _Esta guia de instalacion es para entornos Linux, especificamente Ubuntu 6.10,no se ha probado con entornos Windows_


> Eiffel Compiler http://eiffelsoftware.origo.ethz.ch/index.php/Main_Page
```
   # EiffelStudio Envairoment Variables  
   export ISE_EIFFEL=/usr/local/Eiffel57
   export ISE_PLATFORM=linux-x86  
   export PATH=$PATH:$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin
```



> Para configurar el entorno seguir los siguientes pasos
> detallados en la pagina de origo http://origo.ethz.ch/index.php/Goanna_and_Eposix_setup

> Una ves instalado chequear que las siguientes variables de entorno estan definidas.

> Goanna
```
    # GOANNA setup
    export GOANNA=[path]/goanna/
    export PATH=$PATH:$GOANNA/src/goa_build
```

### Dependencias del proyecto Goanna ###
> GOBO  http://www.gobosoft.com/eiffel/gobo/download.html
```
     # GOBO setup
     export GOBO=[path]/gobo
     export GOBO_EIFFEL=ise
     export GOBO_OS=unix
     export PATH=$PATH:$GOBO/bin
```
> EPOSIX
```
     # EPOSIX setup
     export EPOSIX=[path]/eposix
```
> LOG4E
```
     # LOG4E
     export LOG4E=[path]/log4e
```


### Instalar Apache ###

```
      sudo aptitude install apache2

```

### Instalar FastCGI ###
```
  
   1. Bajar http://fastcgi.com/dist/; 
   2. tar zxvf mod_fastcgi-2.4.2.tar.gz
   3. cd mod_fastcgi-2.4.2
   
   ./configure
    make
    make install

```
> Reiniciar el Apache
```
    sudo /etc/init.d/apache2 restart
```

Editar el archivo httpd.conf, cada aplicacion goanna que corre sobre el
WebServer debe tener su propio FastCgiExternalServer con un path y port unico.
El numero de port es asignado en la clase _APPLICATION\_CONFIGURATION.port_.


```

LoadModule fastcgi_module /usr/lib/apache2/modules/mod_fastcgi.so
FastCgiExternalServer "[path_to_executable_code]/app_name" -host localhost:7879

Alias /sample "[path_to_executable_code]/app_name"

<Directory[path_to_executable_code]/>
 SetHandler fastcgi-script
 Options ExecCGI
 Order Allow,Deny
 Allow from all
</Directory>  
```

Finalmente debe crear un directorio en /var/www/ que se corresponda al valor
del alias definido en el archivo httpd.conf