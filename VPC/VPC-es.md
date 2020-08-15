
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
- 1. VPC
	- 1.2. Subredes publicas y subredes privadas
- 2. Internet gateway y Nat gateway
- 3. Tablas de routeo privada y publica
- 4. Segurity group 

## 1. Creacion de la VPC
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
### 1.2. Crear subredes 
Crear una sub red publica y otra privada en dos zonas de disponibilidad diferente 
#### Zona de disponibilidad Virginia (us-east-1a)
#####  Crear *Subred publica 1*  10.0.0.0/24 
```console
aws ec2 create-subnet --vpc-id vpc-xxxxx --cidr-block 10.0.0.0/24 --availability-zone us-east-1a --profile Jag --region us-east-1

aws ec2 create-tags --resources subnet-xxxxxx --tags Key=Name,Value='Public Subnet 1' \
	--profile cuenta --region us-east-1
 ``` 
#####  Crear  *Subred privada 1* 10.0.1.0/24 
```console
aws ec2 create-subnet --vpc-id vpc-xxxxx --cidr-block 10.0.1.0/24 --availability-zone us-east-1a \
	--profile cuenta --region us-east-1

aws ec2 create-tags --resources subnet-xxxxxx --tags Key=Name,Value='Private Subnet 1' \
	--profile cuenta --region us-east-1
 ```  
#### Zona de disponibilidad Virginia (us-east-1b)

#####  Crear *Subred publica 2*  10.0.2.0/24 
```console
aws ec2 create-subnet --vpc-id vpc-xxxxx --cidr-block 10.0.2.0/24 --availability-zone us-east-1b       \
	--profile cuenta --region us-east-1

aws ec2 create-tags --resources subnet-xxxxx --tags Key=Name,Value='Public Subnet 2' \
	--profile cuenta --region us-east-1
 ``` 

#####  Crear  *Subred privada 2* 10.0.3.0/24 
```console
aws ec2 create-subnet --vpc-id vpc-xxxxx --cidr-block 10.0.3.0/24 --availability-zone us-east-1b \
	--profile cuenta --region us-east-1

aws ec2 create-tags --resources subnet-xxxxxx --tags Key=Name,Value='Private Subnet 2' \
	--profile cuenta --region us-east-1
 ``` 
#### Mostrar VPC
```console
aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-xxxxxx" --query 'Subnets[*].{ID:SubnetId,CIDR:CidrBlock}' \
	--profile cuenta --region us-east-1
 ``` 

### 2. Crear internet gateway y nat gateway

#### Internet gateway

#####  Crear internet gateway
```console
aws ec2 create-internet-gateway --profile cuenta --region us-east-1

aws ec2 create-tags --resources igw-xxxxxxx --tags Key=Name,Value='newDMZ-igt' --profile cuenta --region us-east-1
 ``` 
#### Nat gatewat

#####  Asigar IP publica
``` 
aws ec2 allocate-address --profile cuenta --region us-east-1
 ``` 

#### create nat gateway

```console
aws ec2 create-nat-gateway --subnet-id subnet-xxxxx --allocation-id eipalloc-xxxxx \
	--profile cuenta --region us-east-1

aws ec2 create-tags --resources nat-xxxxx --tags Key=Name,Value='newDMZ-int' \
	 --profile cuenta --region us-east-1
 ``` 

###  3. Crear tablas de routeo 

#### Tabla de routeo publica
Se deben crear las tablas de routeo , crear las reglas y asignarlas a las subredes 
##### Crear tabla de routeo publica 
```console
aws ec2 create-route-table --vpc-id vpc-xxxxx \
 --profile cuenta --region us-east-1

aws ec2 create-tags --resources rtb-xxxxx --tags Key=Name,Value='Tabla publica' \
	--profile cuenta --region us-east-1
 ``` 
##### Crear ruta
 
 ```console
aws ec2 create-route --route-table-id rtb-xxxxx --destination-cidr-block 0.0.0.0/0 --gateway-id igw-xxxxx \
	 --profile cuenta --region us-east-1
 ``` 
##### Asignar subredes publicas a la tabla de routeo 

###### Subred publica 1
 ```console
aws ec2 associate-route-table --subnet-id subnet-xxxxx --route-table-id rtb-xxxxx \
	 --profile cuenta --region us-east-1
  ```
###### Subred publica 2
```console
aws ec2 associate-route-table --subnet-id subnet-xxxxxx 	--route-table-id rtb-xxxxx \
	--profile cuenta --region us-east-1
 ``` 
##### Mostrar tabla de routeo 
```console
aws ec2 describe-route-tables --route-table-id rtb-xxxxxx --profile cuenta --region us-east-1
 ``` 
#### Tabla de routeo privada
Se deben crear las tablas de routeo , crear las reglas y asignarlas a las subredes 
##### Crear tabla de routeo privada
 
 ```console
aws ec2 create-route-table --vpc-id vpc-xxxxx --profile cuenta --region us-east-1
 
aws ec2 create-tags --resources rtb-xxxxx --tags Key=Name,Value='Tabla privada' --profile cuenta --region us-east-1
 ``` 
##### Crear rutas 
```console
aws ec2 create-route --route-table-id rtb-xxxxx --destination-cidr-block 0.0.0.0/0 --nat-gateway-id nat-xxxxxx --profile cuenta --region us-east-1
 ``` 

##### Asignar subredes privadas a la tabla de routeo 
###### Subred privada 1
```console
aws ec2 associate-route-table --subnet-id subnet-xxxxxx --route-table-id rtb-xxxxx --profile cuenta --region us-east-1
 ``` 
###### Subred privada 2
```console
aws ec2 associate-route-table --subnet-id subnet-xxxxxx --route-table-id rtb-xxxxxx --profile cuenta --region us-east-1
  ``` 
##### Mostrar tabla de routeo 
```console
aws ec2 describe-route-tables --route-table-id rtb-xxxxxx --profile cuenta --region us-east-1
 ``` 

###  3. Crear grupo de seguridad
 
```console
aws ec2 create-security-group --group-name web-server --description "Security group para servicios web " --vpc-id vpc-xxxx --profile cuenta --region us-east-1
 ``` 

####  Agregar reglas de entrada

HTTP

```console
aws ec2 authorize-security-group-ingress --group-id sg-xxxxx --protocol tcp --port 80 --cidr 0.0.0.0/0 --profile cuenta --region us-east-1
 ``` 
HTTPS
```console
aws ec2 authorize-security-group-ingress --group-id sg-xxxxx --protocol tcp --port 443 --cidr 0.0.0.0/0 --profile cuenta --region us-east-1
 ``` 
SSH
```console
aws ec2 authorize-security-group-ingress --group-id sg-xxxx --protocol tcp --port 22 --cidr 0.0.0.0/0 --profile cuenta --region us-east-1
 ``` 

 
```console
```

> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbODM5NTc4NzUsMTIyNDA1Nzk2Myw5ODY2OD
IxNjUsMTc4MDIyNDgzMCwtMTY0MzM1OTI0NywtMTc5MTQxMTE2
OCwtMTY3MzQ4MTM1Ml19
-->