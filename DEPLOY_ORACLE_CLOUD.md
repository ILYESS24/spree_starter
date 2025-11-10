# Déploiement sur Oracle Cloud Free Tier

Oracle Cloud offre 2 VPS gratuits à vie! Parfait pour héberger Spree.

## 🎁 Ce que vous obtenez gratuitement

- ✅ 2 instances "Always Free" (1 CPU, 1GB RAM chacune)
- ✅ 200GB de stockage
- ✅ 10TB de bande passante/mois
- ✅ **Gratuit à vie** (pas d'expiration!)

## 🚀 Étape 1: Créer un compte Oracle Cloud

1. Allez sur [Oracle Cloud Free Tier](https://www.oracle.com/cloud/free/)
2. Créez un compte (nécessite une carte de crédit mais ne sera PAS débitée)
3. Vérifiez votre email

## 🖥️ Étape 2: Créer une instance

1. Connectez-vous au [Console Oracle Cloud](https://cloud.oracle.com/)
2. Allez dans "Compute" → "Instances"
3. Cliquez sur "Create Instance"
4. Configurez:
   - **Name:** spree-server
   - **Image:** Ubuntu 22.04
   - **Shape:** VM.Standard.E2.1.Micro (Always Free)
   - **Networking:** Créez un nouveau VCN ou utilisez le défaut
   - **SSH Keys:** Téléchargez la clé privée ou créez-en une nouvelle
5. Cliquez sur "Create"

## 🔐 Étape 3: Configurer le firewall

1. Allez dans "Networking" → "Security Lists"
2. Sélectionnez votre VCN
3. Ajoutez des règles ingress:
   - **Port 22** (SSH) - Source: 0.0.0.0/0
   - **Port 80** (HTTP) - Source: 0.0.0.0/0
   - **Port 443** (HTTPS) - Source: 0.0.0.0/0
   - **Port 3000** (Rails) - Source: 0.0.0.0/0 (temporaire)

## 📦 Étape 4: Installer Docker sur le serveur

Connectez-vous via SSH:

```bash
ssh -i votre-clé-privée ubuntu@votre-ip-publique
```

Puis installez Docker:

```bash
# Mettre à jour le système
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

## 🗄️ Étape 5: Installer PostgreSQL et Redis

Créez un fichier `docker-compose.yml`:

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:16
    environment:
      POSTGRES_DB: spree
      POSTGRES_USER: spree
      POSTGRES_PASSWORD: votre_mot_de_passe_fort
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    restart: unless-stopped

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    restart: unless-stopped

volumes:
  postgres_data:
  redis_data:
```

Démarrez les services:

```bash
docker-compose up -d
```

## 🚀 Étape 6: Déployer Spree

### Option A: Avec Docker directement

```bash
# Cloner votre repo
git clone https://github.com/ILYESS24/spree_starter.git
cd spree_starter

# Construire l'image
docker build -t spree-starter .

# Lancer le conteneur
docker run -d \
  --name spree-app \
  -p 3000:3000 \
  -e RAILS_ENV=production \
  -e SECRET_KEY_BASE=votre_clé_secrète \
  -e DATABASE_URL=postgresql://spree:votre_mot_de_passe@localhost:5432/spree \
  -e REDIS_URL=redis://localhost:6379/0 \
  --link postgres:postgres \
  --link redis:redis \
  spree-starter
```

### Option B: Avec Coolify (Recommandé)

Suivez le guide dans `DEPLOY_COOLIFY.md`

### Option C: Avec Kamal

Suivez le guide dans `DEPLOY_KAMAL.md`

## 🔒 Étape 7: Configurer Nginx (Reverse Proxy)

Installez Nginx:

```bash
sudo apt install nginx -y
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
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Activez le site:

```bash
sudo ln -s /etc/nginx/sites-available/spree /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

## 🔐 Étape 8: SSL avec Let's Encrypt

```bash
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d votre-domaine.com
```

## 📊 Gestion des ressources

Avec seulement 1GB RAM, optimisez:

```bash
# Voir l'utilisation
free -h
df -h

# Limiter les workers Puma
# Dans config/puma.rb:
workers 1
threads 2, 4
```

## 💰 Coûts

**Total: $0/mois** - Gratuit à vie!

## ⚠️ Limitations

- 1GB RAM peut être limitant pour Rails + PostgreSQL + Redis
- Considérez d'utiliser une seule instance pour tout, ou 2 instances séparées

## 🆘 Dépannage

### Pas assez de RAM

```bash
# Créer un swap file
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

### Voir les logs

```bash
docker logs spree-app
docker-compose logs
```

## 📚 Ressources

- [Oracle Cloud Documentation](https://docs.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
- [Oracle Cloud Free Tier](https://www.oracle.com/cloud/free/)

