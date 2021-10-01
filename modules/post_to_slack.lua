-- local Post_To_Slack = {}

local Post_to_slack = {}

function Post_to_slack.fn(slackURL, channel, pretext, title, level, value, icon)
  -- Interpret the color and wording from the level
  local calculatedColor = "good"
  local interpretedLevel = "OK"
  if (level == 0)
  then
    calculatedColor = "good"
    interpretedLevel = "OK"
  elseif (level == 1)
  then
    calculatedColor = "#0000FF"
    interpretedLevel = "Info"
  elseif (level == 2)
  then
    calculatedColor = "warning"
    interpretedLevel = "Warning"
  elseif (level == 3)
  then
    calculatedColor = "danger"
    interpretedLevel = "Critical"
  elseif (level == 4)
  then
    calculatedColor = "#A020F0"
    interpretedLevel = "Error"
  end
  
  print("posting to slack...")
  local body = '{channel: "' .. channel .. '", username: "ExoSense Slack Action", icon_emoji: "' ..icon.. '", attachments: [{fallback: "ExoSense Slack Action", pretext: "' .. pretext .. '", color: "' ..calculatedColor.. '", fields: [{title: "' ..title.. '", value: "Level: ' ..interpretedLevel..', Value: ' ..value.. '", short: false}]}]}'
  -- response, err = Http.post({url="https://hooks.slack.com/services/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", body=body})
  response, err = Http.post({url=slackURL, body=body})
  print(response)
  if err then error(err) end
end

return Post_to_slack
