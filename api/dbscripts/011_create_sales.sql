-- ============================================================
-- TABLA: sales
-- Cabecera de cada venta. Contiene los totales y datos generales.
-- El detalle de que productos se vendieron va en sale_items.
--
-- Una venta tiene UNA cabecera (sales) y MUCHOS items (sale_items).
-- Esto se llama relacion UNO A MUCHOS (one-to-many).
-- ============================================================

create table sales (
  id              uuid        primary key default gen_random_uuid(),
  store_id        uuid        not null references stores (id),

  -- Nullable: las ventas rapidas no requieren cliente registrado
  customer_id     uuid        references customers (id),

  -- Numero secuencial por tienda para el comprobante (0001, 0002...)
  sale_number     integer     not null,

  subtotal        numeric(12, 2) not null default 0,
  discount_amount numeric(12, 2) not null default 0,
  tax_amount      numeric(12, 2) not null default 0,
  total           numeric(12, 2) not null default 0,
  amount_paid     numeric(12, 2) not null default 0,
  change_amount   numeric(12, 2) not null default 0,

  payment_method  text        not null check (
    payment_method in ('cash', 'card', 'transfer', 'credit')
  ),

  status          text        not null default 'completed' check (
    status in ('completed', 'cancelled', 'returned')
  ),

  -- Fecha real de la venta (puede diferir de created_at si hay ajustes)
  sale_date       timestamp   not null default current_timestamp,

  created_by      uuid        references profiles (id),
  created_at      timestamp   not null default current_timestamp,

  -- El numero de venta debe ser unico por tienda
  unique (store_id, sale_number)
);
