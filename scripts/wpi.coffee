module.exports = (robot) ->
  robot.router.get "/wpi/water/:second", (req, res) ->
    { second } = req.params
    { username } = req.query
    envelope = room: '#watering'
    robot.send envelope, "wpi yo sent from #{username}."
    robot.send envelope, "wpi water for #{second}s"
    res.end 'OK'

