# Sorelli Secret Santa — installable web app

Static site (GitHub Pages) + free Supabase database for the wishlists.
Anyone with the link can view the draw and edit wishlists. No accounts for the family.

## 1. Database (Supabase, free)
1. Sign up at https://supabase.com and create a new project (any name, region EU).
2. Open **SQL Editor**, paste all of `supabase-setup.sql`, press **Run**.
3. Open **Project Settings → API**. Copy the **Project URL** and the **anon public** key.
4. Put both into `config.js`.

## 2. Hosting (GitHub Pages, free)
1. Create a public repository, e.g. `sorelli-secret-santa`.
2. Upload every file and the `icons` folder (Add file → Upload files).
3. Settings → Pages → Source: *Deploy from a branch* → `main` / `(root)` → Save.
4. After a minute the app is at `https://<your-github-name>.github.io/sorelli-secret-santa/`.

## 3. Install on phones
- Android / Chrome: open the link, tap **Install the app** at the bottom (or browser menu → Install).
- iPhone: open the link in Safari → Share → **Add to Home Screen**.

## Updating
- Change `index.html`, then bump `VERSION` in `sw.js` (`ss-v1` → `ss-v2`) so installed copies refresh.
- New year: future drafts are generated in `index.html` from `HISTORY`; once a year's list is final, add it to `HISTORY` and raise `LAST_REAL`.
