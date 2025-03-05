#[macro_use]
extern crate rocket;

mod db;
mod handler;

use rocket::launch;
use sqlx::MySqlPool;

#[launch]
async fn rocket() -> _ {
    // Crear el pool de conexiones a la base de datos
    let db_pool = db::create_db_pool().await;

    // Configurar Rocket
    rocket::build()
        .manage(db_pool) // Compartir el pool de conexiones con los endpoints
        .mount("/", routes![
            handler::obtener_rutina_handler,
            handler::insertar_confirmacion_handler
        ]) // Montar ambos endpoints
}