use sqlx::{MySqlPool, Error, query, query_scalar, Row};
use dotenv::dotenv;
use std::env;
use chrono::NaiveDate;

// Nueva solución: Usamos String para almacenar fechas y convertimos cuando sea necesario
#[derive(Debug)]
pub struct Rutina {
    pub id: i32,
    pub fecha: String,  // Almacenamos como String
    pub descripcion: String,
}

// Función helper para convertir String a NaiveDate
pub fn string_to_date(fecha: &str) -> Result<NaiveDate, chrono::ParseError> {
    NaiveDate::parse_from_str(fecha, "%Y-%m-%d")
}

// Función helper para convertir NaiveDate a String
pub fn date_to_string(fecha: NaiveDate) -> String {
    fecha.format("%Y-%m-%d").to_string()
}

pub async fn create_db_pool() -> Result<MySqlPool, Error> {
    dotenv().ok();
    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    MySqlPool::connect(&database_url).await
}

pub async fn obtener_rutina_diaria(pool: &MySqlPool) -> Result<Vec<Rutina>, Error> {
    let rows = query(
        "SELECT id, DATE_FORMAT(fecha, '%Y-%m-%d') as fecha, descripcion FROM rutinas WHERE fecha = CURDATE()"
    )
    .fetch_all(pool)
    .await?;

    let mut rutinas = Vec::new();
    for row in rows {
        rutinas.push(Rutina {
            id: row.try_get("id")?,
            fecha: row.try_get("fecha")?,  // Obtenemos directamente como String
            descripcion: row.try_get("descripcion")?,
        });
    }
    Ok(rutinas)
}

pub async fn insertar_confirmacion(
    pool: &MySqlPool,
    nombre: &str,
    edad: i32,
    peso: f64,
    altura: f64,
    sexo: &str,
) -> Result<(), Error> {
    query(
        "CALL InsertarConfirmacion(?, ?, ?, ?, ?)"
    )
    .bind(nombre)
    .bind(edad)
    .bind(peso)
    .bind(altura)
    .bind(sexo)
    .execute(pool)
    .await?;

    Ok(())
}

pub async fn obtener_confirmacion(
    pool: &MySqlPool,
    id_rutina: i32
) -> Result<Option<String>, Error> {
    let confirmacion = query_scalar(
        "SELECT confirmacion FROM Confirmaciones WHERE id_rutina = ?"
    )
    .bind(id_rutina)
    .fetch_optional(pool)
    .await?;

    Ok(confirmacion)
}
