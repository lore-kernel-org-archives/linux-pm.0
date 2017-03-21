From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v1 0/7] BQ24190 support for power_supply_battery_info and DT binding
Date: Tue, 21 Mar 2017 15:09:14 -0700
Message-ID: <20170321220921.5834-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34995 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932865AbdCUWRU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2017 18:17:20 -0400
Received: by mail-pg0-f65.google.com with SMTP id g2so27300081pge.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2017 15:17:20 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Overview:
BQ24190 needs settings for pre-charge & end-charge current and system min voltage to function 
correctly. Pre- and end-charge current belong in power_supply_battery_info as they are based on 
battery capacity. We add _PRECHARGE & _ENDCHARGE elements to enum power_supply_property.

Issues in v1:
* power_supply_prop_precharge & endcharge are added at end of enum to avoid sysfs breakage
* "Set bq24190-battery device .type=unknown" is a temporary workaround to be fixed in v2

Liam Breck (7):
  devicetree: power: battery: Add properties for pre-charge and end-charge current
  devicetree: power: Add docs for TI BQ24190 battery charger
  power: power_supply_core: Add *_battery_info fields for pre- and end-charge current
  power: bq24190_charger: Uniform pm_runtime_get() failure handling
  power: bq24190_charger: Reorder init sequence in probe()
  power: bq24190_charger: Add power_supply_battery_info and devicetree support
  power: bq24190_charger: Set bq24190-battery device .type=unknown

 .../devicetree/bindings/power/supply/battery.txt   |   4 +
 .../devicetree/bindings/power/supply/bq24190.txt   |  47 +++++++
 drivers/power/supply/bq24190_charger.c             | 152 ++++++++++++++++-----
 drivers/power/supply/power_supply_core.c           |   6 +
 include/linux/power_supply.h                       |   5 +
 5 files changed, 179 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq24190.txt

-- 
2.9.3
