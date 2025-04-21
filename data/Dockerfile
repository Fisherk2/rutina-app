FROM mariadb:10.6

# Variables de entorno para configurar MariaDB
ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_DATABASE=RutinasDB
ENV MYSQL_USER=api_rutinas
ENV MYSQL_PASSWORD=mondongo

# Copiar scripts de inicialización si los tienes
COPY ./init.sql /docker-entrypoint-initdb.d/

# Exponer el puerto de MariaDB
EXPOSE 3306

# Iniciar MariaDB
CMD ["mysqld"]