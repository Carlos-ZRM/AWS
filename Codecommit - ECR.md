

# Integración de Codecommit con ECR

Esta automatización permitirá automatizar los cambios en un repositorio  git code commit y la construcción de una imagen en docker en el regestry de AWS ECR. Para hacerlo se utulizará la herramienta Code pipeline.

## Crear un repositorio codecommit y una imagen en Docker.
```
python3 -m venv myvenv
source myvenv/bin/activate
pip install awscli
```
El siguiente paso es iniciar sesión en aws cli. Para esto necesitamos las credenciales del usuario. Las podemos encontrar en la consola en el servicio **IAM**
### Crear un virtual env e instalar aws-cli 
Se pueden crear estos recursos en la consola aws o 
> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE3MzY4NDUzNzAsMTUzOTEyNTU4Myw4NT
c5MzIyMTFdfQ==
-->