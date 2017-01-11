From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v5 10/11] power: supply: bq27xxx: adds specific support for bq27520-g4 revision.
Date: Wed, 11 Jan 2017 12:44:47 +1100
Message-ID: <1484099088-452-11-git-send-email-chris@cpdesign.com.au>
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

This commit adds the BQ27520G4 chip definition to specifically match the
bq27520-G4 functionality as described in the datasheet.

Signed-off-by: Chris Lapa <chris@lapa.com.au>
Acked-by: Pali Rohár <pali.rohar@gmail.com>
Reviewed-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/supply/bq27xxx_battery.c     | 39 ++++++++++++++++++++++++++++++
 drivers/power/supply/bq27xxx_battery_i2c.c |  2 ++
 include/linux/power/bq27xxx_battery.h      |  1 +
 3 files changed, 42 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 1fe48ea..398801a 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -29,6 +29,7 @@
  * http://www.ti.com/product/bq27520-g1
  * http://www.ti.com/product/bq27520-g2
  * http://www.ti.com/product/bq27520-g3
+ * http://www.ti.com/product/bq27520-g4
  * http://www.ti.com/product/bq27530-g1
  * http://www.ti.com/product/bq27531-g1
  * http://www.ti.com/product/bq27541-g1
@@ -321,6 +322,25 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x24,
 	},
+	[BQ27520G4] = {
+		[BQ27XXX_REG_CTRL] = 0x00,
+		[BQ27XXX_REG_TEMP] = 0x06,
+		[BQ27XXX_REG_INT_TEMP] = 0x28,
+		[BQ27XXX_REG_VOLT] = 0x08,
+		[BQ27XXX_REG_AI] = 0x14,
+		[BQ27XXX_REG_FLAGS] = 0x0a,
+		[BQ27XXX_REG_TTE] = 0x16,
+		[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTES] = 0x1c,
+		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_NAC] = 0x0c,
+		[BQ27XXX_REG_FCC] = 0x12,
+		[BQ27XXX_REG_CYCT] = 0x1e,
+		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_SOC] = 0x20,
+		[BQ27XXX_REG_DCAP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_AP] = INVALID_REG_ADDR,
+	},
 	[BQ27530] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x06,
@@ -619,6 +639,23 @@ static enum power_supply_property bq27520g3_battery_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
+static enum power_supply_property bq27520g4_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
 static enum power_supply_property bq27530_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -710,6 +747,7 @@ static struct {
 	BQ27XXX_PROP(BQ27520G1, bq27520g1_battery_props),
 	BQ27XXX_PROP(BQ27520G2, bq27520g2_battery_props),
 	BQ27XXX_PROP(BQ27520G3, bq27520g3_battery_props),
+	BQ27XXX_PROP(BQ27520G4, bq27520g4_battery_props),
 	BQ27XXX_PROP(BQ27530, bq27530_battery_props),
 	BQ27XXX_PROP(BQ27541, bq27541_battery_props),
 	BQ27XXX_PROP(BQ27545, bq27545_battery_props),
@@ -971,6 +1009,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
 	case BQ27520G1:
 	case BQ27520G2:
 	case BQ27520G3:
+	case BQ27520G4:
 	case BQ27541:
 	case BQ27545:
 		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 3712cd9..c68fbc3 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -158,6 +158,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27520g1", BQ27520G1 },
 	{ "bq27520g2", BQ27520G2 },
 	{ "bq27520g3", BQ27520G3 },
+	{ "bq27520g4", BQ27520G4 },
 	{ "bq27530", BQ27530 },
 	{ "bq27531", BQ27530 },
 	{ "bq27541", BQ27541 },
@@ -187,6 +188,7 @@ static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] = {
 	{ .compatible = "ti,bq27520g1" },
 	{ .compatible = "ti,bq27520g2" },
 	{ .compatible = "ti,bq27520g3" },
+	{ .compatible = "ti,bq27520g4" },
 	{ .compatible = "ti,bq27530" },
 	{ .compatible = "ti,bq27531" },
 	{ .compatible = "ti,bq27541" },
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 5c12717..b312bce 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -13,6 +13,7 @@ enum bq27xxx_chip {
 	BQ27520G1, /* bq27520G1 */
 	BQ27520G2, /* bq27520G2 */
 	BQ27520G3, /* bq27520G3 */
+	BQ27520G4, /* bq27520G4 */
 	BQ27530, /* bq27530, bq27531 */
 	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
 	BQ27545, /* bq27545 */
-- 
2.1.4
