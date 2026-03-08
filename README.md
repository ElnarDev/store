# Store — Sistema de Gestión de Tienda

Sistema web PWA para gestión de inventario, ventas, compras, proveedores y reportes. Diseñado para escalar a múltiples tiendas.

---

## Stack Tecnológico

### Base de Datos
| Tecnología | Versión | Descripción |
|---|---|---|
| [PostgreSQL](https://www.postgresql.org/) | 15 | Motor de base de datos relacional |
| [Supabase](https://supabase.com/) | Cloud | Plataforma cloud que provee PostgreSQL + Auth + Storage |

### Backend
| Tecnología | Versión | Descripción |
|---|---|---|
| [Node.js](https://nodejs.org/) | 20 LTS | Entorno de ejecución de JavaScript en el servidor |
| [TypeScript](https://www.typescriptlang.org/) | 5.x | JavaScript con tipado estático |
| [NestJS](https://nestjs.com/) | 10.x | Framework para APIs REST estructuradas y escalables |
| [Prisma](https://www.prisma.io/) | 5.x | ORM para interactuar con PostgreSQL desde TypeScript |

### Frontend
| Tecnología | Versión | Descripción |
|---|---|---|
| [React](https://react.dev/) | 18.x | Librería para construir interfaces de usuario |
| [TypeScript](https://www.typescriptlang.org/) | 5.x | JavaScript con tipado estático |
| [Vite](https://vitejs.dev/) | 5.x | Herramienta de build rápida para el frontend |

---

## Requisitos Previos

Instala las siguientes herramientas antes de correr el proyecto:

### 1. Node.js 20 LTS
Descarga el instalador desde https://nodejs.org/ y elige la versión **20 LTS**.

Verifica la instalación:
```bash
node --version   # debe mostrar v20.x.x
npm --version    # debe mostrar 10.x.x
```

### 2. Git
Descarga desde https://git-scm.com/

Verifica:
```bash
git --version
```

### 3. Cuenta en Supabase
Crea una cuenta gratuita en https://supabase.com/
No se instala nada localmente, la base de datos vive en la nube.

---

## Variables de Entorno

El proyecto necesita un archivo `.env` en la carpeta `api/` con las credenciales de Supabase.
Crea el archivo copiando el ejemplo:

```bash
cp api/.env.example api/.env
```

Luego rellena los valores con los datos de tu proyecto en Supabase:
```env
DATABASE_URL=postgresql://postgres.[tu-project-ref]:[tu-password]@aws-1-sa-east-1.pooler.supabase.com:5432/postgres
SUPABASE_URL=https://[tu-project-ref].supabase.co
SUPABASE_ANON_KEY=[tu-anon-key]
```

> **Nunca subas el archivo `.env` a GitHub.** Ya está incluido en `.gitignore`.

---

## Estructura del Proyecto

```
store/
├── api/                  # Backend (NestJS + TypeScript)
│   ├── dbscripts/        # Scripts SQL de creación de tablas (migraciones)
│   └── src/              # Código fuente del backend
├── web/                  # Frontend (React + TypeScript + Vite)
└── README.md
```

---

## Base de Datos — Scripts de Creación

Los scripts SQL para crear todas las tablas están en `api/dbscripts/`, numerados en orden de ejecución:

| Archivo | Tabla |
|---|---|
| `001_create_stores.sql` | Tiendas |
| `002_create_triggers.sql` | Triggers automáticos (updated_at) |
| `003_create_profiles.sql` | Perfiles de usuario |
| `004_create_store_users.sql` | Relación usuario-tienda-rol |
| `005_create_categories.sql` | Categorías de productos |
| `006_create_suppliers.sql` | Proveedores |
| `007_create_products.sql` | Catálogo de productos |
| `008_create_inventory.sql` | Stock actual por producto |
| `009_create_stock_movements.sql` | Historial de movimientos de inventario |
| `010_create_customers.sql` | Clientes |
| `011_create_sales.sql` | Cabecera de ventas |
| `012_create_sale_items.sql` | Detalle de ventas |
| `013_create_purchase_orders.sql` | Órdenes de compra |
| `014_create_purchase_order_items.sql` | Detalle de órdenes de compra |
| `015_create_supplier_price_history.sql` | Histórico de precios por proveedor |
| `016_create_expenses.sql` | Gastos operativos |

> Los scripts deben ejecutarse **en orden numérico** porque las tablas posteriores referencian a las anteriores mediante claves foráneas.
