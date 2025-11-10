#!/usr/bin/env bash
# exit on error
set -o errexit

# Installer les dépendances
bundle install --deployment --without development test

# Précompiler les assets (optimisé pour économiser l'espace)
RAILS_ENV=production SECRET_KEY_BASE=dummy bin/rails assets:precompile

# Nettoyer les assets temporaires pour économiser l'espace (nécessite aussi SECRET_KEY_BASE)
RAILS_ENV=production SECRET_KEY_BASE=dummy bin/rails assets:clean

# Nettoyer les caches pour économiser l'espace
rm -rf tmp/cache/*
rm -rf log/*.log