-- ============================================================
-- TABLA: expenses
-- Gastos operativos de la tienda (alquiler, luz, sueldos, etc.)
-- Junto con las ventas, permite calcular la ganancia real:
-- Ganancia neta = Total ventas - Costo mercancia - Gastos operativos
-- ============================================================

create table expenses (
  id            uuid        primary key default gen_random_uuid(),
  store_id      uuid        not null references stores (id),

  -- Categoria del gasto para agrupar en reportes
  category      text        not null check (
    category in ('rent', 'utilities', 'salaries', 'transport', 'marketing', 'other')
  ),

  amount        numeric(12, 2) not null,

  description   text        not null,

  expense_date  date        not null default current_date,

  -- URL de la foto del comprobante subida a Supabase Storage
  receipt_url   text,

  created_by    uuid        references profiles (id),
  created_at    timestamp   not null default current_timestamp
);
