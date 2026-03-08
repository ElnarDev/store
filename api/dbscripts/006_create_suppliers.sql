-- ============================================================
-- TABLA: suppliers
-- Proveedores de la tienda. Cada tienda maneja sus propios proveedores.
-- ============================================================

create table suppliers (
  id            uuid        primary key default gen_random_uuid(),
  store_id      uuid        not null references stores (id),

  name          text        not null,
  contact_name  text,
  phone         text,
  email         text,

  -- Para emitir facturas de compra a nombre del proveedor
  tax_id        text,

  notes         text,

  deleted_at    timestamp
);
