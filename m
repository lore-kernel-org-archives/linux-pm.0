From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v5 02/11] power: supply: bq27xxx: rename BQ27510 allow for deprecation in future.
Date: Wed, 11 Jan 2017 12:44:39 +1100
Message-ID: <1484099088-452-3-git-send-email-chris@cpdesign.com.au>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
 <1484099088-452-1-git-send-email-chris@cpdesign.com.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484099088-452-1-git-send-email-chris@cpdesign.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, afd@ti.com, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chris Lapa <chris@lapa.com.au>
List-Id: linux-pm@vger.kernel.org

From: Chris Lapa <chris@lapa.com.au>

The BQ2751X definition exists only to satisfy backwards compatibility.

Signed-off-by: Chris Lapa <chris@lapa.com.au>
---
 drivers/power/supply/bq27xxx_battery.c     | 8 ++++----
 drivers/power/supply/bq27xxx_battery_i2c.c | 4 ++--
 include/linux/power/bq27xxx_battery.h      | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 103ba3b..90a5373 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -164,7 +164,7 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
 	},
-	[BQ27510] = {
+	[BQ2751X] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
 		[BQ27XXX_REG_INT_TEMP] = 0x28,
@@ -321,7 +321,7 @@ static enum power_supply_property bq2750x_battery_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
-static enum power_supply_property bq27510_battery_props[] = {
+static enum power_supply_property bq2751x_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
@@ -422,7 +422,7 @@ static struct {
 	BQ27XXX_PROP(BQ27000, bq27000_battery_props),
 	BQ27XXX_PROP(BQ27010, bq27010_battery_props),
 	BQ27XXX_PROP(BQ2750X, bq2750x_battery_props),
-	BQ27XXX_PROP(BQ27510, bq27510_battery_props),
+	BQ27XXX_PROP(BQ2751X, bq2751x_battery_props),
 	BQ27XXX_PROP(BQ27530, bq27530_battery_props),
 	BQ27XXX_PROP(BQ27541, bq27541_battery_props),
 	BQ27XXX_PROP(BQ27545, bq27545_battery_props),
@@ -676,7 +676,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
 {
 	switch (di->chip) {
 	case BQ2750X:
-	case BQ27510:
+	case BQ2751X:
 	case BQ27541:
 	case BQ27545:
 		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index fb1219b..5f64e70 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -149,8 +149,8 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27200", BQ27000 },
 	{ "bq27210", BQ27010 },
 	{ "bq27500", BQ2750X },
-	{ "bq27510", BQ27510 },
-	{ "bq27520", BQ27510 },
+	{ "bq27510", BQ2751X },
+	{ "bq27520", BQ2751X },
 	{ "bq27530", BQ27530 },
 	{ "bq27531", BQ27530 },
 	{ "bq27541", BQ27541 },
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 4c904d0..651f265 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -5,7 +5,7 @@ enum bq27xxx_chip {
 	BQ27000 = 1, /* bq27000, bq27200 */
 	BQ27010, /* bq27010, bq27210 */
 	BQ2750X, /* bq27500 deprecated alias */
-	BQ27510, /* bq27510, bq27520 */
+	BQ2751X, /* bq27510, bq27520 deprecated alias */
 	BQ27530, /* bq27530, bq27531 */
 	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
 	BQ27545, /* bq27545 */
-- 
2.1.4
