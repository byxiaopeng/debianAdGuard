#!/bin/bash
#启动ssh
/etc/init.d/ssh start
#启动AdGuardHome
AdGuardHome -c /AdGuardHome/AdGuardHome.yaml
