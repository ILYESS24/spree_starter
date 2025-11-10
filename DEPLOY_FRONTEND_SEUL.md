# 🎨 Déployer UNIQUEMENT le Frontend sur Render

Guide pour créer le service frontend statique (assets uniquement).

## 🚀 Étapes (2 minutes)

### Étape 1: Créer le service Static Site

1. Allez sur [Render Dashboard](https://dashboard.render.com)
2. Cliquez sur **"New"** → **"Static Site"**
3. Connectez votre repository:
   - **Repository**: `https://github.com/ILYESS24/spree_starter.git`
   - Cliquez sur **"Connect"**

### Étape 2: Configuration

Remplissez les champs:

- **Name**: `spree-frontend`
- **Region**: `Oregon` (ou votre région)
- **Branch**: `main`
- **Root Directory**: (laisser vide)
- **Build Command**: 
  ```bash
  bin/build-frontend-only.sh
  ```
- **Publish Directory**: `public`
- **Plan**: `Free`

### Étape 3: Créer

1. Cliquez sur **"Create Static Site"**
2. Render va:
   - Cloner votre repo
   - Exécuter `bin/build-frontend-only.sh`
   - Compiler les assets dans `public/assets/`
   - Servir le contenu de `public/`

### Étape 4: Attendre le déploiement

- Le build prend 5-10 minutes
- Vous pouvez voir la progression dans les logs
- Une fois terminé, votre frontend sera accessible sur:
  `https://spree-frontend.onrender.com`

## ✅ Vérification

Une fois déployé:
1. Ouvrez `https://spree-frontend.onrender.com`
2. Vérifiez que les CSS/JS sont chargés
3. Vérifiez les logs si problème

## 📋 Ce que fait le script

Le script `bin/build-frontend-only.sh`:
- ✅ Installe les dépendances Ruby
- ✅ Compile les assets (CSS/JS) dans `public/assets/`
- ✅ Nettoie les fichiers temporaires
- ✅ Prépare le dossier `public/` pour le service statique

## 🆘 Si problème

### Assets non compilés
- Vérifiez les logs du build
- Vérifiez que `bin/build-frontend-only.sh` existe
- Vérifiez que Ruby est disponible

### Publish Directory incorrect
- Assurez-vous que c'est `public` (pas `public/assets`)

### Build échoue
- Vérifiez les logs pour l'erreur exacte
- Assurez-vous que `SECRET_KEY_BASE=dummy` est utilisé dans le script

## 🎉 C'est tout!

Votre frontend sera accessible sur Render une fois le déploiement terminé! 🚀

