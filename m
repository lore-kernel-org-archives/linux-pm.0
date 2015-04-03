From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH v2 1/2] power: max17042_battery: Use reg type instead of chip
 type
Date: Fri, 03 Apr 2015 17:26:08 +0900
Message-ID: <1428049570-3295-2-git-send-email-beomho.seo@samsung.com>
References: <1428049570-3295-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:18392 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbbDCI02 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2015 04:26:28 -0400
In-reply-to: <1428049570-3295-1-git-send-email-beomho.seo@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, k.kozlowski@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, inki.dae@samsung.com, sangbae90.lee@samsung.com, Beomho Seo <beomho.seo@samsung.com>

Currently, max17042 battery driver choose register map by MAX17042_DevName
register. But it is return IC specific firmware version. So other maxim chip
hard to use this drvier. This patch choose chip type from driver_data.

Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/power/max17042_battery.c       |   33 ++++++++++----------------------
 include/linux/power/max17042_battery.h |    9 ++++++++-
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index e5645ea..bf5a82c 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -63,9 +63,6 @@
 #define dP_ACC_100	0x1900
 #define dP_ACC_200	0x3200
 
-#define MAX17042_IC_VERSION	0x0092
-#define MAX17047_IC_VERSION	0x00AC	/* same for max17050 */
-
 struct max17042_chip {
 	struct i2c_client *client;
 	struct regmap *regmap;
@@ -131,7 +128,7 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval *= 20000; /* Units of LSB = 20mV */
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
-		if (chip->chip_type == MAX17042)
+		if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042)
 			ret = regmap_read(map, MAX17042_V_empty, &data);
 		else
 			ret = regmap_read(map, MAX17047_V_empty, &data);
@@ -378,7 +375,8 @@ static void max17042_write_config_regs(struct max17042_chip *chip)
 	regmap_write(map, MAX17042_FilterCFG,
 			config->filter_cfg);
 	regmap_write(map, MAX17042_RelaxCFG, config->relax_cfg);
-	if (chip->chip_type == MAX17047)
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17047 ||
+			chip->chip_type == MAXIM_DEVICE_TYPE_MAX17050)
 		regmap_write(map, MAX17047_FullSOCThr,
 						config->full_soc_thresh);
 }
@@ -391,7 +389,7 @@ static void  max17042_write_custom_regs(struct max17042_chip *chip)
 	max17042_write_verify_reg(map, MAX17042_RCOMP0, config->rcomp0);
 	max17042_write_verify_reg(map, MAX17042_TempCo,	config->tcompc0);
 	max17042_write_verify_reg(map, MAX17042_ICHGTerm, config->ichgt_term);
-	if (chip->chip_type == MAX17042) {
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042) {
 		regmap_write(map, MAX17042_EmptyTempCo,	config->empty_tempco);
 		max17042_write_verify_reg(map, MAX17042_K_empty0,
 					config->kempty0);
@@ -500,14 +498,14 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 
 	max17042_override_por(map, MAX17042_FullCAP, config->fullcap);
 	max17042_override_por(map, MAX17042_FullCAPNom, config->fullcapnom);
-	if (chip->chip_type == MAX17042)
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042)
 		max17042_override_por(map, MAX17042_SOC_empty,
 						config->socempty);
 	max17042_override_por(map, MAX17042_LAvg_empty, config->lavg_empty);
 	max17042_override_por(map, MAX17042_dQacc, config->dqacc);
 	max17042_override_por(map, MAX17042_dPacc, config->dpacc);
 
-	if (chip->chip_type == MAX17042)
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042)
 		max17042_override_por(map, MAX17042_V_empty, config->vempty);
 	else
 		max17042_override_por(map, MAX17047_V_empty, config->vempty);
@@ -709,20 +707,9 @@ static int max17042_probe(struct i2c_client *client,
 	}
 
 	i2c_set_clientdata(client, chip);
+	chip->chip_type = id->driver_data;
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
@@ -834,9 +821,9 @@ MODULE_DEVICE_TABLE(of, max17042_dt_match);
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
index 89dd84f..cf112b4 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -126,7 +126,14 @@ enum max17047_register {
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
 
 /*
  * used for setting a register to a desired value
-- 
1.7.9.5

