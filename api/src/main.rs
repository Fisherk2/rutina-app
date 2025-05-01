#[macro_use]
extern crate rocket;

mod db;
mod handler;

use rocket::{launch, Build, Rocket};
use handler::{obtener_rutina_handler, insertar_confirmacion_handler, obtener_confirmacion_handler};

#[launch]
async fn rocket() -> Rocket<Build> {
    let db_pool = db::create_db_pool()
        .await
        .expect("Failed to create database pool");

    rocket::build()
        .manage(db_pool)
        .mount("/", routes![
            obtener_rutina_handler,
            insertar_confirmacion_handler,
            obtener_confirmacion_handler
        ])
}
