# Use a imagem oficial do PostgreSQL
FROM postgres:latest

# Configura as variáveis de ambiente do PostgreSQL
ENV POSTGRES_DB=twd_db
ENV POSTGRES_USER=adm
ENV POSTGRES_PASSWORD=12345

# Copia os arquivos SQL para dentro do container
COPY DDL.sql /docker-entrypoint-initdb.d/
COPY DML.sql /docker-entrypoint-initdb.d/
COPY DQL.sql /docker-entrypoint-initdb.d/

# Exposição da porta padrão do PostgreSQL
EXPOSE 5432
