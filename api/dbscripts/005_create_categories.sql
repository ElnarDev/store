-- ============================================================
-- TABLA: categories
-- Categorias de productos. Soporta subcategorias mediante
-- auto-referencia (parent_id apunta a la misma tabla).
--
-- Ejemplo de jerarquia:
-- Bebidas (parent_id = NULL)
--   └── Jugos (parent_id = id de "Bebidas")
--         └── Jugos Naturales (parent_id = id de "Jugos")
-- ============================================================

create table categories (
  id          uuid        primary key default gen_random_uuid(),
  store_id    uuid        not null references stores (id),

  name        text        not null,

  -- Auto-referencia: una categoria puede tener una categoria padre.
  -- Es nullable porque las categorias raiz no tienen padre.
  parent_id   uuid        references categories (id),

  deleted_at  timestamp
);
