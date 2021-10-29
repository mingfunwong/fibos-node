const fibos = require('fibos');
const p2p = require('./p2p.json');

const { PRODUCER_ENABLE, PRODUCER_NAME, PUBLIC_KEY, PRIVATE_KEY, PRODUCER_API_ENABLE, SNAPSHOT_FILE } = process.env;

const chain = {
  'chain-state-db-size-mb': 8192,
};
const http = {
  'http-server-address': '0.0.0.0:8888',
  'access-control-allow-origin': '*',
  'access-control-allow-headers': 'Content-Type',
  'http-validate-host': false,
  'verbose-http-errors': true,
};
const net = {
  'max-clients': 0,
  'p2p-max-nodes-per-host': 20,
  'p2p-listen-endpoint': '0.0.0.0:9977',
  'p2p-peer-address': p2p,
  'p2p-discoverable': true,
};

const producer = {
  'producer-name': PRODUCER_NAME,
  'enable-stale-production': true,
  'private-key': JSON.stringify([PUBLIC_KEY, PRIVATE_KEY]),
};

const bpSignature = {
  'signature-producer': PRODUCER_NAME,
  'signature-private-key': PRIVATE_KEY,
};

if (SNAPSHOT_FILE) {
  console.log('use snapshot', SNAPSHOT_FILE);
  chain['snapshot'] = SNAPSHOT_FILE;
} else {
  chain['genesis-json'] = './genesis.json';
}

fibos.config_dir = './data';
fibos.data_dir = './data';
fibos.load('http', http);
fibos.load('ethash');
fibos.load('net', net);
fibos.load('chain', chain);
fibos.load('chain_api');
if (PRODUCER_API_ENABLE === 'true') {
  fibos.load('producer_api');
}
if (PRODUCER_ENABLE === 'true') {
  fibos.load('producer', producer);
  fibos.load('bp_signature', bpSignature);
} else {
  fibos.load('producer');
}

fibos.start();
