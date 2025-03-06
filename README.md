# Rutina de ejercicios
*Integrantes*:
- {Guapo 1}
- {Guapo 2}
- {Guapo 3}
- Guerrero Dávila Juan Carlos
- Zúñiga Gómez Jóse Alberto

---

#### ENV
```
DATABASE_URL=mysql://[DB_USER]:[DB_PASSWORD]@[DB_IP]/[DB_NAME]
ROCKET_ADDRESS=[IP]
ROCKET_PORT=[Port]
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
        "fecha": "2023-10-05",
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
