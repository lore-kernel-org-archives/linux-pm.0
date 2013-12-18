From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 1/3] fuelgauge: max17042: Do code cleaning to follow kernel
 code convention.
Date: Wed, 18 Dec 2013 12:53:52 +0900
Message-ID: <1387338834-4046-2-git-send-email-jonghwa3.lee@samsung.com>
References: <1387338834-4046-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:24898 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714Ab3LRDyA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2013 22:54:00 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXZ00MXXHHZOZ40@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 18 Dec 2013 12:53:59 +0900 (KST)
In-reply-to: <1387338834-4046-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: anton@enomsg.org, dwmw2@infradead.org, Jonghwa Lee <jonghwa3.lee@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>

- Remove camel case,
- Move #define macros to header file,

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/power/max17042_battery.c       |  185 +++++++++++++-------------------
 include/linux/power/max17042_battery.h |  155 ++++++++++++++------------
 2 files changed, 166 insertions(+), 174 deletions(-)

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index e0b22f9..bbb2e01 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -35,37 +35,6 @@
 #include <linux/of.h>
 #include <linux/regmap.h>
 
-/* Status register bits */
-#define STATUS_POR_BIT         (1 << 1)
-#define STATUS_BST_BIT         (1 << 3)
-#define STATUS_VMN_BIT         (1 << 8)
-#define STATUS_TMN_BIT         (1 << 9)
-#define STATUS_SMN_BIT         (1 << 10)
-#define STATUS_BI_BIT          (1 << 11)
-#define STATUS_VMX_BIT         (1 << 12)
-#define STATUS_TMX_BIT         (1 << 13)
-#define STATUS_SMX_BIT         (1 << 14)
-#define STATUS_BR_BIT          (1 << 15)
-
-/* Interrupt mask bits */
-#define CONFIG_ALRT_BIT_ENBL	(1 << 2)
-#define STATUS_INTR_SOCMIN_BIT	(1 << 10)
-#define STATUS_INTR_SOCMAX_BIT	(1 << 14)
-
-#define VFSOC0_LOCK		0x0000
-#define VFSOC0_UNLOCK		0x0080
-#define MODEL_UNLOCK1	0X0059
-#define MODEL_UNLOCK2	0X00C4
-#define MODEL_LOCK1		0X0000
-#define MODEL_LOCK2		0X0000
-
-#define dQ_ACC_DIV	0x4
-#define dP_ACC_100	0x1900
-#define dP_ACC_200	0x3200
-
-#define MAX17042_IC_VERSION	0x0092
-#define MAX17047_IC_VERSION	0x00AC	/* same for max17050 */
-
 struct max17042_chip {
 	struct i2c_client *client;
 	struct regmap *regmap;
@@ -111,20 +80,20 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		if (data & MAX17042_STATUS_BattAbsent)
+		if (data & STATUS_BST_BIT)
 			val->intval = 0;
 		else
 			val->intval = 1;
 		break;
 	case POWER_SUPPLY_PROP_CYCLE_COUNT:
-		ret = regmap_read(map, MAX17042_Cycles, &data);
+		ret = regmap_read(map, MAX17042_CYCLES, &data);
 		if (ret < 0)
 			return ret;
 
 		val->intval = data;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
-		ret = regmap_read(map, MAX17042_MinMaxVolt, &data);
+		ret = regmap_read(map, MAX17042_MINMAXVOLT, &data);
 		if (ret < 0)
 			return ret;
 
@@ -133,9 +102,9 @@ static int max17042_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 		if (chip->chip_type == MAX17042)
-			ret = regmap_read(map, MAX17042_V_empty, &data);
+			ret = regmap_read(map, MAX17042_V_EMPTY, &data);
 		else
-			ret = regmap_read(map, MAX17047_V_empty, &data);
+			ret = regmap_read(map, MAX17047_V_EMPTY, &data);
 		if (ret < 0)
 			return ret;
 
@@ -150,28 +119,28 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = data * 625 / 8;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
-		ret = regmap_read(map, MAX17042_AvgVCELL, &data);
+		ret = regmap_read(map, MAX17042_AVGVCELL, &data);
 		if (ret < 0)
 			return ret;
 
 		val->intval = data * 625 / 8;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
-		ret = regmap_read(map, MAX17042_OCVInternal, &data);
+		ret = regmap_read(map, MAX17042_OCVINTERNAL, &data);
 		if (ret < 0)
 			return ret;
 
 		val->intval = data * 625 / 8;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		ret = regmap_read(map, MAX17042_RepSOC, &data);
+		ret = regmap_read(map, MAX17042_REPSOC, &data);
 		if (ret < 0)
 			return ret;
 
 		val->intval = data >> 8;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
-		ret = regmap_read(map, MAX17042_FullCAP, &data);
+		ret = regmap_read(map, MAX17042_FULLCAP, &data);
 		if (ret < 0)
 			return ret;
 
@@ -201,7 +170,7 @@ static int max17042_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (chip->pdata->enable_current_sense) {
-			ret = regmap_read(map, MAX17042_Current, &data);
+			ret = regmap_read(map, MAX17042_CURRENT, &data);
 			if (ret < 0)
 				return ret;
 
@@ -219,7 +188,7 @@ static int max17042_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
 		if (chip->pdata->enable_current_sense) {
-			ret = regmap_read(map, MAX17042_AvgCurrent, &data);
+			ret = regmap_read(map, MAX17042_AVGCURRENT, &data);
 			if (ret < 0)
 				return ret;
 
@@ -272,16 +241,16 @@ static inline void max17042_override_por(struct regmap *map,
 static inline void max10742_unlock_model(struct max17042_chip *chip)
 {
 	struct regmap *map = chip->regmap;
-	regmap_write(map, MAX17042_MLOCKReg1, MODEL_UNLOCK1);
-	regmap_write(map, MAX17042_MLOCKReg2, MODEL_UNLOCK2);
+	regmap_write(map, MAX17042_MLOCKREG1, MODEL_UNLOCK1);
+	regmap_write(map, MAX17042_MLOCKREG2, MODEL_UNLOCK2);
 }
 
 static inline void max10742_lock_model(struct max17042_chip *chip)
 {
 	struct regmap *map = chip->regmap;
 
-	regmap_write(map, MAX17042_MLOCKReg1, MODEL_LOCK1);
-	regmap_write(map, MAX17042_MLOCKReg2, MODEL_LOCK2);
+	regmap_write(map, MAX17042_MLOCKREG1, MODEL_LOCK1);
+	regmap_write(map, MAX17042_MLOCKREG2, MODEL_LOCK2);
 }
 
 static inline void max17042_write_model_data(struct max17042_chip *chip,
@@ -331,9 +300,9 @@ static int max17042_init_model(struct max17042_chip *chip)
 		return -ENOMEM;
 
 	max10742_unlock_model(chip);
-	max17042_write_model_data(chip, MAX17042_MODELChrTbl,
+	max17042_write_model_data(chip, MAX17042_MODELCHRTBL,
 				table_size);
-	max17042_read_model_data(chip, MAX17042_MODELChrTbl, temp_data,
+	max17042_read_model_data(chip, MAX17042_MODELCHRTBL, temp_data,
 				table_size);
 
 	ret = max17042_model_data_compare(
@@ -359,7 +328,7 @@ static int max17042_verify_model_lock(struct max17042_chip *chip)
 	if (!temp_data)
 		return -ENOMEM;
 
-	max17042_read_model_data(chip, MAX17042_MODELChrTbl, temp_data,
+	max17042_read_model_data(chip, MAX17042_MODELCHRTBL, temp_data,
 				table_size);
 	for (i = 0; i < table_size; i++)
 		if (temp_data[i])
@@ -375,12 +344,12 @@ static void max17042_write_config_regs(struct max17042_chip *chip)
 	struct regmap *map = chip->regmap;
 
 	regmap_write(map, MAX17042_CONFIG, config->config);
-	regmap_write(map, MAX17042_LearnCFG, config->learn_cfg);
-	regmap_write(map, MAX17042_FilterCFG,
+	regmap_write(map, MAX17042_LEARNCFG, config->learn_cfg);
+	regmap_write(map, MAX17042_FILTERCFG,
 			config->filter_cfg);
-	regmap_write(map, MAX17042_RelaxCFG, config->relax_cfg);
+	regmap_write(map, MAX17042_RELAXCFG, config->relax_cfg);
 	if (chip->chip_type == MAX17047)
-		regmap_write(map, MAX17047_FullSOCThr,
+		regmap_write(map, MAX17047_FULLSOCTHR,
 						config->full_soc_thresh);
 }
 
@@ -390,20 +359,20 @@ static void  max17042_write_custom_regs(struct max17042_chip *chip)
 	struct regmap *map = chip->regmap;
 
 	max17042_write_verify_reg(map, MAX17042_RCOMP0, config->rcomp0);
-	max17042_write_verify_reg(map, MAX17042_TempCo,	config->tcompc0);
-	max17042_write_verify_reg(map, MAX17042_ICHGTerm, config->ichgt_term);
+	max17042_write_verify_reg(map, MAX17042_TEMPCO,	config->tcompc0);
+	max17042_write_verify_reg(map, MAX17042_ICHGTERM, config->ichgt_term);
 	if (chip->chip_type == MAX17042) {
-		regmap_write(map, MAX17042_EmptyTempCo,	config->empty_tempco);
-		max17042_write_verify_reg(map, MAX17042_K_empty0,
+		regmap_write(map, MAX17042_EMPTYTEMPCO,	config->empty_tempco);
+		max17042_write_verify_reg(map, MAX17042_K_EMPTY0,
 					config->kempty0);
 	} else {
-		max17042_write_verify_reg(map, MAX17047_QRTbl00,
+		max17042_write_verify_reg(map, MAX17047_QRTBL00,
 						config->qrtbl00);
-		max17042_write_verify_reg(map, MAX17047_QRTbl10,
+		max17042_write_verify_reg(map, MAX17047_QRTBL10,
 						config->qrtbl10);
-		max17042_write_verify_reg(map, MAX17047_QRTbl20,
+		max17042_write_verify_reg(map, MAX17047_QRTBL20,
 						config->qrtbl20);
-		max17042_write_verify_reg(map, MAX17047_QRTbl30,
+		max17042_write_verify_reg(map, MAX17047_QRTBL30,
 						config->qrtbl30);
 	}
 }
@@ -413,10 +382,10 @@ static void max17042_update_capacity_regs(struct max17042_chip *chip)
 	struct max17042_config_data *config = chip->pdata->config_data;
 	struct regmap *map = chip->regmap;
 
-	max17042_write_verify_reg(map, MAX17042_FullCAP,
+	max17042_write_verify_reg(map, MAX17042_FULLCAP,
 				config->fullcap);
-	regmap_write(map, MAX17042_DesignCap, config->design_cap);
-	max17042_write_verify_reg(map, MAX17042_FullCAPNom,
+	regmap_write(map, MAX17042_DESIGNCAP, config->design_cap);
+	max17042_write_verify_reg(map, MAX17042_FULLCAPNOM,
 				config->fullcapnom);
 }
 
@@ -426,9 +395,9 @@ static void max17042_reset_vfsoc0_reg(struct max17042_chip *chip)
 	struct regmap *map = chip->regmap;
 
 	regmap_read(map, MAX17042_VFSOC, &vfSoc);
-	regmap_write(map, MAX17042_VFSOC0Enable, VFSOC0_UNLOCK);
+	regmap_write(map, MAX17042_VFSOC0ENABLE, VFSOC0_UNLOCK);
 	max17042_write_verify_reg(map, MAX17042_VFSOC0, vfSoc);
-	regmap_write(map, MAX17042_VFSOC0Enable, VFSOC0_LOCK);
+	regmap_write(map, MAX17042_VFSOC0ENABLE, VFSOC0_LOCK);
 }
 
 static void max17042_load_new_capacity_params(struct max17042_chip *chip)
@@ -439,7 +408,7 @@ static void max17042_load_new_capacity_params(struct max17042_chip *chip)
 	struct max17042_config_data *config = chip->pdata->config_data;
 	struct regmap *map = chip->regmap;
 
-	regmap_read(map, MAX17042_FullCAP0, &full_cap0);
+	regmap_read(map, MAX17042_FULLCAP0, &full_cap0);
 	regmap_read(map, MAX17042_VFSOC, &vfSoc);
 
 	/* fg_vfSoc needs to shifted by 8 bits to get the
@@ -447,24 +416,24 @@ static void max17042_load_new_capacity_params(struct max17042_chip *chip)
 	 * full_cap0, fg_vfSoc and devide by 100
 	 */
 	rem_cap = ((vfSoc >> 8) * full_cap0) / 100;
-	max17042_write_verify_reg(map, MAX17042_RemCap, rem_cap);
+	max17042_write_verify_reg(map, MAX17042_REMCAP, rem_cap);
 
 	rep_cap = rem_cap;
-	max17042_write_verify_reg(map, MAX17042_RepCap, rep_cap);
+	max17042_write_verify_reg(map, MAX17042_REPCAP, rep_cap);
 
 	/* Write dQ_acc to 200% of Capacity and dP_acc to 200% */
-	dq_acc = config->fullcap / dQ_ACC_DIV;
-	max17042_write_verify_reg(map, MAX17042_dQacc, dq_acc);
-	max17042_write_verify_reg(map, MAX17042_dPacc, dP_ACC_200);
+	dq_acc = config->fullcap / DQ_ACC_DIV;
+	max17042_write_verify_reg(map, MAX17042_DQACC, dq_acc);
+	max17042_write_verify_reg(map, MAX17042_DPACC, DP_ACC_200);
 
-	max17042_write_verify_reg(map, MAX17042_FullCAP,
+	max17042_write_verify_reg(map, MAX17042_FULLCAP,
 			config->fullcap);
-	regmap_write(map, MAX17042_DesignCap,
+	regmap_write(map, MAX17042_DESIGNCAP,
 			config->design_cap);
-	max17042_write_verify_reg(map, MAX17042_FullCAPNom,
+	max17042_write_verify_reg(map, MAX17042_FULLCAPNOM,
 			config->fullcapnom);
 	/* Update SOC register with new SOC */
-	regmap_write(map, MAX17042_RepSOC, vfSoc);
+	regmap_write(map, MAX17042_REPSOC, vfSoc);
 }
 
 /*
@@ -478,49 +447,49 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 	struct max17042_config_data *config = chip->pdata->config_data;
 
 	max17042_override_por(map, MAX17042_TGAIN, config->tgain);
-	max17042_override_por(map, MAx17042_TOFF, config->toff);
+	max17042_override_por(map, MAX17042_TOFF, config->toff);
 	max17042_override_por(map, MAX17042_CGAIN, config->cgain);
 	max17042_override_por(map, MAX17042_COFF, config->coff);
 
-	max17042_override_por(map, MAX17042_VALRT_Th, config->valrt_thresh);
-	max17042_override_por(map, MAX17042_TALRT_Th, config->talrt_thresh);
-	max17042_override_por(map, MAX17042_SALRT_Th,
+	max17042_override_por(map, MAX17042_VALRT_TH, config->valrt_thresh);
+	max17042_override_por(map, MAX17042_TALRT_TH, config->talrt_thresh);
+	max17042_override_por(map, MAX17042_SALRT_TH,
 						config->soc_alrt_thresh);
 	max17042_override_por(map, MAX17042_CONFIG, config->config);
 	max17042_override_por(map, MAX17042_SHDNTIMER, config->shdntimer);
 
-	max17042_override_por(map, MAX17042_DesignCap, config->design_cap);
-	max17042_override_por(map, MAX17042_ICHGTerm, config->ichgt_term);
+	max17042_override_por(map, MAX17042_DESIGNCAP, config->design_cap);
+	max17042_override_por(map, MAX17042_ICHGTERM, config->ichgt_term);
 
-	max17042_override_por(map, MAX17042_AtRate, config->at_rate);
-	max17042_override_por(map, MAX17042_LearnCFG, config->learn_cfg);
-	max17042_override_por(map, MAX17042_FilterCFG, config->filter_cfg);
-	max17042_override_por(map, MAX17042_RelaxCFG, config->relax_cfg);
-	max17042_override_por(map, MAX17042_MiscCFG, config->misc_cfg);
-	max17042_override_por(map, MAX17042_MaskSOC, config->masksoc);
+	max17042_override_por(map, MAX17042_ATRATE, config->at_rate);
+	max17042_override_por(map, MAX17042_LEARNCFG, config->learn_cfg);
+	max17042_override_por(map, MAX17042_FILTERCFG, config->filter_cfg);
+	max17042_override_por(map, MAX17042_RELAXCFG, config->relax_cfg);
+	max17042_override_por(map, MAX17042_MISCCFG, config->misc_cfg);
+	max17042_override_por(map, MAX17042_MASKSOC, config->masksoc);
 
-	max17042_override_por(map, MAX17042_FullCAP, config->fullcap);
-	max17042_override_por(map, MAX17042_FullCAPNom, config->fullcapnom);
+	max17042_override_por(map, MAX17042_FULLCAP, config->fullcap);
+	max17042_override_por(map, MAX17042_FULLCAPNOM, config->fullcapnom);
 	if (chip->chip_type == MAX17042)
-		max17042_override_por(map, MAX17042_SOC_empty,
+		max17042_override_por(map, MAX17042_SOC_EMPTY,
 						config->socempty);
-	max17042_override_por(map, MAX17042_LAvg_empty, config->lavg_empty);
-	max17042_override_por(map, MAX17042_dQacc, config->dqacc);
-	max17042_override_por(map, MAX17042_dPacc, config->dpacc);
+	max17042_override_por(map, MAX17042_LAVG_EMPTY, config->lavg_empty);
+	max17042_override_por(map, MAX17042_DQACC, config->dqacc);
+	max17042_override_por(map, MAX17042_DPACC, config->dpacc);
 
 	if (chip->chip_type == MAX17042)
-		max17042_override_por(map, MAX17042_V_empty, config->vempty);
+		max17042_override_por(map, MAX17042_V_EMPTY, config->vempty);
 	else
-		max17042_override_por(map, MAX17047_V_empty, config->vempty);
-	max17042_override_por(map, MAX17042_TempNom, config->temp_nom);
-	max17042_override_por(map, MAX17042_TempLim, config->temp_lim);
+		max17042_override_por(map, MAX17047_V_EMPTY, config->vempty);
+	max17042_override_por(map, MAX17042_TEMPNOM, config->temp_nom);
+	max17042_override_por(map, MAX17042_TEMPLIM, config->temp_lim);
 	max17042_override_por(map, MAX17042_FCTC, config->fctc);
 	max17042_override_por(map, MAX17042_RCOMP0, config->rcomp0);
-	max17042_override_por(map, MAX17042_TempCo, config->tcompc0);
+	max17042_override_por(map, MAX17042_TEMPCO, config->tcompc0);
 	if (chip->chip_type) {
-		max17042_override_por(map, MAX17042_EmptyTempCo,
+		max17042_override_por(map, MAX17042_EMPTYTEMPCO,
 						config->empty_tempco);
-		max17042_override_por(map, MAX17042_K_empty0,
+		max17042_override_por(map, MAX17042_K_EMPTY0,
 						config->kempty0);
 	}
 }
@@ -585,11 +554,11 @@ static void max17042_set_soc_threshold(struct max17042_chip *chip, u16 off)
 	/* program interrupt thesholds such that we should
 	 * get interrupt for every 'off' perc change in the soc
 	 */
-	regmap_read(map, MAX17042_RepSOC, &soc);
+	regmap_read(map, MAX17042_REPSOC, &soc);
 	soc >>= 8;
 	soc_tr = (soc + off) << 8;
 	soc_tr |= (soc - off);
-	regmap_write(map, MAX17042_SALRT_Th, soc_tr);
+	regmap_write(map, MAX17042_SALRT_TH, soc_tr);
 }
 
 static irqreturn_t max17042_thread_handler(int id, void *dev)
@@ -598,8 +567,8 @@ static irqreturn_t max17042_thread_handler(int id, void *dev)
 	u32 val;
 
 	regmap_read(chip->regmap, MAX17042_STATUS, &val);
-	if ((val & STATUS_INTR_SOCMIN_BIT) ||
-		(val & STATUS_INTR_SOCMAX_BIT)) {
+	if ((val & STATUS_SMN_BIT) ||
+		(val & STATUS_SMX_BIT)) {
 		dev_info(&chip->client->dev, "SOC threshold INTR\n");
 		max17042_set_soc_threshold(chip, 1);
 	}
@@ -695,7 +664,7 @@ static int max17042_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, chip);
 
-	regmap_read(chip->regmap, MAX17042_DevName, &val);
+	regmap_read(chip->regmap, MAX17042_DEVNAME, &val);
 	if (val == MAX17042_IC_VERSION) {
 		dev_dbg(&client->dev, "chip type max17042 detected\n");
 		chip->chip_type = MAX17042;
@@ -729,8 +698,8 @@ static int max17042_probe(struct i2c_client *client,
 
 	if (!chip->pdata->enable_current_sense) {
 		regmap_write(chip->regmap, MAX17042_CGAIN, 0x0000);
-		regmap_write(chip->regmap, MAX17042_MiscCFG, 0x0003);
-		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
+		regmap_write(chip->regmap, MAX17042_MISCCFG, 0x0003);
+		regmap_write(chip->regmap, MAX17042_LEARNCFG, 0x0007);
 	}
 
 	ret = power_supply_register(&client->dev, &chip->battery);
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index 89dd84f..7f75ecd 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -23,107 +23,130 @@
 #ifndef __MAX17042_BATTERY_H_
 #define __MAX17042_BATTERY_H_
 
-#define MAX17042_STATUS_BattAbsent	(1 << 3)
+/* Status register bits */
+#define STATUS_POR_BIT         (1 << 1)
+#define STATUS_BST_BIT         (1 << 3)
+#define STATUS_VMN_BIT         (1 << 8)
+#define STATUS_TMN_BIT         (1 << 9)
+#define STATUS_SMN_BIT         (1 << 10)
+#define STATUS_BI_BIT          (1 << 11)
+#define STATUS_VMX_BIT         (1 << 12)
+#define STATUS_TMX_BIT         (1 << 13)
+#define STATUS_SMX_BIT         (1 << 14)
+#define STATUS_BR_BIT          (1 << 15)
+
+/* Config register bits */
+#define CONFIG_ALRT_BIT_ENBL	(1 << 2)
+
 #define MAX17042_BATTERY_FULL	(100)
 #define MAX17042_DEFAULT_SNS_RESISTOR	(10000)
-
 #define MAX17042_CHARACTERIZATION_DATA_SIZE 48
 
+#define VFSOC0_LOCK	0x0000
+#define VFSOC0_UNLOCK	0x0080
+#define MODEL_UNLOCK1	0X0059
+#define MODEL_UNLOCK2	0X00C4
+#define MODEL_LOCK1	0X0000
+#define MODEL_LOCK2	0X0000
+
+#define DQ_ACC_DIV	0x4
+#define DP_ACC_100	0x1900
+#define DP_ACC_200	0x3200
+
+#define MAX17042_IC_VERSION	0x0092
+#define MAX17047_IC_VERSION	0x00AC	/* same for max17050 */
+
 enum max17042_register {
 	MAX17042_STATUS		= 0x00,
-	MAX17042_VALRT_Th	= 0x01,
-	MAX17042_TALRT_Th	= 0x02,
-	MAX17042_SALRT_Th	= 0x03,
-	MAX17042_AtRate		= 0x04,
-	MAX17042_RepCap		= 0x05,
-	MAX17042_RepSOC		= 0x06,
-	MAX17042_Age		= 0x07,
+	MAX17042_VALRT_TH	= 0x01,
+	MAX17042_TALRT_TH	= 0x02,
+	MAX17042_SALRT_TH	= 0x03,
+	MAX17042_ATRATE		= 0x04,
+	MAX17042_REPCAP		= 0x05,
+	MAX17042_REPSOC		= 0x06,
+	MAX17042_AGE		= 0x07,
 	MAX17042_TEMP		= 0x08,
 	MAX17042_VCELL		= 0x09,
-	MAX17042_Current	= 0x0A,
-	MAX17042_AvgCurrent	= 0x0B,
-
+	MAX17042_CURRENT	= 0x0A,
+	MAX17042_AVGCURRENT	= 0x0B,
 	MAX17042_SOC		= 0x0D,
-	MAX17042_AvSOC		= 0x0E,
-	MAX17042_RemCap		= 0x0F,
-	MAX17042_FullCAP	= 0x10,
-	MAX17042_TTE		= 0x11,
-	MAX17042_V_empty	= 0x12,
+	MAX17042_AVSOC		= 0x0E,
+	MAX17042_REMCAP		= 0x0F,
 
+	MAX17042_FULLCAP	= 0x10,
+	MAX17042_TTE		= 0x11,
+	MAX17042_V_EMPTY	= 0x12,
 	MAX17042_RSLOW		= 0x14,
-
-	MAX17042_AvgTA		= 0x16,
-	MAX17042_Cycles		= 0x17,
-	MAX17042_DesignCap	= 0x18,
-	MAX17042_AvgVCELL	= 0x19,
-	MAX17042_MinMaxTemp	= 0x1A,
-	MAX17042_MinMaxVolt	= 0x1B,
-	MAX17042_MinMaxCurr	= 0x1C,
+	MAX17042_AVGTA		= 0x16,
+	MAX17042_CYCLES		= 0x17,
+	MAX17042_DESIGNCAP	= 0x18,
+	MAX17042_AVGVCELL	= 0x19,
+	MAX17042_MINMAXTEMP	= 0x1A,
+	MAX17042_MINMAXVOLT	= 0x1B,
+	MAX17042_MINMAXCURR	= 0x1C,
 	MAX17042_CONFIG		= 0x1D,
-	MAX17042_ICHGTerm	= 0x1E,
-	MAX17042_AvCap		= 0x1F,
-	MAX17042_ManName	= 0x20,
-	MAX17042_DevName	= 0x21,
-
-	MAX17042_FullCAPNom	= 0x23,
-	MAX17042_TempNom	= 0x24,
-	MAX17042_TempLim	= 0x25,
-	MAX17042_TempHot	= 0x26,
+	MAX17042_ICHGTERM	= 0x1E,
+	MAX17042_AVCAP		= 0x1F,
+
+	MAX17042_MANNAME	= 0x20,
+	MAX17042_DEVNAME	= 0x21,
+	MAX17042_FULLCAPNOM	= 0x23,
+	MAX17042_TEMPNOM	= 0x24,
+	MAX17042_TEMPLIM	= 0x25,
+	MAX17042_TEMPHOT	= 0x26,
 	MAX17042_AIN		= 0x27,
-	MAX17042_LearnCFG	= 0x28,
-	MAX17042_FilterCFG	= 0x29,
-	MAX17042_RelaxCFG	= 0x2A,
-	MAX17042_MiscCFG	= 0x2B,
+	MAX17042_LEARNCFG	= 0x28,
+	MAX17042_FILTERCFG	= 0x29,
+	MAX17042_RELAXCFG	= 0x2A,
+	MAX17042_MISCCFG	= 0x2B,
 	MAX17042_TGAIN		= 0x2C,
-	MAx17042_TOFF		= 0x2D,
+	MAX17042_TOFF		= 0x2D,
 	MAX17042_CGAIN		= 0x2E,
 	MAX17042_COFF		= 0x2F,
 
-	MAX17042_MaskSOC	= 0x32,
-	MAX17042_SOC_empty	= 0x33,
-	MAX17042_T_empty	= 0x34,
-
-	MAX17042_FullCAP0       = 0x35,
-	MAX17042_LAvg_empty	= 0x36,
+	MAX17042_MASKSOC	= 0x32,
+	MAX17042_SOC_EMPTY	= 0x33,
+	MAX17042_T_EMPTY	= 0x34,
+	MAX17042_FULLCAP0       = 0x35,
+	MAX17042_LAVG_EMPTY	= 0x36,
 	MAX17042_FCTC		= 0x37,
 	MAX17042_RCOMP0		= 0x38,
-	MAX17042_TempCo		= 0x39,
-	MAX17042_EmptyTempCo	= 0x3A,
-	MAX17042_K_empty0	= 0x3B,
-	MAX17042_TaskPeriod	= 0x3C,
+	MAX17042_TEMPCO		= 0x39,
+	MAX17042_EMPTYTEMPCO	= 0x3A,
+	MAX17042_K_EMPTY0	= 0x3B,
+	MAX17042_TASKPERIOD	= 0x3C,
 	MAX17042_FSTAT		= 0x3D,
-
 	MAX17042_SHDNTIMER	= 0x3F,
 
-	MAX17042_dQacc		= 0x45,
-	MAX17042_dPacc		= 0x46,
-
+	MAX17042_DQACC		= 0x45,
+	MAX17042_DPACC		= 0x46,
 	MAX17042_VFSOC0		= 0x48,
-
 	MAX17042_QH		= 0x4D,
 	MAX17042_QL		= 0x4E,
 
-	MAX17042_VFSOC0Enable	= 0x60,
-	MAX17042_MLOCKReg1	= 0x62,
-	MAX17042_MLOCKReg2	= 0x63,
+	MAX17042_VFSOC0ENABLE	= 0x60,
+	MAX17042_MLOCKREG1	= 0x62,
+	MAX17042_MLOCKREG2	= 0x63,
 
-	MAX17042_MODELChrTbl	= 0x80,
+	MAX17042_MODELCHRTBL	= 0x80,
 
 	MAX17042_OCV		= 0xEE,
 
-	MAX17042_OCVInternal	= 0xFB,
-
+	MAX17042_OCVINTERNAL	= 0xFB,
 	MAX17042_VFSOC		= 0xFF,
 };
 
 /* Registers specific to max17047/50 */
 enum max17047_register {
-	MAX17047_QRTbl00	= 0x12,
-	MAX17047_FullSOCThr	= 0x13,
-	MAX17047_QRTbl10	= 0x22,
-	MAX17047_QRTbl20	= 0x32,
-	MAX17047_V_empty	= 0x3A,
-	MAX17047_QRTbl30	= 0x42,
+	MAX17047_QRTBL00	= 0x12,
+	MAX17047_FULLSOCTHR	= 0x13,
+
+	MAX17047_QRTBL10	= 0x22,
+
+	MAX17047_QRTBL20	= 0x32,
+	MAX17047_V_EMPTY	= 0x3A,
+
+	MAX17047_QRTBL30	= 0x42,
 };
 
 enum max170xx_chip_type {MAX17042, MAX17047};
-- 
1.7.9.5

