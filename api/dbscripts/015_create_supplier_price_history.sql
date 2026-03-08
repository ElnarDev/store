-- ============================================================
-- TABLA: supplier_price_history
-- Historico de precios por proveedor y producto.
-- Se llena automaticamente cada vez que se recibe una orden de compra.
-- Permite responder preguntas de Business Intelligence como:
-- - Como han evolucionado los precios de mis proveedores?
-- - Que proveedor me vende X producto mas barato historicamente?
-- ============================================================

create table supplier_price_history (
  -- Se agrega id propio: toda tabla debe tener primary key
  id                  uuid        primary key default gen_random_uuid(),

  supplier_id         uuid        not null references suppliers (id),
  product_id          uuid        not null references products (id),

  unit_cost           numeric(12, 2) not null,

  -- Referencia a la orden de compra que origino este registro
  purchase_order_id   uuid        not null references purchase_orders (id),

  effective_date      date        not null default current_date
);
