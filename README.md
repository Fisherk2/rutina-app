# Rutina de ejercicios
*Integrantes*:
- {Guapo 1}
- {Guapo 2}
- Espinoza Lopez Juan Diego
- Guerrero Dávila Juan Carlos
- Zúñiga Gómez Jóse Alberto

---

#### ENV
Para utilizar la API, es necesario configurar las variables de entorno, este se debe crear en la carpeta `/api` un archivo llamado `.env` con el siguiente contenido:

```
DATABASE_URL=mysql://[DB_USER]:[DB_PASSWORD]@[DB_IP]/[DB_NAME]
ROCKET_ADDRESS=[IP]
ROCKET_PORT=[Port]
```
- `[DB_USER]`: Nombre de usuario de la base de datos.
- `[DB_PASSWORD]`: Contraseña de la base de datos.
- `[DB_IP]`: Dirección IP de la base de datos.
- `[DB_NAME]`: Nombre de la base de datos.
- `[IP]`: Dirección IP de la máquina donde se ejecuta la API.
- `[Port]`: Puerto donde se ejecutará la API.

Las variables de entorno se establecen con estos parametros, para la orquestación de los contenedores:

```
DATABASE_URL=mysql://api_rutinas:mondongo@db:3306/RutinasDB
ROCKET_ADDRESS=0.0.0.0
ROCKET_PORT=8080
```

#### API

##### GET/rutina
Desde otra máquina en la misma red, usa la dirección IP de tu máquina y el puerto `8080`. 
Por ejemplo, si tu dirección IP es `192.168.1.100`.

```bash
curl http://192.168.1.100:8080/rutina
```

Deberías recibir un JSON con estas características:
```json
[
    {
        "id": 1,
        "fecha": "2025-10-05",
        "descripcion": "Hacer ejercicio cardiovascular"
    }
]
```

##### POST/confirmacion
Usa curl o Postman para hacer una solicitud `POST` al endpoint `/confirmacion` con datos en formato JSON.

```bash
curl -X POST http://127.0.0.1:8080/confirmacion \
     -H "Content-Type: application/json" \
     -d '{
           "nombre": "Fisher",
           "edad": 27,
           "peso": 85.0,
           "altura": 176.0,
           "sexo": "M"
         }'
```
