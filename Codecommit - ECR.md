

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


```

> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTIzOTczNzE3Miw2MTQyMjY2MTMsMTYwOD
Q2MDUzMiwtMTc3NjEwNjgyLDE1MzkxMjU1ODMsODU3OTMyMjEx
XX0=
-->