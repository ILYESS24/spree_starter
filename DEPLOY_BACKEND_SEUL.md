# 🔧 Déployer UNIQUEMENT le Backend API sur Render

Guide pour créer le service backend API (sans assets frontend).

## 🚀 Étapes (3 minutes)

### Étape 1: Créer le service Web Service

1. Allez sur [Render Dashboard](https://dashboard.render.com)
2. Cliquez sur **"New"** → **"Web Service"**
3. Connectez votre repository:
   - **Repository**: `https://github.com/ILYESS24/spree_starter.git`
   - Cliquez sur **"Connect"**

### Étape 2: Configuration de base

Remplissez les champs:

- **Name**: `spree-backend-api`
- **Region**: `Oregon` (ou votre région)
- **Branch**: `main`
- **Root Directory**: (laisser vide)
- **Runtime**: `Ruby`
- **Build Command**: 
  ```bash
  bin/build-backend-only.sh
  ```
- **Start Command**: 
  ```bash
  bundle exec puma -C config/puma.rb
  ```
- **Plan**: `Free`

### Étape 3: Variables d'environnement

Cliquez sur **"Advanced"** → **"Add Environment Variable"** et ajoutez:

1. **RAILS_ENV**
   - Key: `RAILS_ENV`
   - Value: `production`

2. **SECRET_KEY_BASE**
   - Key: `SECRET_KEY_BASE`
   - Value: `6586529044089ca3731cb8c604d2f8570c48398808b9142d248498256a0b3b1407511e9b092bacd2aa2defbd69c37162d705b214246256ab72246cbf70773868`
   - (Ou générez-en un nouveau)

3. **DATABASE_URL**
   - Key: `DATABASE_URL`
   - Value: Cliquez sur **"Link Database"** → Sélectionnez `spree-db`
   - (Ou copiez l'Internal Database URL de votre base de données)

4. **REDIS_URL**
   - Key: `REDIS_URL`
   - Value: Cliquez sur **"Link Redis"** → Sélectionnez `keyvalue`
   - (Ou copiez l'Internal Redis URL de votre instance Redis)

5. **RAILS_SERVE_STATIC_FILES**
   - Key: `RAILS_SERVE_STATIC_FILES`
   - Value: `false`

6. **WEB_CONCURRENCY**
   - Key: `WEB_CONCURRENCY`
   - Value: `1`

7. **PORT**
   - Key: `PORT`
   - Value: `3000`

### Étape 4: Health Check

- **Health Check Path**: `/up`

### Étape 5: Créer

1. Cliquez sur **"Create Web Service"**
2. Render va:
   - Cloner votre repo
   - Exécuter `bin/build-backend-only.sh` (sans compiler les assets)
   - Démarrer Puma sur le port 3000
   - Votre backend sera accessible sur: `https://spree-backend-api.onrender.com`

### Étape 6: Attendre le déploiement

- Le build prend 5-10 minutes
- Vous pouvez voir la progression dans les logs
- Une fois terminé, votre backend sera accessible

## ✅ Vérification

Une fois déployé:

1. **Health Check:**
   ```
   https://spree-backend-api.onrender.com/up
   ```
   Doit retourner: `{"status":"ok"}`

2. **Test API:**
   ```
   https://spree-backend-api.onrender.com/api/v1/products
   ```
   (Si vous avez des routes API)

3. **Vérifier les logs:**
   - Render Dashboard → Service → Logs
   - Vous devriez voir: `Puma starting... * Listening on http://0.0.0.0:3000`

## 📋 Ce que fait le script

Le script `bin/build-backend-only.sh`:
- ✅ Installe les dépendances Ruby (sans assets)
- ✅ **NE compile PAS les assets** (économise l'espace)
- ✅ Nettoie les fichiers temporaires
- ✅ Prépare le backend pour l'API uniquement

## 🆘 Si problème

### Service ne démarre pas (502)

1. Vérifiez les logs pour l'erreur exacte
2. Vérifiez que `DATABASE_URL` est correct
3. Vérifiez que `SECRET_KEY_BASE` est défini
4. Vérifiez que le port est 3000

### Erreur de connexion à la base

1. Vérifiez que la base de données `spree-db` existe
2. Vérifiez que `DATABASE_URL` pointe vers la bonne base
3. Vérifiez que la base est accessible (pas suspendue)

### Erreur SECRET_KEY_BASE

1. Assurez-vous que la variable est définie
2. Utilisez la clé fournie ci-dessus ou générez-en une nouvelle

## 🎉 C'est tout!

Votre backend API sera accessible sur Render une fois le déploiement terminé! 🚀

**URL**: `https://spree-backend-api.onrender.com`

