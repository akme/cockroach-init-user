FROM cockroachdb/cockroach

COPY certs.sh /cockroach
WORKDIR /cockroach
RUN chmod +x certs.sh
RUN ./certs.sh
