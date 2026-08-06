FROM node:20.20.2-alpine3.23
WORKDIR /app
COPY package*.json ./
RUN npm ci
ENV NODE_ENV=production
ENV PORT=3000
COPY --chown=node:node . .
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --start-interval=1s --retries=3 CMD wget -q -O /dev/null http://127.0.0.1:$PORT/health || exit 1
EXPOSE ${PORT}
RUN chown node:node /app
USER node
ENTRYPOINT ["node", "src/index.js"]
