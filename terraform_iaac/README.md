## Documentación Terraform

Para la implementación de la infraestructura como código se utilizó Terraform. Con esta herramienta se pasaron a scripts la gran mayoría de las configuraciones realizadas en Amazon Web Services durante el semestre. El código se realizado se aplicó a los siguientes puntos:

* CDN: en este script se creó el bucket s3 en el que se despliega el frontend, además de la configuración para el Content Delivery Network que apunta a este bucket. 
* Auto Scaling Group: se creó la configuración necesaria para implementar Auto Scaling Group. En este script se encuentra la definición del Launch Template, en la que se agrega una imagen de una instancia EC2 y se ajusta para cumplir con todos los requerimientos del backend(Codedeploy-Agent, Docker y aws CLI). También, se incluye la configuración del recurso para crear el Autoscaling  que consume el Launch Template y el Load Balancer.
* Codedeploy: se configuro todo lo necesario para que funcione Codedeploy, tanto la aplicación como el deployment group.
* Load Balancer: Se configuro el balanceador de carga necesario para el Auto Scaling Group.
* Security Groups: se creó el grupo de seguridad para las conexiones de la instancia.
* Subnets: se configuraron todas las subredes necesarias.
* IAM Roles: se crearon todos los roles necesarios para crear la infraestructura desde cero, pero se comentaron ya que, por conveniencia, se utilizaron los roles anteriormente creados.

En cuando a espacio de mejora falto crear una instancia y una imagen a partir de esta con Terraform, ya que se está utilizando una creada previamente. Se realizo de esta manera ya que de otra forma estaba causando errores con el Codedeploy. Además, se podría crear un ambiente para staging y production, para esto basta duplicar el código de la configuración del Auto Scaling Group(solo Autoscaling), CDN y Codedeploy(solo el deployment group). Lo conveniente de esto es que no se debe duplicar el resto del código ya que es todo reutilizable y en general no se deben cambiar más de un par de líneas de código para los duplicados. 
