From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v10 6/8] power: bq27xxx_battery: Keep track of specific chip id
Date: Wed, 15 Mar 2017 12:26:51 -0700
Message-ID: <20170315192653.26799-7-liam@networkimprov.net>
References: <20170315192653.26799-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36369 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752889AbdCOT1b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2017 15:27:31 -0400
Received: by mail-pg0-f65.google.com with SMTP id m5so3256354pgk.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2017 12:27:30 -0700 (PDT)
In-Reply-To: <20170315192653.26799-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Pass actual chip ID into _setup(), which translates it to a group ID,
to allow support for all chips by the power_supply_battery_info code.
There are no functional changes to the driver.

Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq27xxx_battery.c     | 19 +++++++++++++++++++
 drivers/power/supply/bq27xxx_battery_i2c.c | 16 ++++++++--------
 include/linux/power/bq27xxx_battery.h      | 25 ++++++++++++++++++-------
 3 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 7272d1e..d613d3d 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1020,6 +1020,25 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	struct power_supply_desc *psy_desc;
 	struct power_supply_config psy_cfg = { .drv_data = di, };
 
+	switch(di->chip) {
+	case BQ27000:
+	case BQ27010:
+	case BQ27500:
+	case BQ27510:
+	case BQ27530:
+	case BQ27541:
+	case BQ27545:
+	case BQ27421: break;
+	case BQ27520: di->chip = BQ27510; break;
+	case BQ27531: di->chip = BQ27530; break;
+	case BQ27542: di->chip = BQ27541; break;
+	case BQ27546: di->chip = BQ27541; break;
+	case BQ27742: di->chip = BQ27541; break;
+	case BQ27425: di->chip = BQ27421; break;
+	case BQ27441: di->chip = BQ27421; break;
+	case BQ27621: di->chip = BQ27421; break;
+	}
+
 	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
 	mutex_init(&di->lock);
 	di->regs = bq27xxx_regs[di->chip];
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 5c5c3a6..13def59 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -150,18 +150,18 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27210", BQ27010 },
 	{ "bq27500", BQ27500 },
 	{ "bq27510", BQ27510 },
-	{ "bq27520", BQ27510 },
+	{ "bq27520", BQ27520 },
 	{ "bq27530", BQ27530 },
-	{ "bq27531", BQ27530 },
+	{ "bq27531", BQ27531 },
 	{ "bq27541", BQ27541 },
-	{ "bq27542", BQ27541 },
-	{ "bq27546", BQ27541 },
-	{ "bq27742", BQ27541 },
+	{ "bq27542", BQ27542 },
+	{ "bq27546", BQ27546 },
+	{ "bq27742", BQ27742 },
 	{ "bq27545", BQ27545 },
 	{ "bq27421", BQ27421 },
-	{ "bq27425", BQ27421 },
-	{ "bq27441", BQ27421 },
-	{ "bq27621", BQ27421 },
+	{ "bq27425", BQ27425 },
+	{ "bq27441", BQ27441 },
+	{ "bq27621", BQ27621 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 92df553..90db1cf 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -2,14 +2,25 @@
 #define __LINUX_BQ27X00_BATTERY_H__
 
 enum bq27xxx_chip {
+	/* categories; index for bq27xxx_regs[] */
 	BQ27000 = 1, /* bq27000, bq27200 */
-	BQ27010, /* bq27010, bq27210 */
-	BQ27500, /* bq27500 */
-	BQ27510, /* bq27510, bq27520 */
-	BQ27530, /* bq27530, bq27531 */
-	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
-	BQ27545, /* bq27545 */
-	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
+	BQ27010 = 2, /* bq27010, bq27210 */
+	BQ27500 = 3, /* bq27500 */
+	BQ27510 = 4, /* bq27510, bq27520 */
+	BQ27530 = 5, /* bq27530, bq27531 */
+	BQ27541 = 6, /* bq27541, bq27542, bq27546, bq27742 */
+	BQ27545 = 7, /* bq27545 */
+	BQ27421 = 8, /* bq27421, bq27425, bq27441, bq27621 */
+
+	/* members of categories; translate these to category in _setup() */
+	BQ27520 = 101,
+	BQ27531 = 102,
+	BQ27542 = 103,
+	BQ27546 = 104,
+	BQ27742 = 105,
+	BQ27425 = 106,
+	BQ27441 = 107,
+	BQ27621 = 108,
 };
 
 /**
-- 
2.9.3
