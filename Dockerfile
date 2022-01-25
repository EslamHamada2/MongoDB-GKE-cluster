FROM node:latest
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
RUN npm install -g npm@8.3.2
COPY package.json /usr/src/app
RUN npm install
COPY . /usr/src/app
EXPOSE 8282
ENTRYPOINT ["node","server.js","client.js"]
#CMD ["node","client.js"]
