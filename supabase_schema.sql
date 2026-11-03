-- JIDOK 2027 — executar no SQL Editor do Supabase (projeto próprio)
-- A chave public/anon é segura para o navegador com RLS; NUNCA utilizar service_role no site.
create extension if not exists pgcrypto;

create table if not exists public.jidok_roles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  is_admin boolean not null default false
);
alter table public.jidok_roles enable row level security;
drop policy if exists "jidok_roles_own_read" on public.jidok_roles;
create policy "jidok_roles_own_read" on public.jidok_roles
for select to authenticated using (user_id = (select auth.uid()));
revoke all on public.jidok_roles from anon;
grant select on public.jidok_roles to authenticated;

create or replace function public.jidok_is_admin()
returns boolean language sql stable security definer set search_path = ''
as $$
  select exists(
    select 1 from public.jidok_roles
    where user_id = (select auth.uid()) and is_admin is true
  );
$$;
revoke all on function public.jidok_is_admin() from public;
grant execute on function public.jidok_is_admin() to authenticated;

create table if not exists public.jidok_site_config (
  id integer primary key check (id = 1),
  site_data jsonb not null,
  updated_at timestamptz not null default now(),
  updated_by uuid references auth.users(id)
);
alter table public.jidok_site_config enable row level security;
drop policy if exists "jidok_config_public_read" on public.jidok_site_config;
drop policy if exists "jidok_config_admin_insert" on public.jidok_site_config;
drop policy if exists "jidok_config_admin_update" on public.jidok_site_config;
create policy "jidok_config_public_read" on public.jidok_site_config
for select to anon, authenticated using (true);
create policy "jidok_config_admin_insert" on public.jidok_site_config
for insert to authenticated with check ((select public.jidok_is_admin()));
create policy "jidok_config_admin_update" on public.jidok_site_config
for update to authenticated using ((select public.jidok_is_admin()))
with check ((select public.jidok_is_admin()));
grant select on public.jidok_site_config to anon, authenticated;
grant insert, update on public.jidok_site_config to authenticated;

create table if not exists public.jidok_score_entries (
  id uuid primary key default gen_random_uuid(),
  team_id text not null,
  points numeric(28,0) not null check (points <> 0),
  category text not null default 'Geral',
  reason text not null check (char_length(reason) between 3 and 1000),
  event_date date not null default current_date,
  created_at timestamptz not null default now(),
  created_by uuid not null default auth.uid() references auth.users(id)
);
create index if not exists jidok_score_team_date_idx
  on public.jidok_score_entries (team_id, event_date desc, created_at desc);
alter table public.jidok_score_entries enable row level security;
drop policy if exists "jidok_scores_public_read" on public.jidok_score_entries;
drop policy if exists "jidok_scores_admin_insert" on public.jidok_score_entries;
create policy "jidok_scores_public_read" on public.jidok_score_entries
for select to anon, authenticated using (true);
create policy "jidok_scores_admin_insert" on public.jidok_score_entries
for insert to authenticated with check (
  (select public.jidok_is_admin()) and created_by = (select auth.uid())
);
grant select on public.jidok_score_entries to anon, authenticated;
grant insert on public.jidok_score_entries to authenticated;
-- Não habilitar UPDATE ou DELETE: correções são novos lançamentos positivos/negativos.

-- Criar o administrador após cadastrar usuário pelo Authentication > Users:
-- insert into public.jidok_roles(user_id,is_admin)
-- values ('COLE_AQUI_O_UUID_DO_USUARIO', true)
-- on conflict (user_id) do update set is_admin = true;

-- A primeira configuração é gravada pelo botão "Publicar alterações" do painel.
-- Até lá, o site carrega o cronograma padrão de programacao.json.
