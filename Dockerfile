# 1. Utiliser une image Python légère basée sur Alpine Linux
FROM python:3.10-alpine

# 2. Exposer le port 8000 pour accéder à l'application Django
EXPOSE 8000

# 3. Définir le dossier de travail à l'intérieur du conteneur
WORKDIR /app

# 4. Installer les dépendances système nécessaires (outils de compilation et base de données)
RUN apk update && apk add \
    pkgconfig \
    gcc \
    musl-dev \
    bash \
    mariadb-dev

# 5. Copier le fichier des dépendances Python et les installer
COPY requirements.txt /app
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copier tout le code source du projet dans le conteneur
COPY . /app

# 7. Définir l'exécutable principal (Python 3)
ENTRYPOINT ["python3"]

# 8. Lancer le serveur de développement Django sur toutes les interfaces réseau (0.0.0.0)
CMD ["manage.py", "runserver", "0.0.0.0:8000"]