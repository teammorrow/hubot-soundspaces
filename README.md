**soundspac.es is not online yet, so this plugin isn't functional.**

## hubot-soundspaces

A [Hubot](https://github.com/github/hubot) plugin to play sounds on <http://soundspac.es>.

### Configuration

Set these variables into your environment so Hubot can pick them up.

* ```HUBOT_SOUNDSPACES_ROOM_KEY```: This is your unique http://soundspac.es room key.
* ```HUBOT_SOUNDSPACES_SOUND_URL```: Where your sounds are hosted. (eg. http://my.websi.te/sounds/)

### Usage

    /sound soundName
    /sound http://www.dropbox.com/s/2xqd5yw3hffko5m/hom.mp3
    /sound https://www.dropbox.com/s/2xqd5yw3hffko5m/hom.mp3

There's also ```/soundspaces``` for displaying the <http://soundspac.es> room you have configured.

### Installation
1. Edit `package.json` and add `hubot-soundspaces` as a dependency.
- Add `"hubot-soundspaces"` to your `external-scripts.json` file.
- `npm install`
- Reboot Hubot.
- Play sounds.
