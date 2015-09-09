From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH v2 12/13] power: bq24257: Renaming for consistency
Date: Tue, 8 Sep 2015 19:12:36 -0500
Message-ID: <1441757557-7266-13-git-send-email-dannenberg@ti.com>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53500 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314AbbIIAOU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Sep 2015 20:14:20 -0400
In-Reply-To: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

Rename files and refactor definitions, function names, etc as well as
the driver name itself to reflect that this driver supports multiple
devices and not just the bq24257.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 drivers/power/Kconfig                              |   2 +-
 drivers/power/Makefile                             |   2 +-
 .../power/{bq24257_charger.c => bq2425x_charger.c} | 532 ++++++++++-----------
 .../power/{bq24257_charger.h => bq2425x_charger.h} |   8 +-
 4 files changed, 272 insertions(+), 272 deletions(-)
 rename drivers/power/{bq24257_charger.c => bq2425x_charger.c} (64%)
 rename include/linux/power/{bq24257_charger.h => bq2425x_charger.h} (85%)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index fa9b1d1..07112b1 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -395,7 +395,7 @@ config CHARGER_BQ24190
 	help
 	  Say Y to enable support for the TI BQ24190 battery charger.
 
-config CHARGER_BQ24257
+config CHARGER_BQ2425X
 	tristate "TI BQ2425x battery charger driver"
 	depends on I2C && GPIOLIB
 	depends on REGMAP_I2C
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index 5752ce8..4aa9048 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -59,7 +59,7 @@ obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
 obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
 obj-$(CONFIG_CHARGER_BQ2415X)	+= bq2415x_charger.o
 obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
-obj-$(CONFIG_CHARGER_BQ24257)	+= bq24257_charger.o
+obj-$(CONFIG_CHARGER_BQ2425X)	+= bq2425x_charger.o
 obj-$(CONFIG_CHARGER_BQ24735)	+= bq24735-charger.o
 obj-$(CONFIG_CHARGER_BQ25890)	+= bq25890_charger.o
 obj-$(CONFIG_POWER_AVS)		+= avs/
diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq2425x_charger.c
similarity index 64%
rename from drivers/power/bq24257_charger.c
rename to drivers/power/bq2425x_charger.c
index b5e82ed..3bf30d4 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq2425x_charger.c
@@ -1,5 +1,5 @@
 /*
- * TI BQ24257 charger driver
+ * TI BQ2425x charger driver
  *
  * Copyright (C) 2015 Intel Corporation
  *
@@ -32,21 +32,21 @@
 #include <linux/acpi.h>
 #include <linux/of.h>
 
-#include <linux/power/bq24257_charger.h>
+#include <linux/power/bq2425x_charger.h>
 
-#define BQ24257_REG_1			0x00
-#define BQ24257_REG_2			0x01
-#define BQ24257_REG_3			0x02
-#define BQ24257_REG_4			0x03
-#define BQ24257_REG_5			0x04
-#define BQ24257_REG_6			0x05
-#define BQ24257_REG_7			0x06
+#define BQ2425X_REG_1			0x00
+#define BQ2425X_REG_2			0x01
+#define BQ2425X_REG_3			0x02
+#define BQ2425X_REG_4			0x03
+#define BQ2425X_REG_5			0x04
+#define BQ2425X_REG_6			0x05
+#define BQ2425X_REG_7			0x06
 
-#define BQ24257_MANUFACTURER		"Texas Instruments"
-#define BQ24257_STAT_IRQ		"stat"
-#define BQ24257_PG_GPIO			"pg"
+#define BQ2425X_MANUFACTURER		"Texas Instruments"
+#define BQ2425X_STAT_IRQ		"stat"
+#define BQ2425X_PG_GPIO			"pg"
 
-#define BQ24257_ILIM_SET_DELAY		1000	/* msec */
+#define BQ2425X_ILIM_SET_DELAY		1000	/* msec */
 
 enum bq2425x_chip {
 	BQ24250,
@@ -60,7 +60,7 @@ static const char *bq2425x_chip_name[] = {
 	"bq24257",
 };
 
-enum bq24257_fields {
+enum bq2425x_fields {
 	F_WD_FAULT, F_WD_EN, F_STAT, F_FAULT,			    /* REG 1 */
 	F_RESET, F_IILIMIT, F_EN_STAT, F_EN_TERM, F_CE, F_HZ_MODE,  /* REG 2 */
 	F_VBAT, F_USB_DET,					    /* REG 3 */
@@ -73,7 +73,7 @@ enum bq24257_fields {
 };
 
 /* initial field values, converted from uV/uA */
-struct bq24257_init_data {
+struct bq2425x_init_data {
 	u8 ichg;	/* charge current      */
 	u8 vbat;	/* regulation voltage  */
 	u8 iterm;	/* termination current */
@@ -83,13 +83,13 @@ struct bq24257_init_data {
 	bool timer2x_enable;	/* slow down safety timer by 2x */
 };
 
-struct bq24257_state {
+struct bq2425x_state {
 	u8 status;
 	u8 fault;
 	bool power_good;
 };
 
-struct bq24257_device {
+struct bq2425x_device {
 	struct i2c_client *client;
 	struct device *dev;
 	struct power_supply *charger;
@@ -103,8 +103,8 @@ struct bq24257_device {
 
 	struct delayed_work iilimit_setup_work;
 
-	struct bq24257_init_data init_data;
-	struct bq24257_state state;
+	struct bq2425x_init_data init_data;
+	struct bq2425x_state state;
 
 	struct mutex lock; /* protect device access and state data */
 
@@ -112,11 +112,11 @@ struct bq24257_device {
 	bool pg_gpio_disable;
 };
 
-static bool bq24257_is_volatile_reg(struct device *dev, unsigned int reg)
+static bool bq2425x_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case BQ24257_REG_2:
-	case BQ24257_REG_4:
+	case BQ2425X_REG_2:
+	case BQ2425X_REG_4:
 		return false;
 
 	default:
@@ -124,55 +124,55 @@ static bool bq24257_is_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static const struct regmap_config bq24257_regmap_config = {
+static const struct regmap_config bq2425x_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
-	.max_register = BQ24257_REG_7,
+	.max_register = BQ2425X_REG_7,
 	.cache_type = REGCACHE_RBTREE,
 
-	.volatile_reg = bq24257_is_volatile_reg,
+	.volatile_reg = bq2425x_is_volatile_reg,
 };
 
-static const struct reg_field bq24257_reg_fields[] = {
+static const struct reg_field bq2425x_reg_fields[] = {
 	/* REG 1 */
-	[F_WD_FAULT]		= REG_FIELD(BQ24257_REG_1, 7, 7),
-	[F_WD_EN]		= REG_FIELD(BQ24257_REG_1, 6, 6),
-	[F_STAT]		= REG_FIELD(BQ24257_REG_1, 4, 5),
-	[F_FAULT]		= REG_FIELD(BQ24257_REG_1, 0, 3),
+	[F_WD_FAULT]		= REG_FIELD(BQ2425X_REG_1, 7, 7),
+	[F_WD_EN]		= REG_FIELD(BQ2425X_REG_1, 6, 6),
+	[F_STAT]		= REG_FIELD(BQ2425X_REG_1, 4, 5),
+	[F_FAULT]		= REG_FIELD(BQ2425X_REG_1, 0, 3),
 	/* REG 2 */
-	[F_RESET]		= REG_FIELD(BQ24257_REG_2, 7, 7),
-	[F_IILIMIT]		= REG_FIELD(BQ24257_REG_2, 4, 6),
-	[F_EN_STAT]		= REG_FIELD(BQ24257_REG_2, 3, 3),
-	[F_EN_TERM]		= REG_FIELD(BQ24257_REG_2, 2, 2),
-	[F_CE]			= REG_FIELD(BQ24257_REG_2, 1, 1),
-	[F_HZ_MODE]		= REG_FIELD(BQ24257_REG_2, 0, 0),
+	[F_RESET]		= REG_FIELD(BQ2425X_REG_2, 7, 7),
+	[F_IILIMIT]		= REG_FIELD(BQ2425X_REG_2, 4, 6),
+	[F_EN_STAT]		= REG_FIELD(BQ2425X_REG_2, 3, 3),
+	[F_EN_TERM]		= REG_FIELD(BQ2425X_REG_2, 2, 2),
+	[F_CE]			= REG_FIELD(BQ2425X_REG_2, 1, 1),
+	[F_HZ_MODE]		= REG_FIELD(BQ2425X_REG_2, 0, 0),
 	/* REG 3 */
-	[F_VBAT]		= REG_FIELD(BQ24257_REG_3, 2, 7),
-	[F_USB_DET]		= REG_FIELD(BQ24257_REG_3, 0, 1),
+	[F_VBAT]		= REG_FIELD(BQ2425X_REG_3, 2, 7),
+	[F_USB_DET]		= REG_FIELD(BQ2425X_REG_3, 0, 1),
 	/* REG 4 */
-	[F_ICHG]		= REG_FIELD(BQ24257_REG_4, 3, 7),
-	[F_ITERM]		= REG_FIELD(BQ24257_REG_4, 0, 2),
+	[F_ICHG]		= REG_FIELD(BQ2425X_REG_4, 3, 7),
+	[F_ITERM]		= REG_FIELD(BQ2425X_REG_4, 0, 2),
 	/* REG 5 */
-	[F_LOOP_STATUS]		= REG_FIELD(BQ24257_REG_5, 6, 7),
-	[F_LOW_CHG]		= REG_FIELD(BQ24257_REG_5, 5, 5),
-	[F_DPDM_EN]		= REG_FIELD(BQ24257_REG_5, 4, 4),
-	[F_CE_STATUS]		= REG_FIELD(BQ24257_REG_5, 3, 3),
-	[F_VINDPM]		= REG_FIELD(BQ24257_REG_5, 0, 2),
+	[F_LOOP_STATUS]		= REG_FIELD(BQ2425X_REG_5, 6, 7),
+	[F_LOW_CHG]		= REG_FIELD(BQ2425X_REG_5, 5, 5),
+	[F_DPDM_EN]		= REG_FIELD(BQ2425X_REG_5, 4, 4),
+	[F_CE_STATUS]		= REG_FIELD(BQ2425X_REG_5, 3, 3),
+	[F_VINDPM]		= REG_FIELD(BQ2425X_REG_5, 0, 2),
 	/* REG 6 */
-	[F_X2_TMR_EN]		= REG_FIELD(BQ24257_REG_6, 7, 7),
-	[F_TMR]			= REG_FIELD(BQ24257_REG_6, 5, 6),
-	[F_SYSOFF]		= REG_FIELD(BQ24257_REG_6, 4, 4),
-	[F_TS_EN]		= REG_FIELD(BQ24257_REG_6, 3, 3),
-	[F_TS_STAT]		= REG_FIELD(BQ24257_REG_6, 0, 2),
+	[F_X2_TMR_EN]		= REG_FIELD(BQ2425X_REG_6, 7, 7),
+	[F_TMR]			= REG_FIELD(BQ2425X_REG_6, 5, 6),
+	[F_SYSOFF]		= REG_FIELD(BQ2425X_REG_6, 4, 4),
+	[F_TS_EN]		= REG_FIELD(BQ2425X_REG_6, 3, 3),
+	[F_TS_STAT]		= REG_FIELD(BQ2425X_REG_6, 0, 2),
 	/* REG 7 */
-	[F_VOVP]		= REG_FIELD(BQ24257_REG_7, 5, 7),
-	[F_CLR_VDP]		= REG_FIELD(BQ24257_REG_7, 4, 4),
-	[F_FORCE_BATDET]	= REG_FIELD(BQ24257_REG_7, 3, 3),
-	[F_FORCE_PTM]		= REG_FIELD(BQ24257_REG_7, 2, 2)
+	[F_VOVP]		= REG_FIELD(BQ2425X_REG_7, 5, 7),
+	[F_CLR_VDP]		= REG_FIELD(BQ2425X_REG_7, 4, 4),
+	[F_FORCE_BATDET]	= REG_FIELD(BQ2425X_REG_7, 3, 3),
+	[F_FORCE_PTM]		= REG_FIELD(BQ2425X_REG_7, 2, 2)
 };
 
-static const u32 bq24257_vbat_map[] = {
+static const u32 bq2425x_vbat_map[] = {
 	3500000, 3520000, 3540000, 3560000, 3580000, 3600000, 3620000, 3640000,
 	3660000, 3680000, 3700000, 3720000, 3740000, 3760000, 3780000, 3800000,
 	3820000, 3840000, 3860000, 3880000, 3900000, 3920000, 3940000, 3960000,
@@ -181,45 +181,45 @@ static const u32 bq24257_vbat_map[] = {
 	4300000, 4320000, 4340000, 4360000, 4380000, 4400000, 4420000, 4440000
 };
 
-#define BQ24257_VBAT_MAP_SIZE		ARRAY_SIZE(bq24257_vbat_map)
+#define BQ2425X_VBAT_MAP_SIZE		ARRAY_SIZE(bq2425x_vbat_map)
 
-static const u32 bq24257_ichg_map[] = {
+static const u32 bq2425x_ichg_map[] = {
 	500000, 550000, 600000, 650000, 700000, 750000, 800000, 850000, 900000,
 	950000, 1000000, 1050000, 1100000, 1150000, 1200000, 1250000, 1300000,
 	1350000, 1400000, 1450000, 1500000, 1550000, 1600000, 1650000, 1700000,
 	1750000, 1800000, 1850000, 1900000, 1950000, 2000000
 };
 
-#define BQ24257_ICHG_MAP_SIZE		ARRAY_SIZE(bq24257_ichg_map)
+#define BQ2425X_ICHG_MAP_SIZE		ARRAY_SIZE(bq2425x_ichg_map)
 
-static const u32 bq24257_iterm_map[] = {
+static const u32 bq2425x_iterm_map[] = {
 	50000, 75000, 100000, 125000, 150000, 175000, 200000, 225000
 };
 
-#define BQ24257_ITERM_MAP_SIZE		ARRAY_SIZE(bq24257_iterm_map)
+#define BQ2425X_ITERM_MAP_SIZE		ARRAY_SIZE(bq2425x_iterm_map)
 
-static const u32 bq24257_iilimit_map[] = {
+static const u32 bq2425x_iilimit_map[] = {
 	100000, 150000, 500000, 900000, 1500000, 2000000
 };
 
-#define BQ24257_IILIMIT_MAP_SIZE	ARRAY_SIZE(bq24257_iilimit_map)
+#define BQ2425X_IILIMIT_MAP_SIZE	ARRAY_SIZE(bq2425x_iilimit_map)
 
-static const u32 bq24257_vovp_map[] = {
+static const u32 bq2425x_vovp_map[] = {
 	6000000, 6500000, 7000000, 8000000, 9000000, 9500000, 10000000,
 	10500000
 };
 
-#define BQ24257_VOVP_MAP_SIZE		ARRAY_SIZE(bq24257_vovp_map)
+#define BQ2425X_VOVP_MAP_SIZE		ARRAY_SIZE(bq2425x_vovp_map)
 
-static const u32 bq24257_vindpm_map[] = {
+static const u32 bq2425x_vindpm_map[] = {
 	4200000, 4280000, 4360000, 4440000, 4520000, 4600000, 4680000,
 	4760000
 };
 
-#define BQ24257_VINDPM_MAP_SIZE		ARRAY_SIZE(bq24257_vindpm_map)
+#define BQ2425X_VINDPM_MAP_SIZE		ARRAY_SIZE(bq2425x_vindpm_map)
 
-static int bq24257_field_read(struct bq24257_device *bq,
-			      enum bq24257_fields field_id)
+static int bq2425x_field_read(struct bq2425x_device *bq,
+			      enum bq2425x_fields field_id)
 {
 	int ret;
 	int val;
@@ -231,13 +231,13 @@ static int bq24257_field_read(struct bq24257_device *bq,
 	return val;
 }
 
-static int bq24257_field_write(struct bq24257_device *bq,
-			       enum bq24257_fields field_id, u8 val)
+static int bq2425x_field_write(struct bq2425x_device *bq,
+			       enum bq2425x_fields field_id, u8 val)
 {
 	return regmap_field_write(bq->rmap_fields[field_id], val);
 }
 
-static u8 bq24257_find_idx(u32 value, const u32 *map, u8 map_size)
+static u8 bq2425x_find_idx(u32 value, const u32 *map, u8 map_size)
 {
 	u8 idx;
 
@@ -248,14 +248,14 @@ static u8 bq24257_find_idx(u32 value, const u32 *map, u8 map_size)
 	return idx - 1;
 }
 
-enum bq24257_status {
+enum bq2425x_status {
 	STATUS_READY,
 	STATUS_CHARGE_IN_PROGRESS,
 	STATUS_CHARGE_DONE,
 	STATUS_FAULT,
 };
 
-enum bq24257_fault {
+enum bq2425x_fault {
 	FAULT_NORMAL,
 	FAULT_INPUT_OVP,
 	FAULT_INPUT_UVLO,
@@ -269,12 +269,12 @@ enum bq24257_fault {
 	FAULT_INPUT_LDO_LOW,
 };
 
-static int bq24257_get_charge_type(struct bq24257_device *bq,
+static int bq2425x_get_charge_type(struct bq2425x_device *bq,
 		union power_supply_propval *val)
 {
 	int ret;
 
-	ret = bq24257_field_read(bq, F_CE);
+	ret = bq2425x_field_read(bq, F_CE);
 	if (ret < 0)
 		return ret;
 
@@ -285,7 +285,7 @@ static int bq24257_get_charge_type(struct bq24257_device *bq,
 	}
 
 	/* Low Charge means a fixed low-current is used instead of i_chg */
-	ret = bq24257_field_read(bq, F_LOW_CHG);
+	ret = bq2425x_field_read(bq, F_LOW_CHG);
 	if (ret < 0)
 		return ret;
 
@@ -295,19 +295,19 @@ static int bq24257_get_charge_type(struct bq24257_device *bq,
 	return 0;
 }
 
-static int bq24257_set_charge_type(struct bq24257_device *bq,
+static int bq2425x_set_charge_type(struct bq2425x_device *bq,
 		const union power_supply_propval *val)
 {
 	int ret;
 
 	switch (val->intval) {
 	case POWER_SUPPLY_CHARGE_TYPE_NONE:
-		return bq24257_field_write(bq, F_CE, 1);
+		return bq2425x_field_write(bq, F_CE, 1);
 	case POWER_SUPPLY_CHARGE_TYPE_TRICKLE:
-		ret = bq24257_field_write(bq, F_LOW_CHG, 1);
+		ret = bq2425x_field_write(bq, F_LOW_CHG, 1);
 		break;
 	case POWER_SUPPLY_CHARGE_TYPE_FAST:
-		ret = bq24257_field_write(bq, F_LOW_CHG, 0);
+		ret = bq2425x_field_write(bq, F_LOW_CHG, 0);
 		break;
 	default:
 		return -EINVAL;
@@ -316,15 +316,15 @@ static int bq24257_set_charge_type(struct bq24257_device *bq,
 	if (ret < 0)
 		return ret;
 
-	return bq24257_field_write(bq, F_CE, 0);
+	return bq2425x_field_write(bq, F_CE, 0);
 }
 
-static int bq24257_get_input_current_limit(struct bq24257_device *bq,
+static int bq2425x_get_input_current_limit(struct bq2425x_device *bq,
 		union power_supply_propval *val)
 {
 	int ret;
 
-	ret = bq24257_field_read(bq, F_IILIMIT);
+	ret = bq2425x_field_read(bq, F_IILIMIT);
 	if (ret < 0)
 		return ret;
 
@@ -335,31 +335,31 @@ static int bq24257_get_input_current_limit(struct bq24257_device *bq,
 	 * than exceeding the bounds of the lookup table and returning
 	 * garbage.
 	 */
-	if (ret >= BQ24257_IILIMIT_MAP_SIZE)
+	if (ret >= BQ2425X_IILIMIT_MAP_SIZE)
 		return -ENODATA;
 
-	val->intval = bq24257_iilimit_map[ret];
+	val->intval = bq2425x_iilimit_map[ret];
 
 	return 0;
 }
 
-static int bq24257_set_input_current_limit(struct bq24257_device *bq,
+static int bq2425x_set_input_current_limit(struct bq2425x_device *bq,
 		const union power_supply_propval *val)
 {
 	if (!bq->in_ilimit_autoset_disable)
 		return -EPERM;
 
-	return bq24257_field_write(bq, F_IILIMIT, bq24257_find_idx(
-			val->intval, bq24257_iilimit_map,
-			BQ24257_IILIMIT_MAP_SIZE));
+	return bq2425x_field_write(bq, F_IILIMIT, bq2425x_find_idx(
+			val->intval, bq2425x_iilimit_map,
+			BQ2425X_IILIMIT_MAP_SIZE));
 }
 
-static int bq24257_power_supply_get_property(struct power_supply *psy,
+static int bq2425x_power_supply_get_property(struct power_supply *psy,
 					     enum power_supply_property psp,
 					     union power_supply_propval *val)
 {
-	struct bq24257_device *bq = power_supply_get_drvdata(psy);
-	struct bq24257_state state;
+	struct bq2425x_device *bq = power_supply_get_drvdata(psy);
+	struct bq2425x_state state;
 	int ret = 0;
 
 	mutex_lock(&bq->lock);
@@ -380,11 +380,11 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
-		ret = bq24257_get_charge_type(bq, val);
+		ret = bq2425x_get_charge_type(bq, val);
 		break;
 
 	case POWER_SUPPLY_PROP_MANUFACTURER:
-		val->strval = BQ24257_MANUFACTURER;
+		val->strval = BQ2425X_MANUFACTURER;
 		break;
 
 	case POWER_SUPPLY_PROP_MODEL_NAME:
@@ -423,27 +423,27 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
-		val->intval = bq24257_ichg_map[bq->init_data.ichg];
+		val->intval = bq2425x_ichg_map[bq->init_data.ichg];
 		break;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
-		val->intval = bq24257_ichg_map[BQ24257_ICHG_MAP_SIZE - 1];
+		val->intval = bq2425x_ichg_map[BQ2425X_ICHG_MAP_SIZE - 1];
 		break;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
-		val->intval = bq24257_vbat_map[bq->init_data.vbat];
+		val->intval = bq2425x_vbat_map[bq->init_data.vbat];
 		break;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
-		val->intval = bq24257_vbat_map[BQ24257_VBAT_MAP_SIZE - 1];
+		val->intval = bq2425x_vbat_map[BQ2425X_VBAT_MAP_SIZE - 1];
 		break;
 
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
-		val->intval = bq24257_iterm_map[bq->init_data.iterm];
+		val->intval = bq2425x_iterm_map[bq->init_data.iterm];
 		break;
 
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
-		ret = bq24257_get_input_current_limit(bq, val);
+		ret = bq2425x_get_input_current_limit(bq, val);
 		break;
 
 	default:
@@ -455,21 +455,21 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
 	return ret;
 }
 
-static int bq24257_power_supply_set_property(struct power_supply *psy,
+static int bq2425x_power_supply_set_property(struct power_supply *psy,
 		enum power_supply_property prop,
 		const union power_supply_propval *val)
 {
-	struct bq24257_device *bq = power_supply_get_drvdata(psy);
+	struct bq2425x_device *bq = power_supply_get_drvdata(psy);
 	int ret;
 
 	mutex_lock(&bq->lock);
 
 	switch (prop) {
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
-		ret = bq24257_set_charge_type(bq, val);
+		ret = bq2425x_set_charge_type(bq, val);
 		break;
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
-		ret = bq24257_set_input_current_limit(bq, val);
+		ret = bq2425x_set_input_current_limit(bq, val);
 		break;
 	default:
 		ret = -EINVAL;
@@ -480,7 +480,7 @@ static int bq24257_power_supply_set_property(struct power_supply *psy,
 	return ret;
 }
 
-static int bq24257_power_supply_property_is_writeable(struct power_supply *psy,
+static int bq2425x_power_supply_property_is_writeable(struct power_supply *psy,
 		enum power_supply_property psp)
 {
 	switch (psp) {
@@ -492,18 +492,18 @@ static int bq24257_power_supply_property_is_writeable(struct power_supply *psy,
 	}
 }
 
-static int bq24257_get_chip_state(struct bq24257_device *bq,
-				  struct bq24257_state *state)
+static int bq2425x_get_chip_state(struct bq2425x_device *bq,
+				  struct bq2425x_state *state)
 {
 	int ret;
 
-	ret = bq24257_field_read(bq, F_STAT);
+	ret = bq2425x_field_read(bq, F_STAT);
 	if (ret < 0)
 		return ret;
 
 	state->status = ret;
 
-	ret = bq24257_field_read(bq, F_FAULT);
+	ret = bq2425x_field_read(bq, F_FAULT);
 	if (ret < 0)
 		return ret;
 
@@ -533,22 +533,22 @@ static int bq24257_get_chip_state(struct bq24257_device *bq,
 	return 0;
 }
 
-static bool bq24257_state_changed(struct bq24257_device *bq,
-				  struct bq24257_state *new_state)
+static bool bq2425x_state_changed(struct bq2425x_device *bq,
+				  struct bq2425x_state *new_state)
 {
 	return bq->state.status != new_state->status ||
 			bq->state.fault != new_state->fault ||
 			bq->state.power_good != new_state->power_good;
 }
 
-enum bq24257_loop_status {
+enum bq2425x_loop_status {
 	LOOP_STATUS_NONE,
 	LOOP_STATUS_IN_DPM,
 	LOOP_STATUS_IN_CURRENT_LIMIT,
 	LOOP_STATUS_THERMAL,
 };
 
-enum bq24257_in_ilimit {
+enum bq2425x_in_ilimit {
 	IILIMIT_100,
 	IILIMIT_150,
 	IILIMIT_500,
@@ -559,7 +559,7 @@ enum bq24257_in_ilimit {
 	IILIMIT_NONE,
 };
 
-enum bq24257_vovp {
+enum bq2425x_vovp {
 	VOVP_6000,
 	VOVP_6500,
 	VOVP_7000,
@@ -570,7 +570,7 @@ enum bq24257_vovp {
 	VOVP_10500
 };
 
-enum bq24257_vindpm {
+enum bq2425x_vindpm {
 	VINDPM_4200,
 	VINDPM_4280,
 	VINDPM_4360,
@@ -581,21 +581,21 @@ enum bq24257_vindpm {
 	VINDPM_4760
 };
 
-enum bq24257_port_type {
+enum bq2425x_port_type {
 	PORT_TYPE_DCP,		/* Dedicated Charging Port */
 	PORT_TYPE_CDP,		/* Charging Downstream Port */
 	PORT_TYPE_SDP,		/* Standard Downstream Port */
 	PORT_TYPE_NON_STANDARD,
 };
 
-enum bq24257_safety_timer {
+enum bq2425x_safety_timer {
 	SAFETY_TIMER_45,
 	SAFETY_TIMER_360,
 	SAFETY_TIMER_540,
 	SAFETY_TIMER_NONE,
 };
 
-static int bq24257_iilimit_autoset(struct bq24257_device *bq)
+static int bq2425x_iilimit_autoset(struct bq2425x_device *bq)
 {
 	int loop_status;
 	int iilimit;
@@ -608,13 +608,13 @@ static int bq24257_iilimit_autoset(struct bq24257_device *bq)
 		[PORT_TYPE_NON_STANDARD] = IILIMIT_500
 	};
 
-	ret = bq24257_field_read(bq, F_LOOP_STATUS);
+	ret = bq2425x_field_read(bq, F_LOOP_STATUS);
 	if (ret < 0)
 		goto error;
 
 	loop_status = ret;
 
-	ret = bq24257_field_read(bq, F_IILIMIT);
+	ret = bq2425x_field_read(bq, F_IILIMIT);
 	if (ret < 0)
 		goto error;
 
@@ -628,21 +628,21 @@ static int bq24257_iilimit_autoset(struct bq24257_device *bq)
 	if (loop_status == LOOP_STATUS_IN_DPM && iilimit == IILIMIT_500)
 		return 0;
 
-	ret = bq24257_field_read(bq, F_USB_DET);
+	ret = bq2425x_field_read(bq, F_USB_DET);
 	if (ret < 0)
 		goto error;
 
 	port_type = ret;
 
-	ret = bq24257_field_write(bq, F_IILIMIT, new_iilimit[port_type]);
+	ret = bq2425x_field_write(bq, F_IILIMIT, new_iilimit[port_type]);
 	if (ret < 0)
 		goto error;
 
-	ret = bq24257_field_write(bq, F_TMR, SAFETY_TIMER_360);
+	ret = bq2425x_field_write(bq, F_TMR, SAFETY_TIMER_360);
 	if (ret < 0)
 		goto error;
 
-	ret = bq24257_field_write(bq, F_CLR_VDP, 1);
+	ret = bq2425x_field_write(bq, F_CLR_VDP, 1);
 	if (ret < 0)
 		goto error;
 
@@ -656,21 +656,21 @@ error:
 	return ret;
 }
 
-static void bq24257_iilimit_setup_work(struct work_struct *work)
+static void bq2425x_iilimit_setup_work(struct work_struct *work)
 {
-	struct bq24257_device *bq = container_of(work, struct bq24257_device,
+	struct bq2425x_device *bq = container_of(work, struct bq2425x_device,
 						 iilimit_setup_work.work);
 
 	mutex_lock(&bq->lock);
-	bq24257_iilimit_autoset(bq);
+	bq2425x_iilimit_autoset(bq);
 	mutex_unlock(&bq->lock);
 }
 
-static void bq24257_handle_state_change(struct bq24257_device *bq,
-					struct bq24257_state *new_state)
+static void bq2425x_handle_state_change(struct bq2425x_device *bq,
+					struct bq2425x_state *new_state)
 {
 	int ret;
-	struct bq24257_state old_state;
+	struct bq2425x_state old_state;
 	bool reset_iilimit = false;
 	bool config_iilimit = false;
 
@@ -686,7 +686,7 @@ static void bq24257_handle_state_change(struct bq24257_device *bq,
 			cancel_delayed_work_sync(&bq->iilimit_setup_work);
 
 			/* activate D+/D- port detection algorithm */
-			ret = bq24257_field_write(bq, F_DPDM_EN, 1);
+			ret = bq2425x_field_write(bq, F_DPDM_EN, 1);
 			if (ret < 0)
 				goto error;
 
@@ -709,12 +709,12 @@ static void bq24257_handle_state_change(struct bq24257_device *bq,
 	}
 
 	if (reset_iilimit) {
-		ret = bq24257_field_write(bq, F_IILIMIT, IILIMIT_500);
+		ret = bq2425x_field_write(bq, F_IILIMIT, IILIMIT_500);
 		if (ret < 0)
 			goto error;
 	} else if (config_iilimit) {
 		schedule_delayed_work(&bq->iilimit_setup_work,
-				      msecs_to_jiffies(BQ24257_ILIM_SET_DELAY));
+				      msecs_to_jiffies(BQ2425X_ILIM_SET_DELAY));
 	}
 
 	return;
@@ -723,25 +723,25 @@ error:
 	dev_err(bq->dev, "%s: Error communicating with the chip.\n", __func__);
 }
 
-static irqreturn_t bq24257_irq_handler_thread(int irq, void *private)
+static irqreturn_t bq2425x_irq_handler_thread(int irq, void *private)
 {
 	int ret;
-	struct bq24257_device *bq = private;
-	struct bq24257_state state;
+	struct bq2425x_device *bq = private;
+	struct bq2425x_state state;
 
 	mutex_lock(&bq->lock);
 
-	ret = bq24257_get_chip_state(bq, &state);
+	ret = bq2425x_get_chip_state(bq, &state);
 	if (ret < 0)
 		goto out;
 
-	if (!bq24257_state_changed(bq, &state))
+	if (!bq2425x_state_changed(bq, &state))
 		goto out;
 
 	dev_dbg(bq->dev, "irq(state changed): status/fault/pg = %d/%d/%d\n",
 		state.status, state.fault, state.power_good);
 
-	bq24257_handle_state_change(bq, &state);
+	bq2425x_handle_state_change(bq, &state);
 	bq->state = state;
 
 	mutex_unlock(&bq->lock);
@@ -755,11 +755,11 @@ out:
 	return IRQ_HANDLED;
 }
 
-static int bq24257_hw_init(struct bq24257_device *bq)
+static int bq2425x_hw_init(struct bq2425x_device *bq)
 {
 	int ret;
 	int i;
-	struct bq24257_state state;
+	struct bq2425x_state state;
 
 	const struct {
 		int field;
@@ -777,19 +777,19 @@ static int bq24257_hw_init(struct bq24257_device *bq)
 	 * Disable the watchdog timer to prevent the IC from going back to
 	 * default settings after 50 seconds of I2C inactivity.
 	 */
-	ret = bq24257_field_write(bq, F_WD_EN, 0);
+	ret = bq2425x_field_write(bq, F_WD_EN, 0);
 	if (ret < 0)
 		return ret;
 
 	/* configure the charge currents and voltages */
 	for (i = 0; i < ARRAY_SIZE(init_data); i++) {
-		ret = bq24257_field_write(bq, init_data[i].field,
+		ret = bq2425x_field_write(bq, init_data[i].field,
 					  init_data[i].value);
 		if (ret < 0)
 			return ret;
 	}
 
-	ret = bq24257_get_chip_state(bq, &state);
+	ret = bq2425x_get_chip_state(bq, &state);
 	if (ret < 0)
 		return ret;
 
@@ -800,21 +800,21 @@ static int bq24257_hw_init(struct bq24257_device *bq)
 				bq->init_data.in_ilimit);
 
 		/* program fixed input current limit */
-		ret = bq24257_field_write(bq, F_IILIMIT,
+		ret = bq2425x_field_write(bq, F_IILIMIT,
 					  bq->init_data.in_ilimit);
 
 		if (ret < 0)
 			return ret;
 	} else if (!state.power_good)
 		/* activate D+/D- detection algorithm */
-		ret = bq24257_field_write(bq, F_DPDM_EN, 1);
+		ret = bq2425x_field_write(bq, F_DPDM_EN, 1);
 	else if (state.fault != FAULT_NO_BAT)
-		ret = bq24257_iilimit_autoset(bq);
+		ret = bq2425x_iilimit_autoset(bq);
 
 	return ret;
 }
 
-static enum power_supply_property bq24257_power_supply_props[] = {
+static enum power_supply_property bq2425x_power_supply_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_STATUS,
@@ -829,56 +829,56 @@ static enum power_supply_property bq24257_power_supply_props[] = {
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 };
 
-static char *bq24257_charger_supplied_to[] = {
+static char *bq2425x_charger_supplied_to[] = {
 	"main-battery",
 };
 
-static const struct power_supply_desc bq24257_power_supply_desc = {
-	.name = "bq24257-charger",
+static const struct power_supply_desc bq2425x_power_supply_desc = {
+	.name = "bq2425x-charger",
 	.type = POWER_SUPPLY_TYPE_USB,
-	.properties = bq24257_power_supply_props,
-	.num_properties = ARRAY_SIZE(bq24257_power_supply_props),
-	.get_property = bq24257_power_supply_get_property,
-	.set_property = bq24257_power_supply_set_property,
-	.property_is_writeable	= bq24257_power_supply_property_is_writeable
+	.properties = bq2425x_power_supply_props,
+	.num_properties = ARRAY_SIZE(bq2425x_power_supply_props),
+	.get_property = bq2425x_power_supply_get_property,
+	.set_property = bq2425x_power_supply_set_property,
+	.property_is_writeable	= bq2425x_power_supply_property_is_writeable
 };
 
-static ssize_t bq24257_show_ovp_voltage(struct device *dev,
+static ssize_t bq2425x_show_ovp_voltage(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq24257_device *bq = power_supply_get_drvdata(psy);
+	struct bq2425x_device *bq = power_supply_get_drvdata(psy);
 
 	return scnprintf(buf, PAGE_SIZE, "%d\n",
-			bq24257_vovp_map[bq->init_data.vovp]);
+			bq2425x_vovp_map[bq->init_data.vovp]);
 }
 
-static ssize_t bq24257_show_in_dpm_voltage(struct device *dev,
+static ssize_t bq2425x_show_in_dpm_voltage(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq24257_device *bq = power_supply_get_drvdata(psy);
+	struct bq2425x_device *bq = power_supply_get_drvdata(psy);
 
 	return scnprintf(buf, PAGE_SIZE, "%d\n",
-			bq24257_vindpm_map[bq->init_data.vindpm]);
+			bq2425x_vindpm_map[bq->init_data.vindpm]);
 }
 
-static ssize_t bq24257_sysfs_show_enable(struct device *dev,
+static ssize_t bq2425x_sysfs_show_enable(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq24257_device *bq = power_supply_get_drvdata(psy);
+	struct bq2425x_device *bq = power_supply_get_drvdata(psy);
 	int ret;
 
 	mutex_lock(&bq->lock);
 
 	if (strcmp(attr->attr.name, "high_impedance_enable") == 0)
-		ret = bq24257_field_read(bq, F_HZ_MODE);
+		ret = bq2425x_field_read(bq, F_HZ_MODE);
 	else if (strcmp(attr->attr.name, "sysoff_enable") == 0)
-		ret = bq24257_field_read(bq, F_SYSOFF);
+		ret = bq2425x_field_read(bq, F_SYSOFF);
 	else if (strcmp(attr->attr.name, "timer2x_enable") == 0)
 		ret = bq->init_data.timer2x_enable;
 	else
@@ -892,13 +892,13 @@ static ssize_t bq24257_sysfs_show_enable(struct device *dev,
 	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
 }
 
-static ssize_t bq24257_sysfs_set_enable(struct device *dev,
+static ssize_t bq2425x_sysfs_set_enable(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf,
 					size_t count)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
-	struct bq24257_device *bq = power_supply_get_drvdata(psy);
+	struct bq2425x_device *bq = power_supply_get_drvdata(psy);
 	long val;
 	int ret;
 
@@ -908,9 +908,9 @@ static ssize_t bq24257_sysfs_set_enable(struct device *dev,
 	mutex_lock(&bq->lock);
 
 	if (strcmp(attr->attr.name, "high_impedance_enable") == 0)
-		ret = bq24257_field_write(bq, F_HZ_MODE, val);
+		ret = bq2425x_field_write(bq, F_HZ_MODE, val);
 	else if (strcmp(attr->attr.name, "sysoff_enable") == 0)
-		ret = bq24257_field_write(bq, F_SYSOFF, val);
+		ret = bq2425x_field_write(bq, F_SYSOFF, val);
 	else
 		ret = -EINVAL;
 
@@ -922,16 +922,16 @@ static ssize_t bq24257_sysfs_set_enable(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(ovp_voltage, S_IRUGO, bq24257_show_ovp_voltage, NULL);
-static DEVICE_ATTR(in_dpm_voltage, S_IRUGO, bq24257_show_in_dpm_voltage, NULL);
+static DEVICE_ATTR(ovp_voltage, S_IRUGO, bq2425x_show_ovp_voltage, NULL);
+static DEVICE_ATTR(in_dpm_voltage, S_IRUGO, bq2425x_show_in_dpm_voltage, NULL);
 static DEVICE_ATTR(high_impedance_enable, S_IWUSR | S_IRUGO,
-		bq24257_sysfs_show_enable, bq24257_sysfs_set_enable);
+		bq2425x_sysfs_show_enable, bq2425x_sysfs_set_enable);
 static DEVICE_ATTR(sysoff_enable, S_IWUSR | S_IRUGO,
-		bq24257_sysfs_show_enable, bq24257_sysfs_set_enable);
+		bq2425x_sysfs_show_enable, bq2425x_sysfs_set_enable);
 static DEVICE_ATTR(timer2x_enable, S_IRUGO,
-		bq24257_sysfs_show_enable, NULL);
+		bq2425x_sysfs_show_enable, NULL);
 
-static struct attribute *bq24257_charger_attr[] = {
+static struct attribute *bq2425x_charger_attr[] = {
 	&dev_attr_ovp_voltage.attr,
 	&dev_attr_in_dpm_voltage.attr,
 	&dev_attr_high_impedance_enable.attr,
@@ -940,18 +940,18 @@ static struct attribute *bq24257_charger_attr[] = {
 	NULL,
 };
 
-static const struct attribute_group bq24257_attr_group = {
-	.attrs = bq24257_charger_attr,
+static const struct attribute_group bq2425x_attr_group = {
+	.attrs = bq2425x_charger_attr,
 };
 
-static int bq24257_power_supply_init(struct bq24257_device *bq)
+static int bq2425x_power_supply_init(struct bq2425x_device *bq)
 {
 	struct power_supply_config psy_cfg = { .drv_data = bq, };
 
-	psy_cfg.supplied_to = bq24257_charger_supplied_to;
-	psy_cfg.num_supplicants = ARRAY_SIZE(bq24257_charger_supplied_to);
+	psy_cfg.supplied_to = bq2425x_charger_supplied_to;
+	psy_cfg.num_supplicants = ARRAY_SIZE(bq2425x_charger_supplied_to);
 
-	bq->charger = power_supply_register(bq->dev, &bq24257_power_supply_desc,
+	bq->charger = power_supply_register(bq->dev, &bq2425x_power_supply_desc,
 					    &psy_cfg);
 	if (IS_ERR(bq->charger))
 		return PTR_ERR(bq->charger);
@@ -959,14 +959,14 @@ static int bq24257_power_supply_init(struct bq24257_device *bq)
 	return 0;
 }
 
-static int bq24257_irq_probe(struct bq24257_device *bq)
+static int bq2425x_irq_probe(struct bq2425x_device *bq)
 {
-	struct bq24257_platform_data *pdata = bq->client->dev.platform_data;
+	struct bq2425x_platform_data *pdata = bq->client->dev.platform_data;
 	struct gpio_desc *stat_irq;
 	int ret;
 
 	if (!pdata)
-		stat_irq = devm_gpiod_get_index(bq->dev, BQ24257_STAT_IRQ, 0,
+		stat_irq = devm_gpiod_get_index(bq->dev, BQ2425X_STAT_IRQ, 0,
 				GPIOD_IN);
 	else {
 		if (!gpio_is_valid(pdata->stat_gpio)) {
@@ -975,7 +975,7 @@ static int bq24257_irq_probe(struct bq24257_device *bq)
 		}
 
 		ret = devm_gpio_request_one(bq->dev, pdata->stat_gpio,
-				GPIOD_IN, BQ24257_STAT_IRQ);
+				GPIOD_IN, BQ2425X_STAT_IRQ);
 		if (ret) {
 			dev_err(bq->dev, "stat_irq pin request failed\n");
 			return ret;
@@ -994,13 +994,13 @@ static int bq24257_irq_probe(struct bq24257_device *bq)
 	return gpiod_to_irq(stat_irq);
 }
 
-static int bq24257_pg_gpio_probe(struct bq24257_device *bq)
+static int bq2425x_pg_gpio_probe(struct bq2425x_device *bq)
 {
-	struct bq24257_platform_data *pdata = bq->client->dev.platform_data;
+	struct bq2425x_platform_data *pdata = bq->client->dev.platform_data;
 	int ret;
 
 	if (!pdata)
-		bq->pg = devm_gpiod_get_index(bq->dev, BQ24257_PG_GPIO, 0,
+		bq->pg = devm_gpiod_get_index(bq->dev, BQ2425X_PG_GPIO, 0,
 				GPIOD_IN);
 	else {
 		if (!gpio_is_valid(pdata->pg_gpio)) {
@@ -1009,7 +1009,7 @@ static int bq24257_pg_gpio_probe(struct bq24257_device *bq)
 		}
 
 		ret = devm_gpio_request_one(bq->dev, pdata->pg_gpio,
-				GPIOD_IN, BQ24257_PG_GPIO);
+				GPIOD_IN, BQ2425X_PG_GPIO);
 
 		if (ret) {
 			dev_err(bq->dev, "PG pin request failed\n");
@@ -1029,26 +1029,26 @@ static int bq24257_pg_gpio_probe(struct bq24257_device *bq)
 	return 0;
 }
 
-static void bq24257_pdata_probe(struct bq24257_device *bq,
-		struct bq24257_platform_data *pdata)
+static void bq2425x_pdata_probe(struct bq2425x_device *bq,
+		struct bq2425x_platform_data *pdata)
 {
-	bq->init_data.ichg = bq24257_find_idx(pdata->ichg,
-			bq24257_ichg_map, BQ24257_ICHG_MAP_SIZE);
+	bq->init_data.ichg = bq2425x_find_idx(pdata->ichg,
+			bq2425x_ichg_map, BQ2425X_ICHG_MAP_SIZE);
 
-	bq->init_data.vbat = bq24257_find_idx(pdata->vbat,
-			bq24257_vbat_map, BQ24257_VBAT_MAP_SIZE);
+	bq->init_data.vbat = bq2425x_find_idx(pdata->vbat,
+			bq2425x_vbat_map, BQ2425X_VBAT_MAP_SIZE);
 
-	bq->init_data.iterm = bq24257_find_idx(pdata->iterm,
-			bq24257_iterm_map, BQ24257_ITERM_MAP_SIZE);
+	bq->init_data.iterm = bq2425x_find_idx(pdata->iterm,
+			bq2425x_iterm_map, BQ2425X_ITERM_MAP_SIZE);
 
-	bq->init_data.in_ilimit = bq24257_find_idx(pdata->in_ilimit,
-			bq24257_iilimit_map, BQ24257_IILIMIT_MAP_SIZE);
+	bq->init_data.in_ilimit = bq2425x_find_idx(pdata->in_ilimit,
+			bq2425x_iilimit_map, BQ2425X_IILIMIT_MAP_SIZE);
 
-	bq->init_data.vovp = bq24257_find_idx(pdata->vovp, bq24257_vovp_map,
-			BQ24257_VOVP_MAP_SIZE);
+	bq->init_data.vovp = bq2425x_find_idx(pdata->vovp, bq2425x_vovp_map,
+			BQ2425X_VOVP_MAP_SIZE);
 
-	bq->init_data.vindpm = bq24257_find_idx(pdata->vindpm,
-			bq24257_vindpm_map, BQ24257_VINDPM_MAP_SIZE);
+	bq->init_data.vindpm = bq2425x_find_idx(pdata->vindpm,
+			bq2425x_vindpm_map, BQ2425X_VINDPM_MAP_SIZE);
 
 	bq->init_data.timer2x_enable = pdata->timer2x_enable;
 
@@ -1057,7 +1057,7 @@ static void bq24257_pdata_probe(struct bq24257_device *bq,
 	bq->pg_gpio_disable = pdata->pg_gpio_disable;
 }
 
-static int bq24257_fw_probe(struct bq24257_device *bq)
+static int bq2425x_fw_probe(struct bq2425x_device *bq)
 {
 	int ret;
 	u32 property;
@@ -1067,24 +1067,24 @@ static int bq24257_fw_probe(struct bq24257_device *bq)
 	if (ret < 0)
 		return ret;
 
-	bq->init_data.ichg = bq24257_find_idx(property, bq24257_ichg_map,
-					      BQ24257_ICHG_MAP_SIZE);
+	bq->init_data.ichg = bq2425x_find_idx(property, bq2425x_ichg_map,
+					      BQ2425X_ICHG_MAP_SIZE);
 
 	ret = device_property_read_u32(bq->dev, "ti,battery-regulation-voltage",
 				       &property);
 	if (ret < 0)
 		return ret;
 
-	bq->init_data.vbat = bq24257_find_idx(property, bq24257_vbat_map,
-					      BQ24257_VBAT_MAP_SIZE);
+	bq->init_data.vbat = bq2425x_find_idx(property, bq2425x_vbat_map,
+					      BQ2425X_VBAT_MAP_SIZE);
 
 	ret = device_property_read_u32(bq->dev, "ti,termination-current",
 				       &property);
 	if (ret < 0)
 		return ret;
 
-	bq->init_data.iterm = bq24257_find_idx(property, bq24257_iterm_map,
-					       BQ24257_ITERM_MAP_SIZE);
+	bq->init_data.iterm = bq2425x_find_idx(property, bq2425x_iterm_map,
+					       BQ2425X_ITERM_MAP_SIZE);
 
 	/* Optional properties. If not provided use reasonable default. */
 	ret = device_property_read_u32(bq->dev, "ti,current-limit",
@@ -1098,8 +1098,8 @@ static int bq24257_fw_probe(struct bq24257_device *bq)
 		bq->init_data.in_ilimit = IILIMIT_500;
 	else {
 		bq->in_ilimit_autoset_disable = true;
-		bq->init_data.in_ilimit = bq24257_find_idx(property,
-				bq24257_iilimit_map, BQ24257_IILIMIT_MAP_SIZE);
+		bq->init_data.in_ilimit = bq2425x_find_idx(property,
+				bq2425x_iilimit_map, BQ2425X_IILIMIT_MAP_SIZE);
 	}
 
 	ret = device_property_read_u32(bq->dev, "ti,ovp-voltage",
@@ -1107,16 +1107,16 @@ static int bq24257_fw_probe(struct bq24257_device *bq)
 	if (ret < 0)
 		bq->init_data.vovp = VOVP_6500;
 	else
-		bq->init_data.vovp = bq24257_find_idx(property,
-				bq24257_vovp_map, BQ24257_VOVP_MAP_SIZE);
+		bq->init_data.vovp = bq2425x_find_idx(property,
+				bq2425x_vovp_map, BQ2425X_VOVP_MAP_SIZE);
 
 	ret = device_property_read_u32(bq->dev, "ti,in-dpm-voltage",
 				       &property);
 	if (ret < 0)
 		bq->init_data.vindpm = VINDPM_4360;
 	else
-		bq->init_data.vindpm = bq24257_find_idx(property,
-				bq24257_vindpm_map, BQ24257_VINDPM_MAP_SIZE);
+		bq->init_data.vindpm = bq2425x_find_idx(property,
+				bq2425x_vindpm_map, BQ2425X_VINDPM_MAP_SIZE);
 
 	ret = device_property_read_u32(bq->dev, "ti,safety-timer-2x-enable",
 				       &property);
@@ -1128,14 +1128,14 @@ static int bq24257_fw_probe(struct bq24257_device *bq)
 	return 0;
 }
 
-static int bq24257_probe(struct i2c_client *client,
+static int bq2425x_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
 	struct device *dev = &client->dev;
 	const struct acpi_device_id *acpi_id;
-	struct bq24257_platform_data *pdata = client->dev.platform_data;
-	struct bq24257_device *bq;
+	struct bq2425x_platform_data *pdata = client->dev.platform_data;
+	struct bq2425x_device *bq;
 	int ret;
 	int i;
 
@@ -1165,14 +1165,14 @@ static int bq24257_probe(struct i2c_client *client,
 
 	mutex_init(&bq->lock);
 
-	bq->rmap = devm_regmap_init_i2c(client, &bq24257_regmap_config);
+	bq->rmap = devm_regmap_init_i2c(client, &bq2425x_regmap_config);
 	if (IS_ERR(bq->rmap)) {
 		dev_err(dev, "failed to allocate register map\n");
 		return PTR_ERR(bq->rmap);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(bq24257_reg_fields); i++) {
-		const struct reg_field *reg_fields = bq24257_reg_fields;
+	for (i = 0; i < ARRAY_SIZE(bq2425x_reg_fields); i++) {
+		const struct reg_field *reg_fields = bq2425x_reg_fields;
 
 		bq->rmap_fields[i] = devm_regmap_field_alloc(dev, bq->rmap,
 							     reg_fields[i]);
@@ -1185,14 +1185,14 @@ static int bq24257_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, bq);
 
 	if (!pdata) {
-		ret = bq24257_fw_probe(bq);
+		ret = bq2425x_fw_probe(bq);
 		if (ret < 0) {
 			dev_err(dev, "Cannot read device properties.\n");
 			return ret;
 		}
 	} else {
 		dev_dbg(dev, "init using platform data\n");
-		bq24257_pdata_probe(bq, pdata);
+		bq2425x_pdata_probe(bq, pdata);
 	}
 
 	/*
@@ -1205,7 +1205,7 @@ static int bq24257_probe(struct i2c_client *client,
 
 	if (!bq->in_ilimit_autoset_disable)
 		INIT_DELAYED_WORK(&bq->iilimit_setup_work,
-				bq24257_iilimit_setup_work);
+				bq2425x_iilimit_setup_work);
 
 	/*
 	 * The BQ24250 doesn't have a dedicated Power Good (PG) pin so we
@@ -1221,7 +1221,7 @@ static int bq24257_probe(struct i2c_client *client,
 	 * use of the dedicated pin is preferred.
 	 */
 	if (!bq->pg_gpio_disable) {
-		ret = bq24257_pg_gpio_probe(bq);
+		ret = bq2425x_pg_gpio_probe(bq);
 		if (ret < 0) {
 			dev_info(bq->dev,
 				"using SW-based power-good detection\n");
@@ -1230,7 +1230,7 @@ static int bq24257_probe(struct i2c_client *client,
 	}
 
 	/* reset all registers to defaults */
-	ret = bq24257_field_write(bq, F_RESET, 1);
+	ret = bq2425x_field_write(bq, F_RESET, 1);
 	if (ret < 0)
 		return ret;
 
@@ -1239,11 +1239,11 @@ static int bq24257_probe(struct i2c_client *client,
 	 * returns 1 on this bit, so this is the only way to avoid resetting the
 	 * chip every time we update another field in this register.
 	 */
-	ret = bq24257_field_write(bq, F_RESET, 0);
+	ret = bq2425x_field_write(bq, F_RESET, 0);
 	if (ret < 0)
 		return ret;
 
-	ret = bq24257_hw_init(bq);
+	ret = bq2425x_hw_init(bq);
 	if (ret < 0) {
 		dev_err(dev, "Cannot initialize the chip.\n");
 		return ret;
@@ -1251,12 +1251,12 @@ static int bq24257_probe(struct i2c_client *client,
 
 	/*
 	 * When using device firmware we either take the IRQ specified directly
-	 * or probe for a pin named BQ24257_STAT_IRQ. In case of using platform
+	 * or probe for a pin named BQ2425X_STAT_IRQ. In case of using platform
 	 * data always run the IRQ pin probe function to finish IRQ and GPIO
 	 * setup based on the stat pin specified in the platform data.
 	 */
 	if (client->irq <= 0 || pdata)
-		client->irq = bq24257_irq_probe(bq);
+		client->irq = bq2425x_irq_probe(bq);
 
 	if (client->irq < 0) {
 		dev_err(dev, "no irq resource found\n");
@@ -1264,20 +1264,20 @@ static int bq24257_probe(struct i2c_client *client,
 	}
 
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,
-					bq24257_irq_handler_thread,
+					bq2425x_irq_handler_thread,
 					IRQF_TRIGGER_FALLING |
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-					BQ24257_STAT_IRQ, bq);
+					BQ2425X_STAT_IRQ, bq);
 	if (ret)
 		return ret;
 
-	ret = bq24257_power_supply_init(bq);
+	ret = bq2425x_power_supply_init(bq);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register power supply\n");
 		return ret;
 	}
 
-	ret = sysfs_create_group(&bq->charger->dev.kobj, &bq24257_attr_group);
+	ret = sysfs_create_group(&bq->charger->dev.kobj, &bq2425x_attr_group);
 	if (ret < 0) {
 		dev_err(dev, "Can't create sysfs entries\n");
 		return ret;
@@ -1286,26 +1286,26 @@ static int bq24257_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int bq24257_remove(struct i2c_client *client)
+static int bq2425x_remove(struct i2c_client *client)
 {
-	struct bq24257_device *bq = i2c_get_clientdata(client);
+	struct bq2425x_device *bq = i2c_get_clientdata(client);
 
 	if (!bq->in_ilimit_autoset_disable)
 		cancel_delayed_work_sync(&bq->iilimit_setup_work);
 
-	sysfs_remove_group(&bq->charger->dev.kobj, &bq24257_attr_group);
+	sysfs_remove_group(&bq->charger->dev.kobj, &bq2425x_attr_group);
 
 	power_supply_unregister(bq->charger);
 
-	bq24257_field_write(bq, F_RESET, 1); /* reset to defaults */
+	bq2425x_field_write(bq, F_RESET, 1); /* reset to defaults */
 
 	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int bq24257_suspend(struct device *dev)
+static int bq2425x_suspend(struct device *dev)
 {
-	struct bq24257_device *bq = dev_get_drvdata(dev);
+	struct bq2425x_device *bq = dev_get_drvdata(dev);
 	int ret = 0;
 
 	if (!bq->in_ilimit_autoset_disable)
@@ -1314,7 +1314,7 @@ static int bq24257_suspend(struct device *dev)
 	mutex_lock(&bq->lock);
 
 	/* reset all registers to default (and activate standalone mode) */
-	ret = bq24257_field_write(bq, F_RESET, 1);
+	ret = bq2425x_field_write(bq, F_RESET, 1);
 	if (ret < 0)
 		dev_err(bq->dev, "Cannot reset chip to standalone mode.\n");
 
@@ -1323,22 +1323,22 @@ static int bq24257_suspend(struct device *dev)
 	return ret;
 }
 
-static int bq24257_resume(struct device *dev)
+static int bq2425x_resume(struct device *dev)
 {
 	int ret;
-	struct bq24257_device *bq = dev_get_drvdata(dev);
+	struct bq2425x_device *bq = dev_get_drvdata(dev);
 
 	mutex_lock(&bq->lock);
 
-	ret = regcache_drop_region(bq->rmap, BQ24257_REG_1, BQ24257_REG_7);
+	ret = regcache_drop_region(bq->rmap, BQ2425X_REG_1, BQ2425X_REG_7);
 	if (ret < 0)
 		goto err;
 
-	ret = bq24257_field_write(bq, F_RESET, 0);
+	ret = bq2425x_field_write(bq, F_RESET, 0);
 	if (ret < 0)
 		goto err;
 
-	ret = bq24257_hw_init(bq);
+	ret = bq2425x_hw_init(bq);
 	if (ret < 0) {
 		dev_err(bq->dev, "Cannot init chip after resume.\n");
 		goto err;
@@ -1356,19 +1356,19 @@ err:
 }
 #endif
 
-static const struct dev_pm_ops bq24257_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(bq24257_suspend, bq24257_resume)
+static const struct dev_pm_ops bq2425x_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(bq2425x_suspend, bq2425x_resume)
 };
 
-static const struct i2c_device_id bq24257_i2c_ids[] = {
+static const struct i2c_device_id bq2425x_i2c_ids[] = {
 	{ "bq24250", BQ24250 },
 	{ "bq24251", BQ24251 },
 	{ "bq24257", BQ24257 },
 	{},
 };
-MODULE_DEVICE_TABLE(i2c, bq24257_i2c_ids);
+MODULE_DEVICE_TABLE(i2c, bq2425x_i2c_ids);
 
-static const struct of_device_id bq24257_of_match[] = {
+static const struct of_device_id bq2425x_of_match[] = {
 	{
 		.compatible = "ti,bq24250",
 		.compatible = "ti,bq24251",
@@ -1376,29 +1376,29 @@ static const struct of_device_id bq24257_of_match[] = {
 	},
 	{ },
 };
-MODULE_DEVICE_TABLE(of, bq24257_of_match);
+MODULE_DEVICE_TABLE(of, bq2425x_of_match);
 
-static const struct acpi_device_id bq24257_acpi_match[] = {
+static const struct acpi_device_id bq2425x_acpi_match[] = {
 	{ "BQ242500", BQ24250 },
 	{ "BQ242510", BQ24251 },
 	{ "BQ242570", BQ24257 },
 	{},
 };
-MODULE_DEVICE_TABLE(acpi, bq24257_acpi_match);
+MODULE_DEVICE_TABLE(acpi, bq2425x_acpi_match);
 
-static struct i2c_driver bq24257_driver = {
+static struct i2c_driver bq2425x_driver = {
 	.driver = {
-		.name = "bq24257-charger",
-		.of_match_table = of_match_ptr(bq24257_of_match),
-		.acpi_match_table = ACPI_PTR(bq24257_acpi_match),
-		.pm = &bq24257_pm,
+		.name = "bq2425x-charger",
+		.of_match_table = of_match_ptr(bq2425x_of_match),
+		.acpi_match_table = ACPI_PTR(bq2425x_acpi_match),
+		.pm = &bq2425x_pm,
 	},
-	.probe = bq24257_probe,
-	.remove = bq24257_remove,
-	.id_table = bq24257_i2c_ids,
+	.probe = bq2425x_probe,
+	.remove = bq2425x_remove,
+	.id_table = bq2425x_i2c_ids,
 };
-module_i2c_driver(bq24257_driver);
+module_i2c_driver(bq2425x_driver);
 
 MODULE_AUTHOR("Laurentiu Palcu <laurentiu.palcu@intel.com>");
-MODULE_DESCRIPTION("bq24257 charger driver");
+MODULE_DESCRIPTION("bq2425x charger driver");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/power/bq24257_charger.h b/include/linux/power/bq2425x_charger.h
similarity index 85%
rename from include/linux/power/bq24257_charger.h
rename to include/linux/power/bq2425x_charger.h
index 7fc505b..782667e 100644
--- a/include/linux/power/bq24257_charger.h
+++ b/include/linux/power/bq2425x_charger.h
@@ -1,18 +1,18 @@
 /*
- * Platform data for the TI bq24257 battery charger driver.
+ * Platform data for the TI bq2425x battery charger driver.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
 
-#ifndef _BQ24257_CHARGER_H_
-#define _BQ24257_CHARGER_H_
+#ifndef _BQ2425X_CHARGER_H_
+#define _BQ2425X_CHARGER_H_
 
 #include <asm/types.h>
 #include <linux/types.h>
 
-struct bq24257_platform_data {
+struct bq2425x_platform_data {
 	u32 ichg;				       /* charge current (uA) */
 	u32 vbat;				   /* regulation voltage (uV) */
 	u32 iterm;				  /* termination current (uA) */
-- 
1.9.1

