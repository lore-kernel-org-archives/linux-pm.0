From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v12.4 9/10] power: bq27xxx_battery: Flag identical register maps when in debug mode
Date: Tue,  4 Apr 2017 01:57:05 -0700
Message-ID: <20170404085706.32592-7-liam@networkimprov.net>
References: <20170404085706.32592-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36211 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752895AbdDDI5r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Apr 2017 04:57:47 -0400
Received: by mail-pg0-f65.google.com with SMTP id 81so35864466pgh.3
        for <linux-pm@vger.kernel.org>; Tue, 04 Apr 2017 01:57:46 -0700 (PDT)
In-Reply-To: <20170404085706.32592-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org
Cc: Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

We tie multiple chips to unique register maps. When supporting a new chip,
it's easy to add a duplicate map by accident.

In debug mode we now scan the register maps for duplicates.

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 3ff854e..cc87984 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1870,6 +1870,27 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 	schedule_delayed_work(&di->work, 0);
 }
 
+#ifndef DEBUG /* ifdef after testing */
+static void bq27xxx_battery_find_reg_dupes(struct bq27xxx_device_info *di)
+{
+	const size_t max = ARRAY_SIZE(bq27xxx_regs);
+	int a, b;
+
+	dev_warn(di->dev, "checking %d reg maps\n", max);
+
+	for (a = 1; a < max; a++) {
+		for (b = a+1; b < max; b++) {
+			if (!memcmp(bq27xxx_regs[a], bq27xxx_regs[b],
+			            sizeof(bq27xxx_regs[0])))
+				dev_warn(di->dev,
+				        "bq27xxx_regs[%d] & [%d] are identical\n", a, b);
+		}
+	}
+}
+#else
+static inline void bq27xxx_battery_find_reg_dupes(struct bq27xxx_device_info *di) {}
+#endif
+
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 {
 	struct power_supply_desc *psy_desc;
@@ -1878,6 +1899,8 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 		.drv_data = di,
 	};
 
+	bq27xxx_battery_find_reg_dupes(di);
+
 	di->unseal_key = bq27xxx_unseal_keys[di->chip];
 	di->dm_regs = bq27xxx_dm_regs[di->chip];
 
-- 
2.9.3
