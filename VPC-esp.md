
#VPC Amazon Virtual Private Cloud

AWS en una red virtual que usted defina. Puede controlar todos los aspectos del entorno de red virtual, incluida la selección de su propio rango de direcciones IP, la creación de subredes y la configuración de tablas de ruteo y gateways de red. Puede usar tanto IPv4 como IPv6 en su VPC para obtener acceso a recursos y aplicaciones de manera segura y sencilla

## Conceptos

- Subred: un rango de direcciones IP en su VPC. Pueden ser publicas o privadas

- Tablas de ruteo: un conjunto de reglas que se utilizan para determinar hacia dónde se dirige el tráfico de red.
	-  Cada regla en una tabla de ruteo especifica el rango de direcciones IP donde desea que vaya el tráfico (el destino) y la puerta de enlace, la interfaz de red o la conexión a través de la cual se envía el tráfico (el destino).

- Puerta de enlace de Internet (Internet gateway) : Es una puerta de enlace que conecta una VPC para permitir la comunicación entre los recursos dentro de la VPC e Internet.

- Punto final de VPC (VPC endpoint ):  Permite conectar de forma privada las VPC a los servicios de AWS compatibles y a los servicios de punto final de VPC con tecnología PrivateLink sin necesidad de una puerta de enlace a Internet, dispositivo NAT, conexión VPN o conexión de conexión directa AWS. Las instancias en su VPC no requieren direcciones IP públicas para comunicarse con los recursos del servicio. El tráfico entre su VPC y el otro servicio no sale de la red de Amazon
 

> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTQxMjAxMDEyLC05ODEzNzc0NTEsOTQ5MT
A1NDg5XX0=
-->