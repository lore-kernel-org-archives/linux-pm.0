From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v12.2 0/5] bq27xxx_battery partial series
Date: Thu, 30 Mar 2017 02:02:11 -0700
Message-ID: <20170330090216.12381-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34870 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932221AbdC3JCM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2017 05:02:12 -0400
Received: by mail-pg0-f41.google.com with SMTP id 81so33574534pgh.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2017 02:02:11 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org

Changes in this rev:

Removed macro for if (...) dev_dbg(...) from I/O helper functions.

Moved update_dm_block() to patch "Add power_supply_battery_info support".
No more refactoring please; it's not really improving the code itself :-)

set_cfgupdate is required for DM write on certain chips, see this Q&A
https://e2e.ti.com/support/power_management/battery_management/f/180/p/577798/2121489#2121489

Renamed dm_buf .full => .has_data, .updt => .dirty
dm_buf has 3 states: !has_data, has_data && !dirty, has_data && dirty
I considered a single field and enum values, but I think this is clearer.

Renamed set_cfgupdate(..., u16 flag => state)
We call set_cfgupdate(di, BQ27XXX_FLAG_CFGUP or 0)
We !!state to print the intended flag state in error msg.


  power: bq27xxx_battery: Add bulk transfer bus methods
  power: bq27xxx_battery: Add chip data memory read/write support
  power: bq27xxx_battery: Add power_supply_battery_info support
  power: bq27xxx_battery: Enable chip data memory update for certain chips
  power: bq27xxx_battery: Remove duplicate register arrays

 drivers/power/supply/bq27xxx_battery.c     | 700 +++++++++++++++++++++++------
 drivers/power/supply/bq27xxx_battery_i2c.c |  98 +++-
 include/linux/power/bq27xxx_battery.h      |  26 +-
 3 files changed, 682 insertions(+), 142 deletions(-)

-- 
2.9.3
