-- ============================================================
-- TABLA: profiles
-- Extiende el usuario de Supabase Auth (auth.users).
-- Supabase maneja el login/password en su propia tabla interna.
-- Nosotros creamos profiles para datos adicionales del usuario
-- como nombre completo y foto de perfil.
-- ============================================================

create table profiles (
  -- Este id NO es autogenerado: debe ser el mismo UUID que Supabase
  -- asigna al usuario en auth.users. Asi los vinculamos.
  id          uuid        primary key,

  full_name   text        not null,
  avatar_url  text,

  created_at  timestamp   not null default current_timestamp
);
