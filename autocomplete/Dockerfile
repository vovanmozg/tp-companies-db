FROM bitnami/express:4.16.3-debian-9-r48

ENV DISABLE_WELCOME_MESSAGE=1

ENV NODE_ENV=production \
    PORT=3000

# Skip fetching dependencies and database migrations for production image
ENV SKIP_DB_WAIT=0 \
    SKIP_DB_MIGRATION=1 \
    SKIP_NPM_INSTALL=1 \
    SKIP_BOWER_INSTALL=1

USER root
COPY . /app
WORKDIR /app

EXPOSE 3000

CMD ["./start.sh"]

