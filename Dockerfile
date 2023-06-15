# Utilisez l'image Python 3.9 officielle comme image de base
FROM python:3.9

# Définit le répertoire de travail dans le conteneur
WORKDIR /app

# Copie les fichiers requirements.txt dans le conteneur
COPY requirements.txt .

# Installe les dépendances Python
RUN pip install -r requirements.txt
RUN python manage.py makemigrations board

# Copie le code source de l'application dans le conteneur
COPY . .

# Exécute les migrations de la base de données après un délai d'attente de 10 secondes
CMD bash -c "sleep 10 && python manage.py runserver 0.0.0.0:80"
