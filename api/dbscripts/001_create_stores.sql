-- ============================================================
-- TABLA: stores
-- Representa cada tienda del sistema.
-- El diseño multi-tienda permite que un mismo usuario dueño
-- pueda gestionar varias tiendas desde una sola cuenta.
-- ============================================================

create table stores (
  -- gen_random_uuid() genera un UUID aleatorio automaticamente
  -- cada vez que se inserta una fila. Nunca tendras que pasar el id manualmente.
  id          uuid        primary key default gen_random_uuid(),

  name        text        not null,
  address     text,
  phone       text,

  -- Guardar la moneda por tienda permite escalar a tiendas en distintos paises.
  -- Ejemplos: 'PEN', 'USD', 'COP', 'ARS'
  currency    text        not null default 'USD',

  -- RUC, NIT, RFC segun el pais
  tax_id      text,

  created_at  timestamp   not null default current_timestamp,

  -- updated_at se actualiza automaticamente via trigger (ver 002_triggers.sql)
  updated_at  timestamp   not null default current_timestamp,

  -- Soft delete: en lugar de borrar el registro, se marca con la fecha de eliminacion.
  -- Si deleted_at es NULL = activo. Si tiene fecha = eliminado.
  -- Esto preserva el historial contable y de auditoría.
  deleted_at  timestamp
);
