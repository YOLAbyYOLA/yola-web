-- ══════════════════════════════════════════════════════════════
-- YOLA Pro — tabla de suscripciones (pegado en Supabase SQL Editor)
-- Modelo: $1/mes promo lanzamiento → $2/mes oficial (24/09)
-- Suscripción POR ALMA (una cuenta .com cubre todos sus cuerpos)
-- ══════════════════════════════════════════════════════════════

create table if not exists public.subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  -- stripe | manual (contrato SUNAT / gift / dev) | promo
  provider text not null default 'stripe',
  stripe_customer_id text,
  stripe_subscription_id text unique,
  -- free | pro | pro_sunat
  tier text not null default 'free',
  -- active | past_due | canceled | trialing
  status text not null default 'active',
  -- precio acordado en centavos (100 = $1 promo, 200 = $2 oficial)
  amount_cents int not null default 100,
  -- promo lanzamiento: se mantiene $1 hasta que expire este campo
  promo_ends_at timestamptz,
  current_period_start timestamptz not null default now(),
  current_period_end timestamptz,
  cancel_at_period_end boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- RLS: cada usuario solo ve/edita SU suscripción
alter table public.subscriptions enable row level security;

drop policy if exists "subscriptions_select_own" on public.subscriptions;
create policy "subscriptions_select_own"
  on public.subscriptions for select
  using (auth.uid() = user_id);

drop policy if exists "subscriptions_insert_own" on public.subscriptions;
create policy "subscriptions_insert_own"
  on public.subscriptions for insert
  with check (auth.uid() = user_id);

drop policy if exists "subscriptions_update_own" on public.subscriptions;
create policy "subscriptions_update_own"
  on public.subscriptions for update
  using (auth.uid() = user_id);

-- Índice para el webhook (buscar por stripe_subscription_id)
create index if not exists idx_subscriptions_stripe
  on public.subscriptions (stripe_subscription_id);
create index if not exists idx_subscriptions_user
  on public.subscriptions (user_id);

-- ── Vista útil: el tier activo de cada usuario ──
create or replace view public.my_subscription as
  select id, user_id, tier, status, amount_cents, promo_ends_at,
         current_period_end, cancel_at_period_end
  from public.subscriptions
  where user_id = auth.uid()
  order by created_at desc
  limit 1;

-- ══════════════════════════════════════════════════════════════
-- NOTAS DE USO
-- 1. El webhook Stripe (checkout.session.completed + customer.subscription.updated/deleted)
--    escribe aquí usando el service_role key (evita RLS).
-- 2. El panel lee `my_subscription` (RLS aplica, cada uno la suya).
-- 3. El daemon consulta el tier del dueño vía /api/v1/account/status
--    (ya existe el endpoint) y habilita features Pro según tier != 'free'.
-- 4. Pro = sync prioritario + sin ads + privacidad extra + protección.
--    Pro_SUNAT = contrato empresarial (precio aparte, se factura manual).
-- ══════════════════════════════════════════════════════════════
