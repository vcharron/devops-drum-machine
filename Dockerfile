FROM node:10 as buildmachine
WORKDIR /usr/src/app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
RUN npm test

FROM nginx:1.16-alpine
WORKDIR /usr/share/nginx/www
COPY --from=buildmachine /usr/src/public/ .
