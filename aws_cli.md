# Listar bucket 
~~~ bash
aws s3 ls --profile default
~~~

# Listar objetos del bucket 
~~~ bash
aws s3 ls s3://kevops-webestatica
~~~

# Agregar archivo a bucket desde host

~~~ bash
aws s3 mv filename.txt s3://kevops-webestatica
~~~

# Obtener objetos del bucket

~~~ bash
aws s3 cp s3://kevops-webestatica/readme.txt .
~~~

# Sincronizar bucket

~~~ bash

aws s3 sync  --delete s3://kevops-webestatica/ ./

~~~

