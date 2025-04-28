/* 
╔═════════════════════════════════════════════════════════════╗
║                                                             ║
║ 🛠️  PROYECTO: Rutina de ejercicios				          ║
║                                                             ║
║ Fecha: 2025-03-02	                                          ║
║ Execute: 1                                                  ║
╚═════════════════════════════════════════════════════════════╝
*/

-- 1. Creación de la base de datos
CREATE DATABASE IF NOT EXISTS RutinasDB
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE RutinasDB;

-- 2. Creación de tablas

-- Tabla `rutinas`: Almacena las rutinas predefinidas para cada día
CREATE TABLE IF NOT EXISTS rutinas (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único de la rutina
    fecha DATE NOT NULL UNIQUE,        -- Fecha asociada a la rutina (única)
    descripcion TEXT NOT NULL          -- Descripción de los ejercicios
);

-- Tabla `confirmaciones`: Almacena las confirmaciones de los usuarios
CREATE TABLE IF NOT EXISTS confirmaciones (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único de la confirmación
    nombre VARCHAR(100) NOT NULL,      -- Nombre del usuario
    edad INT NOT NULL,                 -- Edad del usuario
    peso DECIMAL(5, 2) NOT NULL,       -- Peso del usuario (en kg)
    altura DECIMAL(5, 2) NOT NULL,     -- Altura del usuario (en cm)
    sexo ENUM('M', 'F') NOT NULL,      -- Sexo del usuario ('M' o 'F')
    fecha_rutina DATE NOT NULL,        -- Fecha de la rutina confirmada
    UNIQUE (nombre, fecha_rutina)      -- Restricción: Un usuario no puede confirmar más de una vez por día
);

-- 3. Creación de un usuario para ejecutar procedimientos almacenados y otro para acceder de forma remota.
CREATE USER IF NOT EXISTS 'api_rutinas'@'localhost' IDENTIFIED BY 'mondongo';
GRANT EXECUTE, SELECT, INSERT ON RutinasDB.* TO 'api_rutinas'@'localhost';

CREATE USER 'remoto_rutinas'@'%' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON RutinasDB.* TO 'remoto_rutinas'@'%';

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'remoto_rutinas'@'%';

-- 4. Índices para optimizar consultas
CREATE INDEX idx_fecha ON rutinas(fecha); -- Índice para buscar rápidamente por fecha en la tabla `rutinas`
CREATE INDEX idx_nombre_fecha ON confirmaciones(nombre, fecha_rutina); -- Índice para validar unicidad en confirmaciones

-- 5. Procedimientos almacenados

-- Procedimiento para obtener la rutina del día actual
-- DROP PROCEDURE IF EXISTS ObtenerRutinaDiaria;
DELIMITER $$

CREATE PROCEDURE ObtenerRutinaDiaria()
BEGIN
    SELECT id, fecha, descripcion
    FROM rutinas
    WHERE fecha = CURDATE(); -- Obtiene la rutina correspondiente al día actual
END$$

DELIMITER ;

-- Procedimiento para insertar una confirmación de usuario
DELIMITER $$

CREATE PROCEDURE InsertarConfirmacion(
    IN p_nombre VARCHAR(100),
    IN p_edad INT,
    IN p_peso DECIMAL(5, 2),
    IN p_altura DECIMAL(5, 2),
    IN p_sexo ENUM('M', 'F')
)
BEGIN
    DECLARE v_fecha_rutina DATE DEFAULT CURDATE();

    -- Verifica si el usuario ya confirmó la rutina del día actual
    IF NOT EXISTS (
        SELECT 1
        FROM confirmaciones
        WHERE nombre = p_nombre AND fecha_rutina = v_fecha_rutina
    ) THEN
        -- Inserta la confirmación si no existe
        INSERT INTO confirmaciones (nombre, edad, peso, altura, sexo, fecha_rutina)
        VALUES (p_nombre, p_edad, p_peso, p_altura, p_sexo, v_fecha_rutina);
    ELSE
        -- Lanza un error si el usuario ya confirmó
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El usuario ya confirmó la rutina para hoy';
    END IF;
END$$

DELIMITER ;
