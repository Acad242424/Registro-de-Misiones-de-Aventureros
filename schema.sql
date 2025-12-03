-- esquema SQL para SQLite: aventuras (héroes, misiones, monstruos, relaciones)
PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS heroes (
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    clase TEXT NOT NULL,
    nivel_experiencia INTEGER NOT NULL DEFAULT 0 CHECK (nivel_experiencia >= 0),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS misiones (
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    descripcion TEXT,
    dificultad INTEGER NOT NULL CHECK (dificultad BETWEEN 1 AND 10),
    ubicacion TEXT,
    recompensa INTEGER NOT NULL DEFAULT 0 CHECK (recompensa >= 0),
    fecha_mision DATE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS monstruos (
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    tipo TEXT NOT NULL,
    nivel_amenaza INTEGER NOT NULL CHECK (nivel_amenaza BETWEEN 1 AND 10),
    descripcion TEXT,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla puente: muchos-a-muchos entre misiones y heroes
CREATE TABLE IF NOT EXISTS misiones_heroes (
    mision_id INTEGER NOT NULL,
    hero_id INTEGER NOT NULL,
    rol TEXT, -- opcional: p.ej. "lider", "sanador"
    dano_infligido INTEGER DEFAULT 0 CHECK (dano_infligido >= 0),
    PRIMARY KEY (mision_id, hero_id),
    FOREIGN KEY (mision_id) REFERENCES misiones(id) ON DELETE CASCADE,
    FOREIGN KEY (hero_id) REFERENCES heroes(id) ON DELETE CASCADE
);

-- Tabla puente: muchos-a-muchos entre misiones y monstruos
CREATE TABLE IF NOT EXISTS misiones_monstruos (
    mision_id INTEGER NOT NULL,
    monstruo_id INTEGER NOT NULL,
    cantidad INTEGER DEFAULT 1 CHECK (cantidad > 0),
    PRIMARY KEY (mision_id, monstruo_id),
    FOREIGN KEY (mision_id) REFERENCES misiones(id) ON DELETE CASCADE,
    FOREIGN KEY (monstruo_id) REFERENCES monstruos(id) ON DELETE CASCADE
);

-- Índices sugeridos para búsquedas frecuentes
CREATE INDEX IF NOT EXISTS idx_heroes_clase ON heroes(clase);
CREATE INDEX IF NOT EXISTS idx_misiones_ubicacion ON misiones(ubicacion);
CREATE INDEX IF NOT EXISTS idx_monstruos_tipo ON monstruos(tipo);
