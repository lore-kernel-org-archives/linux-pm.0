From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v13 10/11] power: supply: bq27xxx_battery: Flag identical register maps when in debug mode
Date: Wed,  3 May 2017 23:18:10 -0700
Message-ID: <20170504061811.18107-11-liam@networkimprov.net>
References: <20170504061811.18107-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32984 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754438AbdEDGTR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 May 2017 02:19:17 -0400
Received: by mail-pf0-f193.google.com with SMTP id b23so807459pfc.0
        for <linux-pm@vger.kernel.org>; Wed, 03 May 2017 23:19:17 -0700 (PDT)
In-Reply-To: <20170504061811.18107-1-liam@networkimprov.net>
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
index 0aecd41..97c646c 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1932,6 +1932,25 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
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
@@ -1940,6 +1959,8 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 		.drv_data = di,
 	};
 
+	bq27xxx_battery_dbg_regs_dupes(di);
+
 	di->ram_chip = di->chip == BQ27421 || di->chip == BQ27441 || di->chip == BQ27621;
 
 	di->unseal_key = bq27xxx_unseal_keys[di->chip];
-- 
2.9.3
