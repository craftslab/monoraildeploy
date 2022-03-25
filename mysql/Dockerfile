FROM mysql:latest

ENV MYSQL_DATABASE=monorail
ENV MYSQL_ROOT_PASSWORD=mysql
ENV MYSQL_USER=monorail
ENV MYSQL_PASSWORD=monorail

COPY schema/framework.sql /docker-entrypoint-initdb.d
COPY schema/project.sql /docker-entrypoint-initdb.d
COPY schema/tracker.sql /docker-entrypoint-initdb.d

EXPOSE 3306
