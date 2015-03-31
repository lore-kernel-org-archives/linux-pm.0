From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 1/3] power: max17042_battery: Use reg type instead of chip type
Date: Tue, 31 Mar 2015 22:34:05 +0900
Message-ID: <1427808847-19498-2-git-send-email-beomho.seo@samsung.com>
References: <1427808847-19498-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:34616 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbbCaNeK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2015 09:34:10 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NM200I4SWCW0810@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 31 Mar 2015 22:34:08 +0900 (KST)
In-reply-to: <1427808847-19498-1-git-send-email-beomho.seo@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Beomho Seo <beomho.seo@samsung.com>, Sebastian Reichel <sre@kernel.org>

Currently, max17042 battery driver choose register map by MAX17042_DevName
register. But thid register is return IC specific firmware version. So other
maxim chip hard to use this drvier. This patch choose reg_type by driver_data.

Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/power/max17042_battery.c       |   55 ++++++++++++++++++--------------
 include/linux/power/max17042_battery.h |   17 +++++++++-
 2 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index 40e7056..1db87fd 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -63,14 +63,12 @@
 #define dP_ACC_100	0x1900
 #define dP_ACC_200	0x3200
 
-#define MAX17042_IC_VERSION	0x0092
-#define MAX17047_IC_VERSION	0x00AC	/* same for max17050 */
-
 struct max17042_chip {
 	struct i2c_client *client;
 	struct regmap *regmap;
 	struct power_supply *battery;
 	enum max170xx_chip_type chip_type;
+	enum max170xx_reg_type reg_type;
 	struct max17042_platform_data *pdata;
 	struct work_struct work;
 	int    init_complete;
@@ -131,7 +129,7 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval *= 20000; /* Units of LSB = 20mV */
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
-		if (chip->chip_type == MAX17042)
+		if (chip->reg_type == MAXIM_REG_TYPE_MAX17047)
 			ret = regmap_read(map, MAX17042_V_empty, &data);
 		else
 			ret = regmap_read(map, MAX17047_V_empty, &data);
@@ -378,7 +376,7 @@ static void max17042_write_config_regs(struct max17042_chip *chip)
 	regmap_write(map, MAX17042_FilterCFG,
 			config->filter_cfg);
 	regmap_write(map, MAX17042_RelaxCFG, config->relax_cfg);
-	if (chip->chip_type == MAX17047)
+	if (chip->reg_type == MAXIM_REG_TYPE_MAX17047)
 		regmap_write(map, MAX17047_FullSOCThr,
 						config->full_soc_thresh);
 }
@@ -391,7 +389,7 @@ static void  max17042_write_custom_regs(struct max17042_chip *chip)
 	max17042_write_verify_reg(map, MAX17042_RCOMP0, config->rcomp0);
 	max17042_write_verify_reg(map, MAX17042_TempCo,	config->tcompc0);
 	max17042_write_verify_reg(map, MAX17042_ICHGTerm, config->ichgt_term);
