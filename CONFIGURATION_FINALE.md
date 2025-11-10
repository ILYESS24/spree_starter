# Configuration finale - Spree sur Render

## ✅ Ce qui a été fait

1. ✅ Base de données PostgreSQL `spree-db` créée (ID: `dpg-d48knl1r0fns7383pf30-a`)
2. ✅ Instance Redis `keyvalue` disponible (ID: `red-d48kfifdiees73a0f1o0`)
3. ✅ Service `spree_starter` créé (ID: `srv-d48kha3e5dus73c8lrqg`)
4. ✅ `SECRET_KEY_BASE` configuré
5. ✅ `RAILS_ENV=production` configuré

## 🔧 Configuration des variables d'environnement

### Étape 1: Obtenir l'URL de la base de données

1. Allez sur [Render Dashboard](https://dashboard.render.com)
2. Cliquez sur la base de données **spree-db**
3. Dans l'onglet **Info**, copiez l'**Internal Database URL**
   - Format: `postgresql://user:password@host:port/database`
   - ⚠️ Utilisez l'URL **Internal** (pas External) pour de meilleures performances

### Étape 2: Obtenir l'URL Redis

1. Allez sur l'instance Redis **keyvalue**
2. Dans l'onglet **Info**, copiez l'**Internal Redis URL**
   - Format: `redis://...` ou `rediss://...`
   - ⚠️ Utilisez l'URL **Internal** (pas External)

### Étape 3: Configurer les variables dans le service

1. Allez sur le service **spree_starter**
2. Cliquez sur l'onglet **Environment**
3. Ajoutez/modifiez ces variables:

```
DATABASE_URL=<Internal Database URL de spree-db>
REDIS_URL=<Internal Redis URL de keyvalue>
REDIS_CACHE_URL=<Même Internal Redis URL de keyvalue>
WEB_CONCURRENCY=1
```

**Variables déjà configurées** (ne pas modifier):
- `SECRET_KEY_BASE` = `6586529044089ca3731cb8c604d2f8570c48398808b9142d248498256a0b3b1407511e9b092bacd2aa2defbd69c37162d705b214246256ab72246cbf70773868`
- `RAILS_ENV` = `production`

4. Cliquez sur **Save Changes**
5. Un nouveau déploiement sera automatiquement déclenché

## 🔍 Vérification

Une fois toutes les variables configurées:

1. Vérifiez les logs du service dans l'onglet **Logs**
2. Le déploiement devrait réussir
3. Votre application sera accessible à: `https://spree-starter-3gim.onrender.com`

## 📝 Informations importantes

- **Base de données**: `spree-db` (dpg-d48knl1r0fns7383pf30-a)
- **Redis**: `keyvalue` (red-d48kfifdiees73a0f1o0)
- **Service**: `spree_starter` (srv-d48kha3e5dus73c8lrqg)
- **URL**: https://spree-starter-3gim.onrender.com

## ⚠️ Note

La base de données peut prendre quelques minutes pour être complètement disponible. Si vous obtenez une erreur de connexion, attendez 2-3 minutes et réessayez.

