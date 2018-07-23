FROM node:alpine

WORKDIR /app
COPY package.json .

RUN npm install --only=production

COPY . .

EXPOSE 4567
CMD [ "node", "app.js" ]