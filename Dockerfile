FROM node:22-alpine

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --ignore-scripts

COPY src/ ./src/
COPY tsconfig.json ./
RUN npx tsc && npm prune --omit=dev

# P8 key is mounted as a file via Cloud Run secret
ENV APP_STORE_P8_PATH=/secrets/p8key

CMD ["node", "/app/dist/index.js"]
