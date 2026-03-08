-- ============================================================
-- TABLA: stock_movements
-- Historial COMPLETO de todos los movimientos de inventario.
-- Es una de las tablas mas importantes del sistema.
--
-- Cada vez que el stock cambia (por venta, compra, ajuste, etc.)
-- se registra una fila aqui. Nunca se borran estos registros.
-- Esto permite reconstruir el estado del inventario en cualquier
-- punto del tiempo y responder preguntas de auditoria.
-- ============================================================

create table stock_movements (
  id              uuid        primary key default gen_random_uuid(),
  product_id      uuid        not null references products (id),
  store_id        uuid        not null references stores (id),

  -- Tipo de movimiento:
  -- purchase   -> entrada por compra a proveedor
  -- sale       -> salida por venta a cliente
  -- adjustment -> ajuste manual (ej: conteo fisico, producto danado)
  -- return     -> devolucion de cliente
  -- transfer   -> transferencia entre tiendas propias
  movement_type   text        not null check (
    movement_type in ('purchase', 'sale', 'adjustment', 'return', 'transfer')
  ),

  -- Positivo = entrada de stock, Negativo = salida de stock
  quantity        numeric(12, 2) not null,

  -- Guardar stock antes y despues permite auditoria completa:
  -- si alguien pregunta "como llegamos a -2 unidades?" puedes
  -- reconstruir cada paso de la historia.
  stock_before    numeric(12, 2) not null,
  stock_after     numeric(12, 2) not null,

  -- De donde vino este movimiento (para trazabilidad)
  -- Ejemplo: reference_type='sale', reference_id=id de la venta
  reference_type  text,
  reference_id    uuid,

  -- Para ajustes manuales: obligatorio explicar el motivo
  notes           text,

  created_by      uuid        references profiles (id),
  created_at      timestamp   not null default current_timestamp
);
