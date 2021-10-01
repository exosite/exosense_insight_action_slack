local I = require('insight')
local post_to_slack = require('post_to_slack')

I.meta({
  name = 'Levy Actions',
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
  },
  fn = function(value, constants)
    post_to_slack.fn(constants["Webhook URL"], constants["Channel"], constants["Pretext"], constants["Title"], value["level"], value["value"], constants["Icon"])
    return 1
  end
})

-- I.add('webhooks', {
--   name = "Custom HTTP Request Webhook",
--   type = "action",
--   description = "Perform an HTTP action from the output of a rule",
--   inlets = {
--     {
--       name = 'Rule State',
--       data_type = 'JSON', -- Inlet for Action is always JSON
--     }
--   },
--   constants = {
--     {
--       name = "HTTP Method",
--       description = "The action to perform",
--       enum = {"GET", "POST", "PUT", "DELETE"},
--       enum_presented = {"GET", "POST", "PUT", "DELETE"},
--       type = I.constant_types.STRING,
--     },
--     {
--       name = "Base URL",
--       description = "The base domain of your endpoint",
--       type = I.constant_types.STRING,
--       default = ""
--     },
--     {
--       name = "Endpoint",
--       description = "The path of your http endpoint",
--       type = I.constant_types.STRING,
--       default = ""
--     },
--     {
--       name = "Body",
--       description = "JSON body",
--       type = I.constant_types.STRING,
--       default = "{}"
--     },
--     {
--       name = "Header Key",
--       description = "Header Key",
--       default = "",
--       type = I.constant_types.STRING,
--       multiple = true
--     },
--     {
--       name = "Header Value",
--       description = "Header Value",
--       default = "",
--       type = I.constant_types.STRING,
--       multiple = true
--     }
--   },
--   fn = function(value, constants)
--     -- local method = constants["HTTP Method"]
--     local baseURL = constants["Base URL"]
--     local endpoint = constants["Endpoint"]
--     local body = constants["Body"]
    
--     local url = "" .. baseURL .. "" ..endpoint.. ""
  
--     print("about to post to webook")
--     response, err = Http.post({url=url, body=body})
--     if err then error(err) end
--     print(response)
--   end
-- })

-- I.add('adder', {
--   name = "The Adder",
--   description = "Adds a value to the signal",
--   constants = {
--     {
--       name = "value",
--       description = "A number",
--       type = I.constant_types.NUMBER,
--     },
--   },
--   inlets = {
--     {
--       name = 'Signal',
--       description = 'The signal to add value to',
--       tag = 'A',
--       primitive_type = I.primitives.NUMERIC,
--       data_type = {'NUMBER', 'TEMPERATURE'},
--     }
--   },
--   outlets = {
--     {
--       name = 'Increased',
--       description = 'The value added result',
--       primitive_type = I.primitives.NUMERIC,
--     },
--     {
--       name = 'Original',
--       description = 'The original value',
--       primitive_type = I.primitives.NUMERIC,
--     }
--   },
--   fn = function(value, constants)
--     return value + constants.value, value
--   end
-- })

-- I.add('lowercase', {
--   name = "Lowercase",
--   description = "Lower case strings",
--   constants = {
--     {
--       name = "Method",
--       description = "HTTP Method",
--       type = I.constant_types.STRING,
--       multiple = true
--     },
--   },
--   inlets = {
--     {
--       name = 'Signal',
--       description = 'A string to change the case of',
--       primitive_type = I.primitives.STRING,
--     },
--   },
--   outlets = {
--     {
--       name = 'lo',
--       description = 'Lower cased string',
--       primitive_type = I.primitives.STRING,
--     },
--   },
--   fn = function(value, constants)
--     value = tostring(value)
--     if constants.onlyFirst then
--       return string.lower(string.sub(value, 1, 1)) .. string.sub(value, 2)
--     else
--       return string.lower(value)
--     end
--   end
-- })

-- I.add('bungle', {
--   name = "Average-ish",
--   description = "Not average, eventhough at first glance it looks like it",
--   constants = { },
--   inlets = {
--     {
--       name = 'Signal',
--       description = 'The values to do maths on',
--       primitive_type = I.primitives.NUMERIC,
--     }
--   },
--   outlets = {
--     {
--       name = 'Resulting',
--       description = 'The resulting value of our misunderstood computation',
--       primitive_type = I.primitives.NUMERIC,
--     }
--   },
--   fn = function(value, _, prior)
--     if prior.A then
--       return (value + prior.A) / 2
--     else
--       return value / 3
--     end
--   end
-- })

-- I.add_group('priadder', 'BR-009', {
--   name = "The Private Adder",
--   description = "Adds a value to the signal",
--   constants = {
--     {
--       name = "value",
--       description = "A number",
--       type = I.constant_types.NUMBER,
--     },
--   },
--   inlets = {
--     {
--       name = 'Signal',
--       description = 'The signal to add value to',
--       tag = 'A',
--       primitive_type = I.primitives.NUMERIC,
--       data_type = {'NUMBER', 'TEMPERATURE'},
--     }
--   },
--   outlets = {
--       {
--       name = 'Increased',
--       description = 'The value added result',
--       primitive_type = I.primitives.NUMERIC,
--     }
--   },
--   fn = function(value, constants)
--     return value + constants.value
--   end
-- })
