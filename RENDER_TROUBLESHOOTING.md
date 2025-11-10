# 🚨 Dépannage Render - Bad Gateway et Assets

## Problème: Bad Gateway (502) + Pas de frontend

### Causes possibles:

1. **Service ne démarre pas**
2. **Assets non compilés**
3. **Manque d'espace disque**
4. **Variables d'environnement manquantes**

## 🔧 Solutions rapides

### 1. Ajouter la variable manquante

Dans Render Dashboard → Service → Environment, ajoutez:

```
RAILS_SERVE_STATIC_FILES=true
```

### 2. Vérifier SECRET_KEY_BASE

Assurez-vous que `SECRET_KEY_BASE` est bien défini.

### 3. Vérifier DATABASE_URL

La base de données doit être accessible.

### 4. Redéployer

Après avoir ajouté les variables, redéployez:
- Render Dashboard → Service → "Manual Deploy"

## 📊 Vérification des logs

Dans Render Dashboard → Logs, cherchez:

✅ **Bon signe:**
```
Puma starting in single mode...
* Listening on http://0.0.0.0:3000
```

❌ **Mauvais signe:**
```
Missing `secret_key_base`
Cannot connect to database
No space left on device
```

## 🎯 Solution complète

1. **Poussez les changements:**
   ```bash
   git add .
   git commit -m "Fix: Configuration pour Render"
   git push origin main
   ```

2. **Vérifiez les variables d'environnement:**
   - `RAILS_ENV=production`
   - `SECRET_KEY_BASE=<votre_clé>`
   - `DATABASE_URL=<votre_url>`
   - `RAILS_SERVE_STATIC_FILES=true`

3. **Attendez le redéploiement**

4. **Vérifiez les logs**

## 📞 Support

Si le problème persiste, partagez les logs Render pour diagnostic.

