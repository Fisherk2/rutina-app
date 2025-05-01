use rocket::{get, post, State, serde::json::Json};
use rocket::http::Status; //Import necesario para manejar errores HTTP
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
    let pool = db_pool.inner();

    match db::obtener_rutina_diaria(pool).await {
        Ok(rutinas) => {
            let rutinas_json = rutinas
                .into_iter()
                .map(|r| Rutina {
                    id: r.id,
                    fecha: r.fecha.format("%Y-%m-%d").to_string(),
                    descripcion: r.descripcion,
                })
                .collect();

            Json(rutinas_json)
        }
        Err(_) => Json(vec![]),
    }
}

// Endpoint POST /confirmacion
#[post("/confirmacion", format = "json", data = "<input>")]
pub async fn insertar_confirmacion_handler(
    db_pool: &State<MySqlPool>,
    input: Json<ConfirmacionInput>,
) -> Result<String, String> {
    let pool = db_pool.inner();

    let nombre = &input.nombre;
    let edad = input.edad;
    let peso = input.peso;
    let altura = input.altura;
    let sexo = &input.sexo;

    if sexo != "M" && sexo != "F" {
        return Err("El campo 'sexo' debe ser 'M' o 'F'".to_string());
    }

    match db::insertar_confirmacion(pool, nombre, edad, peso, altura, sexo).await {
        Ok(_) => Ok("Confirmación insertada exitosamente".to_string()),
        Err(_) => Err("Error al insertar la confirmación".to_string()),
    }
}

// Endpoint GET /confirmacion/<id_rutina>
#[get("/confirmacion/<id_rutina>")]
pub async fn obtener_confirmacion_handler(
    db_pool: &State<MySqlPool>,
    id_rutina: i32
) -> Result<Json<Option<String>>, Status> {
    let pool = db_pool.inner();

    match db::obtener_confirmacion(pool, id_rutina).await {
        Ok(confirmacion) => Ok(Json(confirmacion)),
        Err(_) => Err(Status::InternalServerError),
    }
}
