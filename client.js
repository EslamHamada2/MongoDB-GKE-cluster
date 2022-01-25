const net = require('net');
const JsonSocket = require('json-socket');
const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");
 
const port = 8282;
const socket = new JsonSocket(new net.Socket());

const {
    MONGO_INITDB_ROOT_USERNAME,
    MONGO_INITDB_ROOT_PASSWORD,
    MONGO_HOSTNAME,
    MONGO_PORT,
    MONGO_DB,
    MONGO_REPLICASET
  } = process.env;

const url = `mongodb://${MONGO_INITDB_ROOT_USERNAME}:${MONGO_INITDB_ROOT_PASSWORD}@${MONGO_HOSTNAME}:${MONGO_PORT}/${MONGO_DB}?replicaSet=${MONGO_REPLICASET}&authSource=admin`;
mongoose.connect(url,
  {
    useNewUrlParser: true,
    useFindAndModify: false,
    useUnifiedTopology: true,
    useCreateIndex: true
  }
).then(()=> console.log('connected'))
.catch((error) => console.error(error));

socket.connect(port);
socket.on('connect', () => {
    socket.on('message', (data) => {
        console.log(data);
    });
});