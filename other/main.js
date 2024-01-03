/* eslint-disable */
const { readFile, writeFile } = require('fs').promises;
const axios = require('axios').default;
const { Client } = require('fnbr');
const { ipcMain, app, BrowserWindow } = require('electron');


const express = require('express');
const expressApp = express();
const http = require('http').Server(expressApp);

const serverPort = 3000; // Choose a port for your server

expressApp.use(express.static(__dirname));

http.listen(serverPort, () => {
    console.log(`Server is running on http://localhost:${serverPort}`);
});


console.clear();
const selectedAuth = require("./selectedAccount.json");
console.log("[Info] Selected " + selectedAuth.selectedAccount);

const selectedAccount = "../auths/" + selectedAuth.selectedAccount;

// Client login
(async () => {
  let auth1;
  try {
    auth1 = { deviceAuth: JSON.parse(await readFile(selectedAccount)), killOtherTokens: false };
  } catch (e) {
    auth1 = { authorizationCode: async () => Client.consoleQuestion('[Info] Make an Auth before using this!'), killOtherTokens: false };
  }

  const client1 = new Client({
    "auth": auth1,
    "createParty": false,
    'killOtherTokens': false
  });

  client1.on('deviceauth:created', (da) => writeFile('./auths/deviceAuth.json', JSON.stringify(da, null, 2)));

  // Add your existing event handlers here

  // Login to client


  app.whenReady().then(() => {
    const mainWindow = new BrowserWindow({
        width: 550,
        height: 420,
        icon: __dirname + '/images/icon.jpg',
        webPreferences: {
            nodeIntegration: true,
            contextIsolation: false,
        },
        show: false,
    });
    const serverPort = '1337';
    const serverIP = '10.0.0.17'; // This will make the server accessible on all network interfaces

    mainWindow.loadURL(`http://${serverIP}:${serverPort}/index.html`);

/*
  expressApp.use(express.static(__dirname));
  http.listen(3000, () => {
    console.log('Server is running on http://localhost:3000');
    mainWindow.loadURL('http://localhost:3000/index.html');
  });
*/

  expressApp.use((req, res, next) => {
    console.log(`Request for ${req.url}`);
    next();
  });
/*
  expressApp.post('/setPurpleskull', (req, res) => {
    client1.party.me.setOutfit('CID_030_Athena_Commando_M_Halloween', [{ channel: 'ClothingColor', variant: 'Mat1' }]); //purple skull
    console.log('Successfully set Purple Skull');
    res.send('OK');
  });
*/
  mainWindow.setMenuBarVisibility(false);
  });



//
  client1.on('deviceauth:created', (da) => writeFile('./auths/deviceAuth.json', JSON.stringify(da, null, 2)));


  expressApp.post('/setPinkghoul', (req, res) => {
    console.log('Received POST request for setPinkghoul');
    client1.party.me.setOutfit('CID_029_Athena_Commando_F_Halloween', [{ channel: 'Material', variant: 'Mat3' }]);
    res.send('OK');
  });
  
  expressApp.post('/setPurpleskull', (req, res) => {
    console.log('Received POST request for setPurpleskull');
    try {
      client1.party.me.setOutfit('CID_030_Athena_Commando_M_Halloween', [{ channel: 'ClothingColor', variant: 'Mat1' }]);
      console.log('Successfully set Purple Skull');
      res.send('OK');
    } catch (error) {
      console.error('Error setting Purple Skull:', error);
      res.status(500).send('Internal Server Error');
    }
  });
  
  expressApp.post('/setGalaxy', (req, res) => {
    console.log('Received POST request for setGalaxy');
    client1.party.me.setOutfit('CID_VIP_Athena_Commando_M_GalileoGondola_SG');
    res.send('OK');
  });
  
  expressApp.post('/setBomber', (req, res) => {
    console.log('Received POST request for setBomber');
    client1.party.me.setOutfit('CID_619_Athena_Commando_F_TechLlama');
    res.send('OK');
  });
  
  expressApp.post('/Floss', (req, res) => {
    console.log('Received POST request for Floss');
    client1.party.me.setEmote('EID_Floss');
    res.send('OK');
  });
  
  expressApp.post('/setGalaxyBackpack', (req, res) => {
    console.log('Received POST request for setGalaxyBackpack');
    client1.party.me.setBackpack('BID_138_Celestial');
    res.send('OK');
  });
  
  expressApp.post('/setPurplePortal', (req, res) => {
    console.log('Received POST request for setPurplePortal');
    client1.party.me.setBackpack('BID_105_GhostPortal');
    res.send('OK');
  });
  
  expressApp.post('/setFNCS', (req, res) => {
    console.log('Received POST request for setFNCS');
    client1.party.me.setPickaxe('Pickaxe_ID_804_FNCSS20Male');
    client1.party.me.setEmote('EID_IceKing');
    res.send('OK');
  });
  
  expressApp.post('/setRaiders', (req, res) => {
    console.log('Received POST request for setRaiders');
    client1.party.me.setPickaxe('Pickaxe_Lockjaw');
    client1.party.me.setEmote('EID_IceKing');
    res.send('OK');
  });
  
  expressApp.post('/setCrowns', (req, res) => {
    console.log('Received POST request for setCrowns');
    client1.party.me.setCosmeticStats(41, 71);
    client1.party.me.setEmote('EID_Coronet');
    res.send('OK');
  });
  
  expressApp.post('/stopEmote', (req, res) => {
    console.log('Received POST request for stopEmote');
    client1.party.me.setEmote('EID_Balls');
    res.send('OK');
  });
  
  expressApp.post('/setBanner', (req, res) => {
    console.log('Received POST request for setBanner');
    client1.party.me.setBanner('OT9Banner', 'DefaultColor22');
    res.send('OK');
  });
  
  expressApp.post('/setRene', (req, res) => {
    console.log('Received POST request for setRene');
    client1.party.me.setOutfit('CID_028_Athena_Commando_F', [{ channel: 'Material', variant: 'Mat2' }]);
    res.send('OK');
  });
  

//client1.on('party:member:emote:updated', (value) => {console.log(value)});

  await client1.login();
  console.log(`[Info] Logged in as ${client1.user.displayName} successfully!`);
})();