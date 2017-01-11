From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v5 03/11] power: supply: bq27xxx: adds specific support for bq27500/1 revision.
Date: Wed, 11 Jan 2017 12:44:40 +1100
Message-ID: <1484099088-452-4-git-send-email-chris@cpdesign.com.au>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
 <1484099088-452-1-git-send-email-chris@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484099088-452-1-git-send-email-chris@cpdesign.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, afd@ti.com, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chris Lapa <chris@lapa.com.au>
List-Id: linux-pm@vger.kernel.org

From: Chris Lapa <chris@lapa.com.au>

This commit adds the BQ27500 chip definition to specifically match the
bq27500/1 functionality as described in the datasheet.

Signed-off-by: Chris Lapa <chris@lapa.com.au>
Acked-by: Pali Rohár <pali.rohar@gmail.com>
Reviewed-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/supply/bq27xxx_battery.c     | 42 ++++++++++++++++++++++++++++++
 drivers/power/supply/bq27xxx_battery_i2c.c |  2 ++
 include/linux/power/bq27xxx_battery.h      |  1 +
 3 files changed, 45 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 90a5373..9c9ffe2 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -183,6 +183,25 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_DCAP] = 0x2e,
 		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
 	},
+	[BQ27500] = {
+		[BQ27XXX_REG_CTRL] = 0x00,
+		[BQ27XXX_REG_TEMP] = 0x06,
+		[BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_VOLT] = 0x08,
+		[BQ27XXX_REG_AI] = 0x14,
+		[BQ27XXX_REG_FLAGS] = 0x0a,
+		[BQ27XXX_REG_TTE] = 0x16,
+		[BQ27XXX_REG_TTF] = 0x18,
+		[BQ27XXX_REG_TTES] = 0x1c,
+		[BQ27XXX_REG_TTECP] = 0x26,
+		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_FCC] = 0x12,
+		[BQ27XXX_REG_CYCT] = 0x2a,
+		[BQ27XXX_REG_AE] = 0x22,
+		[BQ27XXX_REG_SOC] = 0x2c,
+		[BQ27XXX_REG_DCAP] = 0x3c,
+		[BQ27XXX_REG_AP] = 0x24,
+	},
 	[BQ27530] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
@@ -339,6 +358,27 @@ static enum power_supply_property bq2751x_battery_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
+static enum power_supply_property bq27500_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
+	POWER_SUPPLY_PROP_ENERGY_NOW,
+	POWER_SUPPLY_PROP_POWER_AVG,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
 static enum power_supply_property bq27530_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -423,6 +463,7 @@ static struct {
 	BQ27XXX_PROP(BQ27010, bq27010_battery_props),
 	BQ27XXX_PROP(BQ2750X, bq2750x_battery_props),
 	BQ27XXX_PROP(BQ2751X, bq2751x_battery_props),
+	BQ27XXX_PROP(BQ27500, bq27500_battery_props),
 	BQ27XXX_PROP(BQ27530, bq27530_battery_props),
 	BQ27XXX_PROP(BQ27541, bq27541_battery_props),
 	BQ27XXX_PROP(BQ27545, bq27545_battery_props),
@@ -677,6 +718,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
 	switch (di->chip) {
 	case BQ2750X:
 	case BQ2751X:
+	case BQ27500:
 	case BQ27541:
 	case BQ27545:
 		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 5f64e70..ce0f01e 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -151,6 +151,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27500", BQ2750X },
 	{ "bq27510", BQ2751X },
 	{ "bq27520", BQ2751X },
+	{ "bq27500-1", BQ27500 },
 	{ "bq27530", BQ27530 },
 	{ "bq27531", BQ27530 },
 	{ "bq27541", BQ27541 },
@@ -173,6 +174,7 @@ static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] = {
 	{ .compatible = "ti,bq27500" },
 	{ .compatible = "ti,bq27510" },
 	{ .compatible = "ti,bq27520" },
+	{ .compatible = "ti,bq27500-1" },
 	{ .compatible = "ti,bq27530" },
 	{ .compatible = "ti,bq27531" },
 	{ .compatible = "ti,bq27541" },
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 651f265..76b623d 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -6,6 +6,7 @@ enum bq27xxx_chip {
 	BQ27010, /* bq27010, bq27210 */
 	BQ2750X, /* bq27500 deprecated alias */
 	BQ2751X, /* bq27510, bq27520 deprecated alias */
+	BQ27500, /* bq27500/1 */
 	BQ27530, /* bq27530, bq27531 */
 	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
 	BQ27545, /* bq27545 */
-- 
2.1.4
