

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
Agregue las siguientes politicas a su usuario. 

- codecommit:CreateRepository 
- codecommit:TagResource 
-  ecr:GetAuthorizationToken
- ecr:CreateRepository

### 1.3 Iniciar seion  Docker.

Agregue el Id de la cuenta aws a la que se este conectando
```
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin aws_account_id.dkr.ecr.us-east-1.amazonaws.com
```
## 2. Crear un repositorio codecommit y una imagen en Docker.

Para crear los recuros debemos asignarles una politica que tenga los siguientes permisos

### 2.1 Codecommit

Creación del repositorio code commit 
```
aws codecommit create-repository --repository-name MiRepositorio --repository-description "Repositorio aws ci/di Codecommit - ECR " --tags Team=ansible
```

Respuesta
``` 
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

### 2.2 Creación del regestry ECR
```
aws ecr create-repository \
    --repository-name dev \
    --image-scanning-configuration scanOnPush=true \
    --region us-east-1
```
Respuesta 
```
{
    "repository": {
        "registryId": "123456789012",
        "repositoryName": "sample-repo",
        "repositoryArn": "`arn:aws:ecr:us-east-1:123456789012:repository/sample-repo`",
        "imageScanningConfiguration": {
            "scanOnPush": true
        }
    }
}
```
## 3 Creación del código en el directorio code commit 
Para hacer uso del codecommit es necesario que el usuario tenga politicas que le permitan acceder al repositorio. 
### 3.1 Clonar el repositorio creado mediante https
Puede acceder al repositorio codecommit mediante ssh o https. Nosotros lo haremos con https

```
git clone  https://git-codecommit.us-west-2.amazonaws.com/v1/repos/MiRepositorio

cd MiRepositorio
``` 

Docker crea una imagen con el comando **docker build .** y es  necesario agregar en el directorio raiz del proyecto git  el archivo **Dockerfile** además de todos los elementos necesarios para construir la imagen.
 ### 3.2 Construir la imagen en el repositorio local 
 Es recomendable construir la imagen en su equipo e indentificar los comandos necesarios para la construcción separandolos en fases, al menos debe considerar las siguientes : **prebuild** , **build**, **postbuild** 


> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbNzc5OTUxOTgzLC0xOTA2NDM1Nzg0LDE1Mj
k0MzA3MDUsLTE1NTgwMDgxNzYsLTg5MTE5MjYxNCwtMjM3MTYy
Njk1LC0yMDIxMTE5OTg2LC0yMzk3MzcxNzIsNjE0MjI2NjEzLD
E2MDg0NjA1MzIsLTE3NzYxMDY4MiwxNTM5MTI1NTgzLDg1Nzkz
MjIxMV19
-->