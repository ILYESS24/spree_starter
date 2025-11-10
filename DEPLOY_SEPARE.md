# 🚀 Déploiement séparé Backend/Frontend sur Render

Guide pour séparer le backend et le frontend en deux services distincts pour économiser l'espace.

## 🎯 Avantages

- ✅ **Économie d'espace**: Backend sans assets lourds
- ✅ **Performance**: Frontend servi depuis un CDN
- ✅ **Scalabilité**: Peut scaler indépendamment
- ✅ **Séparation des responsabilités**

## 📋 Architecture

```
┌─────────────────┐
│  Frontend       │  → Service statique (assets CSS/JS)
│  (Static Site)  │
└─────────────────┘
        │
        ↓ (API calls)
┌─────────────────┐
│  Backend API    │  → Rails API (sans assets)
│  (Rails)        │
└─────────────────┘
        │
        ↓
┌─────────────────┐
│  PostgreSQL     │
│  + Redis        │
└─────────────────┘
```

## 🚀 Option 1: Backend + Frontend séparés (Recommandé)

### Étape 1: Créer le service Backend

1. Allez sur [Render Dashboard](https://dashboard.render.com)
2. Cliquez sur "New" → "Web Service"
3. Connectez votre repo: `https://github.com/ILYESS24/spree_starter.git`
4. Configuration:
   - **Name**: `spree-backend`
   - **Runtime**: `Ruby`
   - **Build Command**: 
     ```bash
     bundle install --deployment --without development test
     ```
   - **Start Command**: 
     ```bash
     bundle exec puma -C config/puma.rb
     ```
   - **Plan**: `Free` (ou `Starter` pour production)

5. Variables d'environnement:
   ```
   RAILS_ENV=production
   SECRET_KEY_BASE=<votre_clé>
   DATABASE_URL=<URL de votre base>
   REDIS_URL=<URL Redis>
   RAILS_SERVE_STATIC_FILES=false
   WEB_CONCURRENCY=1
   PORT=3000
   ```

### Étape 2: Créer le service Frontend (Static)

1. Dans Render Dashboard, cliquez sur "New" → "Static Site"
2. Connectez votre repo: `https://github.com/ILYESS24/spree_starter.git`
3. Configuration:
   - **Name**: `spree-frontend`
   - **Build Command**: 
     ```bash
     bundle install --deployment &&
     RAILS_ENV=production SECRET_KEY_BASE=dummy bin/rails assets:precompile &&
     bin/rails assets:clean
     ```
   - **Publish Directory**: `public`
   - **Plan**: `Free`

### Étape 3: Configurer CORS (si nécessaire)

Si le frontend appelle l'API depuis un domaine différent, ajoutez dans `config/application.rb`:

```ruby
config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'  # Ou votre domaine frontend
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

Et ajoutez dans `Gemfile`:
```ruby
gem 'rack-cors'
```

## 🚀 Option 2: Backend uniquement (Plus simple)

Si vous voulez juste économiser l'espace sans séparer complètement:

### Configuration Backend optimisée

1. Créez un service web avec:
   - **Build Command**: 
     ```bash
     bundle install --deployment --without development test assets
     ```
   - **Variables**:
     ```
     RAILS_SERVE_STATIC_FILES=false
     ```

2. Les assets seront servis depuis un CDN externe (Cloudflare, etc.)

## 📝 Configuration avec render.yaml

Utilisez le fichier `render-separated.yaml`:

1. Allez sur Render Dashboard
2. "New" → "Blueprint"
3. Connectez votre repo
4. Render créera automatiquement les deux services

## 🔧 Configuration manuelle détaillée

### Backend Service

**Settings:**
- Name: `spree-backend`
- Region: `Oregon` (ou votre région)
- Branch: `main`
- Root Directory: (vide)
- Runtime: `Ruby`
- Build Command: `bundle install --deployment --without development test`
- Start Command: `bundle exec puma -C config/puma.rb`

**Environment Variables:**
```
RAILS_ENV=production
SECRET_KEY_BASE=<généré>
DATABASE_URL=<auto-connecté>
REDIS_URL=<auto-connecté>
RAILS_SERVE_STATIC_FILES=false
WEB_CONCURRENCY=1
```

### Frontend Service (Static)

**Settings:**
- Name: `spree-frontend`
- Region: `Oregon`
- Branch: `main`
- Build Command: 
  ```bash
  bundle install --deployment &&
  RAILS_ENV=production SECRET_KEY_BASE=dummy bin/rails assets:precompile &&
  bin/rails assets:clean
  ```
- Publish Directory: `public`

## 🔗 Connecter Frontend et Backend

### Option A: Même domaine (Subdomain)

- Frontend: `https://spree-frontend.onrender.com`
- Backend: `https://spree-backend.onrender.com`

### Option B: Proxy dans le frontend

Créez un fichier `public/_redirects` (pour Netlify) ou configurez Nginx pour proxy les requêtes API vers le backend.

## 📊 Comparaison d'espace

| Configuration | Espace utilisé |
|--------------|----------------|
| **Monolithique** | ~2-3GB (avec assets) |
| **Séparé** | Backend: ~500MB, Frontend: ~200MB |
| **Économie** | **~70% d'espace économisé** |

## ✅ Vérification

1. **Backend**: `https://spree-backend.onrender.com/up` → 200
2. **Frontend**: `https://spree-frontend.onrender.com` → Affiche le site
3. **API**: `https://spree-backend.onrender.com/api/v1/products` → JSON

## 🆘 Dépannage

### Frontend ne charge pas les assets

Vérifiez que:
- Les assets sont compilés dans `public/assets/`
- Le Publish Directory est `public`
- Les chemins dans le HTML pointent vers les bons fichiers

### CORS errors

Ajoutez `rack-cors` et configurez les origines autorisées.

### Backend ne démarre pas

Vérifiez:
- `DATABASE_URL` est correct
- `SECRET_KEY_BASE` est défini
- Les logs pour les erreurs

## 🎯 Résultat

- ✅ Backend léger (sans assets)
- ✅ Frontend optimisé (CDN)
- ✅ Économie d'espace significative
- ✅ Meilleure performance

