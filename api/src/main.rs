#[macro_use] 
extern crate rocket;

mod db;
mod handler;

use rocket::{launch, Build, Rocket};
use sqlx::MySqlPool;
use handler::{obtener_rutina_handler, insertar_confirmacion_handler, obtener_confirmacion_handler};

#[launch]
async fn rocket() -> Rocket<Build> {
    // Configuración del pool de conexiones con manejo de errores
    let db_pool = db::create_db_pool().await.expect("Failed to create database pool");

    // Configuración de Rocket
    rocket::build()
        .manage(db_pool) // Pool disponible en todos los handlers
        .mount("/", routes![
            obtener_rutina_handler,
            insertar_confirmacion_handler,
            obtener_confirmacion_handler
        ])
}
