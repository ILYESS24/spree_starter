#!/usr/bin/env bash
# Build script pour frontend uniquement (assets seulement)
# exit on error
set -o errexit

echo "🎨 Building frontend assets only..."

# Installer les dépendances
bundle install --deployment --without development test

# Compiler uniquement les assets
RAILS_ENV=production SECRET_KEY_BASE=dummy bin/rails assets:precompile

# Nettoyer après compilation
bin/rails assets:clean

# Nettoyer les caches
rm -rf tmp/cache/* log/*.log 2>/dev/null || true

echo "✅ Frontend assets compiled in public/assets/"

