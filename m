From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v12.4 0/7] bq27xxx_battery partial series
Date: Tue,  4 Apr 2017 01:56:59 -0700
Message-ID: <20170404085706.32592-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36803 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbdDDI5B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Apr 2017 04:57:01 -0400
Received: by mail-pg0-f66.google.com with SMTP id 81so35860575pgh.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Apr 2017 01:57:01 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org

Latest changes:

Devicetree docs mention relevant battery node fields.

Clean up patch "Flag identical register maps..."

^.^ - I can has test?

  power: bq27xxx_battery: Add bulk transfer bus methods
  power: bq27xxx_battery: Add chip data memory read/write support
  power: bq27xxx_battery: Add power_supply_battery_info support
  power: bq27xxx_battery: Enable chip data memory update for certain chips
  devicetree: power: bq27xxx: Add monitored-battery documentation
  power: bq27xxx_battery: Flag identical register maps when in debug mode
  power: bq27xxx_battery: Remove duplicate register arrays

 .../devicetree/bindings/power/supply/bq27xxx.txt   |  31 +-
 drivers/power/supply/bq27xxx_battery.c             | 704 +++++++++++++++++----
 drivers/power/supply/bq27xxx_battery_i2c.c         |  98 ++-
 include/linux/power/bq27xxx_battery.h              |  26 +-
 4 files changed, 710 insertions(+), 149 deletions(-)

-- 
2.9.3
