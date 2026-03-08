-- ============================================================
-- TRIGGER: updated_at
-- Un trigger es una funcion que PostgreSQL ejecuta automaticamente
-- cuando ocurre un evento (INSERT, UPDATE, DELETE) en una tabla.
--
-- Este trigger actualiza el campo updated_at con la fecha actual
-- cada vez que se modifica cualquier fila en cualquier tabla que lo use.
-- ============================================================

-- Primero creamos la FUNCION que ejecutara el trigger.
-- RETURNS TRIGGER es un tipo especial de retorno solo para triggers.
-- NEW hace referencia a la fila con los nuevos valores que se esta guardando.
create or replace function update_updated_at()
returns trigger as $$
begin
  NEW.updated_at = current_timestamp;
  return NEW;
end;
$$ language plpgsql;

-- Luego vinculamos la funcion a la tabla stores.
-- BEFORE UPDATE significa: ejecuta esto ANTES de guardar el cambio.
-- FOR EACH ROW significa: ejecutalo por cada fila modificada.
create trigger set_updated_at_stores
  before update on stores
  for each row
  execute function update_updated_at();

-- NOTA: Cada tabla que tenga campo updated_at necesita su propio trigger.
-- Los iremos agregando en cada archivo de tabla correspondiente.
