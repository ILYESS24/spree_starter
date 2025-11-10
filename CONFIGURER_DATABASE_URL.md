# 🔧 Configurer DATABASE_URL sur Render

Le service ne peut pas se connecter à la base de données car `DATABASE_URL` n'est pas configuré.

## 🚀 Solution rapide (2 minutes)

### Étape 1: Obtenir l'URL de la base de données

1. Allez sur [Render Dashboard](https://dashboard.render.com)
2. Cliquez sur votre base de données **`spree-db`**
3. Dans l'onglet **Info**, copiez l'**Internal Database URL**
   - Format: `postgresql://user:password@host:port/database`
   - ⚠️ Utilisez l'URL **Internal** (pas External) pour de meilleures performances

### Étape 2: Ajouter DATABASE_URL au service

1. Allez sur votre service **`spree_starter`**
2. Cliquez sur l'onglet **Environment**
3. Cliquez sur **"Add Environment Variable"**
4. Ajoutez:
   - **Key**: `DATABASE_URL`
   - **Value**: Collez l'**Internal Database URL** que vous avez copiée
5. Cliquez sur **"Save Changes"**

### Étape 3: Vérifier REDIS_URL (optionnel mais recommandé)

Si vous utilisez Redis, ajoutez aussi:

1. Allez sur votre instance Redis **`keyvalue`**
2. Copiez l'**Internal Redis URL**
3. Dans le service, ajoutez:
   - **Key**: `REDIS_URL`
   - **Value**: L'Internal Redis URL

## ✅ Après configuration

Un redéploiement sera automatiquement déclenché. Vérifiez les logs:
- Le service devrait maintenant se connecter à la base de données
- `db:prepare` devrait s'exécuter correctement
- Le service devrait démarrer sur le port 3000

## 🔍 Vérification

Une fois déployé:
- `https://spree-starter-3gim.onrender.com/up` → `{"status":"ok"}`
- Les logs montrent: `Puma starting... * Listening on http://0.0.0.0:3000`

## 📋 Variables d'environnement complètes requises

Assurez-vous que ces variables sont toutes configurées:

```
RAILS_ENV=production
SECRET_KEY_BASE=6586529044089ca3731cb8c604d2f8570c48398808b9142d248498256a0b3b1407511e9b092bacd2aa2defbd69c37162d705b214246256ab72246cbf70773868
DATABASE_URL=<Internal Database URL de spree-db> ← À AJOUTER
REDIS_URL=<Internal Redis URL de keyvalue> (optionnel)
RAILS_SERVE_STATIC_FILES=false
WEB_CONCURRENCY=1
PORT=3000
```

## 🆘 Si problème persiste

1. Vérifiez que la base de données `spree-db` est bien **"Available"** (pas suspendue)
2. Vérifiez que vous utilisez l'URL **Internal** (pas External)
3. Vérifiez les logs pour d'autres erreurs

Une fois `DATABASE_URL` configuré, le service devrait démarrer correctement! 🎉

