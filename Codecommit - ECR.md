

# Integración de Codecommit con ECR

Esta automatización permitirá automatizar los cambios en un repositorio  git code commit y la construcción de una imagen en docker en el regestry de AWS ECR. Para hacerlo se utulizará la herramienta Code pipeline.

## Crear un virtual env e instalar aws-cli 
Se pueden crear estos recursos en la consola aws o 

```
python3 -m venv myvenv
source myvenv/bin/activate
pip install awscli

```
El siguiente paso es iniciar sesión en aws cli. Para esto necesitamos las credenciales del usuario. Las podemos encontrar en la consola en el servicio **IAM** 

```
aws --version
aws configure 
### Respuesta interactiva
AWS Access Key ID [None]: 
AWS Secret Access Key [None]: 
Default region name [None]: 
Default output format [None]:  
```
## Crear un repositorio codecommit y una imagen en Docker.

Para crear los recuros debemos asignarles una politica que tenga los siguientes permisos

- codecommit:CreateRepository 
- codecommit:TagResource 

Creación del repositorio
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

> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbNDg1MTc1MzIxLC0yMzk3MzcxNzIsNjE0Mj
I2NjEzLDE2MDg0NjA1MzIsLTE3NzYxMDY4MiwxNTM5MTI1NTgz
LDg1NzkzMjIxMV19
-->