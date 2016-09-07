From: Vinay Simha BN <simhavcs@gmail.com>
Subject: [PATCH 3/4] power: smb347-charger: Support devicetree binding
Date: Wed,  7 Sep 2016 15:50:12 +0530
Message-ID: <1473243615-29746-3-git-send-email-simhavcs@gmail.com>
References: <1473243615-29746-1-git-send-email-simhavcs@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34939 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932245AbcIGKVA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Sep 2016 06:21:00 -0400
In-Reply-To: <1473243615-29746-1-git-send-email-simhavcs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: Vinay Simha BN <simhavcs@gmail.com>, John Stultz <john.stultz@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Sebastian Reichel <sre@kernel.org>, "open list:POWER SUPPLY CLASS/SUBSYSTEM and
        DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

smb347 charger driver to support dt binding.
All legacy platform data now can be parsed from dt.
smb347 is i2c client driver, IRQ number can be passed
automatically through client's irq variable.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
---
 drivers/power/supply/smb347-charger.c | 198 +++++++++++++++++++++++-----------
 1 file changed, 134 insertions(+), 64 deletions(-)

diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 072c518..472f5e2 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -136,7 +136,7 @@
  * @pdata: pointer to platform data
  */
 struct smb347_charger {
-	struct mutex		lock;
+	struct mutex		lock; /* protects concurrent access */
 	struct device		*dev;
 	struct regmap		*regmap;
 	struct power_supply	*mains;
@@ -440,9 +440,10 @@ static int smb347_set_voltage_limits(struct smb347_charger *smb)
 		ret = clamp_val(ret, 2400000, 3000000) - 2400000;
 		ret /= 200000;
 
-		ret = regmap_update_bits(smb->regmap, CFG_FLOAT_VOLTAGE,
-				CFG_FLOAT_VOLTAGE_THRESHOLD_MASK,
-				ret << CFG_FLOAT_VOLTAGE_THRESHOLD_SHIFT);
+		ret = regmap_update_bits
+			(smb->regmap, CFG_FLOAT_VOLTAGE,
+			 CFG_FLOAT_VOLTAGE_THRESHOLD_MASK,
+			 ret << CFG_FLOAT_VOLTAGE_THRESHOLD_SHIFT);
 		if (ret < 0)
 			return ret;
 	}
@@ -565,8 +566,9 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
 	}
 
 	if (smb->pdata->suspend_on_hard_temp_limit) {
-		ret = regmap_update_bits(smb->regmap, CFG_SYSOK,
-				 CFG_SYSOK_SUSPEND_HARD_LIMIT_DISABLED, 0);
+		ret = regmap_update_bits
+			(smb->regmap, CFG_SYSOK,
+			 CFG_SYSOK_SUSPEND_HARD_LIMIT_DISABLED, 0);
 		if (ret < 0)
 			return ret;
 	}
@@ -575,15 +577,17 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
 	    SMB347_SOFT_TEMP_COMPENSATE_DEFAULT) {
 		val = smb->pdata->soft_temp_limit_compensation & 0x3;
 
-		ret = regmap_update_bits(smb->regmap, CFG_THERM,
-				 CFG_THERM_SOFT_HOT_COMPENSATION_MASK,
-				 val << CFG_THERM_SOFT_HOT_COMPENSATION_SHIFT);
+		ret = regmap_update_bits
+			(smb->regmap, CFG_THERM,
+			 CFG_THERM_SOFT_HOT_COMPENSATION_MASK,
+			 val << CFG_THERM_SOFT_HOT_COMPENSATION_SHIFT);
 		if (ret < 0)
 			return ret;
 
-		ret = regmap_update_bits(smb->regmap, CFG_THERM,
-				 CFG_THERM_SOFT_COLD_COMPENSATION_MASK,
-				 val << CFG_THERM_SOFT_COLD_COMPENSATION_SHIFT);
+		ret = regmap_update_bits
+			(smb->regmap, CFG_THERM,
+			 CFG_THERM_SOFT_COLD_COMPENSATION_MASK,
+			 val << CFG_THERM_SOFT_COLD_COMPENSATION_SHIFT);
 		if (ret < 0)
 			return ret;
 	}
