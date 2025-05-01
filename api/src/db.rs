use sqlx::{MySqlPool, Error, query, query_scalar, Row};
use dotenv::dotenv;
use std::env;
use chrono::NaiveDate;

#[derive(Debug)]
pub struct Rutina {
    pub id: i32,
    pub fecha: NaiveDate,  // Mantenemos NaiveDate con la implementación personalizada
    pub descripcion: String,
}

// Implementación necesaria para que SQLx pueda manejar NaiveDate
impl sqlx::Type<sqlx::MySql> for NaiveDate {
    fn type_info() -> sqlx::mysql::MySqlTypeInfo {
        <&str as sqlx::Type<sqlx::MySql>>::type_info()
    }
}

impl sqlx::Encode<'_, sqlx::MySql> for NaiveDate {
    fn encode_by_ref(&self, buf: &mut sqlx::mysql::MySqlArgumentBuffer) -> sqlx::encode::IsNull {
        self.format("%Y-%m-%d").to_string().encode_by_ref(buf)
    }
}

impl<'r> sqlx::Decode<'r, sqlx::MySql> for NaiveDate {
    fn decode(value: sqlx::mysql::MySqlValueRef<'r>) -> Result<Self, sqlx::error::BoxDynError> {
        let s = <&str as sqlx::Decode<sqlx::MySql>>::decode(value)?;
        NaiveDate::parse_from_str(s, "%Y-%m-%d").map_err(Into::into)
    }
}

pub async fn create_db_pool() -> Result<MySqlPool, Error> {
    dotenv().ok();
    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    
    MySqlPool::connect(&database_url).await
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
    let confirmacion = query_scalar(
        "SELECT confirmacion FROM Confirmaciones WHERE id_rutina = ?"
    )
    .bind(id_rutina)
    .fetch_optional(pool)
    .await?;

    Ok(confirmacion)
}
