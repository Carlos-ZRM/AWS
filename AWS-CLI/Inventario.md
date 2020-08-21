
# Inventario de EC2 y RDS 

AWS permite describir las característica de los recursos de AWS. Cada recurso posee diferentes características pero es posible asignarles Tags para asignarle nuevas propiedades.  
Un tag es una entrada ``<Clave:Valor>`` que se le puede asignar  a los siguientes recursos de AWS.
Los tags nos permitiran filtrar los recursos AWS que deseemos utilizar o describir.   
[Documentación](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)

## Índice 
	- 1. [Conceptos](#conceptos) 
- 2. [Diagrama de la VPC](#diagrama)
- 3. [Creacion de la VPC](#creacion)

## Crear Tag 
```console
aws ec2 create-tags --resources id-recurso \
	--tags Key=Name,Value='Tabla privada' \
	--profile default --region us-east-1

```
##  Describir EC2

```console
aws ec2 describe-instances --output table \
	--filter "Name=instance-state-name,Values=running" \
	--query "Reservations[*].Instances[*].{Name:Tags[?Key=='Name']|[0].Value,estatus:Tags[?Key=='estatus']|[0].Value,cliente:Tags[?Key=='cliente']|[0].Value,rds:Tags[?Key=='endpoint']|[0].Value,tecnologia:Tags[?Key=='tecnologia']|[0].Value,responsable:Tags[?Key=='responsable']|[0].Value}" \
	--region us-east-1 --profile default
```
## Describir RDS

```console
```


> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbOTM0MDA5NjQxLDk1NDM1NTg1MCwxMjQxMD
Q5ODAxXX0=
-->