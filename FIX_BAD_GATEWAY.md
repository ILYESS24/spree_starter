# 🔧 Fix Bad Gateway et problème d'espace sur Render

Guide pour résoudre le Bad Gateway (502) et le manque d'espace pour les assets frontend.

## 🔍 Diagnostic

Le Bad Gateway (502) signifie que:
1. Le service web ne démarre pas correctement
2. Les assets frontend ne sont pas compilés
3. Il n'y a plus d'espace disque

## ✅ Solutions

### Solution 1: Vérifier les logs Render

1. Allez sur [Render Dashboard](https://dashboard.render.com)
2. Cliquez sur votre service `spree_starter`
3. Allez dans l'onglet **Logs**
4. Vérifiez les erreurs récentes

### Solution 2: Vérifier les variables d'environnement

Assurez-vous que ces variables sont configurées:

```
RAILS_ENV=production
SECRET_KEY_BASE=<votre_clé_secrète>
DATABASE_URL=<URL de votre base de données>
RAILS_SERVE_STATIC_FILES=true
```

### Solution 3: Optimiser le build (déjà fait)

Le script `bin/render-build.sh` a été optimisé pour:
- ✅ Économiser l'espace (nettoyage des caches)
- ✅ Compiler les assets correctement
- ✅ Exclure les gems de développement

### Solution 4: Vérifier que le service démarre

Dans Render Dashboard → Service → Settings, vérifiez:

**Start Command:**
```
bundle exec puma -C config/puma.rb
```

**Build Command:**
```
bin/render-build.sh
```

### Solution 5: Redéployer avec les corrections

1. **Poussez les changements sur GitHub:**
   ```bash
   git add .
   git commit -m "Fix: Optimiser build et configurer assets"
   git push origin main
   ```

2. **Render redéploiera automatiquement**

3. **Ou déclenchez manuellement:**
   - Render Dashboard → Service → "Manual Deploy"

### Solution 6: Vérifier l'espace disque

Si vous avez toujours un problème d'espace:

1. **Nettoyer les anciens builds:**
   - Render Dashboard → Service → Settings
   - Cliquez sur "Clear Build Cache"

2. **Réduire la taille des assets:**
   - Les assets sont maintenant optimisés dans le build

### Solution 7: Vérifier la configuration Puma

Le fichier `config/puma.rb` doit être correct. Vérifiez que:
- Le port est `ENV.fetch("PORT", 3000)`
- Les threads sont configurés

## 🐛 Dépannage étape par étape

### Étape 1: Vérifier que le service écoute

Dans les logs Render, vous devriez voir:
```
Puma starting in single mode...
* Listening on http://0.0.0.0:3000
```

Si vous ne voyez pas ça, le service ne démarre pas.

### Étape 2: Vérifier les assets

Les assets doivent être dans `public/assets/` après le build.

Vérifiez dans les logs:
```
Writing /rails/public/assets/application-xxx.css
Writing /rails/public/assets/application-xxx.js
```

### Étape 3: Vérifier la base de données

Assurez-vous que `DATABASE_URL` est bien configuré et que la base est accessible.

### Étape 4: Tester le health check

Votre application doit répondre sur `/up`:
```
https://votre-app.onrender.com/up
```

Si ça retourne 200, l'application fonctionne.

## 🔧 Commandes utiles (via Shell Render)

Dans Render Dashboard → Service → Shell:

```bash
# Vérifier l'espace disque
df -h

# Vérifier que les assets sont compilés
ls -la public/assets/

# Vérifier les variables d'environnement
env | grep RAILS
env | grep DATABASE
env | grep SECRET

# Tester la connexion à la base
bin/rails runner "puts ActiveRecord::Base.connection.execute('SELECT 1').first"
```

## 📋 Checklist de vérification

- [ ] `SECRET_KEY_BASE` est configuré
- [ ] `DATABASE_URL` est configuré et accessible
- [ ] `RAILS_ENV=production` est configuré
- [ ] `RAILS_SERVE_STATIC_FILES=true` est configuré
- [ ] Les assets sont compilés (vérifier dans les logs)
- [ ] Le service écoute sur le port 3000
- [ ] Il y a assez d'espace disque
- [ ] Les migrations sont exécutées

## 🆘 Si ça ne fonctionne toujours pas

1. **Vérifiez les logs complets** dans Render
2. **Testez localement** avec Docker:
   ```bash
   docker build -t spree-test .
   docker run -p 3000:3000 -e SECRET_KEY_BASE=test -e RAILS_ENV=production spree-test
   ```
3. **Contactez le support Render** avec les logs

## ✅ Après correction

Une fois que tout fonctionne:
- ✅ L'application répond sur `/up`
- ✅ Les assets CSS/JS sont chargés
- ✅ La base de données est accessible
- ✅ Pas d'erreurs dans les logs

Votre application devrait être accessible sur `https://votre-app.onrender.com` ! 🎉

