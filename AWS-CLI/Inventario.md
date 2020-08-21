
# Inventario de EC2 y RDS 

AWS permite describir las característica de los recursos de AWS. Cada recurso posee diferentes características pero es posible asignarles Tags para asignarle nuevas propiedades.  

## Índice 
- 1. [Tag](#tag) 
- 2. [Describir EC2](#ec2)
- 3. [Describir RDS](#rds)

##  Tag <a name="tag"></a>
Un tag es una entrada ``<Clave:Valor>`` que se le puede asignar  a los siguientes recursos de AWS.
Los tags nos permitiran filtrar los recursos AWS que deseemos utilizar o describir.    
[Documentación](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)


```console
aws ec2 create-tags --resources id-recurso \
	--tags Key=Name,Value='Tabla privada' \
	--profile default --region us-east-1

```
##  Describir EC2 <a name="ec2"></a>

```console
aws ec2 describe-instances --output table \
	--filter "Name=instance-state-name,Values=running" \
	--query "Reservations[*].Instances[*].{Name:Tags[?Key=='Name']|[0].Value,estatus:Tags[?Key=='estatus']|[0].Value,cliente:Tags[?Key=='cliente']|[0].Value,rds:Tags[?Key=='endpoint']|[0].Value,tecnologia:Tags[?Key=='tecnologia']|[0].Value,responsable:Tags[?Key=='responsable']|[0].Value}" \
	--region us-east-1 --profile default
```
## Describir RDS <a name="rds"></a>

```console
aws rds describe-db-instances \
	--query "DBInstances[*].{Endpoit:Endpoint.Address,name:DBInstanceIdentifier,Engine:Engine,EngineVersion:EngineVersion,GB:AllocatedStorage,Estatus:DBInstanceStatus}" \
	--output table --region us-east-1 --profile default
```


> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTcyODY4OTc5NCwtNTI5ODU1MjY1LDEwOT
E5NDAyNTMsOTU0MzU1ODUwLDEyNDEwNDk4MDFdfQ==
-->