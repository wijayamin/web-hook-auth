FROM node:10.16.0-alpine
EXPOSE 8083 9229

WORKDIR /usr/src/service
COPY package.json /usr/src/service
COPY package-lock.json /usr/src/service

ENV DATABASE_URL=postgres://postgres:@postgres:5432/postgres

RUN apk add --no-cache --virtual .build-deps make gcc g++ python \
 && npm install --production --silent \
 && apk del .build-deps

COPY . /usr/src/service

CMD npm run start