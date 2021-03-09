# Casos de uso

| Use Case |Technology Solutions |
|------------|-------------------|
|Operating System Access | Active Directory LDAP Machine-specific accounts |
|Application Access | Active Directory, Application User Repositories, Amazon Cognito | 
| AWS Resources | IAM |



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
eyJoaXN0b3J5IjpbLTE1NzA2MjExNzksNTUzNzIzNjUxLDE5MT
Q1NTYxODMsMTExNDc4MjY2Nl19
-->