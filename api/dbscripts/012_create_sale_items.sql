-- ============================================================
-- TABLA: sale_items
-- Detalle de cada producto incluido en una venta.
-- Una venta puede tener muchos items.
--
-- PUNTO CRITICO: unit_price y cost_price se copian al momento
-- de la venta. Si manana cambia el precio del producto, estas
-- ventas historicas siguen mostrando el precio que tenia el dia
-- que se vendio. Esto es fundamental para integridad contable.
-- ============================================================

create table sale_items (
  id                   uuid        primary key default gen_random_uuid(),
  sale_id              uuid        not null references sales (id),
  product_id           uuid        not null references products (id),

  quantity             numeric(12, 2) not null,

  -- Precio de venta al momento de la venta (snapshot historico)
  unit_price           numeric(12, 2) not null,

  -- Costo al momento de la venta (para calcular margen historico)
  cost_price           numeric(12, 2) not null,

  discount_percentage  numeric(5, 2) not null default 0,

  subtotal             numeric(12, 2) not null
);
