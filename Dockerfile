# Build Stage
FROM node:18-alpine AS build

WORKDIR /app
COPY package.json . 
RUN npm install
COPY . . 
RUN npm run build

# Production Stage
FROM nginx:1.23-alpine

WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/build .
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
