use sqlx::{MySqlPool, Error, query, query_scalar, Row};
use dotenv::dotenv;
use std::env;
use chrono::NaiveDate;

// Wrapper para NaiveDate que podemos implementar nuestros traits
#[derive(Debug)]
struct SqlxNaiveDate(NaiveDate);

// Implementación de los traits necesarios para nuestro wrapper
impl sqlx::Type<sqlx::MySql> for SqlxNaiveDate {
    fn type_info() -> sqlx::mysql::MySqlTypeInfo {
        <&str as sqlx::Type<sqlx::MySql>>::type_info()
    }
}

impl sqlx::Encode<'_, sqlx::MySql> for SqlxNaiveDate {
    fn encode_by_ref(&self, buf: &mut sqlx::mysql::MySqlArguments) -> sqlx::encode::IsNull {
        self.0.format("%Y-%m-%d").to_string().encode_by_ref(buf)
    }
}

impl<'r> sqlx::Decode<'r, sqlx::MySql> for SqlxNaiveDate {
    fn decode(value: sqlx::mysql::MySqlValueRef<'r>) -> Result<Self, sqlx::error::BoxDynError> {
        let s = <&str as sqlx::Decode<sqlx::MySql>>::decode(value)?;
        Ok(SqlxNaiveDate(NaiveDate::parse_from_str(s, "%Y-%m-%d")?))
    }
}

#[derive(Debug)]
pub struct Rutina {
    pub id: i32,
    pub fecha: NaiveDate,
    pub descripcion: String,
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
        let fecha_wrapper: SqlxNaiveDate = row.try_get("fecha")?;
        rutinas.push(Rutina {
            id: row.try_get("id")?,
            fecha: fecha_wrapper.0,
            descripcion: row.try_get("descripcion")?,
        });
    }
    Ok(rutinas)
}

// Resto de tus funciones permanecen igual...
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
