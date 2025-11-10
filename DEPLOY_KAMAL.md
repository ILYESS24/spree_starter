# Déploiement avec Kamal (Self-hosted)

Kamal (ex-MRSK) est l'outil officiel de Rails pour déployer sur votre propre serveur. Parfait pour un VPS gratuit!

## 🎯 Pourquoi Kamal?

- ✅ Développé par l'équipe Rails
- ✅ Gratuit (vous gérez votre serveur)
- ✅ Simple et rapide
- ✅ Support Docker
- ✅ Déploiements sans interruption

## 📋 Prérequis

Un VPS avec:
- Ubuntu 22.04 ou similaire
- Docker installé
- Accès SSH

**Options de VPS gratuits:**
- Oracle Cloud Free Tier (recommandé)
- Google Cloud Free Tier
- AWS Free Tier

## 🚀 Installation

### Étape 1: Installer Kamal

```bash
gem install kamal
```

### Étape 2: Initialiser Kamal

```bash
kamal setup
```

Cela créera un fichier `config/deploy.yml`

### Étape 3: Configurer le déploiement

Éditez `config/deploy.yml`:

```yaml
service: spree-starter
image: votre-registry/spree-starter

servers:
  web:
    hosts:
      - votre-ip-ou-domaine.com
    options:
      - "--label=traefik.enable=true"
      - "--label=traefik.http.routers.spree.rule=Host(`votre-domaine.com`)"
      - "--label=traefik.http.services.spree.loadbalancer.server.port=3000"

registry:
  server: registry.docker.com
  username: votre-username
  password:
    - KAMAL_REGISTRY_PASSWORD

builder:
  arch: amd64

env:
  secret:
    - SECRET_KEY_BASE
    - DATABASE_URL
    - REDIS_URL

accessories:
  postgres:
    image: postgres:16
    host: votre-ip-ou-domaine.com
    port: 5432
    env:
      secret:
        - POSTGRES_PASSWORD
    directories:
      - data:/var/lib/postgresql/data

  redis:
    image: redis:7
    host: votre-ip-ou-domaine.com
    port: 6379
    directories:
      - data:/data
```

### Étape 4: Configurer les secrets

```bash
kamal envify
```

Cela créera un fichier `.kamal/secrets` (ajoutez-le à `.gitignore`):

```bash
SECRET_KEY_BASE=votre_clé_secrète
DATABASE_URL=postgresql://spree:password@votre-ip:5432/spree
REDIS_URL=redis://votre-ip:6379/0
POSTGRES_PASSWORD=votre_mot_de_passe
```

### Étape 5: Préparer le serveur

```bash
kamal server bootstrap
```

### Étape 6: Déployer

```bash
kamal deploy
```

### Étape 7: Exécuter les migrations

```bash
kamal app exec "bin/rails db:migrate"
kamal app exec "bin/rails db:seed"
```

## 🔧 Commandes utiles

```bash
# Voir les logs
kamal app logs

# Ouvrir une console Rails
kamal app exec "bin/rails console"

# Redéployer
kamal deploy

# Arrêter
kamal app stop

# Démarrer
kamal app start
```

## 💰 Coûts

**Total: $0/mois** (avec VPS gratuit)

- VPS: Gratuit (Oracle Cloud)
- Kamal: Gratuit (open-source)
- Docker Registry: Gratuit (Docker Hub) ou payant

## 📚 Ressources

- [Documentation Kamal](https://kamal-deploy.org)
- [Guide Rails](https://guides.rubyonrails.org/deployment.html)

