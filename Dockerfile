FROM node:lts-alpine as front
WORKDIR /app
COPY ./package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=front /app/build /usr/share/nginx/html
COPY --from=front /app/nginx.conf /etc/nginx/conf.d/default.conf
CMD ["nginx",  "-g", "daemon off;"]