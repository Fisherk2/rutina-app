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

// Función para insertar una confirmación usando una consulta directa en lugar del procedimiento almacenado
pub async fn insertar_confirmacion(
    pool: &MySqlPool,
    nombre: &str,
    edad: i32,
    peso: f64,
    altura: f64,
    sexo: &str,
) -> Result<(), Error> {
    // Primero verificamos si el usuario ya confirmó la rutina del día actual
    let existe = sqlx::query(
        "SELECT 1 FROM confirmaciones WHERE nombre = ? AND fecha_rutina = CURDATE()"
    )
    .bind(nombre)
    .fetch_optional(pool)
    .await?;

    // Si ya existe una confirmación para este usuario hoy, retornamos un error
    if existe.is_some() {
        // Crear un error simple
        return Err(sqlx::Error::Protocol("El usuario ya confirmó la rutina para hoy".into()));
    }

    // Si no existe, insertamos la nueva confirmación
    sqlx::query(
        "INSERT INTO confirmaciones (nombre, edad, peso, altura, sexo, fecha_rutina) 
         VALUES (?, ?, ?, ?, ?, CURDATE())"
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
