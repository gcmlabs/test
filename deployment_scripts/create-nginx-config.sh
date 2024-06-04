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

if [ ! -L /etc/nginx/sites-available/test-service ]; then
  ln -s /etc/nginx/sites-available/test-service /etc/nginx/sites-enabled/test-service
fi

systemctl restart nginx