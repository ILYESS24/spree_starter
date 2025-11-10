# Guide de déploiement sur Render

Ce guide vous explique comment déployer votre application Spree sur Render.

## Prérequis

1. Un compte Render (gratuit ou payant)
2. Votre code poussé sur GitHub: `https://github.com/ILYESS24/spree_starter.git`
3. Une carte de paiement (pour les plans payants) OU utiliser le plan gratuit avec limitations

## Option 1: Déploiement automatique avec render.yaml (Recommandé)

### Pour les plans payants:

1. Allez sur [Render Dashboard](https://dashboard.render.com)
2. Cliquez sur "New" → "Blueprint"
3. Connectez votre repository GitHub: `https://github.com/ILYESS24/spree_starter.git`
4. Render détectera automatiquement le fichier `render.yaml` et créera tous les services

### Pour le plan gratuit:

1. Allez sur [Render Dashboard](https://dashboard.render.com)
2. Cliquez sur "New" → "Blueprint"
3. Connectez votre repository GitHub: `https://github.com/ILYESS24/spree_starter.git`
4. Utilisez le fichier `render-free.yaml` (renommez-le en `render.yaml` temporairement)
5. **Note importante**: Le plan gratuit a des limitations:
   - 1 seule base de données PostgreSQL
   - 1 seule instance Redis
   - Services peuvent être suspendus après inactivité

## Option 2: Déploiement manuel (Plan gratuit)

Si vous préférez créer les services manuellement:

### Étape 1: Créer la base de données PostgreSQL

1. Dans Render Dashboard, cliquez sur "New" → "PostgreSQL"
2. Nom: `spree-db`
3. Plan: `Free` (ou `Basic $7/mois` pour la production)
4. Région: `Oregon` (ou celle de votre choix)
5. Cliquez sur "Create Database"
6. Notez la `Internal Database URL` et `External Database URL`

### Étape 2: Créer l'instance Redis (Key-Value)

1. Dans Render Dashboard, cliquez sur "New" → "Redis"
2. Nom: `keyvalue`
3. Plan: `Free` (ou `Starter $10/mois` pour la production)
4. Région: `Oregon` (même région que la base de données)
5. Max Memory Policy: `noeviction`
6. Cliquez sur "Create Redis"
7. Notez la `Internal Redis URL` et `External Redis URL`

### Étape 3: Créer le service web

1. Dans Render Dashboard, cliquez sur "New" → "Web Service"
2. Connectez votre repository: `https://github.com/ILYESS24/spree_starter.git`
3. Configuration:
   - **Name**: `spree-web`
   - **Region**: `Oregon`
   - **Branch**: `main`
   - **Root Directory**: (laisser vide)
   - **Runtime**: `Ruby`
   - **Build Command**: `bundle install --deployment && bin/rails assets:precompile && bin/rails assets:clean`
   - **Start Command**: `bundle exec puma -C config/puma.rb`
   - **Plan**: `Free` (ou `Starter $7/mois` pour la production)

4. Variables d'environnement:
   - `RAILS_ENV` = `production`
   - `DATABASE_URL` = (sélectionnez la base de données `spree-db` créée à l'étape 1)
   - `REDIS_URL` = (sélectionnez l'instance Redis `keyvalue` créée à l'étape 2)
   - `REDIS_CACHE_URL` = (même instance Redis `keyvalue`)
   - `SECRET_KEY_BASE` = (généré automatiquement par Render, ou utilisez `rails secret`)
   - `WEB_CONCURRENCY` = `1` (pour le plan gratuit) ou `2` (pour les plans payants)
   - `RENDER_EXTERNAL_URL` = (sera automatiquement défini par Render)

5. Cliquez sur "Create Web Service"

### Étape 4: Créer le worker Sidekiq (Optionnel mais recommandé)

1. Dans Render Dashboard, cliquez sur "New" → "Background Worker"
2. Connectez votre repository: `https://github.com/ILYESS24/spree_starter.git`
3. Configuration:
   - **Name**: `spree-worker`
   - **Region**: `Oregon`
   - **Branch**: `main`
   - **Root Directory**: (laisser vide)
   - **Runtime**: `Ruby`
   - **Build Command**: `bundle install --deployment && bin/rails assets:precompile && bin/rails assets:clean`
   - **Start Command**: `bundle exec sidekiq`
   - **Plan**: `Free` (ou `Starter $7/mois` pour la production)

4. Variables d'environnement (mêmes que le service web):
   - `RAILS_ENV` = `production`
   - `DATABASE_URL` = (sélectionnez la base de données `spree-db`)
   - `REDIS_URL` = (sélectionnez l'instance Redis `keyvalue`)
   - `REDIS_CACHE_URL` = (même instance Redis `keyvalue`)
   - `SECRET_KEY_BASE` = (même valeur que le service web)
   - `DB_POOL` = `10`

5. Cliquez sur "Create Background Worker"

### Étape 5: Exécuter les migrations

Une fois le service web créé:

1. Allez dans le service web `spree-web`
2. Cliquez sur l'onglet "Shell"
3. Exécutez:
   ```bash
   bin/rails db:migrate
   bin/rails db:seed
   ```

Ou configurez une commande de pré-déploiement dans les paramètres du service:
- **Pre-deploy Command**: `bin/rails db:migrate && bin/rails db:seed`

## Variables d'environnement importantes

Assurez-vous de configurer ces variables pour la production:

- `SECRET_KEY_BASE`: Généré automatiquement par Render ou créez-en un avec `rails secret`
- `DATABASE_URL`: Automatiquement connecté si vous utilisez la sélection de service
- `REDIS_URL`: Automatiquement connecté si vous utilisez la sélection de service
- `RAILS_ENV`: `production`
- `RENDER_EXTERNAL_URL`: Automatiquement défini par Render

## Vérification du déploiement

1. Une fois déployé, votre application sera accessible à: `https://spree-web-XXXX.onrender.com`
2. Accédez à l'admin: `https://spree-web-XXXX.onrender.com/admin`
3. Les identifiants par défaut sont dans `db/seeds.rb` ou configurez-les via les variables d'environnement

## Limitations du plan gratuit

- Services suspendus après 15 minutes d'inactivité
- 1 seule base de données PostgreSQL
- 1 seule instance Redis
- Ressources limitées (RAM, CPU)
- Pas de support prioritaire

**Recommandation**: Pour la production, utilisez au minimum le plan Starter ($7/mois par service).

## Support

Pour plus d'informations, consultez:
- [Documentation Render](https://render.com/docs)
- [Documentation Spree](https://spreecommerce.org/docs/developer/deployment/render)

