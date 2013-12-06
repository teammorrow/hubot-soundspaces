# Description:
#   A Hubot plugin to play sounds on http://soundspac.es.
#
# Dependencies:
#   "validator": "~2.0.0"
#
# Configuration:
#   HUBOT_SOUNDSPACES_ROOM_KEY - This is your unique http://soundspac.es room key.
#   HUBOT_SOUNDSPACES_SOUND_URL - Where your sounds are hosted. (eg. http://my.websi.te/sounds/)
#
# Commands:
#   /soundspaces - Displays the soundspac.es room you have configured.
#   /sound soundName
#   /sound http://www.dropbox.com/s/2xqd5yw3hffko5m/hom.mp3
#   /sound https://www.dropbox.com/s/2xqd5yw3hffko5m/hom.mp3
#
# Author:
#   jonursenbach

url = require 'url'
path = require 'path'
check = require('validator').check

process.env.HUBOT_SOUNDSPACES_ROOM_KEY = 'teambeep'
process.env.HUBOT_SOUNDSPACES_SOUND_URL = 'http://soundspac.es/sounds/'
#process.env.HUBOT_SOUNDSPACES_SOUND_URL = 'http://soundspac.es/sounds'

###
/sound http://www.dropbox.com/s/2xqd5yw3hffko5m/hom.mp3
/sound https://www.dropbox.com/s/2xqd5yw3hffko5m/hom.mp3
/sound ftp://www.dropbox.com/s/2xqd5yw3hffko5m/hom.mp3
###

module.exports = (robot) ->
  robot.hear /\/soundspaces/i, (msg) ->
    if (!process.env.HUBOT_SOUNDSPACES_ROOM_KEY || process.env.HUBOT_SOUNDSPACES_ROOM_KEY == '')
      msg.send 'It doesn\'t appear that you\'ve set up a soundspac.es room yet. What are you waiting for?'
    else
      msg.send 'Listen to sounds here: http://soundspa.ces/' + process.env.HUBOT_SOUNDSPACES_ROOM_KEY

  robot.hear /\/sound (.*)/i, (msg) ->
    sound = msg.match[1].trim()
    play_sound = false

    try
      parsed_url = url.parse(sound)
      protocol = parsed_url.protocol

      # Soundspaces supports sending sound URLs that don't exist on the
      # configured base URL, but we need to make sure it's an MP3 first before
      # passing it off.
      if (protocol != null)
        ext = getSoundExtension(sound)
        if !ext
          msg.send 'I don\'t understand the name of that sound.'
          return
        else if ext != 'mp3'
          msg.send 'I can only play MP3s.'
          return
        else if (protocol.indexOf('http') == -1)
          msg.send 'I only support sounds from HTTP(s) endpoints. Sorry!'
          return
      else
        # Check if the sound we want to play is either a poorly-formed URL (like
        # it's missing a protocol), or they're trying to send something like
        # "huuu.mp3".
        if getSoundExtension(sound)
          try
            if (check(sound).isUrl())
              msg.send 'I don\'t understand the name of that sound.'
              return
          catch error
            msg.send 'I don\'t understand the name of that sound.'
            return

          msg.send 'Don\'t specify a file extension in the sound name.'
          return

      # Lets play it!
      msg.send 'im going to play: ' + sound
    catch error
      console.log error

    return

getSoundExtension = (sound) ->
  ext = path.extname(sound).split('.')
  return ext[ext.length - 1]
