
# VPC Amazon Virtual Private Cloud

AWS en una red virtual que usted defina. Puede controlar todos los aspectos del entorno de red virtual, incluida la selección de su propio rango de direcciones IP, la creación de subredes y la configuración de tablas de ruteo y gateways de red. Puede usar tanto IPv4 como IPv6 en su VPC para obtener acceso a recursos y aplicaciones de manera segura y sencilla

## Conceptos

- Subred: un rango de direcciones IP en su VPC. Pueden ser publicas o privadas

- Tablas de ruteo: un conjunto de reglas que se utilizan para determinar hacia dónde se dirige el tráfico de red.
	-  Cada regla en una tabla de ruteo especifica el rango de direcciones IP donde desea que vaya el tráfico (el destino) y la puerta de enlace, la interfaz de red o la conexión a través de la cual se envía el tráfico (el destino).
	-  Red privada
		-  Las instancias en la subred privada no pueden. enviar tráfico de salida directamente a Internet
		- Las instancias de la subred privada pueden obtener acceso a Internet utilizando una gateway de traducción de dirección de red (NAT) que reside en la subred pública
	- Red  publica
		- Las instancias de la subred pública pueden enviar tráfico de salida directamente a Internet

- Puerta de enlace de Internet (Internet gateway) : Es una puerta de enlace que conecta una VPC para permitir la comunicación entre los recursos dentro de la VPC e Internet.
- Grupos de seguridad Los grupos de seguridad controlan el tráfico de entrada y salida de las instancias . 
- Punto final de VPC (VPC endpoint):  Permite conectar de forma privada las VPC a los servicios de AWS compatibles y a los servicios de punto final de VPC con tecnología PrivateLink sin necesidad de una puerta de enlace a Internet, dispositivo NAT, conexión VPN o conexión de conexión directa AWS. Las instancias en su VPC no requieren direcciones IP públicas para comunicarse con los recursos del servicio. El tráfico entre su VPC y el otro servicio no sale de la red de Amazon
 
## Diagrama de la VPC 

Crearemos una VPC en la  region de Virginia (**us-east-1**) que tenga subredes en dos zonas de disponibilidad diferentes (**us-east-1a**,**us-east-1b**) . En cada zona  de disponibilidad hay una subred publica y una red privada. 
 
![Diagrama del escenario 2: VPC con subredes públicas y privadas](https://docs.aws.amazon.com/es_es/vpc/latest/userguide/images/nat-gateway-diagram.png)

### Recursos AWS necesarios 
- VPC
- Subredes publicas y subredes privadas
- Internet gateway 
- Nat gateway
- Tablas de routeo privada y publica
-  Segurity group 

## Creacion de la VPC
Es importante guardar los id de los recursos que se han creado
### Crear una VPC 
Se debe escoger un CIDR. 

```console
aws ec2 create-vpc --cidr-block 10.0.0.0/16 \
	--profile cuenta --region us-east-1
```
#### Agregar tag a la vpc 
```console
aws ec2 create-tags --resources vpc-xxxxxx --tags Key=Name,Value=newDMZ \\
	--profile cuenta --region us-east-1
``` 

#### Habilitar DNS hostname 
```console
aws ec2 modify-vpc-attribute --vpc-id vpc-xxxxxx --enable-dns-hostnames "{\"Value\":true}" \
	--profile Jager --region us-east-1
``` 
### Crear subredes 
Crear una sub red publica y otra privada en dos zonas de disponibilidad diferente 
#### Zona de disponibilidad Virginia (us-east-1a)
#####  Crear *Subred publica 1  10.0.0.0/24 
```console
aws ec2 create-subnet --vpc-id vpc-xxxxx --cidr-block 10.0.0.0/24 --availability-zone us-east-1a --profile Jag --region us-east-1

aws ec2 create-tags --resources subnet-xxxxxx --tags Key=Name,Value='Public Subnet 1' \
	--profile cuenta --region us-east-1
``` 
#####  Crear  *Subred privada 1* 10.0.1.0/24 
```console
aws ec2 create-subnet --vpc-id vpc-0ccffd71d42081528 --cidr-block 10.0.1.0/24 --availability-zone us-east-1a \
	--profile cuenta --region us-east-1

aws ec2 create-tags --resources subnet-045c4a014f9c9ca9e --tags Key=Name,Value='Private Subnet 1' \
	--profile cuenta --region us-east-1
```  

```console
```

> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTkyOTE3NzI0MCwxNzgwMjI0ODMwLC0xNj
QzMzU5MjQ3LC0xNzkxNDExMTY4LC0xNjczNDgxMzUyXX0=
-->