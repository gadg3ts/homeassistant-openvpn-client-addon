# OpenVPN Client Add-On

This is a Add-On for [Home Assistant](https://www.home-assistant.io) which enables to tunnel the communication of your Home Assistant server with the world through a VPN connection.

## Installation

Move your client.ovpn file to hassio/share folder in your server.

Just navigate to the Hass.io panel in your Home Assistant frontend and add the OpenVPN Client add-on repository:(https://github.com/gadg3ts/homeassistant-openvpn-client-addon)

Then, scroll down and locate the OpenVPN Client Hass.io Add-Ons section. Click on OpenVPN Client, then INSTALL and Start.

## Notes

This is forked from (https://github.com/HedgU4/homeassistant-openvpn-client-addon) but updated to run in a modern HAOS envionment. Gemini helped with debugging the dockerfile issues, as that is not my string point and I just wanted it working...

"If you can't do it in bash, then it's not worth doing. For everything else, there's Python" ;)