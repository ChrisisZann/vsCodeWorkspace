FROM ubuntu:latest AS ubuntuOne

USER root


ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y postgresql

# Create necessary directories
RUN mkdir -p /etc/postgresql/13/main/

# Configure PostgreSQL

# Initialize database cluster
# RUN /etc/init.d/postgresql start
# RUN psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';"
# RUN createdb -O docker docker

# Adjust PostgreSQL configuration
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/13/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/13/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Start PostgreSQL service
# CMD ["/usr/lib/postgresql/13/bin/postgres", "-D", "/var/lib/postgresql/13/main", "-c", "config_file=/etc/postgresql/13/main/postgresql.conf"]
CMD ["service", "postgresql", "start"]

