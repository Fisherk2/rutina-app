# 1. Usar una imagen base de Rust oficial
FROM rust:1.85 AS builder

# 2. Establecer el directorio de trabajo
WORKDIR /app

# 3. Copiar los archivos necesarios para compilar
COPY Cargo.toml Cargo.lock ./
COPY src ./src

# 4. Instalar dependencias para MySQL/MariaDB
RUN apt-get update && apt-get install -y default-libmysqlclient-dev pkg-config

# 5. Compilar la aplicación en modo release
RUN cargo build --release

# 6. Crear una nueva imagen más ligera para ejecutar la aplicación
FROM debian:bullseye-slim

# 7. Instalar dependencias de tiempo de ejecución
RUN apt-get update && \
    apt-get install -y libssl-dev ca-certificates default-libmysqlclient-dev && \
    rm -rf /var/lib/apt/lists/*

# 8. Copiar el binario compilado desde la fase anterior
COPY --from=builder /app/target/release/rutina-api /usr/local/bin/rutina-api

# 9. Copiar el archivo .env (asegúrate de tener este archivo en el contexto de construcción)
COPY .env /.env

# 10. Exponer el puerto que usará la API
EXPOSE 8080

# 11. Definir el comando para ejecutar la aplicación
CMD ["rutina-api"]