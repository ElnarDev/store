-- ============================================================
-- TABLA: customers
-- Clientes de la tienda.
-- Es opcional al registrar una venta (customer_id puede ser NULL
-- en la tabla sales para ventas rapidas sin cliente identificado).
-- ============================================================

create table customers (
  id          uuid        primary key default gen_random_uuid(),
  store_id    uuid        not null references stores (id),

  name        text        not null,
  email       text,
  phone       text,

  -- Para emitir facturas a nombre del cliente
  tax_id      text,

  notes       text,

  deleted_at  timestamp
);
