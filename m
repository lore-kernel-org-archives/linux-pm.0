From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v5 01/11] power: supply: bq27xxx: rename BQ27500 allow for deprecation in future.
Date: Wed, 11 Jan 2017 12:44:38 +1100
Message-ID: <1484099088-452-2-git-send-email-chris@cpdesign.com.au>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
 <1484099088-452-1-git-send-email-chris@cpdesign.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35323 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932583AbdAKBo6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2017 20:44:58 -0500
Received: by mail-pf0-f193.google.com with SMTP id f144so12396547pfa.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2017 17:44:58 -0800 (PST)
In-Reply-To: <1484099088-452-1-git-send-email-chris@cpdesign.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: pali.rohar@gmail.com, afd@ti.com, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chris Lapa <chris@lapa.com.au>

From: Chris Lapa <chris@lapa.com.au>

The BQ2750X definition exists only to satisfy backwards compatibility.

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 drivers/power/supply/bq27xxx_battery.c     | 8 ++++----
 drivers/power/supply/bq27xxx_battery_i2c.c | 2 +-
 include/linux/power/bq27xxx_battery.h      | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 7272d1e..103ba3b 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -145,7 +145,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_DCAP] = 0x76,
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
 	},
-	[BQ27500] = {
+	[BQ2750X] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
 		[BQ27XXX_REG_INT_TEMP] = 0x28,
@@ -303,7 +303,7 @@ static enum power_supply_property bq27010_battery_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
-static enum power_supply_property bq27500_battery_props[] = {
+static enum power_supply_property bq2750x_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -421,7 +421,7 @@ static struct {
 } bq27xxx_battery_props[] = {
 	BQ27XXX_PROP(BQ27000, bq27000_battery_props),
 	BQ27XXX_PROP(BQ27010, bq27010_battery_props),
-	BQ27XXX_PROP(BQ27500, bq27500_battery_props),
+	BQ27XXX_PROP(BQ2750X, bq2750x_battery_props),
 	BQ27XXX_PROP(BQ27510, bq27510_battery_props),
 	BQ27XXX_PROP(BQ27530, bq27530_battery_props),
 	BQ27XXX_PROP(BQ27541, bq27541_battery_props),
@@ -675,7 +675,7 @@ static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *di)
 static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
 {
 	switch (di->chip) {
-	case BQ27500:
+	case BQ2750X:
 	case BQ27510:
 	case BQ27541:
 	case BQ27545:
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 5c5c3a6..fb1219b 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -148,7 +148,7 @@ static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
 static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27200", BQ27000 },
 	{ "bq27210", BQ27010 },
-	{ "bq27500", BQ27500 },
+	{ "bq27500", BQ2750X },
 	{ "bq27510", BQ27510 },
 	{ "bq27520", BQ27510 },
 	{ "bq27530", BQ27530 },
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index bed9557..4c904d0 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -4,7 +4,7 @@
 enum bq27xxx_chip {
 	BQ27000 = 1, /* bq27000, bq27200 */
 	BQ27010, /* bq27010, bq27210 */
-	BQ27500, /* bq27500 */
+	BQ2750X, /* bq27500 deprecated alias */
 	BQ27510, /* bq27510, bq27520 */
 	BQ27530, /* bq27530, bq27531 */
 	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
-- 
2.1.4

