From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v12.3 9/10] power: bq27xxx_battery: Flag identical register maps when in debug mode
Date: Fri, 31 Mar 2017 03:25:32 -0700
Message-ID: <20170331102533.27528-6-liam@networkimprov.net>
References: <20170331102533.27528-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35663 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932764AbdCaKZy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2017 06:25:54 -0400
Received: by mail-pg0-f68.google.com with SMTP id g2so16247869pge.2
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2017 03:25:53 -0700 (PDT)
In-Reply-To: <20170331102533.27528-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org
Cc: Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

We map multiple chips to unique register maps. When supporting a new chip,
it's easy to add a duplicate map by accident.

In debug mode we now scan the register maps for duplicates.

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 3ff854e..ebc5d31 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1870,6 +1870,26 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 	schedule_delayed_work(&di->work, 0);
 }
 
+static void bq27xxx_battery_find_reg_dupes(struct bq27xxx_device_info *di)
+{
+	int a, b, i;
+	size_t max = sizeof(bq27xxx_regs) / BQ27XXX_REG_MAX;
+
+	dev_warn(di->dev, "checking %d reg maps\n", max);
+
+	for (a = 1; a < max; a++) {
+		for (b = a+1; b < max; b++) {
+			for (i = 0; i < BQ27XXX_REG_MAX; i++) {
+				if (bq27xxx_regs[a][i] != bq27xxx_regs[b][i])
+					break;
+			}
+			if (i == BQ27XXX_REG_MAX)
+				dev_warn(di->dev,
+				        "bq27xxx_regs[%d] & [%d] are identical\n", a, b);
+		}
+	}
+}
+
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 {
 	struct power_supply_desc *psy_desc;
@@ -1878,6 +1898,8 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 		.drv_data = di,
 	};
 
+	bq27xxx_battery_find_reg_dupes(di);
+
 	di->unseal_key = bq27xxx_unseal_keys[di->chip];
 	di->dm_regs = bq27xxx_dm_regs[di->chip];
 
-- 
2.9.3
