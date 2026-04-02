FROM mysql:8.0

COPY pig.sql /docker-entrypoint-initdb.d/01-pig.sql
COPY pig_config.sql /docker-entrypoint-initdb.d/02-pig_config.sql
COPY init-v2.sql /docker-entrypoint-initdb.d/03-hiking_db.sql

ENV MYSQL_ROOT_PASSWORD=root
ENV TZ=Asia/Shanghai
