From: Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v3 0/7] power: bq27xxx: add support for NVRAM R/W access
Date: Tue, 10 Jan 2017 22:19:56 -0800
Message-ID: <20170111062003.10110-1-matt@ranostay.consulting>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36450 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753235AbdAKGUH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jan 2017 01:20:07 -0500
Received: by mail-pf0-f176.google.com with SMTP id 189so47380158pfu.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2017 22:20:06 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: sre@kernel.org, tony@atomide.com, Matt Ranostay <matt@ranostay.consulting>

Enable access to the NVRAM for the bq27425 chipset which allows to
update the battery metrics that are used in the state machine.

This allows adjustments of a termination voltage, design energy, and
design voltage.

Changes from v1:
* add documentation for mWh and mAh property units
* change devicetree entries to match new property units

Changes from v2:
* split i2c changes into respective patches
* add documentation for battery information for fuel gauge
* rebased documentation patches on change on the list
* abstracted the battery configuration for the state machine
  to an generic struct and platform data access function

Matt Ranostay (7):
  devicetree: power: add battery state machine documentation
  power: power_supply: add battery information struct
  power: power_supply: add battery info platform data retrieval
  power: bq27xxx_battery: add BQ27425 chip id
  power: bq27xxx_battery: add i2c bulk read/write functions
  devicetree: power: bq27xxx: add monitored battery documentation
  power: bq27xxx_battery: add initial state machine support

 .../devicetree/bindings/power/supply/battery.txt   |  20 ++
 .../devicetree/bindings/power/supply/bq27xxx.txt   |   8 +
 drivers/power/supply/bq27xxx_battery.c             | 253 ++++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c         |  64 +++++-
 drivers/power/supply/power_supply_core.c           |  31 +++
 include/linux/power/bq27xxx_battery.h              |   7 +-
 include/linux/power_supply.h                       |  16 ++
 7 files changed, 395 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt

-- 
2.10.2

