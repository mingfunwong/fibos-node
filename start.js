// 服务器 全节点

var fibos = require('fibos');
var fs = require("fs");
var http = require('http');
var p2p = require("./p2p.json");
var conf = require("./_config");

var httpClient = new http.Client();

var config = {
  "producer-name":conf["producer-name"],
  "public-key": conf["producer-pubKey"],
  "private-key": conf["producer-priKey"],
  "producer-enable": conf["producer-enable"],
};

fibos.config_dir = './data';
fibos.data_dir = './data'

var chain = {
  'chain-state-db-size-mb': 8192,
};

var snapshots = fs.exists("./data/snapshots") ? fs.readdir("./data/snapshots") : []
var snapshot = '';
if (snapshots.length) {
  snapshot = snapshots[0]
  console.log("snapshot", snapshot)
  chain["snapshot"] = './data/snapshots/' + snapshot
  deleteFolderRecursive("./data/blocks")
  deleteFolderRecursive("./data/state")
} else {
  chain["genesis-json"] = "./genesis.json";
}

fibos.load("http", {
  "http-server-address": "0.0.0.0:8888",
  "access-control-allow-origin": "*",
  "access-control-allow-headers": "Content-Type",
  "http-validate-host": false,
  "verbose-http-errors": true,
});
fibos.load("ethash"); 

fibos.load("net", {
  "max-clients": 0,
  "p2p-max-nodes-per-host": 20,
  "p2p-listen-endpoint": "0.0.0.0:9876",
  "p2p-peer-address": p2p,
});

if (config["producer-enable"]) {
  fibos.load("producer", {
    'producer-name': config["producer-name"],
    'enable-stale-production': true,
    'private-key': JSON.stringify([config["public-key"], config["private-key"]])
  });
  fibos.load("bp_signature", {
    "signature-producer": config["producer-name"],
    "signature-private-key": config["private-key"]
   });
} else {
  fibos.load("producer");
  setInterval(function () {
    var create_snapshot = httpClient.get("http://localhost:8888/v1/producer/create_snapshot").json()
    console.log(create_snapshot)
    var snapshots = fs.readdir("./data/snapshots")
    for (var i = 0; i < snapshots.length; i++) {
      if (snapshots[i].indexOf(create_snapshot.head_block_id) === -1) {
        fs.unlink('./data/snapshots/' + snapshots[i])
      }
    }
  }, 1 * 60 * 60 * 1000) // ever 1 hour backup
}

fibos.load("producer_api");

fibos.load("chain", chain);
fibos.load("chain_api");

fibos.start();

function deleteFolderRecursive(path) {
  if (fs.existsSync(path)) {
    fs.readdirSync(path).forEach(function (file) {
      var curPath = path + "/" + file;
      if (fs.statSync(curPath).isDirectory()) {
        deleteFolderRecursive(curPath);
      } else {
        fs.unlinkSync(curPath);
      }
    });
    fs.rmdirSync(path);
  }
};
