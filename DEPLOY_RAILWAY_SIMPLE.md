# 🚂 Déploiement sur Railway - Alternative Simple

Railway est aussi une bonne alternative à Render.

## 🚀 Étapes (3 minutes)

### Étape 1: Créer un compte

1. Allez sur [Railway](https://railway.app)
2. Créez un compte (GitHub login)

### Étape 2: Créer un nouveau projet

1. Cliquez sur **"New Project"**
2. Sélectionnez **"Deploy from GitHub repo"**
3. Connectez votre repo: `ILYESS24/spree_starter`

### Étape 3: Ajouter PostgreSQL

1. Dans votre projet, cliquez sur **"+ New"**
2. Sélectionnez **"Database"** → **"Add PostgreSQL"**
3. Railway créera automatiquement la base et configurera `DATABASE_URL`

### Étape 4: Ajouter Redis (optionnel)

1. Cliquez sur **"+ New"**
2. Sélectionnez **"Database"** → **"Add Redis"**
3. Railway configurera automatiquement `REDIS_URL`

### Étape 5: Configurer les variables

1. Cliquez sur votre service
2. Allez dans **"Variables"**
3. Ajoutez:
   ```
   RAILS_ENV=production
   SECRET_KEY_BASE=6586529044089ca3731cb8c604d2f8570c48398808b9142d248498256a0b3b1407511e9b092bacd2aa2defbd69c37162d705b214246256ab72246cbf70773868
   RAILS_SERVE_STATIC_FILES=true
   PORT=3000
   ```

### Étape 6: Déployer

Railway détectera automatiquement le Dockerfile et déploiera!

## ✅ Avantages Railway

- ✅ Interface très simple
- ✅ Détection automatique Docker
- ✅ Configuration automatique des bases de données
- ✅ Pas de 502 errors
- ✅ Plan gratuit généreux ($5 crédit/mois)

## 🎉 Résultat

Votre application sera accessible sur `https://votre-app.railway.app`! 🚀

