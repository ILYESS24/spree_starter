# 🚀 Déploiement rapide sur Fly.io

Guide étape par étape pour déployer Spree sur Fly.io (alternative gratuite à Render/Railway).

## ⚡ Installation rapide (5 minutes)

### 1. Installer Fly CLI

**Windows (PowerShell):**
```powershell
iwr https://fly.io/install.ps1 -useb | iex
```

**Vérifier l'installation:**
```bash
fly version
```

### 2. Se connecter

```bash
fly auth login
```

Cela ouvrira votre navigateur pour vous connecter.

### 3. Créer et déployer l'application

```bash
# Dans le dossier du projet
fly launch
```

Répondez aux questions:
- **App name:** `spree-starter` (ou votre nom)
- **Region:** Choisissez la région la plus proche (ex: `cdg` pour Paris)
- **PostgreSQL:** **Oui** ✅
- **Redis:** **Oui** ✅

Fly.io va:
- ✅ Créer l'application
- ✅ Créer une base PostgreSQL (3GB gratuite)
- ✅ Créer Redis (256MB gratuit)
- ✅ Configurer automatiquement les variables d'environnement
- ✅ Déployer votre application

### 4. Configurer SECRET_KEY_BASE

```bash
# Générer une clé secrète
fly secrets set SECRET_KEY_BASE=$(ruby -e "require 'securerandom'; puts SecureRandom.hex(64)")
```

**Si Ruby n'est pas installé localement**, générez la clé en ligne:
- Allez sur https://www.ruby-lang.org/en/documentation/installation/
- Ou utilisez: `openssl rand -hex 64` (si OpenSSL est installé)

Puis:
```bash
fly secrets set SECRET_KEY_BASE=votre_clé_générée_ici
```

### 5. Exécuter les migrations

```bash
fly ssh console -C "bin/rails db:migrate"
fly ssh console -C "bin/rails db:seed"
```

### 6. Ouvrir l'application

```bash
fly open
```

Votre application est maintenant en ligne! 🎉

## 📋 Commandes utiles

```bash
# Voir les logs
fly logs

# Ouvrir une console Rails
fly ssh console

# Redéployer
fly deploy

# Voir le statut
fly status

# Voir les variables d'environnement
fly secrets list
```

## 🔧 Configuration avancée

### Ajouter un worker Sidekiq

Créez `fly.worker.toml`:
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

Puis:
```bash
fly scale count worker=1 --config fly.worker.toml
```

### Augmenter la mémoire

Si vous avez besoin de plus de RAM:
```bash
fly scale vm shared-cpu-1x --memory 1024
```

## 💰 Coûts

**Plan gratuit:**
- 3 machines virtuelles (256MB chacune)
- PostgreSQL 3GB
- Redis 256MB
- 160GB bande passante/mois

**Si vous dépassez:**
- ~$5-10/mois pour un usage modéré

## 🆘 Dépannage

### L'application ne démarre pas

```bash
# Voir les logs
fly logs

# Vérifier les variables d'environnement
fly secrets list

# Vérifier que DATABASE_URL est défini
fly ssh console -C "echo $DATABASE_URL"
```

### Erreur de connexion à la base de données

Vérifiez que PostgreSQL est bien créé:
```bash
fly postgres list
```

### Erreur SECRET_KEY_BASE

Assurez-vous que la variable est définie:
```bash
fly secrets set SECRET_KEY_BASE=votre_clé
fly deploy
```

## 📚 Ressources

- [Documentation Fly.io](https://fly.io/docs)
- [Documentation Rails](https://fly.io/docs/rails/)
- [Dashboard](https://fly.io/dashboard)

## ✅ Avantages de Fly.io vs Render/Railway

| Fonctionnalité | Fly.io | Render | Railway |
|----------------|--------|--------|---------|
| Espace gratuit | 3GB PostgreSQL | 1GB | 1GB |
| Suspension | ❌ Non | ✅ Oui (15min) | ✅ Oui |
| Redis gratuit | ✅ 256MB | ✅ 25MB | ✅ 25MB |
| Machines gratuites | ✅ 3 | ✅ 1 | ✅ 1 |
| Déploiement global | ✅ Oui | ❌ Non | ❌ Non |

**Fly.io est la meilleure option gratuite!** 🎯

