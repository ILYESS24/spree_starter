# 🔧 Transformer le service en Backend uniquement

## ✅ Ce qui a été fait automatiquement

1. ✅ Variable `RAILS_SERVE_STATIC_FILES=false` ajoutée
2. ✅ Redéploiement déclenché automatiquement
3. ✅ Dockerfile backend créé (`Dockerfile.backend`)

## 🔧 Ce qu'il reste à faire (2 minutes)

Le service utilise Docker, donc vous devez modifier le Dockerfile utilisé:

### Option 1: Renommer le Dockerfile (Recommandé)

1. Allez sur [Render Dashboard](https://dashboard.render.com)
2. Cliquez sur votre service **`spree_starter`**
3. Allez dans **Settings**
4. Dans **Docker**, modifiez:
   - **Dockerfile Path**: `Dockerfile.backend`
5. **Save Changes** → Redéploiement automatique

### Option 2: Remplacer le Dockerfile actuel

Ou remplacez simplement `Dockerfile` par le contenu de `Dockerfile.backend`:

```bash
# En local
cp Dockerfile.backend Dockerfile
git add Dockerfile
git commit -m "Use backend-only Dockerfile"
git push origin main
```

## 📋 Services existants

Vous avez déjà:
- ✅ **Frontend**: `spree-starter-1` (static site) - `https://spree-starter-1-n1xc.onrender.com`
- ✅ **Backend**: `spree_starter` (web service) - `https://spree-starter-3gim.onrender.com`

## ✅ Après modification

Votre backend sera:
- ✅ Sans assets (économise ~70% d'espace)
- ✅ Plus léger et rapide
- ✅ Optimisé pour l'API uniquement

## 🎯 Résultat final

- **Frontend**: `https://spree-starter-1-n1xc.onrender.com` (assets statiques)
- **Backend**: `https://spree-starter-3gim.onrender.com` (API Rails)

Les deux services sont séparés et optimisés! 🚀