@@ -594,9 +598,10 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
 		if (val < 0)
 			return val;
 
-		ret = regmap_update_bits(smb->regmap, CFG_OTG,
-				CFG_OTG_CC_COMPENSATION_MASK,
-				(val & 0x3) << CFG_OTG_CC_COMPENSATION_SHIFT);
+		ret = regmap_update_bits
+			(smb->regmap, CFG_OTG,
+			 CFG_OTG_CC_COMPENSATION_MASK,
+			 (val & 0x3) << CFG_OTG_CC_COMPENSATION_SHIFT);
 		if (ret < 0)
 			return ret;
 	}
@@ -662,7 +667,8 @@ static int smb347_hw_init(struct smb347_charger *smb)
 	 * support for driving VBUS. Otherwise we disable it.
 	 */
 	ret = regmap_update_bits(smb->regmap, CFG_OTHER, CFG_OTHER_RID_MASK,
-		smb->pdata->use_usb_otg ? CFG_OTHER_RID_ENABLED_AUTO_OTG : 0);
+				 smb->pdata->use_usb_otg ?
+				 CFG_OTHER_RID_ENABLED_AUTO_OTG : 0);
 	if (ret < 0)
 		goto fail;
 
@@ -809,7 +815,7 @@ static int smb347_irq_set(struct smb347_charger *smb, bool enable)
 		goto fail;
 
 	ret = regmap_update_bits(smb->regmap, CFG_STATUS_IRQ, 0xff,
-			enable ? (CFG_STATUS_IRQ_TERMINATION_OR_TAPER |
+				 enable ? (CFG_STATUS_IRQ_TERMINATION_OR_TAPER |
 					CFG_STATUS_IRQ_CHARGE_TIMEOUT) : 0);
 	if (ret < 0)
 		goto fail;
@@ -834,22 +840,22 @@ static inline int smb347_irq_disable(struct smb347_charger *smb)
 static int smb347_irq_init(struct smb347_charger *smb,
 			   struct i2c_client *client)
 {
-	const struct smb347_charger_platform_data *pdata = smb->pdata;
-	int ret, irq = gpio_to_irq(pdata->irq_gpio);
+	int ret;
+	unsigned long irqflags;
 
-	ret = gpio_request_one(pdata->irq_gpio, GPIOF_IN, client->name);
-	if (ret < 0)
-		goto fail;
+	irqflags = client->dev.of_node ? 0 : IRQF_TRIGGER_FALLING;
+
+	ret = devm_request_threaded_irq(smb->dev, client->irq, NULL,
+					smb347_interrupt, irqflags |
+					IRQF_ONESHOT,
+					client->name, smb);
 
-	ret = request_threaded_irq(irq, NULL, smb347_interrupt,
-				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				   client->name, smb);
 	if (ret < 0)
-		goto fail_gpio;
+		goto out;
 
 	ret = smb347_set_writable(smb, true);
 	if (ret < 0)
-		goto fail_irq;
+		goto out;
 
 	/*
 	 * Configure the STAT output to be suitable for interrupts: disable
@@ -859,20 +865,10 @@ static int smb347_irq_init(struct smb347_charger *smb,
 				 CFG_STAT_ACTIVE_HIGH | CFG_STAT_DISABLED,
 				 CFG_STAT_DISABLED);
 	if (ret < 0)
-		goto fail_readonly;
-
-	smb347_set_writable(smb, false);
-	client->irq = irq;
-	return 0;
+		client->irq = 0;
 
-fail_readonly:
 	smb347_set_writable(smb, false);
-fail_irq:
-	free_irq(irq, smb);
-fail_gpio:
-	gpio_free(pdata->irq_gpio);
-fail:
-	client->irq = 0;
+out:
 	return ret;
 }
 
@@ -947,16 +943,14 @@ static int smb347_mains_get_property(struct power_supply *psy,
 		ret = get_const_charge_voltage(smb);
 		if (ret < 0)
 			return ret;
-		else
-			val->intval = ret;
+		val->intval = ret;
 		break;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		ret = get_const_charge_current(smb);
 		if (ret < 0)
 			return ret;
-		else
-			val->intval = ret;
+		val->intval = ret;
 		break;
 
 	default:
@@ -988,16 +982,14 @@ static int smb347_usb_get_property(struct power_supply *psy,
 		ret = get_const_charge_voltage(smb);
 		if (ret < 0)
 			return ret;
-		else
-			val->intval = ret;
+		val->intval = ret;
 		break;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		ret = get_const_charge_current(smb);
 		if (ret < 0)
 			return ret;
-		else
-			val->intval = ret;
+		val->intval = ret;
 		break;
 
 	default:
@@ -1026,7 +1018,7 @@ static int smb347_get_charging_status(struct smb347_charger *smb)
 		return ret;
 
 	if ((val & STAT_C_CHARGER_ERROR) ||
-			(val & STAT_C_HOLDOFF_STAT)) {
+	    (val & STAT_C_HOLDOFF_STAT)) {
 		/*
 		 * set to NOT CHARGING upon charger error
 		 * or charging has stopped.
@@ -1049,7 +1041,7 @@ static int smb347_get_charging_status(struct smb347_charger *smb)
 		} else {
 			/*
 			 * in this case no charger error or termination
-			 * occured but charging is not in progress!!!
+			 * occurred but charging is not in progress!!!
 			 */
 			status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		}
@@ -1178,6 +1170,78 @@ static bool smb347_readable_reg(struct device *dev, unsigned int reg)
 	return smb347_volatile_reg(dev, reg);
 }
 
