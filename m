From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v6 0/8] devicetree battery support and client bq27xxx_battery
Date: Fri, 10 Feb 2017 18:43:32 -0800
Message-ID: <20170211024340.19491-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33226 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753198AbdBKCnt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2017 21:43:49 -0500
Received: by mail-pg0-f68.google.com with SMTP id 194so4352105pgd.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2017 18:43:49 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F . Davis" <afd@ti.com>, linux-pm@vger.kernel.org

Overview:
* new devicetree battery node specifies static battery data
* fuel gauge and charger nodes shall use monitored-battery=<&battery_node>
* new power_supply_get_battery_info() reads battery data from devicetree
* new struct power_supply_battery_info provides battery data to drivers
* drivers surface battery data in sysfs via related power_supply_prop_* fields
* bq27xxx driver calls the above and writes battery data to NVM for params
  essential to correct operation: energy-full-design-microwatt-hours,
  charge-full-design-microamp-hours, voltage-min-design-microvolt

Changes in v6:
* Documentation/devictree/... fixes
* bq27xxx_battery: clarify names
* bq27xxx_battery: verify that selected registers are supported
* bq27xxx_battery: allocate NVM buffer on stack
* bq27xxx_battery_i2c: fix return code of bulk_read

Changes in v5:
* incorporate feedback into Documentation/devicetree/.../battery.txt
* use power_supply_prop_* names in devicetree and power_supply_battery_info
* default fields to -EINVAL in power_supply_battery_info
* power_supply_get_battery_info() always looks for "monitored-battery"
* power_supply_get_battery_info() emits a warning if !psy->of_node
* squash patches for power_supply_battery_info
* bq27xxx_battery: check power_supply_battery_info values
* bq27xxx_battery: note missing power_supply_prop_* features
* bq27xxx_battery: new patch for access methods

Changes in v4:
* add "fixed-battery" compatible field to be be more consistant with devicetree

Changes in v3:
* split i2c changes into respective patches
* add documentation for battery information for fuel gauge
* rebased documentation patches on change on the list
* abstracted the battery configuration for the state machine
  to an generic struct and platform data access function

Changes in v2:
* add documentation for uWh and uAh property units
* change devicetree entries to match new property units

Matt Ranostay (8):
  devicetree: power: Add battery.txt
  devicetree: property-units: Add uWh and uAh units
  devicetree: power: bq27xxx: Add monitored-battery documentation
  power: power_supply: Add power_supply_battery_info and API
  power: bq27xxx_battery: Define access methods to write chip registers
  power: bq27xxx_battery: Add BQ27425 chip id
  power: bq27xxx_battery: Add power_supply_battery_info support
  power: bq27xxx_battery_i2c: Add I2C bulk read/write functions

 .../devicetree/bindings/power/supply/battery.txt   |  37 +++
 .../devicetree/bindings/power/supply/bq27xxx.txt   |  11 +-
 .../devicetree/bindings/property-units.txt         |   2 +
 drivers/power/supply/bq27xxx_battery.c             | 325 ++++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c         |  67 ++++-
 drivers/power/supply/power_supply_core.c           |  40 +++
 include/linux/power/bq27xxx_battery.h              |   6 +-
 include/linux/power_supply.h                       |  18 ++
 8 files changed, 501 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt

-- 
2.9.3

