# 1. Usar una imagen base de Rust oficial
FROM rust:1.85 AS builder

# 2. Establecer el directorio de trabajo
WORKDIR /app

# 3. Copiar los archivos necesarios para compilar
COPY Cargo.toml Cargo.lock ./
COPY src ./src

# 4. Instalar dependencias para MySQL/MariaDB
RUN apt-get update && apt-get install -y default-libmysqlclient-dev pkg-config

# 5. Proporcionar DATABASE_URL para la compilación
ARG DATABASE_URL=mysql://api_rutinas:mondongo@host.docker.internal:3306/RutinasDB
ENV DATABASE_URL=${DATABASE_URL}

# 6. Compilar la aplicación en modo release
RUN cargo build --release

# 7. Crear una nueva imagen más ligera para ejecutar la aplicación
FROM debian:bullseye-slim

# 8. Instalar dependencias de tiempo de ejecución
RUN apt-get update && \
    apt-get install -y libssl-dev ca-certificates default-libmysqlclient-dev && \
    rm -rf /var/lib/apt/lists/*

# 9. Copiar el binario compilado desde la fase anterior
COPY --from=builder /app/target/release/rutina-api /usr/local/bin/rutina-api

# 10. Copiar el archivo .env (asegúrate de tener este archivo en el contexto de construcción)
COPY .env /.env

# 11. Exponer el puerto que usará la API
EXPOSE 8080

# 12. Definir el comando para ejecutar la aplicación
CMD ["rutina-api"]