# Stage 1: Budowanie aplikacji React
FROM scratch AS build1

# Dodanie systemu plików Alpine
ADD alpine-minirootfs-3.19.1-x86_64.tar /

# Aktualizacja i instalacja pakietów
RUN apk update --no-cache && \
    apk upgrade --no-cache && \
    apk add --no-cache nodejs npm openssh-client git

RUN mkdir -p /pawcho6

# Dodanie klucza prywatnego SSH jako secret
RUN --mount=type=secret,id=ssh_key \
    mkdir -p ~/.ssh && \
    cp /run/secrets/ssh_key ~/.ssh/id_rsa && \
    chmod 600 ~/.ssh/id_rsa && \
    ssh-keyscan github.com >> ~/.ssh/known_hosts

# Pobranie repozytorium GitHub po dodaniu klucza SSH
RUN git clone git@github.com:Valentine0604/pawcho6.git pawcho6

# Tworzenie aplikacji React
RUN npx create-react-app super_react

RUN mv /pawcho6/App.js /super_react/src/App.js

# Ustawienie katalogu roboczego
WORKDIR /super_react

# Instalacja zależności i budowa aplikacji
RUN npm install && \
    npm run build

# Stage 2: Tworzenie obrazu NGINX
FROM nginx:latest
ENV REACT_APP_VERSION=production.v1.0

# Kopiowanie plików z aplikacji React do katalogu html NGINX
COPY --from=build1 /super_react/build/. /var/www/html
COPY --from=build1 /pawcho6/default.conf /etc/nginx/conf.d/default.conf

LABEL org.opencontainers.image.authors="pawcho6@lab6.org"
LABEL org.opencontainers.image.version="$VERSION"

# Eksponowanie portu 80
EXPOSE 80

# Konfiguracja Healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:80/healthcheck || exit 1

# Uruchomienie serwera NGINX
CMD ["nginx", "-g", "daemon off;"]
