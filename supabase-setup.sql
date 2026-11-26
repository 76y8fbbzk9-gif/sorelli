-- Sorelli Secret Santa: wishlist storage.
-- Paste into Supabase → SQL Editor → Run. Safe to run more than once.

create table if not exists public.wishes (
  id          text primary key,
  text        text not null default '',
  name        text,
  updated_at  timestamptz not null default now(),
  constraint wishes_id_format  check (id ~ '^([0-9]{4}__)?[a-z0-9-]{1,60}__(low|mid|high)$'),
  constraint wishes_text_size  check (char_length(text) <= 5000)
);

alter table public.wishes enable row level security;

-- Anyone with the link can read, add and edit wishlists. Nobody can delete rows through the app.
drop policy if exists "wishes read"   on public.wishes;
drop policy if exists "wishes insert" on public.wishes;
drop policy if exists "wishes update" on public.wishes;
create policy "wishes read"   on public.wishes for select to anon using (true);
create policy "wishes insert" on public.wishes for insert to anon with check (true);
create policy "wishes update" on public.wishes for update to anon using (true) with check (true);

-- Live updates between phones.
do $$ begin
  alter publication supabase_realtime add table public.wishes;
exception when duplicate_object then null; end $$;

-- Wishlist entries already written on the Claude version of the page (2026).
insert into public.wishes (id, text, name) values
  ('jack__low',  'Qualcosa da mangiare buono (veggie please), o un buon té, o qualcosa fatto a mano un disegno o uno scherzo', 'Jack'),
  ('jack__high', 'a refurbished iphone 14 256gb? ', 'Jack')
on conflict (id) do nothing;
