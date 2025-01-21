#!/bin/bash

# Créer le répertoire d'installation
install_dir="$HOME/.local/share/youtube-music-downloader"
mkdir -p "$install_dir"

# Copier les fichiers
cp extract_youtube.py "$install_dir/"
chmod +x "$install_dir/extract_youtube.py"

# Créer le répertoire pour le fichier .desktop
mkdir -p "$HOME/.local/share/applications"

# Créer le fichier .desktop
cat > "$HOME/.local/share/applications/youtube-music-downloader.desktop" << EOF
[Desktop Entry]
Name=YouTube Music Downloader
Comment=Télécharge de la musique depuis YouTube
Exec=python3 $install_dir/extract_youtube.py
Icon=audio-x-generic
Terminal=false
Type=Application
Categories=AudioVideo;Audio;
StartupNotify=true
EOF

# Rendre le fichier .desktop exécutable
chmod +x "$HOME/.local/share/applications/youtube-music-downloader.desktop"

echo "Installation terminée !" 