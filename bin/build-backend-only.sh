#!/usr/bin/env bash
# Build script optimisé pour backend uniquement (sans assets)
# exit on error
set -o errexit

echo "🔧 Building backend API only (no assets compilation)..."

# Installer uniquement les dépendances nécessaires (sans assets)
bundle install --deployment --without development test assets

# Ne PAS compiler les assets (économise beaucoup d'espace)
echo "✅ Backend API build complete - assets skipped to save space"

# Nettoyer les caches et fichiers inutiles
rm -rf tmp/cache/* log/*.log public/assets 2>/dev/null || true

echo "✅ Backend build finished - ready to deploy API!"

