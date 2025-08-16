# Dockerfile for Next.js + Firebase Portfolio
# Use official Node.js image as base
FROM node:20-alpine as base

WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm ci

# Copy the rest of the app
COPY . .

# Build the Next.js app
RUN npm run build

# Production image
FROM node:20-alpine as prod
WORKDIR /app

ENV NODE_ENV=production

COPY --from=base /app .

EXPOSE 3000

CMD ["npm", "start"]
