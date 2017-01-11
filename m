From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v5 04/11] power: supply: bq27xxx: adds specific support for bq27510-g1 revision.
Date: Wed, 11 Jan 2017 12:44:41 +1100
Message-ID: <1484099088-452-5-git-send-email-chris@cpdesign.com.au>
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

This commit adds the BQ27510G1 chip definition to specifically match the
bq27510-G1 functionality as described in the datasheet.

Signed-off-by: Chris Lapa <chris@lapa.com.au>
Acked-by: Pali Rohár <pali.rohar@gmail.com>
Reviewed-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/supply/bq27xxx_battery.c     | 43 ++++++++++++++++++++++++++++++
 drivers/power/supply/bq27xxx_battery_i2c.c |  2 ++
 include/linux/power/bq27xxx_battery.h      |  1 +
 3 files changed, 46 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 9c9ffe2..44e8aa0 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -22,6 +22,7 @@
  * http://www.ti.com/product/bq27010
  * http://www.ti.com/product/bq27210
  * http://www.ti.com/product/bq27500
+ * http://www.ti.com/product/bq27510-g1
  * http://www.ti.com/product/bq27510-g3
  * http://www.ti.com/product/bq27520-g4
  * http://www.ti.com/product/bq27530-g1
@@ -202,6 +203,25 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x24,
 	},
+	[BQ27510G1] = {
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
@@ -379,6 +399,27 @@ static enum power_supply_property bq27500_battery_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
+static enum power_supply_property bq27510g1_battery_props[] = {
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
@@ -464,6 +505,7 @@ static struct {
 	BQ27XXX_PROP(BQ2750X, bq2750x_battery_props),
 	BQ27XXX_PROP(BQ2751X, bq2751x_battery_props),
 	BQ27XXX_PROP(BQ27500, bq27500_battery_props),
+	BQ27XXX_PROP(BQ27510G1, bq27510g1_battery_props),
 	BQ27XXX_PROP(BQ27530, bq27530_battery_props),
 	BQ27XXX_PROP(BQ27541, bq27541_battery_props),
 	BQ27XXX_PROP(BQ27545, bq27545_battery_props),
@@ -719,6 +761,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
 	case BQ2750X:
 	case BQ2751X:
 	case BQ27500:
+	case BQ27510G1:
 	case BQ27541:
 	case BQ27545:
 		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index ce0f01e..11e54c1 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -152,6 +152,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27510", BQ2751X },
 	{ "bq27520", BQ2751X },
 	{ "bq27500-1", BQ27500 },
+	{ "bq27510g1", BQ27510G1 },
 	{ "bq27530", BQ27530 },
 	{ "bq27531", BQ27530 },
 	{ "bq27541", BQ27541 },
@@ -175,6 +176,7 @@ static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] = {
 	{ .compatible = "ti,bq27510" },
 	{ .compatible = "ti,bq27520" },
 	{ .compatible = "ti,bq27500-1" },
+	{ .compatible = "ti,bq27510g1" },
 	{ .compatible = "ti,bq27530" },
 	{ .compatible = "ti,bq27531" },
 	{ .compatible = "ti,bq27541" },
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 76b623d..3af0815 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -7,6 +7,7 @@ enum bq27xxx_chip {
 	BQ2750X, /* bq27500 deprecated alias */
 	BQ2751X, /* bq27510, bq27520 deprecated alias */
 	BQ27500, /* bq27500/1 */
+	BQ27510G1, /* bq27510G1 */
 	BQ27530, /* bq27530, bq27531 */
 	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
 	BQ27545, /* bq27545 */
-- 
2.1.4
