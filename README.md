# todo-list
Ceci est une todo liste pour la formation D-CLIC. 
Description
Lyst est une application mobile intuitive de gestion de tâches qui permet aux utilisateurs de créer, organiser, compléter et supprimer leurs tâches quotidiennes. Développée avec Flutter et utilisant SQLite pour le stockage local, elle offre une expérience utilisateur fluide et moderne avec une interface soignée.

# Objectifs du Projet:
 
 Gestion simple et efficace des tâches
 
 Interface utilisateur moderne et élégante
 
 Persistance des données locale avec SQLite
 
 Authentification multi-utilisateurs
 
 Compatible Android et iOS

# Étapes d'installation

# Cloner le repository

git clone https://github.com/alixHub-ux/todo-list.git

cd todo-list

# Installer les Dépendances

flutter pub get

Lancer l’Application

# Sur emulateur / appareil Android
flutter run

# Sur emulateur / appareil iOS
flutter run -d ios

# Dépendances du Projet

dependencies :
dependencies:
  flutter:
    sdk: flutter
  
  # Base de données
  sqflite: ^2.3.0          # SQLite pour Flutter
  path: ^1.8.3             # Gestion des chemins
  path_provider: ^2.1.1    # Accès aux répertoires
  
  # Utilitaires
  intl: ^0.18.1            # Formatage des dates
  crypto: ^3.0.3           # Hachage des mots de passe
