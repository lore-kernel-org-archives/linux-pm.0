From: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Subject: [RFC 0/2] Again w1-regman and power_supply MAX1721x
Date: Mon,  8 May 2017 09:13:26 +0300
Message-ID: <20170508061328.17370-1-minimumlaw@rambler.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>
Cc: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
List-Id: linux-pm@vger.kernel.org

Hi!
I wrote driver for Maxim MAX17211/MAX17215 standalone fuel gauge IC. 

Earlier I post preliminary versions of this driver and got recommendations to
translate it into the infrastructure of regmap. Accordingly, it was necessary
to implement at least basic support of regmap for the OneWire bus. Which was 
done. There was a criticism about the use of an intermediate platform_device.
In this edition, this is also fixed.

I would like to hear not only criticism, but also constructive proposals
for the implementation or correction of this code.

Known issuie/troubles:
~~~~~~~~~~~~~~~~~~~~~~
1. Endian for W1-regmap
Code writen for use nativ endian for host (master) device. But waiting for
little-endian slave divice. I don't know W1 slave device with big-endian
addrees or data format. May be regmap_bus or regmap_config will be checked
for host/device endian requirements?

2. W1 Family/device infrastructure
All present power_supply class drivers in vanilla kernel use w1-slave devices.
All of them create platform_device with name "chip-battery.X.auto", and 
power_supply class driver use this platform device. Why used this way? I
write code, allocated power_supply at W1 slave (family) device register.
This work as expected.

3. Device names
All W1 device have unical 64 bit ID (8-bit family, 48-bit serial number,
8 bit CRC). W1 infrastructure show 56 bits (family-serial_nimber) as w1
slave device name. I use this (unical) device name as power_supply battery
name. This work. But in /sys/class/power_supply is placed machine readabe 
subdir "26-HexDigString", instead of human-readable "chip-battery.X.auto".
But in /sys/class/power_supply/26-HexDigString/type file still content
human-readable type "Battery".
Thermal zone working, but in /sys/class/thermal/thermal_zoneX/type also
placed "26-HexDigString", instead of "chip-battery.X.auto".
I can rename "26-HexDigString" to "battery-26-HexDigString" or 
"26-HexDigString-battery", but this exceeded 20 chars thermal zone device
name. So, thermal zone will have to be disabled.

Alex A. Mihaylov (2):
  Basic support for regmap ifrastucture over Maxim/Dalas OneWire Bus
  MAX1721x Standalone Fuel Gauge IC power_supply class driver

 drivers/base/regmap/Kconfig             |   6 +-
 drivers/base/regmap/Makefile            |   1 +
 drivers/base/regmap/regmap-w1.c         | 241 +++++++++++++++++++++
 drivers/power/supply/Kconfig            |  14 ++
 drivers/power/supply/Makefile           |   1 +
 drivers/power/supply/max1721x_battery.c | 361 ++++++++++++++++++++++++++++++++
 include/linux/power/max172xx-battery.h  | 100 +++++++++
 include/linux/regmap.h                  |  34 +++
 8 files changed, 757 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/regmap/regmap-w1.c
 create mode 100644 drivers/power/supply/max1721x_battery.c
 create mode 100644 include/linux/power/max172xx-battery.h

-- 
2.8.4 (Apple Git-73)