+static void smb347_dt_parse_pdata(struct device_node *np,
+				  struct smb347_charger_platform_data *pdata)
+{
+	/* Charing constraints */
+	of_property_read_u32(np, "max-chg-curr", &pdata->max_charge_current);
+	of_property_read_u32(np, "max-chg-volt", &pdata->max_charge_voltage);
+	of_property_read_u32(np, "pre-chg-curr", &pdata->pre_charge_current);
+	of_property_read_u32(np, "term-curr", &pdata->termination_current);
+	of_property_read_u32(np, "fast-volt-threshold",
+			     &pdata->pre_to_fast_voltage);
+	of_property_read_u32(np, "mains-curr-limit",
+			     &pdata->mains_current_limit);
+	of_property_read_u32(np, "usb-curr-limit",
+			     &pdata->usb_hc_current_limit);
+
+	/* For thermometer monitoring */
+	of_property_read_u32(np, "chip-temp-threshold",
+			     &pdata->chip_temp_threshold);
+	if (of_property_read_u32(np, "soft-cold-temp-limit",
+				 &pdata->soft_cold_temp_limit))
+		pdata->soft_cold_temp_limit = SMB347_TEMP_USE_DEFAULT;
+	if (of_property_read_u32(np, "soft-hot-temp-limit",
+				 &pdata->soft_hot_temp_limit))
+		pdata->soft_hot_temp_limit = SMB347_TEMP_USE_DEFAULT;
+	if (of_property_read_u32(np, "hard-cold-temp-limit",
+				 &pdata->hard_cold_temp_limit))
+		pdata->hard_cold_temp_limit = SMB347_TEMP_USE_DEFAULT;
+	if (of_property_read_u32(np, "hard-hot-temp-limit",
+				 &pdata->hard_hot_temp_limit))
+		pdata->hard_hot_temp_limit = SMB347_TEMP_USE_DEFAULT;
+
+	/* Suspend when battery temperature is outside hard limits */
+	if ((pdata->hard_cold_temp_limit != SMB347_TEMP_USE_DEFAULT) ||
+	    (pdata->hard_hot_temp_limit != SMB347_TEMP_USE_DEFAULT))
+		pdata->suspend_on_hard_temp_limit = true;
+
+	if (of_property_read_u32(np, "soft-comp-method",
+				 &pdata->soft_temp_limit_compensation))
+		pdata->soft_temp_limit_compensation =
+				SMB347_SOFT_TEMP_COMPENSATE_DEFAULT;
+
+	of_property_read_u32(np, "chg-curr-comp",
+			     &pdata->charge_current_compensation);
+
+	/* Supported charging mode */
+	pdata->use_mains = of_property_read_bool(np, "enable-mains-charging");
+	pdata->use_usb = of_property_read_bool(np, "enable-usb-charging");
+	pdata->use_usb_otg = of_property_read_bool(np, "enable-otg-charging");
+
+	/* Enable charging method */
+	of_property_read_u32(np, "enable-chg-ctrl", &pdata->enable_control);
+
+	/* If IRQ is enabled or not */
+	if (!of_get_property(np, "interrupts", NULL))
+		pdata->irq_gpio = -1;
+}
+
+static struct smb347_charger_platform_data
+			*smb347_get_platdata(struct device *dev)
+{
+	struct smb347_charger_platform_data *pdata = NULL;
+
+	if (dev->of_node) {
+		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+		smb347_dt_parse_pdata(dev->of_node, pdata);
+	} else {
+		pdata = dev_get_platdata(dev);
+	}
+
+	return pdata;
+}
+
 static const struct regmap_config smb347_regmap = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
