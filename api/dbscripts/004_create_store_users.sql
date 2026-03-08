-- ============================================================
-- TABLA: store_users
-- Tabla pivote (de union) entre stores y profiles.
-- Responde la pregunta: "que usuario trabaja en que tienda y con que rol?"
--
-- Un usuario puede trabajar en varias tiendas.
-- Una tienda puede tener varios usuarios.
-- Esto se llama relacion MUCHOS A MUCHOS (many-to-many).
-- ============================================================

create table store_users (
  id          uuid        primary key default gen_random_uuid(),

  -- REFERENCES crea una Foreign Key (llave foranea).
  -- Significa: el valor de store_id DEBE existir en stores.id.
  -- PostgreSQL rechazara cualquier insercion con un store_id que no exista.
  store_id    uuid        not null references stores (id),
  user_id     uuid        not null references profiles (id),

  -- El rol define que puede hacer el usuario en esa tienda:
  -- owner    -> dueno, acceso total
  -- manager  -> gerente, puede ver reportes y gestionar productos
  -- cashier  -> cajero, solo puede registrar ventas
  role        text        not null check (role in ('owner', 'manager', 'cashier')),

  is_active   boolean     not null default true,

  created_at  timestamp   not null default current_timestamp
);
