From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: [PATCH 1/3] bq27xxx_battery: add BQ27425 chip id
Date: Sun, 25 Dec 2016 21:44:40 -0800
Message-ID: <20161226054442.23599-2-matt@ranostay.consulting>
References: <20161226054442.23599-1-matt@ranostay.consulting>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161226054442.23599-1-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
---
 drivers/power/supply/bq27xxx_battery.c     | 24 ++++++++++++++++++++++--
 drivers/power/supply/bq27xxx_battery_i2c.c |  2 +-
 include/linux/power/bq27xxx_battery.h      |  3 ++-
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 08c36b8e04bd..721cf6f67874 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -259,6 +259,25 @@ static u8 bq27xxx_regs[][BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_DCAP] = 0x3c,
 		[BQ27XXX_REG_AP] = 0x18,
 	},
+	[BQ27425] = {
+		[BQ27XXX_REG_CTRL] = 0x00,
+		[BQ27XXX_REG_TEMP] = 0x02,
+		[BQ27XXX_REG_INT_TEMP] = 0x1e,
+		[BQ27XXX_REG_VOLT] = 0x04,
+		[BQ27XXX_REG_AI] = 0x10,
+		[BQ27XXX_REG_FLAGS] = 0x06,
+		[BQ27XXX_REG_TTE] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTF] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_NAC] = 0x08,
+		[BQ27XXX_REG_FCC] = 0x0e,
+		[BQ27XXX_REG_CYCT] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_AE] = INVALID_REG_ADDR,
+		[BQ27XXX_REG_SOC] = 0x1c,
+		[BQ27XXX_REG_DCAP] = 0x3c,
+		[BQ27XXX_REG_AP] = 0x18,
+	},
 };
 
 static enum power_supply_property bq27000_battery_props[] = {
@@ -427,6 +446,7 @@ static struct {
 	BQ27XXX_PROP(BQ27541, bq27541_battery_props),
 	BQ27XXX_PROP(BQ27545, bq27545_battery_props),
 	BQ27XXX_PROP(BQ27421, bq27421_battery_props),
+	BQ27XXX_PROP(BQ27425, bq27421_battery_props),
 };
 
 static DEFINE_MUTEX(bq27xxx_list_lock);
@@ -677,7 +697,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
 	if (di->chip == BQ27500 || di->chip == BQ27510 ||
 	    di->chip == BQ27541 || di->chip == BQ27545)
 		return flags & (BQ27XXX_FLAG_OTC | BQ27XXX_FLAG_OTD);
-	if (di->chip == BQ27530 || di->chip == BQ27421)
+	if (di->chip == BQ27530 || di->chip == BQ27421 || di->chip == BQ27425)
 		return flags & BQ27XXX_FLAG_OT;
 
 	return false;
@@ -688,7 +708,7 @@ static bool bq27xxx_battery_overtemp(struct bq27xxx_device_info *di, u16 flags)
  */
 static bool bq27xxx_battery_undertemp(struct bq27xxx_device_info *di, u16 flags)
 {
-	if (di->chip == BQ27530 || di->chip == BQ27421)
+	if (di->chip == BQ27530 || di->chip == BQ27421 || di->chip == BQ27425)
 		return flags & BQ27XXX_FLAG_UT;
 
 	return false;
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 5c5c3a6f9923..27143230839a 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -159,9 +159,9 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ "bq27742", BQ27541 },
 	{ "bq27545", BQ27545 },
 	{ "bq27421", BQ27421 },
-	{ "bq27425", BQ27421 },
 	{ "bq27441", BQ27421 },
 	{ "bq27621", BQ27421 },
+	{ "bq27425", BQ27425 },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index bed9557b69e7..14ecac158150 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -9,7 +9,8 @@ enum bq27xxx_chip {
 	BQ27530, /* bq27530, bq27531 */
 	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
 	BQ27545, /* bq27545 */
-	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
+	BQ27421, /* bq27421, bq27441, bq27621 */
+	BQ27425, /* bq27425 */
 };
 
 /**
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
