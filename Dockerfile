FROM node:alpine

WORKDIR /app
COPY package.json .

RUN npm install

COPY . .
RUN mkdir logs
RUN mkdir -p public/uploads/category && mkdir -p public/uploads/files && mkdir -p public/uploads/profile && mkdir -p public/uploads/sounds && mkdir -p public/uploads/system

COPY patch /app

EXPOSE 4567
CMD node nodebb build && node app.js