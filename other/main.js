/* eslint-disable */
const { readFile, writeFile } = require('fs').promises;
const axios = require('axios').default;
const { Client } = require('fnbr');

console.clear();
const selectedAuth = require("./selectedAccount.json");
//const selectedAuth = JSON.parse(readFile('./selectedAccount.json'));
console.log("[Info] Selected " + selectedAuth.selectedAccount);

const selectedAccount = "../auths/" + selectedAuth.selectedAccount;




//Client login
(async () => {
  let auth1;
  try {
    auth1 = { deviceAuth: JSON.parse(await readFile(selectedAccount)), killOtherTokens: false };
  } catch (e) {
    auth1 = { authorizationCode: async () => Client.consoleQuestion('[Info] Make an Auth before using this!'), killOtherTokens: false };
  }

const client1 = new Client({
  //"defaultStatus": 'Peter is short',
  "auth": auth1,
  "createParty": false,
  'killOtherTokens': false
});

//
  client1.on('deviceauth:created', (da) => writeFile('./auths/deviceAuth.json', JSON.stringify(da, null, 2)));


ipcMain.on('setPinkghoul', () => {
  client1.party.me.setOutfit('CID_029_Athena_Commando_F_Halloween', [{ channel: 'Material', variant: 'Mat3' }]); //Pink ghoul
})

ipcMain.on('setPurpleskull', () => {
  client1.party.me.setOutfit('CID_030_Athena_Commando_M_Halloween', [{ channel: 'ClothingColor', variant: 'Mat1' }]); //purple skull
  //client1.party.me.setBanner('OT9Banner', 'DefaultColor22');
})

ipcMain.on('setPurpleskull', () => {
  client1.party.me.setOutfit('CID_030_Athena_Commando_M_Halloween', [{ channel: 'ClothingColor', variant: 'Mat1' }]); //purple skull
  //client1.party.me.setBanner('OT9Banner', 'DefaultColor22');
}) 

ipcMain.on('setGalaxy', () => {
  client1.party.me.setOutfit('CID_VIP_Athena_Commando_M_GalileoGondola_SG'); //Indgo Kuno
})

ipcMain.on('setBomber', () => {
  client1.party.me.setOutfit('CID_619_Athena_Commando_F_TechLlama'); //Brillant bomber
})

ipcMain.on('Floss', () => {
  client1.party.me.setEmote('EID_Floss'); //makes emote stop
});

ipcMain.on('setGalaxyBackpack', () => {
  client1.party.me.setBackpack('BID_138_Celestial');
});

ipcMain.on('setPurplePortal', () => {
  //client1.party.me.setBackpack('BID_105_GhostPortal', [{ channel: 'Particle', variant: 'Mat1'}]);
  client1.party.me.setBackpack('BID_105_GhostPortal');
  console.log(client1.party.me.backpack)
});



ipcMain.on('setFNCS', () => {
  client1.party.me.setPickaxe('Pickaxe_ID_804_FNCSS20Male');
  client1.party.me.setEmote('EID_IceKing');
});

ipcMain.on('setRaiders', () => {
  client1.party.me.setPickaxe('Pickaxe_Lockjaw');
  client1.party.me.setEmote('EID_IceKing');
});

ipcMain.on('setCrowns', () => {
  client1.party.me.setCosmeticStats(41, 71) // # of crowns
  client1.party.me.setEmote('EID_Coronet') // show crown wins emote //Negitive or invalid values make everyones levels disappear while the ghost equip is active. Any level set here applies to everyone in the party
});

ipcMain.on('stopEmote', () => {
  client1.party.me.setEmote('EID_Balls') //makes emote stop
});

ipcMain.on('setBanner', () => { 
  client1.party.me.setBanner('OT9Banner', 'DefaultColor22');
});

ipcMain.on('setRene', () => { 
  client1.party.me.setOutfit('CID_028_Athena_Commando_F', [{ channel: 'Material', variant: 'Mat2' }]);
});

//client1.on('party:member:emote:updated', (value) => {console.log(value)});



  


//Login to client
  await client1.login();
  //client1.setStatus('Peter is short', 'online')
  console.log(`[Info] Logged in as ${client1.user.displayName} successfully!`);
  //console.log(`[Info] If you have inquires DM @drizz1le on discord!`);
})();

const { ipcMain, app, BrowserWindow } = require('electron')

app.whenReady().then(() => {
  const win = new BrowserWindow({
    width: 550,
    height: 420,
    icon: __dirname + '/images/icon.jpg',
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false,
  }
  });
  win.setMenuBarVisibility(false)

    win.loadFile('index.html');
    }
  )
