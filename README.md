# www.arquichat.ml

Para realizar esta página web, se hizo un desacoplamiento de backend y frontend.

El backend consta de un api montada en Ruby on Rails, en un ambiente docker, en el que, a través de docker-compose, se integran distintos contenedores para la aplicación, base de datos (en postgres) y NGINX. Este está montado en un servidor con el servicio EC2 de Amazon Web Services.

El frontend se realizó con React, y se comunica vía endpoints HTTP con el backend.
Se puede acceder a la página a través del siguiente dominio (asegurado con SSL):

www.arquichat.ml

Los URL que se utilizan para obtener/postear información desde la api, son del siguiente estilo:

https://misimplechat.ml/api/v1

Tanto la página de frontend como los endpoints del backend, están asegurados por SSL, con Aws Certificate Manager para frontend y con Let's Encrypt para backend.

## Guía de uso

La página es bastante amigable y simple de usar. Sin embargo, aquí va una guía de uso:

Para ingresar y ponerse en contacto con otros usuarios, es necesario registrarse con un correo electrónico, el que será usado como tu nickname en la aplicación, y una contraseña para que solo tú puedas enviar mensajes asociados a tu nickname.

Una vez adentro, te aparecerá la lista del resto de los usuarios, a quienes puedes enviar mensajes privados, simplemente apretando su nickname e ingresando a la conversación.

También existe la posibilidad de chatear en grupo. Para esto, puedes crear una sala de chat, o bien, entrar a una ya existente. Cualquier usuario puede ingresar a estas salas a leer o enviar mensajes, sin ningún tipo de restricción. Sin embargo, solo podrá entrar a una sala si inicia sesión, luego de que esta haya sido creada.

## Mensajes en tiempo real

Para llevar a cabo los mensajes en tiempo real, se utilizó Action Cable, creando conexiones wss entre la api expuesta por Rails y el frontend consumidor de React. Así, al momento de entrar a una sala o a una conversación uno a uno con otro usuario, se genera una conexión a través de websockets, la cual luego se encarga de hacer broadcast desde el backend. Para permitir la comunicación entre el EC2 en donde se encuentra rails y el clound front se levantó un load balancer que permitiese conexiones tipo SSL.

Aprovechando la api montada en rails, se utilizó la herramienta de Application mailer para así enviar correos en dominio @gmail cada vez que un usuario etiquete a otro de la forma @'mail_usuario' o #'mail_usuario'. Dada la libertad del enunciado, decidimos como grupo que estos mensajes que desencadenan correos podían ocurirr en cualquier conversación/sala, independiente de si el usuario etiquetado está conectado o presente en la conversación. El único requisito consiste en que este debe estar en la base de datos.

## Funcionalidades faltantes

Dentro de la parte mínima, el requisito de implementar un autoScalingGroup fue retirado a último momento dado a que una instancia fue terminada. Por lo que solo se cuenta con un ELB.

Por otra parte, en la sección variable solo se alcanzó a cumplir con los mensajes en tiempo real.

## Tutoriales usados

Se utilizaron los siguientes tutoriales para montar la aplicación:

* Rails: https://www.youtube.com/watch?v=pPy0GQJLZUM

* Docker: https://www.youtube.com/watch?v=awFLzy0XwXo

* AWS EC2: https://www.youtube.com/watch?v=Nv_1u8gCkIQ

* NGINX y Let's encrypt: https://medium.com/@pentacent/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71
