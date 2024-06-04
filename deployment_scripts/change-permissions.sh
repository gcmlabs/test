#!/bin/bash

chown -R www-data:www-data /var/www/test-service

find /var/www/test-service -type d -exec chmod 2775 {} \;
find /var/www/test-service -type f -exec chmod 0664 {} \;
