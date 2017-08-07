From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v2 0/5] BQ24190 devicetree config
Date: Mon,  7 Aug 2017 12:54:15 -0700
Message-ID: <20170807195420.20767-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34144 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdHGTyj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2017 15:54:39 -0400
Received: by mail-pg0-f66.google.com with SMTP id y192so1240674pgd.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Aug 2017 12:54:39 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>

Hi Sebastian, here is this series that was waiting on the power_supply_battery_info
patchset. Thanks!

Overview:
BQ24190 uses power_supply_battery_info fields for precharge & charge-termination 
current and a DT property for system min voltage. A new DT binding documents these.

Changes in v2:
* new patch adds bq24192i to DT table
* dropped patches for power_supply precharge-current; they moved to bq27xxx series
* dropped patches for recently-applied fixes
* rebased to -next

Issues in v1:
* power_supply_prop_precharge & endcharge are added at end of enum to avoid sysfs breakage
* "Set bq24190-battery device .type=unknown" is a temporary workaround to be fixed in v2

Liam Breck (5):
  power: bq24190_charger: Add ti,bq24192i to devicetree table
  devicetree: power: Add docs for TI BQ24190 battery charger
  power: bq24190_charger: Enable devicetree config
  power: bq24190_charger: Add property system-minimum-microvolt
  power: bq24190_charger: Add power_supply_battery_info support

 .../devicetree/bindings/power/supply/bq24190.txt   |  49 ++++++
 drivers/power/supply/bq24190_charger.c             | 177 ++++++++++++++++++---
 2 files changed, 203 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq24190.txt

-- 
2.13.2
