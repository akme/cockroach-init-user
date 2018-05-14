#!/bin/sh
docker build -t "cockroach_user:dockerfile" .
export CONTAINER_ID=`docker run -d -p 26257:26257 cockroach_user:dockerfile start --certs-dir=certs`
sleep 2

USER="test"
PASSWORD="test"
DBNAME="test"

[ "$(docker exec -i $CONTAINER_ID ./cockroach sql --certs-dir=certs --execute='show users;' | grep -w ${POSTGRES_USER:=$USER})" ] && exit 0;

cat >/tmp/create.sql <<EOL
CREATE DATABASE IF NOT EXISTS ${POSTGRES_DB:=$DBNAME};
CREATE USER ${POSTGRES_USER:=$USER} WITH PASSWORD '${POSTGRES_PASSWORD:=$PASSWORD}';
GRANT ALL ON DATABASE ${POSTGRES_DB:=$DBNAME} TO ${POSTGRES_USER:=$USER};
EOL

docker exec -i $CONTAINER_ID ./cockroach sql --certs-dir=certs < /tmp/create.sql && rm /tmp/create.sql
