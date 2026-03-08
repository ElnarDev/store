-- ============================================================
-- TABLA: products
-- Catalogo de productos de la tienda.
-- OJO: esta tabla guarda el PRECIO ACTUAL.
-- Los precios historicos al momento de cada venta se guardan
-- en sale_items.unit_price, no aqui.
-- ============================================================

create table products (
  id               uuid        primary key default gen_random_uuid(),
  store_id         uuid        not null references stores (id),
  category_id      uuid        references categories (id),

  name             text        not null,
  description      text,

  -- SKU (Stock Keeping Unit): codigo interno unico por producto.
  -- UNIQUE garantiza que no pueden existir dos productos con el mismo SKU.
  sku              text        unique,

  -- Codigo de barras para lector fisico en caja
  barcode          text,

  -- 'unidad', 'kg', 'litro', 'caja', etc.
  unit_of_measure  text        not null default 'unidad',

  -- NUMERIC es el tipo correcto para dinero en PostgreSQL.
  -- Evita errores de redondeo que tiene FLOAT/REAL con decimales.
  sale_price       numeric(12, 2),
  min_sale_price   numeric(12, 2),
  cost_price       numeric(12, 2),

  -- Stock minimo para generar alerta de reabastecimiento
  min_stock        integer     not null default 0,

  is_active        boolean     not null default true,
  image_url        text,

  deleted_at       timestamp
);
