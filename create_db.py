#!/usr/bin/env python3
"""Crea la base de datos SQLite 'aventuras.db' usando schema.sql y agrega datos de ejemplo."""
import sqlite3
from pathlib import Path

base = Path(__file__).parent / "aventuras.db"
schema_file = Path(__file__).parent / "schema.sql"

conn = sqlite3.connect(base)
cur = conn.cursor()

# habilitar foreign keys en sqlite
cur.execute("PRAGMA foreign_keys = ON;")

schema_sql = schema_file.read_text(encoding="utf-8")
cur.executescript(schema_sql)

# Inserciones de ejemplo
heroes = [
    ("Aelin", "Mago", 1200),
    ("Borin", "Guerrero", 850),
    ("Lyra", "Arquera", 620),
]

misiones = [
    ("La Caverna del Eco", "Explorar la caverna y recuperar la gema", 6, "Montañas Grises", 500, "2025-11-10"),
    ("Noche en el Bosque Maldito", "Investigar extraños ruidos y limpiar el lugar", 8, "Bosque Lóbrego", 1200, "2025-11-22"),
]

monstruos = [
    ("Gorak", "Goblin", 3),
    ("Fauzard", "Dragón", 9),
    ("Espectro Sombrío", "No-muerto", 7),
]

cur.executemany("INSERT INTO heroes (nombre, clase, nivel_experiencia) VALUES (?, ?, ?);", heroes)
cur.executemany("INSERT INTO misiones (nombre, descripcion, dificultad, ubicacion, recompensa, fecha_mision) VALUES (?, ?, ?, ?, ?, ?);", misiones)
cur.executemany("INSERT INTO monstruos (nombre, tipo, nivel_amenaza) VALUES (?, ?, ?);", monstruos)

# Asociaciones (mision_id y hero_id asumen autoincrement empezando en 1)
cur.execute("INSERT INTO misiones_heroes (mision_id, hero_id, rol, dano_infligido) VALUES (1, 1, 'mago_apoyo', 120);")
cur.execute("INSERT INTO misiones_heroes (mision_id, hero_id, rol, dano_infligido) VALUES (1, 2, 'tanque', 430);")
cur.execute("INSERT INTO misiones_monstruos (mision_id, monstruo_id, cantidad) VALUES (1, 1, 8);")
cur.execute("INSERT INTO misiones_monstruos (mision_id, monstruo_id, cantidad) VALUES (2, 3, 2);")

conn.commit()
conn.close()

print('Base de datos creada en:', base)
