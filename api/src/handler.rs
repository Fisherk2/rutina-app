use rocket::{get, State, serde::json::Json};
use sqlx::MySqlPool;
use crate::db;

// Estructura para mapear los datos de la rutina (opcional, si queremos usarla en Rocket)
#[derive(Debug, serde::Serialize)]
pub struct Rutina {
    pub id: i32,
    pub fecha: String, // Convertimos NaiveDate a String para serializarlo como JSON
    pub descripcion: String,
}

// Estructura para recibir los datos de entrada
#[derive(Debug, serde::Deserialize)]
pub struct ConfirmacionInput {
    pub nombre: String,
    pub edad: i32,
    pub peso: f64,
    pub altura: f64,
    pub sexo: String, // "M" o "F"
}

// Endpoint GET /rutina
#[get("/rutina")]
pub async fn obtener_rutina_handler(db_pool: &State<MySqlPool>) -> Json<Vec<Rutina>> {
    // Obtener el pool de conexiones desde Rocket
    let pool = db_pool.inner();

    // Llamar a la función `obtener_rutina_diaria` desde `db.rs`
    match db::obtener_rutina_diaria(pool).await {
        Ok(rutinas) => {
            // Convertir NaiveDate a String para serializar como JSON
            let rutinas_json = rutinas
                .into_iter()
                .map(|r| Rutina {
                    id: r.id,
                    fecha: r.fecha.format("%Y-%m-%d").to_string(), // Formatear la fecha como String
                    descripcion: r.descripcion,
                })
                .collect();

            Json(rutinas_json) // Devolver las rutinas como JSON
        }
        Err(_) => {
            // En caso de error, devolver una lista vacía
            Json(vec![])
        }
    }
}

// Endpoint POST /confirmacion
#[post("/confirmacion", format = "json", data = "<input>")]
pub async fn insertar_confirmacion_handler(
    db_pool: &State<MySqlPool>,
    input: Json<ConfirmacionInput>,
) -> Result<String, String> {
    // Obtener el pool de conexiones desde Rocket
    let pool = db_pool.inner();

    // Extraer los datos del JSON
    let nombre = &input.nombre;
    let edad = input.edad;
    let peso = input.peso;
    let altura = input.altura;
    let sexo = &input.sexo;

    // Validar el campo sexo
    if sexo != "M" && sexo != "F" {
        return Err("El campo 'sexo' debe ser 'M' o 'F'".to_string());
    }

    // Llamar a la función `insertar_confirmacion` desde `db.rs`
    match db::insertar_confirmacion(pool, nombre, edad, peso, altura, sexo).await {
        Ok(_) => Ok("Confirmación insertada exitosamente".to_string()),
        Err(_) => Err("Error al insertar la confirmación".to_string()),
    }
}