FROM node:alpine

WORKDIR /app
COPY package.json .

RUN npm install

COPY . .
RUN mkdir logs
RUN node nodebb build

EXPOSE 4567
CMD [ "node", "app.js" ]