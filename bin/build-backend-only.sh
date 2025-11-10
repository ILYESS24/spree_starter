#!/usr/bin/env bash
# Build script optimisé pour backend uniquement (sans assets)
# exit on error
set -o errexit

echo "🔧 Building backend only (no assets compilation)..."

# Installer uniquement les dépendances nécessaires
bundle install --deployment --without development test

# Ne PAS compiler les assets (économise beaucoup d'espace)
echo "✅ Backend build complete - assets skipped to save space"

# Nettoyer les caches
rm -rf tmp/cache/* log/*.log 2>/dev/null || true

echo "✅ Build finished - ready to deploy!"

