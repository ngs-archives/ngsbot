# Description:
#   Notifies someone comes in my garage
#
# Confuguration:
#   HUBOT_CHIME_#{ROOM_NAME}_TOKEN

module.exports = (robot) ->
  robot.router.post "/chime/:room", (req, res) ->
    { room } = req.params
    token = req.headers['x-hubot-chime-token']
    envName = "HUBOT_CHIME_#{room.toUpperCase()}_TOKEN"
    envToken = process.env[envName]
    err = null
    unless envToken?
      err = "#{envName} is not set"
    else if envToken isnt token
      err = "Invalid token"
    if err?
      res.status(403).send err
      return
    envelope = room: "#{room}@conference.conference.littleapps.xmpp.slack.com"
    robot.send envelope, '何者かが侵入してきました。' + new Date()
    res.end 'OK'

