# ⚡ Guide Rapide - 2 Services Séparés sur Render

## 🎯 Objectif

Créer 2 services distincts pour éviter le 502:
- **Backend API**: Rails sans assets
- **Frontend**: Assets statiques

## 🚀 Étapes (5 minutes)

### Service 1: Backend API

1. Render Dashboard → **"New"** → **"Web Service"**
2. Repo: `https://github.com/ILYESS24/spree_starter.git`
3. **Settings:**
   - Name: `spree-backend-api`
   - Build: `bin/build-backend-only.sh`
   - Start: `bundle exec puma -C config/puma.rb`
   - Plan: `Free`

4. **Environment:**
   ```
   RAILS_ENV=production
   SECRET_KEY_BASE=<généré>
   DATABASE_URL=<sélectionnez votre DB>
   REDIS_URL=<sélectionnez Redis>
   RAILS_SERVE_STATIC_FILES=false
   WEB_CONCURRENCY=1
   PORT=3000
   ```

5. **Create**

### Service 2: Frontend Static

1. Render Dashboard → **"New"** → **"Static Site"**
2. Repo: `https://github.com/ILYESS24/spree_starter.git`
3. **Settings:**
   - Name: `spree-frontend`
   - Build: `bin/build-frontend-only.sh`
   - Publish: `public`
   - Plan: `Free`

4. **Create**

## ✅ Résultat

- Backend: `https://spree-backend-api.onrender.com`
- Frontend: `https://spree-frontend.onrender.com`
- Plus de 502! 🎉

## 🔧 Si besoin de CORS

Ajoutez `gem 'rack-cors'` dans Gemfile et créez `config/initializers/cors.rb` (voir `DEPLOY_SEPARE_COMPLET.md`)

C'est tout! 🚀

