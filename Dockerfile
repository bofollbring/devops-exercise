FROM node:13.3.0

RUN npm install -g yarn

RUN yarn install

RUN yarn start
