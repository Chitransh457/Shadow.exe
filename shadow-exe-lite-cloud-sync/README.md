# SHADOW.exe Lite — Cloud Sync edition

A responsive, static personal productivity tracker. It runs without npm or a build step. Local browser saving works immediately; optional Supabase authentication and cloud backup sync the same Hunter save between devices.

## 1. Run locally

1. Extract the folder.
2. Open `index.html` in a browser, or use VS Code Live Server.
3. Local progress is automatically saved in that browser.

Cloud authentication generally requires serving the site over `http://localhost` or HTTPS, so use Live Server for local cloud-sync testing rather than opening the file directly.

## 2. Configure Supabase cloud sync

### Create a project

1. Create a project at https://supabase.com/.
2. In the project dashboard, open **SQL Editor**.
3. Open `supabase/schema.sql` from this project, copy its complete contents, paste into SQL Editor, and run it.
4. Open **Project Settings → API** (or the API Keys page).
5. Copy the Project URL and the `anon` / publishable public key.

### Add the project keys

Open `config.js` and replace the placeholders:

```js
window.SHADOW_CONFIG = {
  SUPABASE_URL: 'https://YOUR-PROJECT.supabase.co',
  SUPABASE_ANON_KEY: 'YOUR_PUBLIC_ANON_OR_PUBLISHABLE_KEY'
};
```

Only use the public anon/publishable key in this browser app. **Never put a service-role key in `config.js`.** The SQL enables Row Level Security so each account can access only its own row.

### Authentication settings

In Supabase **Authentication → URL Configuration**, add your deployed Vercel URL to the allowed Site URL / Redirect URLs. For local testing, also add your local Live Server URL, e.g. `http://127.0.0.1:5500/**`.

For easiest first setup, you can temporarily turn off email confirmation under **Authentication → Providers → Email**. If email confirmation remains enabled, create your account, confirm the email, then return and sign in.

## 3. Deploy to Vercel

1. Upload the contents of this folder to the root of a GitHub repository (including `config.js` and the `supabase` folder).
2. Import the repository into https://vercel.com/.
3. Framework preset: **Other**.
4. Build command: leave empty.
5. Output directory: `.` (root).
6. Deploy.

After changing `config.js`, commit and push the change; Vercel will redeploy automatically.

## 4. Sync between devices

1. Open the deployed Vercel URL on your computer.
2. Select **CLOUD SYNC** in the top bar.
3. Create an account with email and password.
4. If a cloud save already exists on a device, choose whether to load the cloud save or upload the current device's save.
5. Open the same URL on your phone and sign in with the same account.

Changes are saved locally immediately and uploaded to Supabase shortly after each change. You can also use **SYNC NOW**. If the network is unavailable, local progress remains on that device and you can sync again when online.

## Important sync behavior

- LocalStorage is the offline copy; Supabase is the cross-device copy.
- On first sign-in to a device, if a cloud save exists, you are asked whether to load it or replace it with that device's local save. Choose carefully.
- This starter version stores one JSON save per account. Avoid editing the same account on multiple devices simultaneously; last successful save wins. A future revision can add conflict-aware merging and per-activity history.
- Sign out does not erase the local save.
- Do not share your password or public project configuration. The anon/publishable key is designed for browser use when RLS is configured correctly.
