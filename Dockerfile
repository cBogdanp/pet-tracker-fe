# BUILD
FROM node:20 as build

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build --prod

# SERVE NGINX
FROM nginx:alpine

COPY --from=build /app/dist/your-app-name /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf
