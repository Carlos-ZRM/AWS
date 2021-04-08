- instalar nginx y certbot **Linux AMI**
    ~~~console
    sudo amazon-linux-extras install  epel -y
    sudo yum install nginx -y
    sudo yum install certbot python2-certbot-nginx -y
    sudo systemctl enable nginx
    sudo systemctl start nginx
    ~~~