@@ -1210,32 +1274,33 @@ static const struct power_supply_desc smb347_battery_desc = {
 	.num_properties	= ARRAY_SIZE(smb347_battery_properties),
 };
 
+static char *battery[] = {
+	"smb347-battery",
+};
+
 static int smb347_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
-	static char *battery[] = { "smb347-battery" };
-	const struct smb347_charger_platform_data *pdata;
 	struct power_supply_config mains_usb_cfg = {}, battery_cfg = {};
 	struct device *dev = &client->dev;
 	struct smb347_charger *smb;
 	int ret;
 
-	pdata = dev->platform_data;
-	if (!pdata)
-		return -EINVAL;
-
-	if (!pdata->use_mains && !pdata->use_usb)
-		return -EINVAL;
-
 	smb = devm_kzalloc(dev, sizeof(*smb), GFP_KERNEL);
 	if (!smb)
 		return -ENOMEM;
 
+	smb->pdata = smb347_get_platdata(dev);
+	if (IS_ERR_OR_NULL(smb->pdata))
+		return -ENODEV;
+
+	if (!smb->pdata->use_mains && !smb->pdata->use_usb)
+		return -EINVAL;
+
 	i2c_set_clientdata(client, smb);
 
 	mutex_init(&smb->lock);
 	smb->dev = &client->dev;
-	smb->pdata = pdata;
 
 	smb->regmap = devm_regmap_init_i2c(client, &smb347_regmap);
 	if (IS_ERR(smb->regmap))
@@ -1280,7 +1345,7 @@ static int smb347_probe(struct i2c_client *client,
 	 * Interrupt pin is optional. If it is connected, we setup the
 	 * interrupt support here.
 	 */
-	if (pdata->irq_gpio >= 0) {
+	if (smb->pdata->irq_gpio >= 0) {
 		ret = smb347_irq_init(smb, client);
 		if (ret < 0) {
 			dev_warn(dev, "failed to initialize IRQ: %d\n", ret);
@@ -1297,11 +1362,8 @@ static int smb347_remove(struct i2c_client *client)
 {
 	struct smb347_charger *smb = i2c_get_clientdata(client);
 
-	if (client->irq) {
+	if (client->irq)
 		smb347_irq_disable(smb);
-		free_irq(client->irq, smb);
-		gpio_free(smb->pdata->irq_gpio);
-	}
 
 	power_supply_unregister(smb->battery);
 	if (smb->pdata->use_usb)
@@ -1317,9 +1379,17 @@ static const struct i2c_device_id smb347_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, smb347_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id of_smb347_ids[] = {
+	{ .compatible = "summit,smb347" },
+	{},
+};
+#endif
+
 static struct i2c_driver smb347_driver = {
 	.driver = {
 		.name = "smb347",
+		.of_match_table = of_match_ptr(of_smb347_ids),
 	},
 	.probe        = smb347_probe,
 	.remove       = smb347_remove,
-- 
2.1.2

