-- ============================================================
-- TABLA: purchase_order_items
-- Detalle de cada producto en una orden de compra.
-- quantity_received puede ser menor a quantity_ordered cuando
-- el proveedor entrega parcialmente (status = 'partial_received').
-- ============================================================

create table purchase_order_items (
  -- Se agrega id propio: toda tabla debe tener primary key
  id                  uuid        primary key default gen_random_uuid(),

  purchase_order_id   uuid        not null references purchase_orders (id),
  product_id          uuid        not null references products (id),

  quantity_ordered    numeric(12, 2) not null,

  -- Puede ser menor si el proveedor entrego parcialmente
  quantity_received   numeric(12, 2) not null default 0,

  -- Precio de compra en esta orden especifica (para historial de precios)
  unit_cost           numeric(12, 2) not null,

  subtotal            numeric(12, 2) not null
);
