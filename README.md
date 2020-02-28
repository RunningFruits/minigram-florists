
<a href="https://github.com/wangsaisoon/sell" target="_blank">sell卖家后台管理系统</a><br>

线上地址
```
http://47.98.119.123:8080/sell/admin/index
http://brightereyer.com/sell/admin/index
```

<a href="https://blog.csdn.net/myy_1314/article/details/81076819" target="_blank">新版MySQL修改密码的四种方法</a><br>
```
vim /etc/my.cnf
#加入
skip-grant-tables

systemctl restart mysqld
service mysqld restart
```

```
use mysql
update user set authentication_string=password('helloWorld') where user='root';
flush privileges;
quit
```

注释掉skip-grant-tables
```
vim /etc/my.cnf
systemctl restart mysqld
```

nginx 配置 https
```
    upstream tomcat {
       server  127.0.0.1:8080 weight=10;
    }

    server {
        listen       443 ssl;
        server_name  localhost;

        ssl_certificate      cert/2667785_brightereyer.com.pem;
        ssl_certificate_key  cert/2667785_brightereyer.com.key;

        ssl_session_cache    shared:SSL:1m;
        ssl_session_timeout  5m;

        ssl_ciphers  HIGH:!aNULL:!MD5;
        ssl_prefer_server_ciphers  on;

        location / {
            proxy_pass http://47.98.119.123:8080;
        }

        location /sell {
            include uwsgi_params;
            proxy_pass http://47.98.119.123:8080/sell;

            # 负载均衡
            # proxy_pass http://tomcat/;

            proxy_set_header Host $host:$server_port;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header REMOTE-HOST $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            client_max_body_size    2000m;
        }

        location /sell {
            client_max_body_size    16m;
            client_body_buffer_size 128k;
            proxy_pass              http://localhost:8080/sell;
            proxy_set_header        Host $host;
            proxy_set_header        X-Real-IP $remote_addr;
            proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header        X-Forwarded-Proto $scheme;
            proxy_set_header        X-Forwarded-Port $server_port;
            proxy_next_upstream     off;
            proxy_connect_timeout   30;
            proxy_read_timeout      300;
            proxy_send_timeout      300;
        }

    }

```
