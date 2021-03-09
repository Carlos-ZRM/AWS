# Casos de uso

| Use Case |Technology Solutions |
|------------|-------------------|
|Operating System Access | Active Directory LDAP Machine-specific accounts |
|Application Access | Active Directory, Application User Repositories, Amazon Cognito | 
| AWS Resources | IAM |

##  Authentication

- There are three ways that IAM authenticates
-  1. Username/Password
-  2. Acces key : ( access_key_id : acces_secret_key)
	- Olvide Nombre
	-  API-REST ( services call with aws)
	-  AWS SDK 
	- AWS CLI
- 3.  When a process operates under an assumed role, the temporary security token provides an access key for authentication. In addition to the access key (remember that it consists of two parts), the token also includes a session token. Calls to AWS must include both the two-part access key and the session token to authenticate.

## Polices 
A policy is a JSON document that fully defines a set of permissions to access and manipulate AWS resources. Policy documents contain one or more permissions, with each permissions defining:

- *Effect*: Allow / Deny
- *Service*: 
- *Resource* ARN ** arn:aws:service:region:account-id:[resourcetype:]resource **

[https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_cross-account-with-roles.html](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_cross-account-with-roles.html)

# Práctica: Compartir permisos a tráves de cuentas AWS

Crear una pólitica de lectura de EC2  En la cuenta A y que será compartida con la Cuenta B

Cuenta A
- Crear politica  
- Crear role y asignar politica
- Obtener ARN
Cuenta B 
- Crear grupo
- Asumir politica
~~~JSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1615264585000",
      "Effect": "Allow",
      "Action": [
        "sts:AssumeRole"
      ],
      "Resource": [
        "arn:aws:iam::xxxxxxxx:role/ReadEc2ExternalRole"
      ]
    }
  ]
}
~~~

<!--stackedit_data:
eyJoaXN0b3J5IjpbMzgyMjU0NDYwLC0zOTY4OTA4NTQsMTE3Nj
QxNjQ3NywtMTU3MDYyMTE3OSw1NTM3MjM2NTEsMTkxNDU1NjE4
MywxMTE0NzgyNjY2XX0=
-->