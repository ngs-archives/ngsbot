# Description:
#   Notifies Travis CI builds

module.exports = (robot) ->
  robot.router.post "/travisci/hooks", (req, res) ->
    envelope = room: 'travisci@conference.conference.littleapps.xmpp.slack.com'
    { payload } = req.body
    { status_message, build_url, message, number, repository } = JSON.parse payload
    robot.send envelope, """
    Build##{ number } for #{ repository.owner_name }/#{ repository.name } #{ if status_message is 'Pending' then 'started.' else "finished. (#{status_message})" }
    > #{message}
    #{build_url}
    """
    res.end "OK"

