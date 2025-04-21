FROM mariadb:10.6

# Variables de entorno para configurar MariaDB
ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_DATABASE=RutinasDB
ENV MYSQL_USER=api_rutinas
ENV MYSQL_PASSWORD=mondongo

# Copiar el archivo de volcado de base de datos
COPY ./database_backup.sql /docker-entrypoint-initdb.d/

# Exponer el puerto de MariaDB
EXPOSE 3306

# Iniciar MariaDB
CMD ["mysqld"]