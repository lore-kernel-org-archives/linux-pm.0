From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v12.3 0/6] bq27xxx_battery partial series
Date: Fri, 31 Mar 2017 03:25:27 -0700
Message-ID: <20170331102533.27528-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35368 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753338AbdCaKZ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2017 06:25:27 -0400
Received: by mail-pg0-f67.google.com with SMTP id g2so16245533pge.2
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2017 03:25:26 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org

I recounted; we're at 17 versions including partial series. I don't mind
making lots of changes, but each feedback/revision cycle has substantial
overhead, and I need to move on to other work. I'm starting to wonder
whether I work for TI.

Latest changes:

A maintenance cookie for you: new patch to flag identical reg maps. After
this is tested we'll hide it behind #ifdef debug.

Describe di->chip IDs as "category prototypes/members".

Add kernel-doc for bq27xxx_dm_buf. I just realized nothing else in the file
has kernel-doc, and it's not a header, so I don't know why this needed it.

I/O helpers return -ENOSYS if di->bus.* missing.

Macro for DM fields in bq27xxx_regs.




  power: bq27xxx_battery: Add bulk transfer bus methods
  power: bq27xxx_battery: Add chip data memory read/write support
  power: bq27xxx_battery: Add power_supply_battery_info support
  power: bq27xxx_battery: Enable chip data memory update for certain chips
  power: bq27xxx_battery: Remove duplicate register arrays

 drivers/power/supply/bq27xxx_battery.c     | 681 +++++++++++++++++++++++------
 drivers/power/supply/bq27xxx_battery_i2c.c |  98 ++++-
 include/linux/power/bq27xxx_battery.h      |  26 +-
 3 files changed, 663 insertions(+), 142 deletions(-)

-- 
2.9.3
