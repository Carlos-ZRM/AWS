

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
        "repositoryName": "dev",
        "repositoryArn": "`arn:aws:ecr:us-east-1:123456789012:repository/dev`",
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

###  3.2 Construir la imagen en el repositorio local 
 Es recomendable construir la imagen en su equipo e indentificar los comandos necesarios para la construcción separandolos en fases, al menos debe considerar las siguientes : **prebuild** , **build**, **postbuild** 
#### 3.2.2 buildspec.yml
Se debe agregar el archivo buildspec.yml con la siguiente estructura. deberá modificar el parametro **aws_account_id** con el id de su cuenta
```
version: 0.2

phases:
  pre_build:
    commands:
      - echo Logging in to Amazon ECR...
      -a aws --version
      - echo $AWS_DEFAULT_REGION
      - REPOSITORY_URI=aws_account_id.dkr.ecr.us-east-1.amazonaws.com/dev
      - $(aws ecr get-login --region us-west-2 --no-include-email)
      - COMMIT_HASH=$(echo $CODEBUILD_RESOLVED_SOURCE_VERSION | cut -c 1-7)
      - echo $COMMIT_HASH
      - IMAGE_TAG=build-$(echo $CODEBUILD_BUILD_ID | awk -F":" '{print $2}')
      - echo $IMAGE_TAG

  build:
    commands:
      - echo Build started on `date`
      - echo Building the Docker image...
      - docker build -t dev .
      - docker tag dev:latest aws_account_id.dkr.ecr.us-west-2.amazonaws.com/dev:latest
  post_build:
    commands:
      - echo Build completed on `date`
      - echo Pushing the Docker images...
      - docker push aws_account_id.dkr.ecr.us-west-2.amazonaws.com/dev:latest
      - echo '[{"name":"dev","imageUri":"aws_account_id.dkr.ecr.us-west-2.amazonaws.com/dev:latest"}]' > imagedefinitions.json
artifacts:
  files:
      - '**/*'
```
#### 3.2.3 Push al repositorio
```
git add --all
git commit -m "Primer repostorio code commit - cr "
```
### Politicas del role codebuild-Build-dev-admisiones-service-role
Agregar las siguientes politicas al role creado 

> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTIxMDQ0OTMxMzYsLTIxMzkwNzA2NzIsLT
IwNDEyNzExNzQsLTE0NDMyODQxNzcsNzc5OTUxOTgzLC0xOTA2
NDM1Nzg0LDE1Mjk0MzA3MDUsLTE1NTgwMDgxNzYsLTg5MTE5Mj
YxNCwtMjM3MTYyNjk1LC0yMDIxMTE5OTg2LC0yMzk3MzcxNzIs
NjE0MjI2NjEzLDE2MDg0NjA1MzIsLTE3NzYxMDY4MiwxNTM5MT
I1NTgzLDg1NzkzMjIxMV19
-->