From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v12.1 0/5] bq27xxx_battery partial series
Date: Wed, 29 Mar 2017 13:48:05 -0700
Message-ID: <20170329204810.5427-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34732 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932739AbdC2UsF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2017 16:48:05 -0400
Received: by mail-pg0-f66.google.com with SMTP id o123so4652162pga.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2017 13:48:04 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org

All comments from previous partial series were resolved.

  power: bq27xxx_battery: Add bulk transfer bus methods
  power: bq27xxx_battery: Add chip data memory read/write support
  power: bq27xxx_battery: Add power_supply_battery_info support
  power: bq27xxx_battery: Enable chip data memory update for certain chips
  power: bq27xxx_battery: Remove duplicate register arrays

 drivers/power/supply/bq27xxx_battery.c     | 694 +++++++++++++++++++++++------
 drivers/power/supply/bq27xxx_battery_i2c.c |  98 +++-
 include/linux/power/bq27xxx_battery.h      |  26 +-
 3 files changed, 676 insertions(+), 142 deletions(-)

-- 
2.9.3
