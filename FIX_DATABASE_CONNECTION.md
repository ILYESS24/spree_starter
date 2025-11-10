# ⚠️ Erreur: ConnectionNotEstablished - Fix rapide

## Problème

```
ActiveRecord::ConnectionNotEstablished: connection to server on socket failed
```

Cela signifie que `DATABASE_URL` n'est pas configuré ou incorrect.

## ✅ Solution immédiate

1. **Render Dashboard** → Service `spree_starter` → **Environment**
2. **Ajoutez `DATABASE_URL`**:
   - Allez sur la base `spree-db` → Copiez **Internal Database URL**
   - Ajoutez-la comme variable `DATABASE_URL`
3. **Save** → Redéploiement automatique

## 📍 Où trouver l'URL

1. Render Dashboard → **Databases** → `spree-db`
2. Onglet **Info**
3. Copiez **Internal Database URL** (pas External)

## ✅ C'est tout!

Une fois `DATABASE_URL` ajouté, le service redéploiera et se connectera à la base! 🚀

