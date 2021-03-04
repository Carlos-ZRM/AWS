## Cómputo en la nube 
<br>

El cómputo en la nube es la entrega bajo demanda de recursos de cómputo,  almacenamientos en bases de datos, aplicacioes y otros recursos de TI mediante una plataforma con un modelo de pago: Pagas lo que usas *pay-as-you-go pricing.*

## Ventajas del cloud computing. 
<br>

- Cambiar la inversi[on inicial por inversión variable.
    Una alternativa de hacer una fuerte inversion en centro de datos y servidores antes de saber como lo usaras, Es pagar por la cantidad de recursos que consumas. 
    ( Infrastrucutra sobreestimada )
- Beneficios de la economía de escala masiva.
    Al utilizar la computación en la nube, puede lograr un costo variable más bajo que el que puedes obtener por tu cuenta. Debido a que el uso de cientos de miles de clientes se agrega en la nube, los proveedores como AWS pueden lograr menores precios por el uso.
- Dejar de adivinar la capacidad.
    Eliminar la necesidad de adivinar la capacidad de infraestrucutra que necesitas. Cuando tomas una decision sobre la capacidad de cómputo antes de desarrollar la aplicaición a menudo terminas pagando por recursos inactivos o trabajando con capacidades limitadas. Con el cómputo en la nube tu puedes acceder a grandes o pequenos recursos que necesites y escalar o contraer los recursos que ocupas en pocos minutos
- Incrementa la velocidad y la agilidad. 
    En el cómputo en l anube todos los recursos estan a un click de distancia, lo que significa que se reduce el tiempo en que los recursos disponibles para los desarrolladores estan disponibles en minutos no en horas, 
- Dejar de gastar dinero utilizando y manteniendo centro de datos.
    Puedes concentrarse en proyectos que diferencian tu negocio, no en la infraestructura. La computación en la nube te permite concentrarte en tus propios clientes, en lugar de en el trabajo pesado de almacenar, apilar y alimentar servidores.
- Se global en minutos
    Implemente fácilmente tu aplicación en varias regiones del mundo con solo unos pocos clics. Esto significa que puedes proporcionar una latencia más baja y una mejor experiencia para tus clientes a un costo mínimo.
  
## Modelos del cómputo en la nube 

![c0_cloud_computing.png](img/c0_cloud_computing.png)

## Infraestructura global

URL:

- [Infraestructura global](https://aws.amazon.com/es/about-aws/global-infrastructure/regions_az/)

- [Global acelerator](https://speedtest.globalaccelerator.aws/#/)

AWS cuenta con 80 zonas de disponibilidad repartidas en 25 regiones geográficas. 

### Regiones
AWS tiene el concepto de una región, que es una ubicación física en todo el mundo donde agrupamos los centros de datos. Llamamos a cada grupo de centros de datos lógicos una zona de disponibilidad (AZ). Cada región de AWS consta de varias AZ aisladas y separadas físicamente dentro de un área geográfica. A diferencia de otros proveedores de nube, que a menudo definen una región como un solo centro de datos, el diseño múltiple de AZ de cada región de AWS ofrece ventajas para los clientes. Cada AZ tiene alimentación, refrigeración y seguridad física independientes y está conectada a través de redes redundantes de latencia ultrabaja. Los clientes de AWS centrados en la alta disponibilidad pueden diseñar sus aplicaciones para que se ejecuten en múltiples AZ y lograr una mayor tolerancia a fallas. Las regiones de infraestructura de AWS cumplen con los niveles más altos de seguridad, cumplimiento y protección de datos.

### Zonas de disponibilidad

Una zona de disponibilidad (AZ) es uno o más centros de datos discretos con alimentación, redes y conectividad redundantes en una región de AWS. Las zonas de disponibilidad permiten que los clientes operen bases de datos y aplicaciones de producción con un nivel de disponibilidad, tolerancia a errores y escalabilidad mayor que el que ofrecería un centro de datos único. Todas las zonas de disponibilidad en una región de AWS están interconectadas con redes de alto ancho de banda y baja latencia, a través de una fibra metropolitana exclusiva totalmente redundante que proporciona una red de alto rendimiento y baja latencia entre las zonas de disponibilidad. Todo el tráfico entre las AZ está cifrado. El rendimiento de la red es suficiente como para llevar a cabo la replicación sincrónica entre las zonas de disponibilidad. Las AZ facilitan la partición de las aplicaciones para una alta disponibilidad. Si una aplicación se divide en AZ, las empresas estarán mejor aisladas y protegidas de problemas como cortes de energía, rayos, tornados, terremotos, etc. Las AZ están físicamente separadas entre sí por una distancia significativa de muchos kilómetros, aunque todas están dentro de un rango de 100 km (60 millas) de separación.

### AWS Local Zones
Las zonas locales de AWS ubican el cómputo, el almacenamiento, la base de datos y otros servicios selectos de AWS más cerca de los usuarios finales. Con las zonas locales de AWS, puede ejecutar fácilmente aplicaciones sensibles que requieren latencias de milisegundos de un solo dígito para sus usuarios finales, como la creación de contenido multimedia y de entretenimiento, juegos en tiempo real, simulaciones de depósitos, automatización de diseño electrónico y aprendizaje automático.

Cada ubicación de AWS Local Zone es una extensión de una región de AWS en donde puede ejecutar sus aplicaciones sensibles a la latencia con servicios de AWS tales como Amazon Elastic Compute Cloud, Amazon Virtual Private Cloud, Amazon Elastic Block Store, Amazon File Storage y Amazon Elastic Load Balancing en las proximidades geográficas de sus usuarios finales.

## Servicios AWS

[https://aws.amazon.com/](https://aws.amazon.com/)

Servicios base