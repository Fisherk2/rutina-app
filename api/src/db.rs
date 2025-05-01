use sqlx::{MySqlPool, Error, Row, query, query_scalar};
use dotenv::dotenv;
use std::env;
use chrono::NaiveDate;
use std::time::Duration;
use sqlx::mysql::MySqlConnectOptions;

// Estructura para mapear los datos de la rutina
#[derive(Debug)]
pub struct Rutina {
    pub id: i32,
    pub fecha: NaiveDate,
    pub descripcion: String,
}

// Función para crear un pool de conexiones a la base de datos
pub async fn create_db_pool() -> Result<MySqlPool, Error> {
    dotenv().ok();
    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    
    let pool = MySqlPool::connect_with(
        MySqlConnectOptions::from_str(&database_url)?
            .idle_timeout(Duration::from_secs(30))
            .max_connections(10)
    )
    .await?;
    
    Ok(pool)
}

// Función para obtener la rutina del día actual
pub async fn obtener_rutina_diaria(pool: &MySqlPool) -> Result<Vec<Rutina>, Error> {
    let rows = query(
        "SELECT id, fecha, descripcion FROM rutinas WHERE fecha = CURDATE()"
    )
    .fetch_all(pool)
    .await?;

    let mut rutinas = Vec::new();

    for row in rows {
        let rutina = Rutina {
            id: row.get("id"),
            fecha: row.get("fecha"),
            descripcion: row.get("descripcion"),
        };
        rutinas.push(rutina);
    }

    Ok(rutinas)
}

// Función para insertar una confirmación usando el procedimiento almacenado
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

// Función para obtener una confirmación
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
