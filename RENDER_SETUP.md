# Configuration Render - Variables d'environnement requises

## ✅ Variables déjà configurées

- `SECRET_KEY_BASE` = `6586529044089ca3731cb8c604d2f8570c48398808b9142d248498256a0b3b1407511e9b092bacd2aa2defbd69c37162d705b214246256ab72246cbf70773868`
- `RAILS_ENV` = `production`

## ⚠️ Variables manquantes à configurer

### 1. DATABASE_URL (OBLIGATOIRE)

**Problème**: Vous avez déjà une base de données PostgreSQL gratuite (`evershop-db`) utilisée par un autre service. Le plan gratuit de Render ne permet qu'une seule base de données.

**Solutions**:

#### Option A: Créer une nouvelle base de données (Recommandé pour la production)
1. Allez sur [Render Dashboard](https://dashboard.render.com)
2. Cliquez sur "New" → "PostgreSQL"
3. Nom: `spree-db`
4. Plan: `Basic $7/mois` (minimum recommandé) ou `Free` (si vous supprimez l'ancienne)
5. Région: `Oregon`
6. Créez la base de données
7. Copiez l'**Internal Database URL**
8. Ajoutez-la comme variable d'environnement `DATABASE_URL` dans le service `spree_starter`

#### Option B: Utiliser la base existante (Temporaire, non recommandé)
⚠️ **Attention**: Cela partagera la base de données entre deux applications différentes.

1. Allez sur la base de données `evershop-db` dans Render Dashboard
2. Copiez l'**Internal Database URL**
3. Ajoutez-la comme variable d'environnement `DATABASE_URL` dans le service `spree_starter`

### 2. REDIS_URL (Optionnel mais recommandé)

Vous avez déjà une instance Redis `keyvalue` créée. Pour l'utiliser:

1. Allez sur l'instance Redis `keyvalue` dans Render Dashboard
2. Copiez l'**Internal Redis URL**
3. Ajoutez-la comme variable d'environnement `REDIS_URL` dans le service `spree_starter`
4. Ajoutez aussi `REDIS_CACHE_URL` avec la même valeur (pour le cache Rails)

## 📋 Liste complète des variables d'environnement recommandées

Pour le service `spree_starter`, configurez ces variables dans Render Dashboard:

```
SECRET_KEY_BASE=6586529044089ca3731cb8c604d2f8570c48398808b9142d248498256a0b3b1407511e9b092bacd2aa2defbd69c37162d705b214246256ab72246cbf70773868
RAILS_ENV=production
DATABASE_URL=<Internal Database URL de votre base PostgreSQL>
REDIS_URL=<Internal Redis URL de votre instance keyvalue>
REDIS_CACHE_URL=<Même Internal Redis URL>
WEB_CONCURRENCY=1
```

## 🔧 Comment ajouter les variables dans Render

1. Allez sur [Render Dashboard](https://dashboard.render.com)
2. Cliquez sur le service `spree_starter`
3. Allez dans l'onglet "Environment"
4. Cliquez sur "Add Environment Variable"
5. Ajoutez chaque variable une par une
6. Cliquez sur "Save Changes"
7. Un nouveau déploiement sera automatiquement déclenché

## 🔍 Vérification

Une fois toutes les variables configurées, le déploiement devrait réussir. Vérifiez les logs dans l'onglet "Logs" du service.

## 📝 Notes importantes

- **SECRET_KEY_BASE**: Ne partagez jamais cette clé publiquement. Elle est déjà configurée.
- **DATABASE_URL**: Utilisez l'URL **Internal** (pas External) pour de meilleures performances
- **REDIS_URL**: Utilisez l'URL **Internal** (pas External) pour de meilleures performances
- Le plan gratuit suspend les services après 15 minutes d'inactivité

## 🆘 En cas de problème

Si le déploiement échoue toujours:
1. Vérifiez que toutes les variables sont bien définies
2. Vérifiez les logs pour les erreurs spécifiques
3. Assurez-vous que la base de données est accessible
4. Vérifiez que Redis est accessible (si configuré)

