# Simple Login Example SRS (DRAFT) #
Un simple ejemplo que muestra como desarrollar un simple Web Page Login en
Goanna Web Framework

## System SetUp ##
  * Apache web server.
  * FastCGI Module in Goanna.
  * MySQL as DB.
> > ver http://code.google.com/p/webeiffel/wiki/StartUp

## Page Login ##
  * UserName
  * Password
  * Submit

## Home Page ##
  * Successful Message
  * Link to Logout Application

## Logout Page ##
  * Successful Logout Message

Es un simple ejemplo de un Login Page, no se accede a una Base de Datos,
simplemente se chequea que el los datos sean iguales a los hardcodeados en el
codigo.
En el ejemplo el username: "admin" y el password:"password".

## Design ##
Notación BON
![http://farm1.static.flickr.com/201/441960780_b7c2dc0e71_o.png](http://farm1.static.flickr.com/201/441960780_b7c2dc0e71_o.png)

Version en UML [http://www.flickr.com/photos/27971095@N00/441963386/ ](.md)

Source : [http://webeiffel.googlecode.com/svn/trunk/examples/simple\_login/ ](.md)


## Excecution ##
  1. Login Page
  1. if SuccesFull Login then
    1. Show HomePage
      1. if Logout is cliked then
        1. Show LogoutPage
      1. else
        1. Show HomePage
  1. else
    1. Show LoginPage with Errors

![http://farm1.static.flickr.com/188/441920709_29ca2e4388_o.png](http://farm1.static.flickr.com/188/441920709_29ca2e4388_o.png)

Si nos logeamos correctamente veremos la siguiente pagina

![http://farm1.static.flickr.com/193/441926985_1221ed12a3_o.png](http://farm1.static.flickr.com/193/441926985_1221ed12a3_o.png)


Logout de la aplicacion

![http://farm1.static.flickr.com/204/441930069_baf635415a_o.png](http://farm1.static.flickr.com/204/441930069_baf635415a_o.png)

Error de Login

![http://farm1.static.flickr.com/183/441933795_4f9062f482_o.png](http://farm1.static.flickr.com/183/441933795_4f9062f482_o.png)

**Caso 1**:
En caso de que el nombre de usuario o password sean incorrectos se mostrara
el mensaje :Name or Password are Incorrect

**Caso 2**:

Log In

Name [admin ](.md)   Name or Password are Incorrect

Password [\_\_\_\_ ](.md)    Password may not be empty


**Caso 3** :(siguiendo el caso 2 si borramos  el nombre y ponemos un password incorrecto obtenemos el siguiente mensaje)

Log In

Name [\_\_\_\_ ](.md) Name may not be empty. Name was not updated and remains 'admin'.

> Name or Password re Incorrect

Password [cualquierpassword ](.md)

**Caso 4 : Supongamos que nos logeamos correctamente
Si apretamos el back button del browser, obtendermos
la una pagina de login con el siguiente mensage**

> Log In
Name [admin ](.md) Name or Password are Incorrect
Password [\_\_\_ ](.md) Password may not be empty