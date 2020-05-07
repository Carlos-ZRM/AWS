

# Integración de Codecommit con ECR

Esta automatización permitirá automatizar los cambios en un repositorio  git code commit y la construcción de una imagen en docker en el regestry de AWS ECR. Para hacerlo se utulizará la herramienta Code pipeline.

##  1. Crear un virtual env e instalar aws-cli 
Se pueden crear estos recursos en la consola aws o 

```
python3 -m venv myvenv
source myvenv/bin/activate
pip install awscli

```
### 1.2 Iniciar sesión aws cli

El siguiente paso es iniciar sesión en aws cli y que Docker inicie sesión. 
Para esto necesitamos las credenciales del usuario. Las podemos encontrar en la consola en el servicio **IAM** .  
```
aws --version
# Iniciar sesion aws-cli
aws configure 
### Respuesta interactiva
AWS Access Key ID [None]: 
AWS Secret Access Key [None]: 
Default region name [None]: 
Default output format [None]:
```

####  1.2.1 Politicas necesarias
Agregue las siguientes politicas a su usu
- codecommit:CreateRepository 
- codecommit:TagResource 
-  ecr:GetAuthorizationToken
- ecr:CreateRepository

### 1.3 Iniciar seion  Docker.

Agregue el Id de la cuenta aws a la que se este conectando
```
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin aws_account_id.dkr.ecr.us-east-1.amazonaws.com
```
## 1) Crear un repositorio codecommit y una imagen en Docker.

Para crear los recuros debemos asignarles una politica que tenga los siguientes permisos


Creación del repositorio code commit 
```
aws codecommit create-repository --repository-name MiRepositorio --repository-description "Repositorio aws ci/di Codecommit - ECR " --tags Team=ansible
### Respuesta 
{
    "repositoryMetadata": {
        "accountId": "2222222222",
        "repositoryId": "ffffffff-ffff-ffff-ffff-ffffffff",
        "repositoryName": "MiRepositorio",
        "repositoryDescription": "Repositorio aws ci/di Codecommit a ECR",
        "lastModifiedDate": 1588893218.1,
        "creationDate": 1588893218.1,
        "cloneUrlHttp": "https://git-codecommit.us-west-2.amazonaws.com/v1/repos/MiRepositorio",
        "cloneUrlSsh": "ssh://git-codecommit.us-west-2.amazonaws.com/v1/repos/MiRepositorio",
        "Arn": "arn:aws:codecommit:us-west-2:2222222222:MiRepositorio
    }
}
```

Creación del regestry ECR
```
aws ecr create-repository \
    --repository-name dev \
    --image-scanning-configuration scanOnPush=true \
    --region us-east-1
```


> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbMjAyNjcwNTQyOCwtMTU1ODAwODE3NiwtOD
kxMTkyNjE0LC0yMzcxNjI2OTUsLTIwMjExMTk5ODYsLTIzOTcz
NzE3Miw2MTQyMjY2MTMsMTYwODQ2MDUzMiwtMTc3NjEwNjgyLD
E1MzkxMjU1ODMsODU3OTMyMjExXX0=
-->