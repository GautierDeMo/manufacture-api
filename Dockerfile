FROM node:24.20.0-alpine3.24@sha256:e67514e5d0f6c46656005e1b693b2ec9d52e80b641307de684d4a015ba7a4eaf AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev

# Not mandatory because the CI pipeline/workflow runs tests already, but it's possible
# FROM node:24.19.0-alpine3.24@sha256:d32cdf619f63fe0471182d08996dd516c6275bb5fd31ae06e55a570bd9e1ad43 AS test
# WORKDIR /app
# COPY package*.json ./
# RUN npm ci
# COPY . .
# RUN npm run test

FROM node:24.20.0-alpine3.24@sha256:e67514e5d0f6c46656005e1b693b2ec9d52e80b641307de684d4a015ba7a4eaf AS runtime
WORKDIR /app
ENV NODE_ENV=production
ENV PORT=3000
RUN rm -rf /usr/local/lib/node_modules/npm /usr/local/lib/node_modules/corepack /opt/yarn* /usr/local/bin/npm /usr/local/bin/npx /usr/local/bin/corepack /usr/local/bin/yarn /usr/local/bin/yarnpkg
COPY --from=deps --chown=node:node /app/node_modules ./node_modules
COPY --chown=node:node . .
RUN chown node:node /app
USER node
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --start-interval=1s --retries=3 CMD wget -q -O /dev/null http://127.0.0.1:$PORT/health || exit 1
EXPOSE ${PORT}
ENTRYPOINT ["node", "src/index.js"]
LABEL org.opencontainers.image.source=https://github.com/GautierDeMo/manufacture-api
