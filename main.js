import { texts } from './const.js';
import { writeFile } from 'fs/promises';

function parseSong(text) {
  const lines = text.split('\n');

  let currentSong = {
    number: '',
    lyrics: '',
  };

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    const regExp = /^No\. (\d+)$/;
    const match = regExp.exec(line);

    if (match) {
      currentSong.number = `No. ${match[1]}`;
    } else if (currentSong.number) {
      if (currentSong.lyrics) {
        currentSong.lyrics += '\n' + line;
      } else {
        currentSong.lyrics = line;
      }
    }

    // Check if it's the last line and process it accordingly
    if (i === lines.length - 1 && !match) {
      if (currentSong.lyrics) {
        currentSong.lyrics += '\n' + line;
      } else {
        currentSong.lyrics = line;
      }
    }
  }

  return currentSong;
}


const songs = [];

for (const text of texts) {
  const song = parseSong(text);
  songs.push(song);
}

const json = JSON.stringify(songs, null, 2);

// Write the JSON data to the file
const path = './songs.json';

writeFile(path, json)
  .then(() => {
    console.log('Data successfully saved to songs.json');
  })
  .catch((error) => {
    console.log('An error has occurred', error);
  });
