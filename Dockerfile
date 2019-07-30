FROM node:10 as buildmachine
WORKDIR /usr/src/app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
RUN npm test

FROM nginx:1.16-alpine
COPY --from=buildmachine /usr/src/app/public/ /usr/share/nginx/html
CMD [ "ls" ]