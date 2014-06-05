From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 4/4] power: max17042_battery: Refactoring max17042 driver
Date: Thu, 05 Jun 2014 12:46:17 +0900
Message-ID: <1401939977-20328-5-git-send-email-jonghwa3.lee@samsung.com>
References: <1401939977-20328-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18603 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbaFEDq1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jun 2014 23:46:27 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6O003YHFTDLC70@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Thu, 05 Jun 2014 12:46:25 +0900 (KST)
In-reply-to: <1401939977-20328-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, Jonghwa Lee <jonghwa3.lee@samsung.com>

This patch refactors and optimizes max17042 driver by removing unneccessary
wrapping functions and duplicate initialization. Addition to this, it also
relocates some codes and functions for better readability.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/power/max17042_battery.c |  362 ++++++++++----------------------------
 1 file changed, 93 insertions(+), 269 deletions(-)

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index 0178a32..abad31b 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -240,106 +240,41 @@ static int max17042_get_property(struct power_supply *psy,
 static int max17042_write_verify_reg(struct regmap *map, u8 reg, u32 value)
 {
 	int retries = 8;
-	int ret;
 	u32 read_value;
 
 	do {
-		ret = regmap_write(map, reg, value);
-		regmap_read(map, reg, &read_value);
-		if (read_value != value) {
-			ret = -EIO;
-			retries--;
-		}
-	} while (retries && read_value != value);
-
-	if (ret < 0)
-		pr_err("%s: err %d\n", __func__, ret);
-
-	return ret;
-}
-
-static inline void max17042_override_por(struct regmap *map,
-					 u8 reg, u16 value)
-{
-	if (value)
 		regmap_write(map, reg, value);
-}
-
-static inline void max10742_unlock_model(struct max17042_chip *chip)
-{
-	struct regmap *map = chip->regmap;
-	regmap_write(map, MAX17042_MLOCKReg1, MODEL_UNLOCK1);
-	regmap_write(map, MAX17042_MLOCKReg2, MODEL_UNLOCK2);
-}
-
-static inline void max10742_lock_model(struct max17042_chip *chip)
-{
-	struct regmap *map = chip->regmap;
-
-	regmap_write(map, MAX17042_MLOCKReg1, MODEL_LOCK1);
-	regmap_write(map, MAX17042_MLOCKReg2, MODEL_LOCK2);
-}
-
-static inline void max17042_write_model_data(struct max17042_chip *chip,
-					u8 addr, int size)
-{
-	struct regmap *map = chip->regmap;
-	int i;
-	for (i = 0; i < size; i++)
-		regmap_write(map, addr + i,
-			chip->pdata->config_data->cell_char_tbl[i]);
-}
-
-static inline void max17042_read_model_data(struct max17042_chip *chip,
-					u8 addr, u32 *data, int size)
-{
-	struct regmap *map = chip->regmap;
-	int i;
-
-	for (i = 0; i < size; i++)
-		regmap_read(map, addr + i, &data[i]);
-}
+		regmap_read(map, reg, &read_value);
+		if (read_value == value)
+			return 0;
+	} while (--retries);
 
