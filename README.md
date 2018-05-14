# cockroach-init-user
## Start
Just run:
```
$ ./start.sh
```
It will automatically build image from Dockerfile, generate certificates for secure cockroach setup, start container with exposed port 26257 and create test user.
## How to test
```
$ psql "postgresql://test@localhost:26257?sslmode=require"
```
All credentials can be configured inside start.sh script.
