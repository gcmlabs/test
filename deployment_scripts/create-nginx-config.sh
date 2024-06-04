#!/bin/bash

echo 'server {
        listen 80;
        server_name _;

        location / {
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $host;
            proxy_pass http://127.0.0.1:3000;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
        }
}' > /etc/nginx/sites-available/test-service

if [ ! -L /etc/nginx/sites-available/helloworld ]; then
  ln -s /etc/nginx/sites-available/helloworld /etc/nginx/sites-enabled/helloworld
fi

systemctl restart nginx

mkdir /var/log/helloworld
touch /var/log/helloworld/hw_service.log
touch /var/log/helloworld/hw_service_err.log

echo '[Unit]
Description=helloworld
After=network.target

[Service]
Type=simple
User=ec2-user
WorkingDirectory=/var/www/helloworld
ExecStart=/usr/bin/node index.js
Restart=on-failure
StandardOutput=append:/var/log/helloworld/hw_service.log
StandardError=append:/var/log/helloworld/hw_service_err.log

[Install]
WantedBy=multi-user.target' > /lib/systemd/system/helloworld.service 

systemctl daemon-reload
systemctl enable helloworld