-static inline int max17042_model_data_compare(struct max17042_chip *chip,
-					u16 *data1, u16 *data2, int size)
-{
-	int i;
+	pr_err("%s: failed to update reg(%x)\n", __func__, reg);
 
-	if (memcmp(data1, data2, size)) {
-		dev_err(&chip->client->dev, "%s compare failed\n", __func__);
-		for (i = 0; i < size; i++)
-			dev_info(&chip->client->dev, "0x%x, 0x%x",
-				data1[i], data2[i]);
-		dev_info(&chip->client->dev, "\n");
-		return -EINVAL;
-	}
-	return 0;
+	return -EIO;
 }
 
 static int max17042_init_model(struct max17042_chip *chip)
 {
-	int ret;
-	int table_size = ARRAY_SIZE(chip->pdata->config_data->cell_char_tbl);
-	u32 *temp_data;
-
-	temp_data = kcalloc(table_size, sizeof(*temp_data), GFP_KERNEL);
-	if (!temp_data)
-		return -ENOMEM;
+	struct max17042_config_data *config = chip->pdata->config_data;
+	int i, ret = 0;
 
-	max10742_unlock_model(chip);
-	max17042_write_model_data(chip, MAX17042_MODELChrTbl,
-				table_size);
-	max17042_read_model_data(chip, MAX17042_MODELChrTbl, temp_data,
-				table_size);
+	/* Unlock model */
+	regmap_write(chip->regmap, MAX17042_MLOCKReg1, MODEL_UNLOCK1);
+	regmap_write(chip->regmap, MAX17042_MLOCKReg2, MODEL_UNLOCK2);
 
-	ret = max17042_model_data_compare(
-		chip,
-		chip->pdata->config_data->cell_char_tbl,
-		(u16 *)temp_data,
-		table_size);
+	/* Update custom model */
+	for (i = 0; i < MAX17042_CHARACTERIZATION_DATA_SIZE; i++) {
+		ret = max17042_write_verify_reg(chip->regmap,
+					MAX17042_MODELChrTbl + i,
+					config->cell_char_tbl[i]);
+		if (ret)
+			return ret;
+	}
 
-	max10742_lock_model(chip);
-	kfree(temp_data);
+	/* Lock model */
+	regmap_write(chip->regmap, MAX17042_MLOCKReg1, MODEL_LOCK1);
+	regmap_write(chip->regmap, MAX17042_MLOCKReg2, MODEL_LOCK2);
 
 	return ret;
 }
