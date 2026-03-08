-- ============================================================
-- TABLA: inventory
-- Stock actual de cada producto en cada tienda.
-- Esta tabla tiene UNA fila por producto. Se actualiza cada
-- vez que entra o sale mercancia.
--
-- NUNCA se modifica directamente desde el frontend.
-- Solo se actualiza como consecuencia de registrar un
-- movimiento en stock_movements.
-- ============================================================

create table inventory (
  id             uuid        primary key default gen_random_uuid(),
  product_id     uuid        not null references products (id),
  store_id       uuid        not null references stores (id),

  current_stock  numeric(12, 2) not null default 0,

  last_updated   timestamp   not null default current_timestamp,

  -- Auditoria: quien hizo el ultimo cambio en el stock
  updated_by     uuid        references profiles (id),

  -- Garantiza que no puede haber dos filas para el mismo producto en la misma tienda
  unique (product_id, store_id)
);
