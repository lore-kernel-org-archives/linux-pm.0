From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v2 01/11] power: supplies: bq275xx: rename BQ27500 allow for deprecation in future.
Date: Fri, 23 Dec 2016 11:04:57 +1100
Message-ID: <1482451507-37676-2-git-send-email-chris@lapa.com.au>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
 <1482451507-37676-1-git-send-email-chris@lapa.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35033 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757812AbcLWAFR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Dec 2016 19:05:17 -0500
Received: by mail-pg0-f65.google.com with SMTP id i5so12094432pgh.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Dec 2016 16:05:16 -0800 (PST)
In-Reply-To: <1482451507-37676-1-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: pali.rohar@gmail.com, afd@ti.com, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chris Lapa <chris@lapa.com.au>

From: Chris Lapa <chris@lapa.com.au>

The BQ275XX definition exists only to satisfy backwards compatibility.

tested: yes

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 drivers/power/supply/bq27xxx_battery.c     | 8 ++++----
 drivers/power/supply/bq27xxx_battery_i2c.c | 6 +++---
 include/linux/power/bq27xxx_battery.h      | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 3b0dbc6..312f668 100644
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
@@ -284,7 +284,7 @@ static enum power_supply_property bq27010_battery_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
-static enum power_supply_property bq27500_battery_props[] = {
+static enum power_supply_property bq275xx_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -384,7 +384,7 @@ static struct {
 } bq27xxx_battery_props[] = {
 	BQ27XXX_PROP(BQ27000, bq27000_battery_props),
 	BQ27XXX_PROP(BQ27010, bq27010_battery_props),
-	BQ27XXX_PROP(BQ27500, bq27500_battery_props),
+	BQ27XXX_PROP(BQ275XX, bq275xx_battery_props),
 	BQ27XXX_PROP(BQ27530, bq27530_battery_props),
 	BQ27XXX_PROP(BQ27541, bq27541_battery_props),
 	BQ27XXX_PROP(BQ27545, bq27545_battery_props),
@@ -635,7 +635,7 @@ static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *di)
  */
 static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
 {
-	if (di->chip == BQ27500 || di->chip == BQ27541 || di->chip == BQ27545)
+	if (di->chip == BQ275XX || di->chip == BQ27541 || di->chip == BQ27545)
 		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
 	if (di->chip == BQ27530 || di->chip == BQ27421)
 		return flags & BQ27XXX_FLAG_OT;
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 85d4ea2..762d96e 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -148,9 +148,9 @@ static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
 static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27200", BQ27000 },
 	{ "bq27210", BQ27010 },
-	{ "bq27500", BQ27500 },
-	{ "bq27510", BQ27500 },
-	{ "bq27520", BQ27500 },
+	{ "bq27500", BQ275XX },
+	{ "bq27510", BQ275XX },
+	{ "bq27520", BQ275XX },
 	{ "bq27530", BQ27530 },
 	{ "bq27531", BQ27530 },
 	{ "bq27541", BQ27541 },
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index e30deb0..c452b94 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -4,7 +4,7 @@
 enum bq27xxx_chip {
 	BQ27000 = 1, /* bq27000, bq27200 */
 	BQ27010, /* bq27010, bq27210 */
-	BQ27500, /* bq27500, bq27510, bq27520 */
+	BQ275XX, /* bq27500, bq27510, bq27520 deprecated alias */
 	BQ27530, /* bq27530, bq27531 */
 	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
 	BQ27545, /* bq27545 */
-- 
2.1.4

