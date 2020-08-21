
# Amazon Elastic Compute Cloud (Amazon EC2)

## Índice 
- 1. [Conceptos](#conceptos) 
- 2. [Crear EC2](#ec2)
- 3.  [Crear AMI](#ami)
## Conceptos <a name="conceptos"></a>

## Crear instancia EC2  <a name="ec2"></a>
### Requerimientos 

- VPC id 
- VPC subnet id subnet-idSubredPublica
- Security group id sg-securityGroup
[Opcional] 
- --user-data 


### Crear llave 
```console
aws ec2 create-key-pair --key-name nueva-llave \
	--output text --query 'KeyMaterial' \
	--profile default --region us-east-1 > nueva-llave.pem

chmod 400 nueva-llave.pem
 ``` 
### Crear instancia base
```console
aws ec2 run-instances --image-id ami-02354e95b39ca8dec \
        --count 1 \
        --instance-type t3a.micro \
        --key-name nueva-llave \
        --security-group-ids sg-id-securitygroup \
        --subnet-id subnet-idsubnet \
        --credit-specification CpuCredits=standard \
        --associate-public-ip-address \
        --block-device-mappings file://mapping.json \
        --user-data file://my_script.txt \
         --profile default --region us-east-1
 ```
## 3. Crear AMI <a name="conceptos"></a>
### Detener instancia base
```console
aws ec2 stop-instances --instance-ids i-idInstancia-creada
 ```

### Verificar estatus de la instancia 

```console
aws ec2 describe-instance-status --instance-id i-idInstancia-creada
 ```
## Crear imagen base
```console
aws ec2 create-image --instance-id i-idInstancia-creada \
	--name "Mi Imagen" --description "Imagen que muestra la ip" \
	--block-device-mappings file://mapping.json \
	--profile default --region us-east-1
	
aws ec2 create-tags --resources ami-idImagenBase  --tags Key=Name,Value='Imagen base'\
	--profile default --region us-east-1
 ```

> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTYyNjAzODIxOV19
-->