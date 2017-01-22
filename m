From: Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v4 0/8] power: bq27xxx: add support for NVRAM R/W access
Date: Sat, 21 Jan 2017 23:13:56 -0800
Message-ID: <20170122071404.9654-1-matt@ranostay.consulting>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34427 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750813AbdAVHOF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2017 02:14:05 -0500
Received: by mail-pf0-f173.google.com with SMTP id e4so32862070pfg.1
        for <linux-pm@vger.kernel.org>; Sat, 21 Jan 2017 23:14:05 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: sre@kernel.org, tony@atomide.com, Matt Ranostay <matt@ranostay.consulting>

Changes from v1:
* add documentation for mWh and mAh property units
* change devicetree entries to match new property units

Changes from v2:
* split i2c changes into respective patches
* add documentation for battery information for fuel gauge
* rebased documentation patches on change on the list
* abstracted the battery configuration for the state machine
  to an generic struct and platform data access function

Changes from v3:
* add "fixed-battery" compatible field to be be more consistant
  with devicetree

Matt Ranostay (8):
  devicetree: property-units: add mWh and mAh units
  devicetree: power: add battery state machine documentation
  power: power_supply: add battery information struct
  power: power_supply: add battery info platform data retrieval
  power: bq27xxx_battery: add BQ27425 chip id
  power: bq27xxx_battery: add i2c bulk read/write functions
  devicetree: power: bq27xxx: add monitored battery documentation
  power: bq27xxx_battery: add initial state machine support

 .../devicetree/bindings/power/supply/battery.txt   |  24 ++
 .../devicetree/bindings/power/supply/bq27xxx.txt   |   8 +
 .../devicetree/bindings/property-units.txt         |   2 +
 drivers/power/supply/bq27xxx_battery.c             | 253 ++++++++++++++++++++-
 drivers/power/supply/bq27xxx_battery_i2c.c         |  64 +++++-
 drivers/power/supply/power_supply_core.c           |  41 ++++
 include/linux/power/bq27xxx_battery.h              |   7 +-
 include/linux/power_supply.h                       |  16 ++
 8 files changed, 411 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt

-- 
2.10.2

