# 🆓 Déployer sur Coolify + Oracle Cloud (Gratuit à vie!)

Solution 100% gratuite avec contrôle total. Pas de limitations, pas de 502!

## 🎁 Ce que vous obtenez GRATUITEMENT

- ✅ **2 VPS gratuits à vie** (1 CPU, 1GB RAM chacun)
- ✅ **200GB de stockage**
- ✅ **10TB de bande passante/mois**
- ✅ **Coolify gratuit** (open-source)
- ✅ **PostgreSQL et Redis inclus**
- ✅ **Pas de suspension**
- ✅ **Pas de limitations**

## 🚀 Étape 1: Créer un VPS Oracle Cloud (5 minutes)

### 1.1 Créer un compte

1. Allez sur [Oracle Cloud Free Tier](https://www.oracle.com/cloud/free/)
2. Cliquez sur **"Start for Free"**
3. Créez un compte (nécessite une carte de crédit mais ne sera PAS débitée)
4. Vérifiez votre email

### 1.2 Créer une instance

1. Connectez-vous au [Console Oracle Cloud](https://cloud.oracle.com/)
2. Allez dans **"Compute"** → **"Instances"**
3. Cliquez sur **"Create Instance"**
4. Configurez:
   - **Name**: `spree-server`
   - **Image**: `Canonical Ubuntu 22.04`
   - **Shape**: `VM.Standard.E2.1.Micro` (Always Free)
   - **Networking**: Créez un nouveau VCN ou utilisez le défaut
   - **SSH Keys**: Téléchargez la clé privée ou créez-en une nouvelle
5. Cliquez sur **"Create"**

### 1.3 Configurer le firewall

1. Allez dans **"Networking"** → **"Security Lists"**
2. Sélectionnez votre VCN
3. Ajoutez des règles ingress:
   - **Port 22** (SSH) - Source: `0.0.0.0/0`
   - **Port 80** (HTTP) - Source: `0.0.0.0/0`
   - **Port 443** (HTTPS) - Source: `0.0.0.0/0`
   - **Port 8000** (Coolify) - Source: `0.0.0.0/0`

## 🚀 Étape 2: Installer Coolify (2 minutes)

### 2.1 Se connecter au serveur

```bash
ssh -i votre-clé-privée ubuntu@votre-ip-publique
```

### 2.2 Installer Coolify

```bash
curl -fsSL https://cdn.coollabs.io/coolify/install.sh | bash
```

Suivez les instructions. Coolify sera accessible sur `http://votre-ip:8000`

### 2.3 Configurer Coolify

1. Ouvrez `http://votre-ip:8000` dans votre navigateur
2. Créez un compte admin
3. Connectez votre GitHub/GitLab

## 🚀 Étape 3: Déployer Spree (3 minutes)

### 3.1 Créer PostgreSQL

1. Dans Coolify, cliquez sur **"New Resource"** → **"Database"** → **"PostgreSQL"**
2. Configurez:
   - **Name**: `spree-db`
   - **Version**: `16`
   - **Database**: `spree`
   - **User**: `spree`
   - **Password**: (générez un mot de passe fort)
3. Coolify créera automatiquement la base et configurera `DATABASE_URL` ✅

### 3.2 Créer Redis

1. Cliquez sur **"New Resource"** → **"Database"** → **"Redis"**
2. Configurez:
   - **Name**: `spree-redis`
   - **Version**: `7`
3. Coolify configurera automatiquement `REDIS_URL` ✅

### 3.3 Déployer l'application

1. Dans Coolify, cliquez sur **"New Resource"** → **"Application"**
2. Connectez votre repository: `https://github.com/ILYESS24/spree_starter.git`
3. Coolify détectera automatiquement le Dockerfile ✅
4. Configurez:
   - **Port**: `3000`
   - **Build Command**: (automatique avec Dockerfile)
   - **Start Command**: (automatique avec Dockerfile)

### 3.4 Variables d'environnement

Dans votre application Coolify, ajoutez:

```
RAILS_ENV=production
SECRET_KEY_BASE=6586529044089ca3731cb8c604d2f8570c48398808b9142d248498256a0b3b1407511e9b092bacd2aa2defbd69c37162d705b214246256ab72246cbf70773868
DATABASE_URL=<sera automatiquement configuré par Coolify>
REDIS_URL=<sera automatiquement configuré par Coolify>
RAILS_SERVE_STATIC_FILES=true
PORT=3000
```

### 3.5 Déployer

1. Cliquez sur **"Deploy"**
2. Attendez la fin du build (5-10 minutes)
3. Votre application sera accessible!

## 🔒 Étape 4: Configurer un domaine (optionnel)

1. Dans Coolify, allez dans **"Settings"** → **"Domains"**
2. Ajoutez votre domaine
3. Configurez les DNS selon les instructions
4. Coolify gère automatiquement SSL avec Let's Encrypt! ✅

## ✅ Résultat

Votre application sera accessible sur:
- `http://votre-ip:3000` (direct)
- Ou votre domaine si configuré

## 💰 Coûts

**Total: $0/mois - Gratuit à vie!**

- VPS: Gratuit à vie (Oracle Cloud)
- Coolify: Gratuit (open-source)
- PostgreSQL: Gratuit (sur le même VPS)
- Redis: Gratuit (sur le même VPS)

## 🎯 Avantages

- ✅ **100% gratuit** - Pas de limitations
- ✅ **Contrôle total** - Vous gérez tout
- ✅ **Pas de 502** - Votre infrastructure
- ✅ **Pas de suspension** - Toujours disponible
- ✅ **Interface moderne** - Similaire à Heroku

## 🆘 Dépannage

### Pas assez de RAM (1GB)

Si 1GB n'est pas suffisant:
1. Utilisez les 2 VPS gratuits (1 pour app, 1 pour DB)
2. Ou optimisez votre application Rails

### Voir les logs

Dans Coolify, cliquez sur votre application → **"Logs"**

### Redéployer

Dans Coolify, cliquez sur **"Redeploy"**

## 🎉 C'est la solution la plus économique!

Gratuit à vie, contrôle total, pas de limitations! 🚀

