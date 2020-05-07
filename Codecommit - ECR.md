

# Integración de Codecommit con ECR

Esta automatización permitirá automatizar los cambios en un repositorio  git code commit y la construcción de una imagen en docker en el regestry de AWS ECR. Para hacerlo se utulizará la herramienta Code pipeline.

## Crear un repositorio codecommit y una imagen en Docker.
```
python3 -m venv myvenv
source myvenv/bin/activate
pip install awscli
```
El siguiente paso es iniciar sesión en aws cli. Para esto necesitamos las credenciales del usuario. Las podemos encontrar en la consola en el servicio **IAM** 

```
aws --version
aws configure 
### Respuesta iterativa
AWS Access Key ID [None]: `` `AKIAIOSFODNN7EXAMPLE` ``
AWS Secret Access Key [None]: `` `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY` `` Default region name [None]: `` `us-west-2` `` Default output format [None]: `` `json` ``
```
### Crear un virtual env e instalar aws-cli 
Se pueden crear estos recursos en la consola aws o 
> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbNzUwNTc1MjIzLDE1MzkxMjU1ODMsODU3OT
MyMjExXX0=
-->