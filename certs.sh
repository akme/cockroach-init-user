#!/bin/sh
mkdir certs
mkdir my-safe-directory
./cockroach cert create-ca \
--certs-dir=certs \
--ca-key=my-safe-directory/ca.key
./cockroach cert create-client \
root \
--certs-dir=certs \
--ca-key=my-safe-directory/ca.key
./cockroach cert create-node \
localhost \
$(hostname) \
--certs-dir=certs \
--ca-key=my-safe-directory/ca.key
