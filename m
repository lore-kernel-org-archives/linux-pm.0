From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v12.6 11/11] power: bq27xxx_battery: Disable flash/NVM data memory update
Date: Sun,  9 Apr 2017 22:07:12 -0700
Message-ID: <20170410050712.930-8-liam@networkimprov.net>
References: <20170410050712.930-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34930 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdDJFHt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 01:07:49 -0400
Received: by mail-pg0-f66.google.com with SMTP id g2so24239496pge.2
        for <linux-pm@vger.kernel.org>; Sun, 09 Apr 2017 22:07:49 -0700 (PDT)
In-Reply-To: <20170410050712.930-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org
Cc: Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

On chips with flash/NVM data memory, it's not clear whether battery
characteristics from devicetree monitored-battery or data memory should
take precedence. The gauge may be packaged in a smart battery or resident
on the circuit board, and in either case, the battery type may have changed
since the dtb was installed. However, it is safe to assume that a device
vendor who includes battery characteristics in devicetree knows what
they're doing.

Drop module param use_monitored_battery. If devicetree monitored-battery
values differ from data memory registers, emit a warning instead of
updating flash/NVM.

This is controversial; the patch author believes ignoring devicetree is
the wrong decision, that its integrity should be trusted. But as the
patch does not impact him directly, he suggests others lobby the
maintainers to revert it :-)

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 13 ++++++-------
 include/linux/power/bq27xxx_battery.h  |  1 +
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index b579304..7234e6f 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -809,11 +809,6 @@ static u32 bq27xxx_unseal_keys[] = {
 };
 
 
-static bool bq27xxx_dt_battery = true;
-module_param_named(use_monitored_battery, bq27xxx_dt_battery, bool, S_IRUGO);
-MODULE_PARM_DESC(use_monitored_battery,
- "Use devicetree monitored-battery config if present. Default is 1/y.");
-
 static int poll_interval_param_set(const char *val, const struct kernel_param *kp)
 {
 	struct bq27xxx_device_info *di;
@@ -1035,8 +1030,10 @@ static void bq27xxx_battery_update_dm_block(struct bq27xxx_device_info *di,
 		return;
 	}
 
-	if (!bq27xxx_dt_battery) {
-		dev_warn(di->dev, "%s has %u; update to %u disallowed by use_monitored_battery=0\n",
+	if (!di->ram_chip) {
+		/* devicetree and NVM differ; defer to NVM. this may be wrong.   */
+		/* revert this or allow override via DT property or module param */
+		dev_warn(di->dev, "%s has %u; update to %u disallowed for flash/NVM\n",
 		         str, be16_to_cpup(prev), val);
 		return;
 	}
@@ -1822,6 +1819,8 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 
 	bq27xxx_battery_dbg_regs_dupes(di);
 
+	di->ram_chip = di->chip == BQ27421 || di->chip == BQ27441 || di->chip == BQ27621;
+
 	di->unseal_key = bq27xxx_unseal_keys[di->chip];
 	di->dm_regs = bq27xxx_dm_regs[di->chip];
 	di->chip = bq27xxx_chips[di->chip];
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 7c0f3d3..4702b86 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -76,6 +76,7 @@ struct bq27xxx_device_info {
 	struct device *dev;
 	int id;
 	enum bq27xxx_chip chip;
+	bool ram_chip;
 	const char *name;
 	struct bq27xxx_dm_reg *dm_regs;
 	u32 unseal_key;
-- 
2.9.3
