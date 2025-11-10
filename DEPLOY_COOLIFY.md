# Déploiement sur Coolify (Self-hosted gratuit)

Coolify est une alternative open-source et gratuite à Heroku. Vous pouvez l'installer sur un VPS gratuit (Oracle Cloud, etc.).

## 🎯 Pourquoi Coolify?

- ✅ 100% gratuit et open-source
- ✅ Interface similaire à Heroku
- ✅ Support Docker natif
- ✅ Pas de limitations
- ✅ Contrôle total sur votre infrastructure

## 📋 Prérequis

Vous avez besoin d'un VPS gratuit. Options:
1. **Oracle Cloud Free Tier** (recommandé) - 2 VPS gratuits à vie
2. **Google Cloud Free Tier** - $300 crédit gratuit
3. **AWS Free Tier** - 12 mois gratuit
4. **DigitalOcean** - $200 crédit gratuit

## 🚀 Installation sur Oracle Cloud (Recommandé)

### Étape 1: Créer un VPS Oracle Cloud

1. Allez sur [Oracle Cloud](https://www.oracle.com/cloud/free/)
2. Créez un compte gratuit (nécessite une carte de crédit mais ne sera pas débitée)
3. Créez une instance "Always Free":
   - Shape: VM.Standard.E2.1.Micro
   - OS: Ubuntu 22.04
   - 1 CPU, 1GB RAM (gratuit à vie!)

### Étape 2: Installer Coolify

Connectez-vous à votre VPS via SSH:

```bash
ssh ubuntu@votre-ip-publique
```

Puis installez Coolify:

```bash
curl -fsSL https://cdn.coollabs.io/coolify/install.sh | bash
```

Suivez les instructions. Coolify sera accessible sur `http://votre-ip:8000`

### Étape 3: Configurer Coolify

1. Ouvrez `http://votre-ip:8000` dans votre navigateur
2. Créez un compte admin
3. Connectez votre GitHub/GitLab

### Étape 4: Déployer Spree

1. Dans Coolify, cliquez sur "New Resource" → "Application"
2. Connectez votre repository: `https://github.com/ILYESS24/spree_starter.git`
3. Coolify détectera automatiquement le Dockerfile
4. Configurez:
   - **Port:** 3000
   - **Build Command:** (automatique avec Dockerfile)
   - **Start Command:** (automatique avec Dockerfile)

### Étape 5: Ajouter PostgreSQL

1. Dans Coolify, cliquez sur "New Resource" → "Database" → "PostgreSQL"
2. Configurez:
   - **Name:** spree-db
   - **Version:** 16
   - **Database:** spree
   - **User:** spree
3. Coolify créera automatiquement la base et configurera `DATABASE_URL`

### Étape 6: Ajouter Redis

1. Dans Coolify, cliquez sur "New Resource" → "Database" → "Redis"
2. Configurez:
   - **Name:** spree-redis
   - **Version:** 7
3. Coolify configurera automatiquement `REDIS_URL`

### Étape 7: Variables d'environnement

Dans votre application Coolify, ajoutez:

```
RAILS_ENV=production
SECRET_KEY_BASE=votre_clé_secrète_générée
DATABASE_URL=<sera automatiquement configuré>
REDIS_URL=<sera automatiquement configuré>
REDIS_CACHE_URL=<même que REDIS_URL>
```

### Étape 8: Déployer

1. Cliquez sur "Deploy"
2. Attendez la fin du build
3. Votre application sera accessible!

## 🔧 Configuration avancée

### Ajouter un domaine

1. Dans Coolify, allez dans "Settings" → "Domains"
2. Ajoutez votre domaine
3. Configurez les DNS selon les instructions

### Ajouter SSL (HTTPS)

Coolify gère automatiquement SSL avec Let's Encrypt!

### Worker Sidekiq

1. Créez une nouvelle application dans Coolify
2. Même repository mais commande différente: `bundle exec sidekiq`
3. Partagez les mêmes variables d'environnement

## 💰 Coûts

**Total: $0/mois** (si vous utilisez Oracle Cloud Free Tier)

- VPS: Gratuit à vie
- Coolify: Gratuit (open-source)
- PostgreSQL: Gratuit (sur le même VPS)
- Redis: Gratuit (sur le même VPS)

## ⚠️ Limitations Oracle Cloud Free Tier

- 1 CPU core
- 1GB RAM (peut être limitant pour Rails)
- 200GB stockage
- 10TB bande passante/mois

**Recommandation:** Pour plus de RAM, considérez un VPS payant ($5-10/mois) ou utilisez plusieurs instances gratuites.

## 🆘 Dépannage

### Pas assez de RAM

Si 1GB n'est pas suffisant:
1. Optimisez votre application Rails
2. Utilisez Puma avec moins de workers
3. Considérez un VPS payant avec plus de RAM

### Voir les logs

Dans Coolify, cliquez sur votre application → "Logs"

### Redéployer

Dans Coolify, cliquez sur "Redeploy"

## 📚 Ressources

- [Documentation Coolify](https://coolify.io/docs)
- [Oracle Cloud Free Tier](https://www.oracle.com/cloud/free/)
- [Coolify GitHub](https://github.com/coollabsio/coolify)

