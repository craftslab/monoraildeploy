#!/bin/bash

docker run --name mysql --rm \
  -e MYSQL_ROOT_PASSWORD=mysql -e MYSQL_USER=monorail -e MYSQL_PASSWORD=monorail \
  -v $PWD/mysql/conf:/etc/mysql/conf.d -v $PWD/mysql/data:/var/lib/mysql \
  mysql:latest --user=monorail monorail -e "UPDATE User SET is_site_admin = TRUE WHERE email = 'foo@example.com';"
