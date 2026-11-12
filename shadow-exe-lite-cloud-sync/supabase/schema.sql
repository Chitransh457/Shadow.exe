-- Run this entire script in Supabase Dashboard > SQL Editor.
create table if not exists public.hunter_saves (
  user_id uuid primary key references auth.users(id) on delete cascade,
  state jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.hunter_saves enable row level security;

-- Each signed-in user can read and change only their own save.
create policy "Users can read their own hunter save"
  on public.hunter_saves for select
  to authenticated
  using (auth.uid() = user_id);

create policy "Users can insert their own hunter save"
  on public.hunter_saves for insert
  to authenticated
  with check (auth.uid() = user_id);

create policy "Users can update their own hunter save"
  on public.hunter_saves for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
