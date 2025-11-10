# 🔧 Instructions pour transformer le service existant en Backend

L'API Render ne permet pas de créer des services gratuits automatiquement. Voici comment transformer votre service existant en backend uniquement:

## 🚀 Étapes rapides

### Option 1: Modifier le service existant (Recommandé)

1. Allez sur [Render Dashboard](https://dashboard.render.com)
2. Cliquez sur votre service **`spree_starter`**
3. Allez dans **Settings**

4. **Modifiez le Build Command:**
   - Remplacez par: `bin/build-backend-only.sh`
   - Ou: `bundle install --deployment --without development test assets`

5. **Vérifiez les variables d'environnement:**
   - `RAILS_SERVE_STATIC_FILES=false` ✅ (déjà ajouté)
   - `RAILS_ENV=production` ✅
   - `SECRET_KEY_BASE` ✅
   - `DATABASE_URL` ✅ (doit pointer vers spree-db)
   - `REDIS_URL` ✅ (doit pointer vers keyvalue)
   - `WEB_CONCURRENCY=1`
   - `PORT=3000`

6. **Save Changes** → Un redéploiement se déclenchera automatiquement

### Option 2: Créer un nouveau service Backend

Si vous préférez garder l'ancien et créer un nouveau:

1. Render Dashboard → **"New"** → **"Web Service"**
2. Repo: `https://github.com/ILYESS24/spree_starter.git`
3. **Configuration:**
   - Name: `spree-backend-api`
   - Build: `bin/build-backend-only.sh`
   - Start: `bundle exec puma -C config/puma.rb`
   - Plan: `Free`

4. **Variables d'environnement:**
   ```
   RAILS_ENV=production
   SECRET_KEY_BASE=6586529044089ca3731cb8c604d2f8570c48398808b9142d248498256a0b3b1407511e9b092bacd2aa2defbd69c37162d705b214246256ab72246cbf70773868
   DATABASE_URL=<Liez spree-db>
   REDIS_URL=<Liez keyvalue>
   RAILS_SERVE_STATIC_FILES=false
   WEB_CONCURRENCY=1
   PORT=3000
   ```

5. **Health Check:** `/up`

6. **Create**

## ✅ Résultat

Votre service sera transformé en backend API uniquement:
- ✅ Pas d'assets compilés (économise l'espace)
- ✅ Service plus léger
- ✅ Plus de 502 (si c'était le problème)

## 🔍 Vérification

Après le redéploiement:
- `https://spree_starter.onrender.com/up` → `{"status":"ok"}`
- Les logs montrent: `Puma starting... * Listening on http://0.0.0.0:3000`

## 📝 Note

J'ai déjà ajouté `RAILS_SERVE_STATIC_FILES=false` au service existant. Il vous suffit de modifier le Build Command pour utiliser `bin/build-backend-only.sh`.

