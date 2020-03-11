
# header 
- proxy_set_header Host $http_host;
- proxy_set_header X-Real-IP $remote_addr;
- proxy_set_header X-Scheme $scheme;
       proxy_set_header X-Forwarded-Proto $scheme;
       proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
       proxy_pass http://127.0.0.1:8087/jasperserver;
       proxy_redirect off;

> Written with [StackEdit](https://stackedit.io/).
<!--stackedit_data:
eyJoaXN0b3J5IjpbMTcwMzI5MjY1XX0=
-->