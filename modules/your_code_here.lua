local I = require('insight')
local helpers = require('helpers')

local function post_to_slack (slackURL, pretext, title, message, color)
  local body = '{attachments: [{fallback: "ExoSense Slack Action", pretext: "' .. pretext .. '", color: "' ..color.. '", fields: [{title: "' ..title.. '", value: "' ..message..'", short: false}]}]}'
  response, err = Http.post({url=slackURL, body=body})
  if err then error(err) end
end

I.meta({
  name = 'Slack Integrations',
  description = 'Actions for the Slack API',
  author = "Patrick Levy",
  author_contact = "your@email.address.here",
})

I.add('posttoslack', {
  name = "Post to Slack",
  type = "action",
  description = "Post a message to slack",
  inlets = {
    {
      name = 'Rule State',
      primitive_type = 'JSON',
      data_type = 'STATUS',
    }
  },
  constants = {
    {
      name = "Webhook URL",
      description = "The complete slack webhook URL",
      type = I.constant_types.STRING,
      default = ""
    },
    {
      name = "Pretext",
      description = "The pretext of your message",
      type = I.constant_types.STRING,
      default = ""
    },
    {
      name = "Title",
      description = "The Title of your message",
      type = I.constant_types.STRING,
      default = ""
    },
    {
      name = "Level",
      description = "Active rule levels",
      type = I.constant_types.NUMBER,
      enum = {0, 1, 2, 3, 4},
      enum_presented = {"Normal", "Info", "Warning", "Critical", "Error"},
      multiple = true
    }
  },
  fn = function(value, constants)
    local subscribedLevels = constants["Level"]
    local currentEventLevel = value["level"]
    
    -- Only post to slack if the rule level has been selected
    if helpers.has_value(subscribedLevels, currentEventLevel) then
      print('Posting to slack...')
      local datapoint = value["value"]
      local category = value["category"]
      local color = helpers.get_color_from_level(value["level"], category)
      local severity = helpers.get_severity_from_level(value["level"], category)
      local message = "Level: " ..severity.. ", Value: " ..datapoint

      post_to_slack(
        constants["Webhook URL"],
        constants["Pretext"],
        constants["Title"],
        message,
        color
      )
    else
      print('Rule event occurred but the level is not subscribed to.')
    end

    return 1
  end
})
