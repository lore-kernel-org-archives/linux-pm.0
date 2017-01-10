From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v4 01/10] power: supplies: bq27xxx: rename BQ27500 allow for deprecation in future.
Date: Tue, 10 Jan 2017 16:25:29 +1100
Message-ID: <1484025938-114133-2-git-send-email-chris@lapa.com.au>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
 <1484025938-114133-1-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34975 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938486AbdAJFZu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2017 00:25:50 -0500
Received: by mail-pf0-f193.google.com with SMTP id f144so8123755pfa.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2017 21:25:50 -0800 (PST)
In-Reply-To: <1484025938-114133-1-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: pali.rohar@gmail.com, afd@ti.com, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chris Lapa <chris@lapa.com.au>

From: Chris Lapa <chris@lapa.com.au>

The BQ275XX definition exists only to satisfy backwards compatibility.

tested: yes

Signed-off-by: Chris Lapa <chris@lapa.com.au>
Acked-by: Pali Rohár <pali.rohar@gmail.com>
Reviewed-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/supply/bq27xxx_battery.c     | 10 ++++------
 drivers/power/supply/bq27xxx_battery_i2c.c |  6 +++---
 include/linux/power/bq27xxx_battery.h      |  3 +--
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 7272d1e..a86417c 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -145,7 +145,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_DCAP] = 0x76,
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
 	},
-	[BQ27500] = {
+	[BQ275XX] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
 		[BQ27XXX_REG_INT_TEMP] = 0x28,
@@ -303,7 +303,7 @@ static enum power_supply_property bq27010_battery_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
-static enum power_supply_property bq27500_battery_props[] = {
+static enum power_supply_property bq275xx_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -421,8 +421,7 @@ static struct {
 } bq27xxx_battery_props[] = {
 	BQ27XXX_PROP(BQ27000, bq27000_battery_props),
 	BQ27XXX_PROP(BQ27010, bq27010_battery_props),
-	BQ27XXX_PROP(BQ27500, bq27500_battery_props),
-	BQ27XXX_PROP(BQ27510, bq27510_battery_props),
+	BQ27XXX_PROP(BQ275XX, bq275xx_battery_props),
 	BQ27XXX_PROP(BQ27530, bq27530_battery_props),
 	BQ27XXX_PROP(BQ27541, bq27541_battery_props),
 	BQ27XXX_PROP(BQ27545, bq27545_battery_props),
@@ -675,8 +674,7 @@ static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *di)
 static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
 {
 	switch (di->chip) {
-	case BQ27500:
-	case BQ27510:
+	case BQ275XX:
 	case BQ27541:
 	case BQ27545:
 		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 5c5c3a6..762d96e 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -148,9 +148,9 @@ static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
 static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27200", BQ27000 },
 	{ "bq27210", BQ27010 },
-	{ "bq27500", BQ27500 },
-	{ "bq27510", BQ27510 },
-	{ "bq27520", BQ27510 },
+	{ "bq27500", BQ275XX },
+	{ "bq27510", BQ275XX },
+	{ "bq27520", BQ275XX },
 	{ "bq27530", BQ27530 },
 	{ "bq27531", BQ27530 },
 	{ "bq27541", BQ27541 },
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index bed9557..c452b94 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -4,8 +4,7 @@
 enum bq27xxx_chip {
 	BQ27000 = 1, /* bq27000, bq27200 */
 	BQ27010, /* bq27010, bq27210 */
-	BQ27500, /* bq27500 */
-	BQ27510, /* bq27510, bq27520 */
+	BQ275XX, /* bq27500, bq27510, bq27520 deprecated alias */
 	BQ27530, /* bq27530, bq27531 */
 	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
 	BQ27545, /* bq27545 */
-- 
2.1.4

