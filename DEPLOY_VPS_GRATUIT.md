# 🆓 Déployer sur VPS Gratuit (Alternatives à Oracle)

Guide pour déployer avec Docker Compose sur différents VPS gratuits.

## 🎁 Options de VPS Gratuits

### Option 1: DigitalOcean (Crédit gratuit $200)

**Avantages:**
- ✅ $200 crédit gratuit (60 jours)
- ✅ Interface très simple
- ✅ Excellent support
- ✅ Documentation complète

**Étapes:**
1. Créez un compte sur [DigitalOcean](https://www.digitalocean.com/)
2. Utilisez le lien de crédit gratuit (cherchez "DigitalOcean $200 credit")
3. Créez un Droplet:
   - **Image**: Ubuntu 22.04
   - **Plan**: Basic $6/mois (utilise le crédit)
   - **Region**: Choisissez la plus proche
4. Suivez `DEPLOY_DOCKER_COMPOSE.md` pour installer Docker et déployer

**Coût:** Gratuit 60 jours, puis $6/mois

---

### Option 2: AWS Free Tier

**Avantages:**
- ✅ 12 mois gratuit
- ✅ EC2 t2.micro gratuit
- ✅ 30GB stockage gratuit

**Étapes:**
1. Créez un compte [AWS](https://aws.amazon.com/)
2. Créez une instance EC2:
   - **AMI**: Ubuntu 22.04
   - **Instance Type**: t2.micro (Free Tier)
   - **Security Group**: Ouvrez ports 22, 80, 443, 3000
3. Suivez `DEPLOY_DOCKER_COMPOSE.md`

**Coût:** Gratuit 12 mois, puis ~$5-10/mois

---

### Option 3: Google Cloud Platform (Crédit gratuit $300)

**Avantages:**
- ✅ $300 crédit gratuit (90 jours)
- ✅ f1-micro gratuit à vie (limité)
- ✅ Interface moderne

**Étapes:**
1. Créez un compte [GCP](https://cloud.google.com/)
2. Créez une VM:
   - **Image**: Ubuntu 22.04
   - **Machine Type**: f1-micro (gratuit à vie)
   - **Firewall**: Ouvrez ports nécessaires
3. Suivez `DEPLOY_DOCKER_COMPOSE.md`

**Coût:** Gratuit avec crédit, puis ~$5/mois

---

### Option 4: Azure (Crédit gratuit $200)

**Avantages:**
- ✅ $200 crédit gratuit (30 jours)
- ✅ B1s gratuit 12 mois
- ✅ Interface intuitive

**Étapes:**
1. Créez un compte [Azure](https://azure.microsoft.com/)
2. Créez une VM:
   - **Image**: Ubuntu 22.04
   - **Size**: B1s (gratuit 12 mois)
3. Suivez `DEPLOY_DOCKER_COMPOSE.md`

**Coût:** Gratuit avec crédit, puis ~$10/mois

---

### Option 5: Contabo (VPS très abordable)

**Avantages:**
- ✅ VPS à partir de €4.99/mois
- ✅ Pas de crédit, prix fixe
- ✅ Bonnes performances

**Étapes:**
1. Créez un compte sur [Contabo](https://www.contabo.com/)
2. Commandez un VPS (VPS S - €4.99/mois)
3. Suivez `DEPLOY_DOCKER_COMPOSE.md`

**Coût:** €4.99/mois (~$5.50)

---

## 🚀 Déploiement (identique pour tous)

Une fois votre VPS créé, suivez ces étapes:

### 1. Se connecter

```bash
ssh ubuntu@votre-ip
```

### 2. Installer Docker

```bash
curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh
sudo apt install docker-compose -y
sudo usermod -aG docker ubuntu
```

### 3. Déployer

```bash
git clone https://github.com/ILYESS24/spree_starter.git
cd spree_starter
cp .env.production.example .env.production
nano .env.production  # Éditez avec vos valeurs
docker-compose -f docker-compose.production.yml --env-file .env.production up -d
docker-compose -f docker-compose.production.yml exec app bin/rails db:migrate
```

## 📊 Comparaison

| Fournisseur | Gratuit | Après gratuit | RAM | Stockage |
|-------------|---------|---------------|-----|----------|
| **DigitalOcean** | $200 crédit | $6/mois | 1GB | 25GB |
| **AWS** | 12 mois | $5-10/mois | 1GB | 30GB |
| **GCP** | $300 crédit | $5/mois | 0.6GB | 30GB |
| **Azure** | $200 crédit | $10/mois | 1GB | 30GB |
| **Contabo** | ❌ | €4.99/mois | 4GB | 50GB |

## 🎯 Recommandation

### Pour commencer (gratuit):
**DigitalOcean** - $200 crédit, très simple, excellent support

### Pour long terme (abordable):
**Contabo** - €4.99/mois, bonnes performances, prix fixe

## ✅ Tous utilisent le même déploiement

Peu importe le VPS, le déploiement avec Docker Compose est identique! 🚀

