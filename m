From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v9 0/8] devicetree battery support and client bq27xxx_battery
Date: Sun,  5 Mar 2017 23:25:31 -0800
Message-ID: <20170306072539.980-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35577 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752557AbdCFHeb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Mar 2017 02:34:31 -0500
Received: by mail-pg0-f66.google.com with SMTP id 187so5323940pgb.2
        for <linux-pm@vger.kernel.org>; Sun, 05 Mar 2017 23:34:30 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>

Overview:
* new devicetree battery node specifies static battery data
* fuel gauge and charger nodes shall use monitored-battery=<&battery_node>
* new power_supply_get_battery_info() reads battery data from devicetree
* new struct power_supply_battery_info provides battery data to drivers
* drivers surface battery data in sysfs via related power_supply_prop_* fields
* bq27xxx driver calls the above and writes battery data to RAM/NVM for params
  essential to correct operation: energy-full-design-microwatt-hours,
  charge-full-design-microamp-hours, voltage-min-design-microvolt

Changes in v9:
  bq27xxx_battery:
*   fix set_cfgupdate()
*   support bq27500, 545, 421; defer others
*   bq27441, 621 use enum BQ27425 instead of BQ27421
*   drop print_dm_blocks() patch
*   minor polishing
  Documentation/devicetree/.../battery.txt:
*   describe rationale for enum power_supply_property names

Changes in v8:
  bq27xxx_battery:
*   wait on flag after set_cfgupdate & soft_reset
*   drop print_config(), report status in update_dm_block()
*   clarify error messages
*   cleanup from Andrew's feedback; minor polishing

Changes in v7:
  bq27xxx_battery:
*   support chips where terminate_voltage & design_* live in separate blocks
*   draft support for 421, 441, 621 chips
*   new patch to log chip memory fields
*   report bus I/O errors; return error code in bq27xxx_battery_i2c
*   verify checksum in read_dm_block()
*   use set_cfgupdate only if chip provides it, soft_reset on I/O error
*   block_data_control=0 only in write_dm_block()
*   note toxic code from TI bqtool in write_dm_block()
*   lots of functionally neutral polishing
  Documentation/devicetree/.../battery.txt:
*   mention power_supply_get_battery_info()

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

Liam (4):
  devicetree: power: Add battery.txt
  devicetree: power: bq27xxx: Add monitored-battery documentation
  power: power_supply: Add power_supply_battery_info and API
  power: bq27xxx_battery: Add power_supply_battery_info support

Matt Ranostay (4):
  devicetree: property-units: Add uWh and uAh units
  power: bq27xxx_battery: Define access methods to write chip registers
  power: bq27xxx_battery: Move BQ27421 chip id to its own group
  power: bq27xxx_battery_i2c: Add I2C bulk read/write functions

 .../devicetree/bindings/power/supply/battery.txt   |  45 ++
 .../devicetree/bindings/power/supply/bq27xxx.txt   |  11 +-
 .../devicetree/bindings/property-units.txt         |   2 +
 drivers/power/supply/bq27xxx_battery.c             | 506 ++++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c         |  88 +++-
 drivers/power/supply/power_supply_core.c           |  40 ++
 include/linux/power/bq27xxx_battery.h              |   6 +-
 include/linux/power_supply.h                       |  18 +
 8 files changed, 707 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt

-- 
2.9.3
