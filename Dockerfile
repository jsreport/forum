FROM node:alpine

WORKDIR /app
COPY package.json .

RUN npm install --only=production

COPY . .
RUN mkdir logs

EXPOSE 4567
CMD [ "node", "app.js" ]