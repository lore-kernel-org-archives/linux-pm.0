From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 00/14] power: supply: Fix custom sysfs attribute registration
Date: Mon,  1 Oct 2018 00:03:35 +0200
Message-ID: <20180930220349.10515-1-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Milo Kim <milo.kim@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-pm@vger.kernel.org

Hi,

Udev may not detect sysfs attributes, that have been added
after the device has been created. Code doing that is racy [0].
The power-supply class properly registers its attributes
when the device is created, but some drivers add additional
custom attributes in a racy way.

The first patch from this series adds native support for custom
sysfs attributes to the power-supply subsystem. This feature
allows cleaner code and avoids a race condition preventing udev
from noticing the custom properties.

The following patches replace all instances of sysfs_create_*
in drivers/power/supply to use the new feature and a couple
of small cleanups.

TL;DR: This patchsets replaces all sysfs_create_* in power-supply.

[0] http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/

-- Sebastian

Sebastian Reichel (14):
  power: supply: core: add support for custom sysfs attributes
  power: supply: bq2415x: fix race-condition in sysfs registration
  power: supply: ds2780: fix race-condition in sysfs registration
  power: supply: ds2781: fix race-condition in sysfs registration
  power: supply: lp8788: fix race-condition in sysfs registration
  power: supply: bq24190_charger: fix race-condition in sysfs
    registration
  power: supply: bq24257: fix race-condition in sysfs registration
  power: supply: charger-manager: simplify generation of sysfs attribute
    group name
  power: supply: charger-manager: fix race-condition in sysfs
    registration
  power: supply: pcf50633: fix race-condition in sysfs registration
  power: supply: ds2780: fix race-condition in bin attribute
    registration
  power: supply: ds2781: fix race-condition in bin attribute
    registration
  power: supply: ds2780: switch to devm_power_supply_register
  power: supply: ds2781: switch to devm_power_supply_register

 drivers/power/supply/bq2415x_charger.c   | 119 ++++++++++-------------
 drivers/power/supply/bq24190_charger.c   |  43 ++------
 drivers/power/supply/bq24257_charger.c   |  15 +--
 drivers/power/supply/charger-manager.c   |  62 +++++-------
 drivers/power/supply/ds2780_battery.c    |  87 +++++------------
 drivers/power/supply/ds2781_battery.c    |  82 +++++-----------
 drivers/power/supply/lp8788-charger.c    |  62 +++++-------
 drivers/power/supply/pcf50633-charger.c  |  17 ++--
 drivers/power/supply/power_supply_core.c |   1 +
 include/linux/power/charger-manager.h    |   3 +-
 include/linux/power_supply.h             |   3 +
 11 files changed, 172 insertions(+), 322 deletions(-)

-- 
2.19.0
