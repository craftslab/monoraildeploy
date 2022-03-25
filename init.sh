#!/bin/bash

docker run --name mysql --rm \
  -e MYSQL_ROOT_PASSWORD=mysql -e MYSQL_USER=monorail -e MYSQL_PASSWORD=monorail \
  -v $PWD/mysql/conf:/etc/mysql/conf.d -v $PWD/mysql/data:/var/lib/mysql \
  mysql:latest --user=root -e 'CREATE DATABASE monorail;'

docker run --name mysql --rm \
  -e MYSQL_ROOT_PASSWORD=mysql -e MYSQL_USER=monorail -e MYSQL_PASSWORD=monorail \
  -v $PWD/mysql/conf:/etc/mysql/conf.d -v $PWD/mysql/data:/var/lib/mysql \
  mysql:latest --user=root monorail < monorail/schema/framework.sql

docker run --name mysql --rm \
  -e MYSQL_ROOT_PASSWORD=mysql -e MYSQL_USER=monorail -e MYSQL_PASSWORD=monorail \
  -v $PWD/mysql/conf:/etc/mysql/conf.d -v $PWD/mysql/data:/var/lib/mysql \
  mysql:latest --user=root monorail < monorail/schema/project.sql

docker run --name mysql --rm \
  -e MYSQL_ROOT_PASSWORD=mysql -e MYSQL_USER=monorail -e MYSQL_PASSWORD=monorail \
  -v $PWD/mysql/conf:/etc/mysql/conf.d -v $PWD/mysql/data:/var/lib/mysql \
  mysql:latest --user=root monorail < monorail/schema/tracker.sql
