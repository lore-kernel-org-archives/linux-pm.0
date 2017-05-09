From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v13.2 10/11] power: supply: bq27xxx_battery: Flag identical register maps when in debug mode
Date: Tue,  9 May 2017 01:21:23 -0700
Message-ID: <20170509082123.27592-5-liam@networkimprov.net>
References: <20170509082123.27592-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33294 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbdEIIWE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2017 04:22:04 -0400
Received: by mail-pg0-f66.google.com with SMTP id s62so14177420pgc.0
        for <linux-pm@vger.kernel.org>; Tue, 09 May 2017 01:22:04 -0700 (PDT)
In-Reply-To: <20170509082123.27592-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org
Cc: Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

We tie multiple chips to unique register maps. When supporting a new chip,
it's easy to add a duplicate map by mistake.

In debug mode we now scan the register maps for duplicates.

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 76cb181..0492f33 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1922,6 +1922,25 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 	schedule_delayed_work(&di->work, 0);
 }
 
+#ifdef DEBUG
+static void bq27xxx_battery_dbg_regs_dupes(struct bq27xxx_device_info *di)
+{
+	const size_t max = ARRAY_SIZE(bq27xxx_regs);
+	int a, b;
+
+	for (a = 1; a < max-1; a++) {
+		for (b = a+1; b < max; b++) {
+			if (!memcmp(bq27xxx_regs[a], bq27xxx_regs[b],
+				    sizeof(bq27xxx_regs[0])))
+				dev_warn(di->dev,
+					"bq27xxx_regs[%d] & [%d] are identical\n", a, b);
+		}
+	}
+}
+#else
+static inline void bq27xxx_battery_dbg_regs_dupes(struct bq27xxx_device_info *di) {}
+#endif
+
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 {
 	struct power_supply_desc *psy_desc;
@@ -1930,6 +1949,8 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 		.drv_data = di,
 	};
 
+	bq27xxx_battery_dbg_regs_dupes(di);
+
 	di->ram_chip = di->chip == BQ27421 || di->chip == BQ27441 || di->chip == BQ27621;
 
 	di->unseal_key = bq27xxx_unseal_keys[di->real_chip];
-- 
2.9.3
