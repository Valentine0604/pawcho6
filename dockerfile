FROM scratch as build1

ADD alpine-minirootfs-3.19.1-x86_64.tar /

RUN apk update --no-cache && \
    apk upgrade --no-cache && \
    apk add --no-cache nodejs npm openssh-client git

COPY id_ed25519.pub /root/.ssh/id_ed25519.pub

RUN chmod 600 /root/.ssh/id_ed25519.pub
    
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN npx create-react-app super_react

WORKDIR /super_react

RUN mkdir -p /pawcho6

RUN git clone git@github.com:Valentine0604/pawcho6.git /pawcho6 && \
    mv /pawcho6/App.js /super_react/src/App.js

WORKDIR /super_react

ARG VERSION
ENV REACT_APP_VERSION=${VERSION}

RUN npm install && \
    npm run build

FROM nginx:latest

ARG VERSION
ENV REACT_APP_VERSION=${VERSION}
RUN echo $REACT_APP_VERSION

LABEL org.opencontainers.image.authors="pawcho6@docker.org"
LABEL org.opencontainers.image.version="$VERSION"

COPY --from=build1 /super_react/build/. /var/www/html
COPY --from=build1 /pawcho6/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:80/healthcheck || exit 1

CMD ["nginx", "-g", "daemon off;"]
