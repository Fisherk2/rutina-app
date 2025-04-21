# 1. Usar una imagen base de Rust oficial
FROM rust:1.85 AS builder

# 2. Establecer el directorio de trabajo
WORKDIR /app

# 3. Copiar los archivos necesarios para compilar
COPY Cargo.toml Cargo.lock ./
COPY src ./src

# 4. Compilar la aplicación en modo release
RUN cargo build --release

# 5. Crear una nueva imagen más ligera para ejecutar la aplicación
FROM debian:bullseye-slim

# 6. Instalar dependencias de tiempo de ejecución
RUN apt-get update && apt-get install -y libssl-dev ca-certificates && rm -rf /var/lib/apt/lists/*

# 7. Copiar el binario compilado desde la fase anterior
COPY --from=builder /app/target/release/mi-api-rust /usr/local/bin/mi-api-rust

# 8. Exponer el puerto que usará la API
EXPOSE 8080

# 9. Definir el comando para ejecutar la aplicación
CMD ["mi-api-rust"]