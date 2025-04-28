# Etapa 1: Build
FROM rust:1.77 as builder

WORKDIR /app

# Copiar dependencias
COPY Cargo.toml Cargo.lock ./
COPY src ./src

# Compilar en release
RUN cargo build --release

# Etapa 2: Runtime
FROM debian:buster-slim

WORKDIR /app

# Copiar el binario desde el builder
COPY --from=builder /app/target/release/rutina-app .

# Exponer el puerto que usa Rocket (8000 por defecto)
EXPOSE 8000

# Comando para correr el servidor
CMD ["./rutina-app"]
