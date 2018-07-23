FROM node:alpine

WORKDIR /app
COPY package.json .

RUN npm install

COPY . .
RUN mkdir logs

EXPOSE 4567
CMD [ "node", "app.js" ]