@@ -347,120 +282,23 @@ static int max17042_init_model(struct max17042_chip *chip)
 static int max17042_verify_model_lock(struct max17042_chip *chip)
 {
 	int i;
-	int table_size = ARRAY_SIZE(chip->pdata->config_data->cell_char_tbl);
-	u32 *temp_data;
-	int ret = 0;
-
-	temp_data = kcalloc(table_size, sizeof(*temp_data), GFP_KERNEL);
-	if (!temp_data)
-		return -ENOMEM;
-
-	max17042_read_model_data(chip, MAX17042_MODELChrTbl, temp_data,
-				table_size);
-	for (i = 0; i < table_size; i++)
-		if (temp_data[i])
-			ret = -EINVAL;
-
-	kfree(temp_data);
-	return ret;
-}
-
-static void max17042_write_config_regs(struct max17042_chip *chip)
-{
-	struct max17042_config_data *config = chip->pdata->config_data;
-	struct regmap *map = chip->regmap;
-
-	regmap_write(map, MAX17042_CONFIG, config->config);
-	regmap_write(map, MAX17042_LearnCFG, config->learn_cfg);
-	regmap_write(map, MAX17042_FilterCFG,
-			config->filter_cfg);
-	regmap_write(map, MAX17042_RelaxCFG, config->relax_cfg);
-	if (chip->chip_type == MAX17047)
-		regmap_write(map, MAX17047_FullSOCThr,
-						config->full_soc_thresh);
-}
-
-static void  max17042_write_custom_regs(struct max17042_chip *chip)
-{
-	struct max17042_config_data *config = chip->pdata->config_data;
-	struct regmap *map = chip->regmap;
+	u32 val;
 
-	max17042_write_verify_reg(map, MAX17042_RCOMP0, config->rcomp0);
-	max17042_write_verify_reg(map, MAX17042_TempCo,	config->tcompc0);
-	max17042_write_verify_reg(map, MAX17042_ICHGTerm, config->ichgt_term);
-	if (chip->chip_type == MAX17042) {
-		regmap_write(map, MAX17042_EmptyTempCo,	config->empty_tempco);
-		max17042_write_verify_reg(map, MAX17042_K_empty0,
-					config->kempty0);
-	} else {
-		max17042_write_verify_reg(map, MAX17047_QRTbl00,
-						config->qrtbl00);
-		max17042_write_verify_reg(map, MAX17047_QRTbl10,
-						config->qrtbl10);
-		max17042_write_verify_reg(map, MAX17047_QRTbl20,
-						config->qrtbl20);
-		max17042_write_verify_reg(map, MAX17047_QRTbl30,
-						config->qrtbl30);
+	/* After locking model, all registers' value should be zero */
+	for (i = 0; i < MAX17042_CHARACTERIZATION_DATA_SIZE; i++) {
+		regmap_read(chip->regmap, MAX17042_MODELChrTbl + i, &val);
+		if (val)
+			return -EIO;
 	}
-}
-
-static void max17042_update_capacity_regs(struct max17042_chip *chip)
-{
-	struct max17042_config_data *config = chip->pdata->config_data;
-	struct regmap *map = chip->regmap;
-
-	max17042_write_verify_reg(map, MAX17042_FullCAP,
-				config->fullcap);
-	regmap_write(map, MAX17042_DesignCap, config->design_cap);
-	max17042_write_verify_reg(map, MAX17042_FullCAPNom,
-				config->fullcapnom);
-}
-
-static void max17042_reset_vfsoc0_reg(struct max17042_chip *chip)
-{
-	unsigned int vfSoc;
-	struct regmap *map = chip->regmap;
 
-	regmap_read(map, MAX17042_VFSOC, &vfSoc);
-	regmap_write(map, MAX17042_VFSOC0Enable, VFSOC0_UNLOCK);
-	max17042_write_verify_reg(map, MAX17042_VFSOC0, vfSoc);
-	regmap_write(map, MAX17042_VFSOC0Enable, VFSOC0_LOCK);
+	return 0;
 }
 
-static void max17042_load_new_capacity_params(struct max17042_chip *chip)
+static inline void max17042_override_por(struct regmap *map,
+					 u8 reg, u16 value)
 {
-	u32 full_cap0, rep_cap, dq_acc, vfSoc;
-	u32 rem_cap;
-
-	struct max17042_config_data *config = chip->pdata->config_data;
-	struct regmap *map = chip->regmap;
-
-	regmap_read(map, MAX17042_FullCAP0, &full_cap0);
-	regmap_read(map, MAX17042_VFSOC, &vfSoc);
-
-	/* fg_vfSoc needs to shifted by 8 bits to get the
-	 * perc in 1% accuracy, to get the right rem_cap multiply
-	 * full_cap0, fg_vfSoc and devide by 100
-	 */
-	rem_cap = ((vfSoc >> 8) * full_cap0) / 100;
-	max17042_write_verify_reg(map, MAX17042_RemCap, rem_cap);
-
-	rep_cap = rem_cap;
-	max17042_write_verify_reg(map, MAX17042_RepCap, rep_cap);
-
-	/* Write dQ_acc to 200% of Capacity and dP_acc to 200% */
-	dq_acc = config->fullcap / dQ_ACC_DIV;
-	max17042_write_verify_reg(map, MAX17042_dQacc, dq_acc);
-	max17042_write_verify_reg(map, MAX17042_dPacc, dP_ACC_200);
-
-	max17042_write_verify_reg(map, MAX17042_FullCAP,
-			config->fullcap);
-	regmap_write(map, MAX17042_DesignCap,
-			config->design_cap);
-	max17042_write_verify_reg(map, MAX17042_FullCAPNom,
-			config->fullcapnom);
-	/* Update SOC register with new SOC */
-	regmap_write(map, MAX17042_RepSOC, vfSoc);
+	if (value)
+		regmap_write(map, reg, value);
 }
 
 /*
@@ -497,27 +335,40 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 
 	max17042_override_por(map, MAX17042_FullCAP, config->fullcap);
 	max17042_override_por(map, MAX17042_FullCAPNom, config->fullcapnom);
-	if (chip->chip_type == MAX17042)
-		max17042_override_por(map, MAX17042_SOC_empty,
-						config->socempty);
 	max17042_override_por(map, MAX17042_LAvg_empty, config->lavg_empty);
-	max17042_override_por(map, MAX17042_dQacc, config->dqacc);
-	max17042_override_por(map, MAX17042_dPacc, config->dpacc);
 
-	if (chip->chip_type == MAX17042)
-		max17042_override_por(map, MAX17042_V_empty, config->vempty);
-	else
-		max17042_override_por(map, MAX17047_V_empty, config->vempty);
+	/* Write dQ_acc to 200% of Capacity and dP_acc to 200% */
+	max17042_override_por(map, MAX17042_dQacc,
+					config->fullcap / dQ_ACC_DIV);
+	max17042_override_por(map, MAX17042_dPacc, dP_ACC_200);
+
 	max17042_override_por(map, MAX17042_TempNom, config->temp_nom);
 	max17042_override_por(map, MAX17042_TempLim, config->temp_lim);
 	max17042_override_por(map, MAX17042_FCTC, config->fctc);
 	max17042_override_por(map, MAX17042_RCOMP0, config->rcomp0);
 	max17042_override_por(map, MAX17042_TempCo, config->tcompc0);
-	if (chip->chip_type) {
+
+
+	if (chip->chip_type == MAX17042) {
+		max17042_override_por(map, MAX17042_SOC_empty,
+						config->socempty);
+		max17042_override_por(map, MAX17042_V_empty, config->vempty);
 		max17042_override_por(map, MAX17042_EmptyTempCo,
 						config->empty_tempco);
 		max17042_override_por(map, MAX17042_K_empty0,
 						config->kempty0);
+	} else if (chip->chip_type == MAX17047) {
+		max17042_override_por(map, MAX17047_FullSOCThr,
+						config->full_soc_thresh);
+		max17042_override_por(map, MAX17047_V_empty, config->vempty);
+		max17042_override_por(map, MAX17047_QRTbl00,
+						config->qrtbl00);
+		max17042_override_por(map, MAX17047_QRTbl10,
+						config->qrtbl10);
+		max17042_override_por(map, MAX17047_QRTbl20,
+						config->qrtbl20);
+		max17042_override_por(map, MAX17047_QRTbl30,
+						config->qrtbl30);
 	}
 }
 
@@ -525,16 +376,19 @@ static int max17042_init_chip(struct max17042_chip *chip)
 {
 	struct regmap *map = chip->regmap;
 	int ret;
-	int val;
+	long long left_t = 0;
+
+	if (chip->pdata->enable_por_init && chip->pdata->config_data)
+		goto out;
 
-	max17042_override_por_values(chip);
 	/* After Power up, the MAX17042 requires 500mS in order
 	 * to perform signal debouncing and initial SOC reporting
+	 * In most cases, max17042 driver is probed after 500ms.
 	 */
-	msleep(500);
-
-	/* Initialize configaration */
-	max17042_write_config_regs(chip);
+	left_t = jiffies_to_msecs(jiffies - INITIAL_JIFFIES);
+	left_t -= 500;
+	if (left_t > 0)
+		msleep(left_t);
 
 	/* write cell characterization data */
 	ret = max17042_init_model(chip);
@@ -550,26 +404,18 @@ static int max17042_init_chip(struct max17042_chip *chip)
 			__func__);
 		return -EIO;
 	}
