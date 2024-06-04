#!/bin/bash

chown -R www-data:www-data /var/www/helloworld

find /var/www/helloworld -type d -exec chmod 2775 {} \;
find /var/www/helloworld -type f -exec chmod 0664 {} \;
