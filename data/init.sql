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

-- 3. Creación de un usuario para ejecutar procedimientos almacenados
CREATE USER IF NOT EXISTS 'api_rutinas'@'localhost' IDENTIFIED BY 'mondongo';
GRANT EXECUTE, SELECT, INSERT ON RutinasDB.* TO 'api_rutinas'@'localhost';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'api_rutinas'@'localhost';

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

-- 6. Población inicial de datos en la tabla `rutinas`

INSERT INTO rutinas (fecha, descripcion) VALUES
('2025-03-01', 'Sentadillas, Flexiones, Plancha'),
('2025-03-02', 'Correr 3 km, Abdominales, Estiramientos'),
('2025-03-03', 'Zancadas, Elevaciones laterales, Burpees'),
('2025-03-04', 'Saltos de cuerda, Sentadillas, Flexiones'),
('2025-03-05', 'Ciclismo, Plancha, Abdominales'),
('2025-03-06', 'Sentadillas con pesas, Flexiones diamante, Estiramientos'),
('2025-03-07', 'Correr 5 km, Zancadas, Elevaciones frontales'),
('2025-03-08', 'Burpees, Plancha lateral, Saltos de cuerda'),
('2025-03-09', 'Flexiones explosivas, Sentadillas, Abdominales'),
('2025-03-10', 'Estiramientos, Ciclismo, Zancadas'),
('2025-03-11', 'Sentadillas búlgaras, Flexiones inclinadas, Plancha abdominal'),
('2025-03-12', 'Correr 4 km, Abdominales oblicuos, Estiramientos dinámicos'),
('2025-03-13', 'Zancadas inversas, Elevaciones frontales, Burpees modificados'),
('2025-03-14', 'Saltos de tijera, Sentadillas sumo, Flexiones cerradas'),
('2025-03-15', 'Ciclismo en interiores, Plancha con brazos extendidos, Abdominales inferiores'),
('2025-03-16', 'Sentadillas con salto, Flexiones explosivas, Estiramientos profundos'),
('2025-03-17', 'Correr 6 km, Zancadas con pesas, Elevaciones laterales con mancuernas'),
('2025-03-18', 'Burpees con salto, Plancha frontal, Saltos de cuerda dobles'),
('2025-03-19', 'Flexiones diamante, Sentadillas búlgaras, Abdominales cruzados'),
('2025-03-20', 'Estiramientos activos, Ciclismo al aire libre, Zancadas alternas'),
('2025-03-21', 'Sentadillas sumo, Flexiones inclinadas, Plancha lateral izquierda'),
('2025-03-22', 'Correr 3 km, Abdominales inferiores, Estiramientos estáticos'),
('2025-03-23', 'Zancadas con salto, Elevaciones frontales con banda elástica, Burpees lentos'),
('2025-03-24', 'Saltos de cuerda simples, Sentadillas con banda elástica, Flexiones abiertas'),
('2025-03-25', 'Ciclismo en montaña, Plancha con rodillas, Abdominales con elevación de piernas'),
('2025-03-26', 'Sentadillas con peso corporal, Flexiones explosivas, Estiramientos de espalda'),
('2025-03-27', 'Correr 5 km, Zancadas largas, Elevaciones laterales con pesas'),
('2025-03-28', 'Burpees con flexión, Plancha frontal con apoyo, Saltos de cuerda triples'),
('2025-03-29', 'Flexiones cerradas, Sentadillas sumo, Abdominales oblicuos intensos'),
('2025-03-30', 'Estiramientos de piernas, Ciclismo en grupo, Zancadas cortas'),
('2025-03-31', 'Sentadillas explosivas, Flexiones diamante, Plancha abdominal completa');

INSERT INTO confirmaciones (nombre, edad, peso, altura, sexo, fecha_rutina) VALUES
('Juan Pérez', 28, 75.5, 178.0, 'M', '2025-03-02'),
('María López', 34, 62.0, 165.0, 'F', '2025-03-02'),
('Carlos Ramírez', 22, 80.0, 180.0, 'M', '2025-03-02'),
('Ana Gómez', 29, 58.5, 168.0, 'F', '2025-03-02'),
('Luis Fernández', 31, 70.0, 175.0, 'M', '2025-03-02'),
('Sofía Torres', 26, 65.0, 170.0, 'F', '2025-03-02'),
('Diego Morales', 27, 78.0, 179.0, 'M', '2025-03-02'),
('Valeria Castro', 30, 60.0, 167.0, 'F', '2025-03-02'),
('Javier Mendoza', 33, 82.0, 182.0, 'M', '2025-03-02'),
('Laura Sánchez', 25, 55.0, 163.0, 'F', '2025-03-02');