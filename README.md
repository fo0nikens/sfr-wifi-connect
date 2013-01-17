# Readme

*SFR WiFi Connect* will check regularly if your SFR WiFi session is still up
and reopen it automatically if required.

Default check period is 15 seconds.

## Install

    $ sudo make install

See the Makefile for more options.

## Usage

    $ sfr-wifi-connect foobar@sfr.fr 123abc456
    $ sfr-wifi-connect foobar@sfr.fr 123abc456 30s

## `netcfg` profile example

    CONNECTION='wireless'
    DESCRIPTION='SFR WiFi'
    INTERFACE='wlan0'
    SECURITY='none'
    ESSID='SFR WiFi Public'
    IP='dhcp'
    POST_UP='sfr-wifi-connect SFR_EMAIL_HERE SFR_PASSWORD_HERE > /var/log/sfr-wifi-connect.log &'
    POST_DOWN='killall -q sfr-wifi-connect || echo "sfr-wifi-connect process not found"'

Put this `netcfg` profile in your `/etc/rc.d/network` directory and `netcfg`
will automatically start `sfr-wifi-connect` when connect and kill it when
disconnected. Logs are put in the `/var/log/sfr-wifi-connect.log` file.

