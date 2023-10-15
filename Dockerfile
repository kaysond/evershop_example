FROM node:20.7.0-alpine3.17

WORKDIR /opt/evershop
# This depends on .dockerignore being set up correctly
COPY . .

ENV npm_config_cache=.npm
RUN npm ci
RUN npm run build
RUN mkdir .log

# Add curl for the healthcheck
RUN apk add --no-cache curl
HEALTHCHECK --interval=30s --timeout=6s --start-period=60s --retries=3 CMD curl -sSf -m 5 localhost:3000

EXPOSE 3000

VOLUME ["/opt/evershop/config", "/opt/evershop/media", "/opt/evershop/.log"]

ENTRYPOINT ["npm"]
CMD ["run", "start"]