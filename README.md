# Proyecto: BD Aventuras (SQLite)
Descripción
Este proyecto incluye un modelo lógico relacional (SQLite) para registrar información sobre misiones, héroes y monstruos en un mundo de aventuras.

Contenido
- schema.sql: definiciones de tablas y restricciones.
- create_db.py: script para crear la base de datos 'aventuras.db' y poblarla con datos de ejemplo.
- aventuras.db: base de datos SQLite generada (si ejecuta create_db.py).
- er_diagram.png: diagrama ER simple (imagen).
Cómo usar
1. Descargar los archivos.
2. (Opcional) ejecutar `python3 create_db.py` para crear `aventuras.db` y ver los datos de ejemplo.
3. Abrir `schema.sql` para revisar el esquema o cargar `aventuras.db` en DB Browser for SQLite.

Notas técnicas
- Las tablas puente usan claves primarias compuestas (mision_id, hero_id) y (mision_id, monstruo_id).
- Se usan CHECK para validar rango de dificultades y niveles de amenaza.
- ON DELETE CASCADE en las FK para mantener integridad en eliminaciones.

Autor: Generado con ayuda de ChatGPT.
