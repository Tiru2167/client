FROM node:20-alpine AS build

WORKDIR /app
COPY package.json . 
RUN npm install --legacy-peer-deps  # Use legacy peer deps to bypass the conflict
COPY . . 
RUN npm run build

FROM nginx:1.23-alpine

WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/build .
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
