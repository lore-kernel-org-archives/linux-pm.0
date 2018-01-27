From: Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] power: supply: bq27xxx: Add bq27411 support
Date: Sat, 27 Jan 2018 22:25:36 +0800
Message-ID: <1517063136-23210-1-git-send-email-liu.xiang6@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, sre@kernel.org, pali.rohar@gmail.com, afd@ti.com, Liu Xiang <liu.xiang6@zte.com.cn>
List-Id: linux-pm@vger.kernel.org

According to the datasheet, bq27411 is similar to bq27421.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 drivers/power/supply/bq27xxx_battery.c | 14 ++++++++++++++
 include/linux/power/bq27xxx_battery.h  |  3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 51f0961..2de378a 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -410,6 +410,7 @@ enum bq27xxx_reg_index {
 #define bq27425_regs bq27421_regs
 #define bq27441_regs bq27421_regs
 #define bq27621_regs bq27421_regs
+#define bq27411_regs bq27421_regs
 
 static enum power_supply_property bq27000_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
@@ -633,6 +634,7 @@ enum bq27xxx_reg_index {
 #define bq27425_props bq27421_props
 #define bq27441_props bq27421_props
 #define bq27621_props bq27421_props
+#define bq27411_props bq27421_props
 
 struct bq27xxx_dm_reg {
 	u8 subclass_id;
@@ -716,6 +718,17 @@ enum bq27xxx_dm_reg_id {
 #define bq27621_dm_regs 0
 #endif
 
+#if 0 /* not yet tested */
+static struct bq27xxx_dm_reg bq27411_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0, 32767 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 16, 2, 2800,  3700 },
+};
+#else
+#define bq27411_dm_regs 0
+#endif
+
+
 #define BQ27XXX_O_ZERO	0x00000001
 #define BQ27XXX_O_OTDC	0x00000002
 #define BQ27XXX_O_UTOT  0x00000004
@@ -762,6 +775,7 @@ enum bq27xxx_dm_reg_id {
 	[BQ27425]   = BQ27XXX_DATA(bq27425,   0x04143672, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP),
 	[BQ27441]   = BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27621]   = BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
+	[BQ27411]   = BQ27XXX_DATA(bq27411,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 };
 
 static DEFINE_MUTEX(bq27xxx_list_lock);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index e6187f5..5f48eb0 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -23,10 +23,11 @@ enum bq27xxx_chip {
 	BQ27546,
 	BQ27742,
 	BQ27545, /* bq27545 */
-	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
+	BQ27421, /* bq27421, bq27425, bq27441, bq27621, bq27411 */
 	BQ27425,
 	BQ27441,
 	BQ27621,
+	BQ27411,
 };
 
 struct bq27xxx_device_info;
-- 
1.9.1