-	/* write custom parameters */
-	max17042_write_custom_regs(chip);
 
-	/* update capacity params */
-	max17042_update_capacity_regs(chip);
+	max17042_override_por_values(chip);
 
 	/* delay must be atleast 350mS to allow VFSOC
 	 * to be calculated from the new configuration
 	 */
 	msleep(350);
 
-	/* reset vfsoc0 reg */
-	max17042_reset_vfsoc0_reg(chip);
-
-	/* load new capacity params */
-	max17042_load_new_capacity_params(chip);
-
+out:
 	/* Init complete, Clear the POR bit */
-	regmap_read(map, MAX17042_STATUS, &val);
-	regmap_write(map, MAX17042_STATUS, val & (~STATUS_POR_BIT));
+	regmap_update_bits(map, MAX17042_STATUS, STATUS_POR_BIT, 0);
+
 	return 0;
 }
 
@@ -604,22 +450,6 @@ static irqreturn_t max17042_thread_handler(int id, void *dev)
 	return IRQ_HANDLED;
 }
 
-static int max17042_init_worker(struct max17042_chip *chip)
-{
-	struct max17042_chip *chip = container_of(work,
-				struct max17042_chip, work);
-	int ret;
-
-	/* Initialize registers according to values from the platform data */
-	if (chip->pdata->enable_por_init && chip->pdata->config_data) {
-		ret = max17042_init_chip(chip);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 #ifdef CONFIG_OF
 static struct max17042_platform_data *
 max17042_get_pdata(struct device *dev)
@@ -665,7 +495,6 @@ static int max17042_probe(struct i2c_client *client,
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
 	struct max17042_chip *chip;
 	int ret;
-	int i;
 	u32 val;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA))
@@ -705,34 +534,6 @@ static int max17042_probe(struct i2c_client *client,
 	dev_dbg(&client->dev, "operates as modelgauge %s\n",
 				chip->mode == MODELGAUGE_M1 ? "M1" : "M3");
 
-	chip->battery.name		= "max170xx_battery";
-	chip->battery.type		= POWER_SUPPLY_TYPE_BATTERY;
-	chip->battery.get_property	= max17042_get_property;
-	chip->battery.properties	= max17042_battery_props;
-	if (chip->mode == MODELGAUGE_M3) {
-		/* ModelGauge m3 */
-		chip->battery.num_properties = MODELGAUGE_M3_PROPS;
-		if (chip->pdata->r_sns == 0)
-			chip->pdata->r_sns = MAX17042_DEFAULT_SNS_RESISTOR;
-	} else {
-		/* ModelGauge m1 */
-		chip->battery.num_properties = MODELGAUGE_M1_PROPS;
-		regmap_write(chip->regmap, MAX17042_CGAIN, 0x0000);
-		regmap_write(chip->regmap, MAX17042_MiscCFG, 0x0003);
-		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
-
-		/* Off thermistor - temperature may be externally given */
-		regmap_update_bits(chip->regmap, MAX17042_CONFIG,
-			CONFIG_ETHERM_BIT | CONFIG_TEX_BIT | CONFIG_TEN_BIT,
-			CONFIG_TEX_BIT);
-	}
-
-	if (chip->pdata->init_data)
-		for (i = 0; i < chip->pdata->num_init_data; i++)
-			regmap_write(chip->regmap,
-					chip->pdata->init_data[i].addr,
-					chip->pdata->init_data[i].data);
-
 	if (client->irq) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 					NULL, max17042_thread_handler,
@@ -752,13 +553,36 @@ static int max17042_probe(struct i2c_client *client,
 
 	regmap_read(chip->regmap, MAX17042_STATUS, &val);
 	if (val & STATUS_POR_BIT) {
-		ret = max17042_init_worker(chip);
+		/* Initialize registers with specified data */
+		ret = max17042_init_chip(chip);
 		if (ret) {
 			dev_err(&client->dev, "failed: init chip\n");
 			return ret;
 		}
 	}
 
+	chip->battery.name		= "max170xx_battery";
+	chip->battery.type		= POWER_SUPPLY_TYPE_BATTERY;
+	chip->battery.get_property	= max17042_get_property;
+	chip->battery.properties	= max17042_battery_props;
+	if (chip->mode == MODELGAUGE_M3) {
+		/* ModelGauge m3 */
+		chip->battery.num_properties = MODELGAUGE_M3_PROPS;
+		if (chip->pdata->r_sns == 0)
+			chip->pdata->r_sns = MAX17042_DEFAULT_SNS_RESISTOR;
+	} else {
+		/* ModelGauge m1 */
+		chip->battery.num_properties = MODELGAUGE_M1_PROPS;
+		regmap_write(chip->regmap, MAX17042_CGAIN, 0x0000);
+		regmap_write(chip->regmap, MAX17042_MiscCFG, 0x0003);
+		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
+
+		/* Off thermistor - temperature may be externally given */
+		regmap_update_bits(chip->regmap, MAX17042_CONFIG,
+			CONFIG_ETHERM_BIT | CONFIG_TEX_BIT | CONFIG_TEN_BIT,
+			CONFIG_TEX_BIT);
+	}
+
 	ret = power_supply_register(&client->dev, &chip->battery);
 	if (ret) {
 		dev_err(&client->dev, "failed: power supply register\n");
-- 
1.7.9.5

