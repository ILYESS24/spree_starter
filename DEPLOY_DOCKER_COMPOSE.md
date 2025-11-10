# 🐳 Déployer avec Docker Compose - Ultra Simple

Solution la plus simple: Docker Compose sur un VPS gratuit. Pas de plateforme cloud, tout sous votre contrôle!

## 🎁 Ce dont vous avez besoin

- Un VPS gratuit (Oracle Cloud - gratuit à vie)
- Docker et Docker Compose installés
- C'est tout!

## 🚀 Étape 1: Créer un VPS Oracle Cloud (5 minutes)

### 1.1 Créer un compte

1. Allez sur [Oracle Cloud Free Tier](https://www.oracle.com/cloud/free/)
2. Créez un compte (carte de crédit requise mais ne sera PAS débitée)
3. Vérifiez votre email

### 1.2 Créer une instance

1. Console Oracle Cloud → **Compute** → **Instances**
2. **Create Instance**:
   - **Name**: `spree-server`
   - **Image**: `Canonical Ubuntu 22.04`
   - **Shape**: `VM.Standard.E2.1.Micro` (Always Free)
   - **SSH Keys**: Téléchargez la clé privée
3. **Create**

### 1.3 Configurer le firewall

1. **Networking** → **Security Lists**
2. Ajoutez des règles ingress:
   - **Port 22** (SSH) - `0.0.0.0/0`
   - **Port 80** (HTTP) - `0.0.0.0/0`
   - **Port 443** (HTTPS) - `0.0.0.0/0`
   - **Port 3000** (Rails) - `0.0.0.0/0`

## 🚀 Étape 2: Installer Docker (2 minutes)

### 2.1 Se connecter

```bash
ssh -i votre-clé-privée ubuntu@votre-ip-publique
```

### 2.2 Installer Docker

```bash
# Mettre à jour
sudo apt update && sudo apt upgrade -y

# Installer Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Ajouter votre utilisateur au groupe docker
sudo usermod -aG docker ubuntu

# Installer Docker Compose
sudo apt install docker-compose -y

# Redémarrer (ou déconnectez/reconnectez)
exit
```

Reconnectez-vous et vérifiez:

```bash
docker --version
docker-compose --version
```

## 🚀 Étape 3: Déployer Spree (3 minutes)

### 3.1 Cloner votre repo

```bash
git clone https://github.com/ILYESS24/spree_starter.git
cd spree_starter
```

### 3.2 Créer le fichier .env

```bash
cp .env.production.example .env.production
nano .env.production
```

Remplissez:
```
SECRET_KEY_BASE=6586529044089ca3731cb8c604d2f8570c48398808b9142d248498256a0b3b1407511e9b092bacd2aa2defbd69c37162d705b214246256ab72246cbf70773868
POSTGRES_PASSWORD=votre_mot_de_passe_fort_ici
```

### 3.3 Démarrer avec Docker Compose

```bash
docker-compose -f docker-compose.production.yml --env-file .env.production up -d
```

### 3.4 Exécuter les migrations

```bash
docker-compose -f docker-compose.production.yml exec app bin/rails db:migrate
docker-compose -f docker-compose.production.yml exec app bin/rails db:seed
```

## ✅ C'est tout!

Votre application est maintenant accessible sur:
- `http://votre-ip:3000`

## 🔒 Étape 4: Configurer Nginx (optionnel)

Pour servir sur le port 80 avec SSL:

```bash
sudo apt install nginx certbot python3-certbot-nginx -y
```

Créez `/etc/nginx/sites-available/spree`:

```nginx
server {
    listen 80;
    server_name votre-domaine.com ou votre-ip;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

Activez et configurez SSL:

```bash
sudo ln -s /etc/nginx/sites-available/spree /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
sudo certbot --nginx -d votre-domaine.com
```

## 📋 Commandes utiles

```bash
# Voir les logs
docker-compose -f docker-compose.production.yml logs -f

# Redémarrer
docker-compose -f docker-compose.production.yml restart

# Arrêter
docker-compose -f docker-compose.production.yml down

# Mettre à jour
git pull
docker-compose -f docker-compose.production.yml up -d --build
```

## 💰 Coûts

**Total: $0/mois - Gratuit à vie!**

- VPS: Gratuit (Oracle Cloud Always Free)
- Docker: Gratuit (open-source)
- PostgreSQL: Gratuit (conteneur Docker)
- Redis: Gratuit (conteneur Docker)

## 🎯 Avantages

- ✅ **Ultra simple** - Juste Docker Compose
- ✅ **Gratuit à vie** - Oracle Cloud
- ✅ **Contrôle total** - Votre serveur
- ✅ **Pas de 502** - Votre infrastructure
- ✅ **Pas de limitations** - Utilisez ce que vous voulez

## 🆘 Dépannage

### Voir les logs

```bash
docker-compose -f docker-compose.production.yml logs app
```

### Redémarrer un service

```bash
docker-compose -f docker-compose.production.yml restart app
```

### Vérifier l'espace

```bash
df -h
docker system df
```

## 🎉 C'est la solution la plus simple et la plus économique!

Gratuit à vie, ultra simple, contrôle total! 🚀

