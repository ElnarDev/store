-- ============================================================
-- TABLA: purchase_orders
-- Ordenes de compra enviadas a proveedores.
-- Cuando se recibe la mercancia, se actualiza el inventario
-- y se registra en stock_movements con type='purchase'.
-- ============================================================

create table purchase_orders (
  id              uuid        primary key default gen_random_uuid(),
  store_id        uuid        not null references stores (id),
  supplier_id     uuid        not null references suppliers (id),

  order_number    text        not null,

  -- Ciclo de vida de una orden:
  -- draft           -> borrador, aun no enviada
  -- sent            -> enviada al proveedor
  -- partial_received-> llego una parte de lo pedido
  -- received        -> llego todo
  -- cancelled       -> cancelada
  status          text        not null default 'draft' check (
    status in ('draft', 'sent', 'partial_received', 'received', 'cancelled')
  ),

  total           numeric(12, 2) not null default 0,

  expected_date   date,
  received_date   date,
  notes           text,

  created_by      uuid        references profiles (id),
  created_at      timestamp   not null default current_timestamp
);