-	if (chip->chip_type == MAX17042) {
+	if (chip->reg_type == MAXIM_REG_TYPE_MAX17042) {
 		regmap_write(map, MAX17042_EmptyTempCo,	config->empty_tempco);
 		max17042_write_verify_reg(map, MAX17042_K_empty0,
 					config->kempty0);
@@ -500,14 +498,14 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 
 	max17042_override_por(map, MAX17042_FullCAP, config->fullcap);
 	max17042_override_por(map, MAX17042_FullCAPNom, config->fullcapnom);
-	if (chip->chip_type == MAX17042)
+	if (chip->reg_type == MAXIM_REG_TYPE_MAX17042)
 		max17042_override_por(map, MAX17042_SOC_empty,
 						config->socempty);
 	max17042_override_por(map, MAX17042_LAvg_empty, config->lavg_empty);
 	max17042_override_por(map, MAX17042_dQacc, config->dqacc);
 	max17042_override_por(map, MAX17042_dPacc, config->dpacc);
 
-	if (chip->chip_type == MAX17042)
+	if (chip->reg_type == MAXIM_REG_TYPE_MAX17042)
 		max17042_override_por(map, MAX17042_V_empty, config->vempty);
 	else
 		max17042_override_por(map, MAX17047_V_empty, config->vempty);
@@ -516,7 +514,7 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 	max17042_override_por(map, MAX17042_FCTC, config->fctc);
 	max17042_override_por(map, MAX17042_RCOMP0, config->rcomp0);
 	max17042_override_por(map, MAX17042_TempCo, config->tcompc0);
-	if (chip->chip_type) {
+	if (chip->reg_type) {
 		max17042_override_por(map, MAX17042_EmptyTempCo,
 						config->empty_tempco);
 		max17042_override_por(map, MAX17042_K_empty0,
@@ -623,6 +621,25 @@ static void max17042_init_worker(struct work_struct *work)
 	chip->init_complete = 1;
 }
 
+static int max17042_get_reg_type(struct max17042_chip *chip)
+{
+	int reg_type;
+
+	switch (chip->chip_type) {
+	case MAXIM_DEVICE_TYPE_MAX17042:
+		reg_type = MAXIM_REG_TYPE_MAX17042;
+		break;
+	case MAXIM_DEVICE_TYPE_MAX17047:
+	case MAXIM_DEVICE_TYPE_MAX17050:
+		reg_type = MAXIM_REG_TYPE_MAX17047;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return reg_type;
+}
+
 #ifdef CONFIG_OF
 static struct max17042_platform_data *
 max17042_get_pdata(struct device *dev)
@@ -711,20 +728,10 @@ static int max17042_probe(struct i2c_client *client,
 	}
 
 	i2c_set_clientdata(client, chip);
+	chip->chip_type = id->driver_data;
+	chip->reg_type = max17042_get_reg_type(chip);
 	psy_cfg.drv_data = chip;
 
-	regmap_read(chip->regmap, MAX17042_DevName, &val);
-	if (val == MAX17042_IC_VERSION) {
-		dev_dbg(&client->dev, "chip type max17042 detected\n");
-		chip->chip_type = MAX17042;
-	} else if (val == MAX17047_IC_VERSION) {
-		dev_dbg(&client->dev, "chip type max17047/50 detected\n");
-		chip->chip_type = MAX17047;
-	} else {
-		dev_err(&client->dev, "device version mismatch: %x\n", val);
-		return -EIO;
-	}
-
 	/* When current is not measured,
 	 * CURRENT_NOW and CURRENT_AVG properties should be invisible. */
 	if (!chip->pdata->enable_current_sense)
@@ -836,9 +843,9 @@ MODULE_DEVICE_TABLE(of, max17042_dt_match);
 #endif
 
 static const struct i2c_device_id max17042_id[] = {
-	{ "max17042", 0 },
-	{ "max17047", 1 },
-	{ "max17050", 2 },
+	{ "max17042", MAXIM_DEVICE_TYPE_MAX17042 },
+	{ "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
+	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max17042_id);
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index 89dd84f..8dd7b70 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -126,7 +126,22 @@ enum max17047_register {
 	MAX17047_QRTbl30	= 0x42,
 };
 
-enum max170xx_chip_type {MAX17042, MAX17047};
+enum max170xx_chip_type {
+	MAXIM_DEVICE_TYPE_UNKNOWN	= 0,
+	MAXIM_DEVICE_TYPE_MAX17042,
+	MAXIM_DEVICE_TYPE_MAX17047,
+	MAXIM_DEVICE_TYPE_MAX17050,
+
+	MAXIM_DEVICE_TYPE_NUM
+};
+
+enum max170xx_reg_type {
+	MAXIM_REG_TYPE_UNKNOWN	= 0,
+	MAXIM_REG_TYPE_MAX17042,
+	MAXIM_REG_TYPE_MAX17047,
+
+	MAXIM_REG_TYPE_NUM
+};
 
 /*
  * used for setting a register to a desired value
-- 
1.7.9.5

