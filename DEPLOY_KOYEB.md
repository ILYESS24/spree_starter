# 🚀 Déployer sur Koyeb - 100% Gratuit Sans Carte Bancaire

Koyeb est une plateforme serverless gratuite qui supporte Docker. Parfait pour Rails!

## 🎁 Ce que vous obtenez GRATUITEMENT

- ✅ **Déploiement illimité**
- ✅ **Support Docker natif**
- ✅ **Déploiement automatique depuis GitHub**
- ✅ **Pas de carte bancaire requise**
- ✅ **Interface très simple**
- ✅ **CDN global**

## 🚀 Déploiement en 2 minutes

### Étape 1: Créer un compte

1. Allez sur [Koyeb.com](https://www.koyeb.com/)
2. Cliquez sur **"Get Started"**
3. Créez un compte (GitHub, Google, ou email)
4. **Pas de carte bancaire requise!** ✅

### Étape 2: Créer une application

1. Dans Koyeb Dashboard, cliquez sur **"Create App"**
2. Sélectionnez **"GitHub"**
3. Autorisez Koyeb à accéder à votre GitHub
4. Sélectionnez votre repository: `ILYESS24/spree_starter`
5. Cliquez sur **"Deploy"**

### Étape 3: Configuration

Koyeb détectera automatiquement votre Dockerfile! ✅

**Build Settings:**
- **Build Command**: (automatique)
- **Run Command**: (automatique depuis Dockerfile)

### Étape 4: Variables d'environnement

Dans **Settings** → **Environment Variables**, ajoutez:

```
RAILS_ENV=production
SECRET_KEY_BASE=6586529044089ca3731cb8c604d2f8570c48398808b9142d248498256a0b3b1407511e9b092bacd2aa2defbd69c37162d705b214246256ab72246cbf70773868
DATABASE_URL=<URL de votre base de données>
REDIS_URL=<URL de votre Redis> (optionnel)
RAILS_SERVE_STATIC_FILES=true
PORT=3000
```

### Étape 5: Ajouter une base de données

1. Dans Koyeb Dashboard, cliquez sur **"Databases"**
2. **Create Database** → **PostgreSQL**
3. Koyeb créera automatiquement la base
4. Copiez l'URL de connexion
5. Ajoutez-la comme `DATABASE_URL` dans les variables d'environnement

### Étape 6: Déployer

1. Cliquez sur **"Deploy"**
2. Koyeb va:
   - Cloner votre repo
   - Builder votre Dockerfile
   - Déployer l'application
3. Votre app sera accessible sur: `https://votre-app.koyeb.app`

### Étape 7: Exécuter les migrations

1. Dans Koyeb Dashboard → Votre app → **Shell**
2. Exécutez:
   ```bash
   bin/rails db:migrate
   bin/rails db:seed
   ```

## ✅ C'est tout!

Votre application est maintenant en ligne sur `https://votre-app.koyeb.app`! 🎉

## 📋 Commandes utiles

- **Voir les logs**: Dashboard → App → Logs
- **Redéployer**: Dashboard → App → Redeploy
- **Variables**: Dashboard → App → Settings → Environment Variables

## 🎯 Avantages Koyeb

- ✅ **100% gratuit** - Pas de carte bancaire
- ✅ **Support Docker** - Votre Dockerfile fonctionne directement
- ✅ **Déploiement automatique** - Depuis GitHub
- ✅ **Interface simple** - Très facile à utiliser
- ✅ **Pas de 502** - Infrastructure moderne
- ✅ **CDN global** - Performance optimale

## 🆘 Dépannage

### Build échoue

- Vérifiez les logs dans Dashboard
- Vérifiez que le Dockerfile est correct
- Vérifiez que toutes les variables sont définies

### Application ne démarre pas

- Vérifiez que `SECRET_KEY_BASE` est défini
- Vérifiez que `DATABASE_URL` est correct
- Vérifiez les logs pour les erreurs

## 💰 Coûts

**Total: $0/mois - Gratuit à vie!**

- Application: Gratuit
- Base de données: Gratuit (dans les limites)
- Bande passante: Gratuit (dans les limites)

## 🎉 Résultat

Votre application Spree est maintenant déployée gratuitement sur Koyeb! 🚀

**URL**: `https://votre-app.koyeb.app`

