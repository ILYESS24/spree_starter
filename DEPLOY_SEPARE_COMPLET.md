# 🚀 Déploiement Backend/Frontend séparés sur Render

Guide complet pour déployer le backend et le frontend en deux services distincts sur Render.

## 🎯 Architecture

```
┌─────────────────────┐
│  Frontend (Static)   │  → Assets CSS/JS/Images
│  spree-frontend     │  → Service statique
└─────────────────────┘
         │
         ↓ (API calls)
┌─────────────────────┐
│  Backend API       │  → Rails API (sans assets)
│  spree-backend-api │  → Port 3000
└─────────────────────┘
         │
         ↓
┌─────────────────────┐
│  PostgreSQL        │
│  + Redis           │
└─────────────────────┘
```

## 📋 Étape 1: Créer le service Backend API

### Via Blueprint (Recommandé)

1. Allez sur [Render Dashboard](https://dashboard.render.com)
2. Cliquez sur **"New"** → **"Blueprint"**
3. Connectez votre repo: `https://github.com/ILYESS24/spree_starter.git`
4. Render détectera `render-backend-api.yaml` et créera le service automatiquement

### Via Interface (Manuel)

1. **Créer la base de données** (si pas déjà créée):
   - "New" → "PostgreSQL"
   - Nom: `spree-db`
   - Plan: `Free`
   - Région: `Oregon`

2. **Créer Redis** (si pas déjà créé):
   - "New" → "Redis"
   - Nom: `keyvalue`
   - Plan: `Free`

3. **Créer le service Backend**:
   - "New" → "Web Service"
   - Repo: `https://github.com/ILYESS24/spree_starter.git`
   - **Configuration:**
     - Name: `spree-backend-api`
     - Region: `Oregon`
     - Branch: `main`
     - Runtime: `Ruby`
     - **Build Command**: `bin/build-backend-only.sh`
     - **Start Command**: `bundle exec puma -C config/puma.rb`
     - Plan: `Free`

4. **Variables d'environnement:**
   ```
   RAILS_ENV=production
   SECRET_KEY_BASE=<généré ou votre clé>
   DATABASE_URL=<sélectionnez spree-db>
   REDIS_URL=<sélectionnez keyvalue>
   RAILS_SERVE_STATIC_FILES=false
   WEB_CONCURRENCY=1
   PORT=3000
   ```

5. **Health Check Path**: `/up`

6. Cliquez sur **"Create Web Service"**

## 📋 Étape 2: Créer le service Frontend (Static)

1. Dans Render Dashboard, cliquez sur **"New"** → **"Static Site"**
2. Connectez votre repo: `https://github.com/ILYESS24/spree_starter.git`
3. **Configuration:**
   - **Name**: `spree-frontend`
   - **Region**: `Oregon`
   - **Branch**: `main`
   - **Build Command**: `bin/build-frontend-only.sh`
   - **Publish Directory**: `public`
   - **Plan**: `Free`

4. Cliquez sur **"Create Static Site"**

## 🔧 Étape 3: Configurer CORS (si nécessaire)

Si le frontend doit appeler l'API depuis un domaine différent, ajoutez CORS:

1. Ajoutez dans `Gemfile`:
   ```ruby
   gem 'rack-cors'
   ```

2. Créez `config/initializers/cors.rb`:
   ```ruby
   Rails.application.config.middleware.insert_before 0, Rack::Cors do
     allow do
       origins '*'  # Ou votre domaine frontend
       resource '*',
         headers: :any,
         methods: [:get, :post, :put, :patch, :delete, :options, :head],
         credentials: false
     end
   end
   ```

3. Poussez les changements:
   ```bash
   git add .
   git commit -m "Add: CORS configuration"
   git push origin main
   ```

## 🔗 Étape 4: Connecter Frontend et Backend

### Option A: Même domaine avec proxy (Recommandé)

Configurez le frontend pour proxy les requêtes API vers le backend.

### Option B: Domaines séparés

- Frontend: `https://spree-frontend.onrender.com`
- Backend: `https://spree-backend-api.onrender.com`

Modifiez les URLs dans votre frontend pour pointer vers le backend.

## ✅ Vérification

### Backend API
```bash
# Health check
curl https://spree-backend-api.onrender.com/up
# Doit retourner: {"status":"ok"}

# Test API
curl https://spree-backend-api.onrender.com/api/v1/products
```

### Frontend
```bash
# Ouvrir dans le navigateur
https://spree-frontend.onrender.com
# Doit afficher le site avec CSS/JS chargés
```

## 📊 Avantages de cette séparation

| Aspect | Monolithique | Séparé |
|--------|-------------|--------|
| **Espace Backend** | 2-3GB | ~500MB |
| **Espace Frontend** | Inclus | ~200MB |
| **Performance** | Moyenne | Excellente (CDN) |
| **Scalabilité** | Limitée | Indépendante |
| **Déploiement** | Tout ensemble | Indépendant |

## 🆘 Dépannage

### Backend retourne 502

1. Vérifiez les logs: Render Dashboard → Service → Logs
2. Vérifiez que `DATABASE_URL` est correct
3. Vérifiez que `SECRET_KEY_BASE` est défini
4. Vérifiez que le service écoute sur le port 3000

### Frontend ne charge pas les assets

1. Vérifiez que les assets sont dans `public/assets/`
2. Vérifiez le Publish Directory est `public`
3. Vérifiez les logs du build

### CORS errors

Ajoutez la configuration CORS comme indiqué ci-dessus.

## 🎉 Résultat

- ✅ Backend API léger (~500MB)
- ✅ Frontend optimisé (CDN)
- ✅ Pas de 502 (services séparés)
- ✅ Économie d'espace (~70%)

Votre application est maintenant séparée et optimisée! 🚀

