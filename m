From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v14 00/11] devicetree simple-battery and client in bq27xxx_battery
Date: Wed,  7 Jun 2017 11:37:48 -0700
Message-ID: <20170607183759.20261-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33176 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751944AbdFGSiQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 14:38:16 -0400
Received: by mail-pg0-f65.google.com with SMTP id a70so2163819pge.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2017 11:38:06 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org
Cc: Enric Balletbo <enric.balletbo@collabora.com>, Paul Kocialkowski <contact@paulk.fr>, Quentin Schulz <quentin.schulz@free-electrons.com>

Hi Sebastian, I think this is finally ready to go. I'll make a final
test pass while awaiting any further comments. There's a lot here, so
I'd appreciate it if you could look closely, as it's been a while since
you had any feedback. Also note comment about Rob's ack in v13 change list.

Enric, Paul, Quentin, and I all have patchsets waiting on this one.
Thanks!

Overview:
* new devicetree battery node specifies static battery data
* fuel gauge and charger nodes shall use monitored-battery=<&battery_node>
* new power_supply_get_battery_info() reads battery data from devicetree
* new struct power_supply_battery_info provides battery data to drivers
* drivers surface battery data in sysfs via related power_supply_prop_* fields
* bq27xxx driver calls the above and writes battery data to RAM/NVM for params
  essential to correct operation: energy-full-design-microwatt-hours,
  charge-full-design-microamp-hours, voltage-min-design-microvolt

Changes in v14:
  Doc...bindings/power/supply/ & power_supply_core
*   add constant-charge-{current,voltage}-max-* for Enric's patchset
  bq27xxx_battery:
*   separate set_cfgupdate() and soft_reset() functions
*   module param dt_monitored_battery_updates_nvm visible even when disabled
*   real_chip & chip IDs combined in i2c_id_table[]
*   hide untested chip params behind ifdef DEBUG

Changes in v13:
  Doc...bindings/power/supply/*
*   add fields in battery.txt, see below
*   caution about changing battery type in battery.txt
*   note: Rob acked v11 battery.txt containing URL to Linux header
*   more detail in bq27xxx.txt
  power_supply_core:
*   add battery_info fields precharge-current-microamp & charge-term-current-microamp
*   new patch for power_supply_prop_precharge_current
  bq27xxx_battery:
*   add copyright notice
*   for flash/NVM chips, emit warning instead of doing update
*   config_battery_bq27xxx_dt_updates_nvm enables update of flash/NVM
*   module param dt_monitored_battery_updates_nvm lets user disallow update
*   new patch to flag dupes in bq27xxx_regs[]
*   drop patch to clean up error reporting
*   polishing from Andrew's feedback
*   resolve checkpatch errors
*   refactor patchset
*   fix missing static keyword flagged by Colin

Changes in v12: (several partial series posts; see above)

Changes in v11:
  power_supply_core:
*   switch to compatible = "simple-battery"
*   add docs to power_supply_class.txt
  Documentation/devicetree/.../battery.txt:
*   add description, drop refs to Linux, "simple-battery"
  bq27xxx_battery:
*   reset flash chips after DM update
*   add bq27xxx_write/xfer()
*   polishing from Andrew's feedback
*   new patch to clean up error reporting
*   new patch to consolidate duplicate register/property arrays

Changes in v10:
  bq27xxx_battery:
*   pass actual chip ID into _setup()
*   add di->unseal_key & di->dm_regs; drop static arrays
*   support bq27425, 441, 621

Changes in v9:
  bq27xxx_battery:
*   fix set_cfgupdate()
*   support bq27500, 545, 421; defer others
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


Liam Breck (9):
  dt-bindings: power: supply: Add battery.txt with simple-battery binding
  power: supply: core: Add power_supply_battery_info and API
  power: supply: core: Add power_supply_prop_precharge
  dt-bindings: power: supply: bq27xxx: Add monitored-battery documentation
  power: supply: bq27xxx: Add chip data memory read/write support
  power: supply: bq27xxx: Add power_supply_battery_info support
  power: supply: bq27xxx: Enable data memory update for certain chips
  power: supply: bq27xxx: Flag identical register maps when in debug mode
  power: supply: bq27xxx: Remove duplicate register arrays

Matt Ranostay (2):
  devicetree: property-units: Add uWh and uAh units
  power: supply: bq27xxx: Add bulk transfer bus methods

 .../devicetree/bindings/power/supply/battery.txt   |  57 ++
 .../devicetree/bindings/power/supply/bq27xxx.txt   |  31 +-
 .../devicetree/bindings/property-units.txt         |   2 +
 Documentation/power/power_supply_class.txt         |  31 +-
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/bq27xxx_battery.c             | 752 +++++++++++++++++----
 drivers/power/supply/bq27xxx_battery_i2c.c         | 134 +++-
 drivers/power/supply/power_supply_core.c           |  57 ++
 drivers/power/supply/power_supply_sysfs.c          |   1 +
 include/linux/power/bq27xxx_battery.h              |  30 +-
 include/linux/power_supply.h                       |  25 +
 11 files changed, 955 insertions(+), 176 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt

-- 
2.13.0
