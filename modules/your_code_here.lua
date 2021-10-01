local I = require('insight')
local post_to_slack = require('post_to_slack')

I.meta({
  name = 'Slack Integrations',
  description = 'Actions and and some Transforms',
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
      -- primitive type json, data_type status
      data_type = 'JSON', -- Inlet for Action is always JSON
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
      name = "Channel",
      description = "Channel (#delivery-team, @someuser, etc)",
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
      name = "Icon",
      description = "The slack icon to use",
      type = I.constant_types.STRING,
      default = ":cool_doge:"
    },
    {
      name = "Level",
      description = "Select active levels",
      type = I.constant_types.STRING,
      enum = {0, 1, 2, 3, 4},
      enum_presented = {"Normal", "Info", "Warning", "Critical", "Error"},
      multiple = true
    }
  },
  fn = function(value, constants)
    post_to_slack.fn(constants["Webhook URL"], constants["Channel"], constants["Pretext"], constants["Title"], value["level"], value["value"], constants["Icon"])
    return 1
  end
})
