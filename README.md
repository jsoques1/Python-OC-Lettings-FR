[![forthebadge](https://forthebadge.com/images/badges/made-with-python.svg)](https://forthebadge.com) [![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)

# Projet 13 : Mettez à l'échelle une application Django en utilisant une architecture modulaire

*** voir https://openclassrooms.com/fr/paths/518/projects/841/assignment ***

## Logiciels
 
 ```
Windows 11
Python 3.10.1
CircleCI
Docker, Docker Hub 2022, Docker Desktop 4.12.0,
Heroku 
Sentry 
modules python - voir requirements.txt
```

## Développement local

### Prérequis

Site web d'Orange County Lettings

- Compte GitHub avec accès en lecture à ce repository
- Git CLI
- SQLite3 CLI
- Interpréteur Python, version 3.6 ou supérieure

Dans le reste de la documentation sur le développement local, il est supposé que la commande `python` de votre OS shell exécute l'interpréteur Python ci-dessus (à moins qu'un environnement virtuel ne soit activé).


#### Cloner le repository

- `cd /path/to/put/project/in`
- `git clone https://github.com/OpenClassrooms-Student-Center/Python-OC-Lettings-FR.git`

#### Créer l'environnement virtuel

- `cd /path/to/Python-OC-Lettings-FR`
- `python -m venv venv`
- `apt-get install python3-venv` (Si l'étape précédente comporte des erreurs avec un paquet non trouvé sur Ubuntu)
- Activer l'environnement `source venv/bin/activate`
- Confirmer que la commande `python` exécute l'interpréteur Python dans l'environnement virtuel
`which python`
- Confirmer que la version de l'interpréteur Python est la version 3.6 ou supérieure `python --version`
- Confirmer que la commande `pip` exécute l'exécutable pip dans l'environnement virtuel, `which pip`
- Pour désactiver l'environnement, `deactivate`

#### Exécuter le site

- `cd /path/to/Python-OC-Lettings-FR`
- `source venv/bin/activate`
- `pip install --requirement requirements.txt`
- `python manage.py runserver`
- Aller sur `http://localhost:8000` dans un navigateur.
- Confirmer que le site fonctionne et qu'il est possible de naviguer (vous devriez voir plusieurs profils et locations).

#### Linting

- `cd /path/to/Python-OC-Lettings-FR`
- `source venv/bin/activate`
- `flake8`

#### Tests unitaires

- `cd /path/to/Python-OC-Lettings-FR`
- `source venv/bin/activate`
- `pytest`

#### Base de données

- `cd /path/to/Python-OC-Lettings-FR`
- Ouvrir une session shell `sqlite3`
- Se connecter à la base de données `.open oc-lettings-site.sqlite3`
- Afficher les tables dans la base de données `.tables`
- Afficher les colonnes dans le tableau des profils, `pragma table_info(Python-OC-Lettings-FR_profile);`
- Lancer une requête sur la table des profils, `select user_id, favorite_city from
  Python-OC-Lettings-FR_profile where favorite_city like 'B%';`
- `.quit` pour quitter

#### Panel d'administration

- Aller sur `http://localhost:8000/admin`
- Connectez-vous avec l'utilisateur `admin`, mot de passe `Abc1234!`

## Déploiement

### fonctionnement

Une application GitHub mise à jour avec un Push des modifications vers GitHub va déclencher un pipeline CircleCI
comprenant étapes :
* lint du code et exécutions des tests de non-régression,
* génération d'une image Docker pour le déploiement de l'application mise à jour sur les sites le nécessitant,
* déploiement de l'application sur Heroku, où l'application est automatiquement démarré.

Sur échec d'une étape, le pipeline est interrompu avec une erreur reportée pour le Push initial

Lors de l'échec d'execution de l'application, une erreur est reportée par Django vers Sentry.

### Variables de configuration CircleCI

| Clé             | Valeur                  |
|-----------------|-------------------------|
| DOCKER_LOGIN    | Docker Hub login        |
| DOCKER_PASSWORD | Docker Hub Passwd       |
| HEROKU_REPO     | Docker Hub repository   |
| HEROKU_APP_NAME | Heroku application name |
| HEROKU_TOKEN    | Heroku token            |

### Variables dans settings.py
- ALLOWED_HOSTS doit contenir le dns de l'application déployé sur le web par Heroku
Sentry dns dans sentry_sdk.init()

### Récupération d'une image Docker
- lancer le Docker Desktop (s'il ne l'est pas encore)
- sélectionner Images/REMOTE REPOSITORIES
- sélectionner une image (la dernière contient toutes les dernières m.à.j.) en positionnant le curseur sur la bonne 
  ligne
- cliquer RUN qui apparaît et valider
- le contenu de Images/Local va afficher les barres d'avancement de chargement de l'image Docker

L'image téléchargée va être stockée sous C:\Users\my_win_username\AppData\Local\Docker\wsl\data\ext4.vhdx

### Lancement d'une image locale

Lancer la commande suivante dans une fenêtre powershell: 
- `docker run -p 8000:8000 -i -t $DOCKER_USERNAME/$IMAGE_REPO:$CIRCLE_SHA1`     

$DOCKER_USERNAME/$IMAGE_REPO:$CIRCLE_SHA1 est le tag associé à l'image locale.

- lancer l'application avec
    `https://localhost:8000`      
     ou la partie administrative de l'application  
    `https://localhost:8000/admin/`

### Lancement d'une application déployée heroku

- utiliser le dns de l'application déployée sur le web par Heroku déclaré dans settings.py