# ⚡ Guide Rapide - Séparer Backend et Frontend sur Render

## 🎯 Objectif

Séparer en 2 services pour économiser l'espace:
- **Backend**: API Rails (sans assets) → ~500MB
- **Frontend**: Assets statiques → ~200MB
- **Total**: ~700MB au lieu de 2-3GB

## 🚀 Étapes rapides

### Étape 1: Modifier le service Backend existant

1. Allez sur [Render Dashboard](https://dashboard.render.com)
2. Cliquez sur votre service `spree_starter`
3. Allez dans **Settings**

**Modifiez le Build Command:**
```bash
bin/build-backend-only.sh
```

**Ou manuellement:**
```bash
bundle install --deployment --without development test
```

**Ajoutez cette variable d'environnement:**
```
RAILS_SERVE_STATIC_FILES=false
```

4. **Save Changes** → Un redéploiement se déclenchera

### Étape 2: Créer le service Frontend (Static)

1. Dans Render Dashboard, cliquez sur **"New"** → **"Static Site"**
2. Connectez votre repo: `https://github.com/ILYESS24/spree_starter.git`
3. Configuration:
   - **Name**: `spree-frontend`
   - **Branch**: `main`
   - **Build Command**: 
     ```bash
     bin/build-frontend-only.sh
     ```
   - **Publish Directory**: `public`
   - **Plan**: `Free`

4. Cliquez sur **"Create Static Site"**

### Étape 3: Configurer les URLs

Une fois déployé:
- **Backend API**: `https://spree_starter.onrender.com` (votre service actuel)
- **Frontend**: `https://spree-frontend.onrender.com` (nouveau service)

## 🔧 Configuration avancée (Optionnel)

### Si vous voulez que le frontend appelle le backend

Modifiez les URLs dans votre frontend pour pointer vers le backend API.

Ou utilisez un reverse proxy dans le frontend pour router `/api/*` vers le backend.

## ✅ Résultat

- ✅ Backend léger (sans assets) - économise ~70% d'espace
- ✅ Frontend optimisé (CDN)
- ✅ Deux services indépendants
- ✅ Meilleure performance

## 📊 Comparaison

| Avant | Après |
|-------|-------|
| 1 service: 2-3GB | 2 services: ~700MB |
| Tout ensemble | Séparé et optimisé |

## 🆘 Si problème

1. Vérifiez les logs des deux services
2. Assurez-vous que `RAILS_SERVE_STATIC_FILES=false` est dans le backend
3. Vérifiez que le frontend compile bien les assets dans `public/`

## 🎉 C'est tout!

Votre application est maintenant séparée et optimisée! 🚀

