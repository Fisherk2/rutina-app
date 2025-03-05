use sqlx::{MySqlPool, Error, Row};
use dotenv::dotenv;
use std::env;
use chrono::NaiveDate; // Para manejar fechas

// Estructura para mapear los datos de la rutina
#[derive(Debug)]
pub struct Rutina {
    pub id: i32,
    pub fecha: NaiveDate, // Usamos NaiveDate porque es compatible con el tipo DATE de SQL
    pub descripcion: String,
}

// Función para crear un pool de conexiones a la base de datos
pub async fn create_db_pool() -> MySqlPool {
    // Cargar variables de entorno desde el archivo .env
    dotenv().ok();

    // Obtener la URL de la base de datos desde las variables de entorno
    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");

    // Crear y devolver un pool de conexiones
    MySqlPool::connect(&database_url)
        .await
        .expect("Failed to connect to the database")
}

// Función para obtener la rutina del día actual
pub async fn obtener_rutina_diaria(pool: &MySqlPool) -> Result<Vec<Rutina>, Error> {
    // Ejecutar directamente la consulta SQL
    let rows = sqlx::query(
        "SELECT id, fecha, descripcion FROM rutinas WHERE fecha = CURDATE()"
    )
    .fetch_all(pool)
    .await?;

    // Crear un vector vacío para almacenar las rutinas
    let mut rutinas = Vec::new();

    // Recorrer las filas y mapearlas a la estructura `Rutina`
    for row in rows {
        let rutina = Rutina {
            id: row.get("id"),
            fecha: row.get("fecha"), // `sqlx` convierte automáticamente DATE a NaiveDate
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
    // Ejecutar el procedimiento almacenado
    sqlx::query!(
        "CALL InsertarConfirmacion(?, ?, ?, ?, ?)",
        nombre,
        edad,
        peso,
        altura,
        sexo
    )
    .execute(pool)
    .await?;

    Ok(())
}
  