# Déploiement sur Fly.io - Alternative gratuite

Fly.io est une excellente alternative gratuite pour déployer des applications Rails. Il offre:
- ✅ 3 machines virtuelles gratuites (256MB RAM chacune)
- ✅ Base de données PostgreSQL gratuite (3GB)
- ✅ Redis gratuit (256MB)
- ✅ Pas de suspension après inactivité
- ✅ Déploiement global (CDN)

## 🚀 Installation et configuration

### Étape 1: Installer Fly CLI

**Windows (PowerShell):**
```powershell
iwr https://fly.io/install.ps1 -useb | iex
```

**Mac/Linux:**
```bash
curl -L https://fly.io/install.sh | sh
```

### Étape 2: Se connecter à Fly.io

```bash
fly auth login
```

### Étape 3: Créer l'application

```bash
fly launch
```

Répondez aux questions:
- App name: `spree-starter` (ou votre nom)
- Region: choisissez la région la plus proche (ex: `cdg` pour Paris)
- PostgreSQL: **Oui** (créera une base de données)
- Redis: **Oui** (créera une instance Redis)

### Étape 4: Configurer les variables d'environnement

```bash
# Générer SECRET_KEY_BASE
fly secrets set SECRET_KEY_BASE=$(ruby -e "require 'securerandom'; puts SecureRandom.hex(64)")

# Ou manuellement:
fly secrets set SECRET_KEY_BASE=votre_clé_secrète_ici
```

### Étape 5: Configurer la base de données

Fly.io créera automatiquement une base PostgreSQL. Les variables seront automatiquement configurées:
- `DATABASE_URL` sera automatiquement défini

### Étape 6: Configurer Redis

Si vous avez créé Redis, la variable `REDIS_URL` sera automatiquement définie.

Sinon, créez Redis:
```bash
fly redis create
```

### Étape 7: Déployer

```bash
fly deploy
```

### Étape 8: Exécuter les migrations

```bash
fly ssh console -C "bin/rails db:migrate"
fly ssh console -C "bin/rails db:seed"
```

## 📋 Variables d'environnement complètes

```bash
fly secrets set SECRET_KEY_BASE=votre_clé_secrète
fly secrets set RAILS_ENV=production
fly secrets set REDIS_URL=redis://...  # Si créé manuellement
fly secrets set REDIS_CACHE_URL=redis://...  # Même URL que REDIS_URL
```

## 🔧 Configuration avancée

### Ajouter un worker Sidekiq

Créez un fichier `fly.worker.toml`:

```toml
app = "spree-starter"
primary_region = "cdg"

[env]
  RAILS_ENV = "production"

[[vm]]
  memory_mb = 256
  cpu_kind = "shared"
  cpus = 1

[processes]
  worker = "bundle exec sidekiq"
```

Puis créez le worker:
```bash
fly scale count worker=1 --config fly.worker.toml
```

### Voir les logs

```bash
fly logs
```

### Ouvrir une console Rails

```bash
fly ssh console
```

## 💰 Plan gratuit Fly.io

- **3 machines virtuelles** (256MB RAM chacune)
- **PostgreSQL**: 3GB de stockage
- **Redis**: 256MB
- **Bande passante**: 160GB/mois
- **Pas de suspension** après inactivité

## 🌍 Régions disponibles

Choisissez la région la plus proche de vos utilisateurs:
- `cdg` - Paris, France
- `iad` - Washington, USA
- `lhr` - London, UK
- `syd` - Sydney, Australia
- `nrt` - Tokyo, Japan
- Et plus...

## 🔗 Liens utiles

- [Documentation Fly.io](https://fly.io/docs)
- [Documentation Rails sur Fly.io](https://fly.io/docs/rails/)
- [Dashboard Fly.io](https://fly.io/dashboard)

## ⚠️ Notes importantes

1. Le plan gratuit a des limites mais est généreux pour le développement
2. Les machines peuvent être mises en veille après inactivité (mais se réveillent automatiquement)
3. Pour la production, considérez un plan payant ($5-10/mois)

