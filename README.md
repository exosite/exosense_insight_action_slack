# ExoSense™ Insight Action Slack

## Overview
Actions are ExoSense insights that subscribe to rule events and do not produce an outlet signal. They can be built in almost the exact same way as external insight rules and transforms. They are intended to be used to perform work based on a particular rule status being triggered. For example, an action could post data to a spreadsheet, send a slack message, or send data to a custom api all based on a desired rule status being triggered.

See https://github.com/exosite/exosense_insight_example_murano_lua for more general information on exosense insights.

### Tutorial: Build an action to send Slack messages
**1. Create a murano application from this template**
  - This template already contains a functioning action for sending Slack messages
  - You can make changes to the code or add additional actions to the 'Module' -> 'your_code_here'

**2. Publish your murano application as an insight service so that you can connect it to ExoSense**
  - In Murano, go to IoT Marketplace and click on Publish on the left
  - Element Name: Recommend including 'Insight' in the name
  - Element Type: Service
  - Element Variation: ExoSense Insight
  - Configuration File (YAML): `https://<the domain of your application>/interface`

**3. Connect your new insight service to ExoSense**
  - Click on your ExoSense instance
  - From the "Manage Application" modal that pops up, select "Insight Services" on the left
  - Click "Add Insight Service"
  - Find the newly published service and click it
  - Click "Add to Solution"

**4. Create a Slack App that is connected to your organization's Slack Workspace**
  - Go to [api.slack.com](https://api.slack.com/)
  - Click "Create an app"
  - Add “Incoming Webhooks” feature
  - Copy the webhook
  - Note: Slack's updated API now requires that you set the username, emoji, and channel within the Slack App itself. You can no longer change these within each message being sent.
  
**5. In ExoSense, create an action definition**
  - Navigate to Configuration -> Actions
  - Add a new Action
  - Set the Webhook URL using the value copied from the Slack Incoming Webhook configuration