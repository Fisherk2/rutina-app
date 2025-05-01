use sqlx::{MySqlPool, Error, query, query_scalar, Row}; // Añadido Row
use dotenv::dotenv;
use std::env;
use chrono::NaiveDate;
use std::time::Duration;
use sqlx::mysql::MySqlConnectOptions;
use std::str::FromStr;

#[derive(Debug)]
pub struct Rutina {
    pub id: i32,
    pub fecha: NaiveDate,
    pub descripcion: String,
}

pub async fn create_db_pool() -> Result<MySqlPool, Error> {
    dotenv().ok();
    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    
    let options = MySqlConnectOptions::from_str(&database_url)?
        .idle_timeout(Duration::from_secs(30))
        .max_connections(10);

    MySqlPool::connect_with(options).await
}

pub async fn obtener_rutina_diaria(pool: &MySqlPool) -> Result<Vec<Rutina>, Error> {
    let rows = query(
        "SELECT id, fecha, descripcion FROM rutinas WHERE fecha = CURDATE()"
    )
    .fetch_all(pool)
    .await?;

    let mut rutinas = Vec::new();
    for row in rows {
        rutinas.push(Rutina {
            id: row.try_get("id")?,
            fecha: row.try_get("fecha")?,
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
    query_scalar(
        "SELECT confirmacion FROM Confirmaciones WHERE id_rutina = ?"
    )
    .bind(id_rutina)
    .fetch_optional(pool)
    .await
}
