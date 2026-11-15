-- Proyecto: Gestión de préstamos
-- Motor: SQLite3
-- Relaciones:
-- Cliente 1:N Prestamo
-- Recurso 1:N Prestamo
-- Cliente y Recurso tienen una relación conceptual N:M resuelta por Prestamo.

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Prestamo;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Recurso;

CREATE TABLE Cliente (
    id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    telefono TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE
);

CREATE TABLE Recurso (
    id_recurso INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    descripcion TEXT,
    estado TEXT NOT NULL CHECK (estado IN ('Disponible', 'Prestado', 'Mantenimiento'))
);

CREATE TABLE Prestamo (
    id_prestamo INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente INTEGER NOT NULL,
    id_recurso INTEGER NOT NULL,
    fecha_prestamo TEXT NOT NULL,
    fecha_devolucion TEXT NOT NULL,
    estado TEXT NOT NULL CHECK (estado IN ('Activo', 'Devuelto', 'Atrasado')),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_recurso) REFERENCES Recurso(id_recurso)
);

-- Datos de ejemplo: 5 registros por tabla
INSERT INTO Cliente (nombre, apellido, telefono, correo) VALUES
('Carlos', 'Pérez', '809-555-0101', 'carlos.perez@email.com'),
('María', 'Gómez', '809-555-0102', 'maria.gomez@email.com'),
('Juan', 'Rodríguez', '809-555-0103', 'juan.rodriguez@email.com'),
('Ana', 'Martínez', '809-555-0104', 'ana.martinez@email.com'),
('Pedro', 'Sánchez', '809-555-0105', 'pedro.sanchez@email.com');

INSERT INTO Recurso (nombre, descripcion, estado) VALUES
('Laptop Lenovo', 'Laptop para uso académico', 'Prestado'),
('Proyector Epson', 'Proyector multimedia', 'Prestado'),
('Tablet Samsung', 'Tablet de 10 pulgadas', 'Disponible'),
('Cámara Canon', 'Cámara digital', 'Prestado'),
('Impresora HP', 'Impresora multifunción', 'Disponible');

INSERT INTO Prestamo (id_cliente, id_recurso, fecha_prestamo, fecha_devolucion, estado) VALUES
(1, 1, '2026-11-01', '2026-11-10', 'Activo'),
(2, 2, '2026-11-02', '2026-11-12', 'Activo'),
(3, 3, '2026-10-15', '2026-10-20', 'Devuelto'),
(1, 4, '2026-11-05', '2026-11-15', 'Activo'),
(4, 5, '2026-10-25', '2026-10-30', 'Devuelto');

-- Consulta relacionada usando INNER JOIN
SELECT
    p.id_prestamo,
    c.nombre || ' ' || c.apellido AS cliente,
    r.nombre AS recurso,
    p.fecha_prestamo,
    p.fecha_devolucion,
    p.estado AS estado_prestamo
FROM Prestamo AS p
INNER JOIN Cliente AS c ON p.id_cliente = c.id_cliente
INNER JOIN Recurso AS r ON p.id_recurso = r.id_recurso
ORDER BY p.id_prestamo;

-- Otras consultas útiles
SELECT * FROM Cliente;
SELECT * FROM Recurso;
SELECT * FROM Prestamo;
