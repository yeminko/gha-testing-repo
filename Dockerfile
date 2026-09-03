# Named this stage as "build"
FROM node:24-alpine AS build 

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

COPY . .

RUN npm run build

FROM nginx:alpine

# Copy the output from previous stage to the nginx html folder
COPY --from=build /app/dist /usr/share/nginx/html