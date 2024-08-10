# Étape 1 : Construction de l'application
FROM node:18 AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier package.json et package-lock.json
COPY package.json package-lock.json ./

# Installer les dépendances en utilisant package-lock.json
RUN npm ci

# Copier le reste du code de l'application
COPY . .

# Construire l'application React
RUN npm run build

# Étape 2 : Préparer le serveur NGINX pour servir l'application
FROM nginx:alpine

# Copier les fichiers de build dans le répertoire approprié de NGINX
COPY --from=build /app/build /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Démarrer NGINX
CMD ["nginx", "-g", "daemon off;"]
