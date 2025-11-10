# 🚀 Déploiement sur Fly.io - Solution Simple

Fly.io est plus fiable que Render pour Rails. Guide simple étape par étape.

## ⚡ Installation (2 minutes)

### Windows (PowerShell)

```powershell
iwr https://fly.io/install.ps1 -useb | iex
```

### Vérifier l'installation

```bash
fly version
```

## 🔐 Étape 1: Se connecter

```bash
fly auth login
```

Cela ouvrira votre navigateur pour vous connecter.

## 🚀 Étape 2: Créer et déployer (automatique)

```bash
# Dans le dossier du projet
fly launch
```

Répondez aux questions:
- **App name**: `spree-starter` (ou votre nom)
- **Region**: `cdg` (Paris) ou `iad` (Washington)
- **PostgreSQL**: **Oui** ✅
- **Redis**: **Oui** ✅

Fly.io va automatiquement:
- ✅ Créer l'application
- ✅ Créer PostgreSQL (3GB gratuit)
- ✅ Créer Redis (256MB gratuit)
- ✅ Configurer `DATABASE_URL` et `REDIS_URL`
- ✅ Déployer votre application

## 🔑 Étape 3: Configurer SECRET_KEY_BASE

```bash
fly secrets set SECRET_KEY_BASE=6586529044089ca3731cb8c604d2f8570c48398808b9142d248498256a0b3b1407511e9b092bacd2aa2defbd69c37162d705b214246256ab72246cbf70773868
```

## 🗄️ Étape 4: Exécuter les migrations

```bash
fly ssh console -C "bin/rails db:migrate"
fly ssh console -C "bin/rails db:seed"
```

## ✅ C'est tout!

Votre application est maintenant en ligne! 🎉

**URL**: `https://spree-starter.fly.dev`

## 📋 Commandes utiles

```bash
# Voir les logs
fly logs

# Redéployer
fly deploy

# Ouvrir une console Rails
fly ssh console
```

## 🎯 Avantages de Fly.io vs Render

| Fonctionnalité | Fly.io | Render |
|----------------|--------|--------|
| **502 errors** | ❌ Rare | ✅ Fréquent |
| **Espace gratuit** | ✅ 3GB PostgreSQL | ❌ 1GB |
| **Suspension** | ❌ Non | ✅ Oui (15min) |
| **Facilité** | ✅ Très simple | ⚠️ Complexe |
| **Support Rails** | ✅ Excellent | ⚠️ Moyen |

## 🆘 Si problème

```bash
# Voir les logs
fly logs

# Vérifier les secrets
fly secrets list

# Redéployer
fly deploy
```

## 🎉 Résultat

Votre application sera accessible sur `https://spree-starter.fly.dev` sans erreur 502! 🚀

