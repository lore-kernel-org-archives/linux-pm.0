From: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Subject: [PATCH 3/3] power_supply: max77693: Listen for cable events and enable charging
Date: Tue, 27 Sep 2016 01:31:10 +0200
Message-ID: <1474932670-11953-4-git-send-email-wolfgit@wiedmeyer.de>
References: <1474932670-11953-1-git-send-email-wolfgit@wiedmeyer.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from wiedmeyer.de ([85.116.192.112]:39352 "EHLO wiedmeyer.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755174AbcIZXcq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Sep 2016 19:32:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by wiedmeyer.localdomain (Postfix) with ESMTP id C8C1B8E91C2
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2016 01:32:39 +0200 (CEST)
Received: from wiedmeyer.de ([127.0.0.1])
        by localhost (wiedmeyer.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id upZfWrBesJ_R for <linux-pm@vger.kernel.org>;
        Tue, 27 Sep 2016 01:32:37 +0200 (CEST)
In-Reply-To: <1474932670-11953-1-git-send-email-wolfgit@wiedmeyer.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: krzk@kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: cw00.choi@samsung.com, b.zolnierkie@samsung.com, broonie@kernel.org, lgirdwood@gmail.com, lee.jones@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>

This patch adds a listener for extcon cable events and enables
charging if an USB cable is connected. It recognizes SDP and DCP cable
types and treats them the same (same input current and fast charge
current). The maximum input current is set before the charger is
enabled and before the charger gets disabled, the maximum input
current is set to zero. The listener is inspired by the listener
implementation that was used for the AXP288 Charger driver.

The patch also adds support for the CURRENT_NOW property. It reads the
fast charge current that gets set before the charger is enabled or
disabled.

Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
---
 drivers/power/Kconfig            |   2 +-
 drivers/power/max77693_charger.c | 171 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index acd4a15..28254d3 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -372,7 +372,7 @@ config CHARGER_MAX14577
 
 config CHARGER_MAX77693
 	tristate "Maxim MAX77693 battery charger driver"
-	depends on MFD_MAX77693
+	depends on MFD_MAX77693 && REGULATOR_MAX77693
 	help
 	  Say Y to enable support for the Maxim MAX77693 battery charger.
 
diff --git a/drivers/power/max77693_charger.c b/drivers/power/max77693_charger.c
index 060cab5..922f43f 100644
--- a/drivers/power/max77693_charger.c
+++ b/drivers/power/max77693_charger.c
@@ -22,8 +22,11 @@
 #include <linux/mfd/max77693.h>
 #include <linux/mfd/max77693-common.h>
 #include <linux/mfd/max77693-private.h>
+#include <linux/extcon.h>
+#include <linux/regulator/consumer.h>
 
 #define MAX77693_CHARGER_NAME				"max77693-charger"
+#define MAX77693_EXTCON_DEV_NAME			"max77693-muic"
 static const char *max77693_charger_model		= "MAX77693";
 static const char *max77693_charger_manufacturer	= "Maxim Integrated";
 
@@ -31,12 +34,21 @@ struct max77693_charger {
 	struct device		*dev;
 	struct max77693_dev	*max77693;
 	struct power_supply	*charger;
+	struct regulator	*regu;
 
 	u32 constant_volt;
 	u32 min_system_volt;
 	u32 thermal_regulation_temp;
 	u32 batttery_overcurrent;
 	u32 charge_input_threshold_volt;
+
+	/* SDP/DCP USB charging cable notifications */
+	struct {
+		struct extcon_dev *edev;
+		bool connected;
+		struct notifier_block nb;
+		struct work_struct work;
+	} cable;
 };
 
 static int max77693_get_charger_state(struct regmap *regmap, int *val)
@@ -207,12 +219,28 @@ static int max77693_get_online(struct regmap *regmap, int *val)
 	return 0;
 }
 
+int max77693_get_charge_current(struct regmap *regmap, int *val)
+{
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(regmap, MAX77693_CHG_REG_CHG_CNFG_02, &data);
+	if (ret < 0)
+		return ret;
+
+	data &= CHG_CNFG_02_CC_MASK;
+	*val = data * 333 / 10; /* 3 steps/0.1A */
+
+	return 0;
+}
+
 static enum power_supply_property max77693_charger_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
@@ -241,6 +269,9 @@ static int max77693_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_ONLINE:
 		ret = max77693_get_online(regmap, &val->intval);
 		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = max77693_get_charge_current(regmap, &val->intval);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = max77693_charger_model;
 		break;
@@ -295,6 +326,7 @@ static ssize_t fast_charge_timer_show(struct device *dev,
 
 	data &= CHG_CNFG_01_FCHGTIME_MASK;
 	data >>= CHG_CNFG_01_FCHGTIME_SHIFT;
+
 	switch (data) {
 	case 0x1 ... 0x7:
 		/* Starting from 4 hours, step by 2 hours */
@@ -582,6 +614,97 @@ static int max77693_set_charge_input_threshold_volt(struct max77693_charger *chg
 			CHG_CNFG_12_VCHGINREG_MASK, data);
 }
 
+static int max77693_enable_charger(struct max77693_charger *chg, bool enable)
+{
+	int ret;
+
+	if (enable) {
+		regulator_set_current_limit(chg->regu,
+					    CHG_CNFG_09_CHGIN_ILIM_500_MIN,
+					    CHG_CNFG_09_CHGIN_ILIM_500_MAX);
+		if (ret < 0)
+			return ret;
+
+		ret = regulator_enable(chg->regu);
+		if (ret < 0)
+			return ret;
+	} else {
+		/* sets fast charge current to zero */
+		ret = regulator_set_current_limit(chg->regu,
+						  CHG_CNFG_09_CHGIN_ILIM_0_MIN,
+						  CHG_CNFG_09_CHGIN_ILIM_0_MAX);
+		if (ret < 0)
+			return ret;
+
+		ret = regulator_disable(chg->regu);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ret;
+}
+
+static void max77693_extcon_evt_worker(struct work_struct *work)
+{
+	struct max77693_charger *chg =
+	    container_of(work, struct max77693_charger, cable.work);
+	bool changed = false;
+	struct extcon_dev *edev = chg->cable.edev;
+	bool old_connected = chg->cable.connected;
+	bool is_charger_enabled;
+	int ret;
+
+	/* Determine cable/charger type */
+	if (extcon_get_cable_state_(edev, EXTCON_CHG_USB_SDP) ||
+	extcon_get_cable_state_(edev, EXTCON_CHG_USB_DCP)) {
+		dev_dbg(chg->dev, "USB charger is connected");
+		chg->cable.connected = true;
+	} else {
+		if (old_connected)
+			dev_dbg(chg->dev, "USB charger disconnected");
+
+		chg->cable.connected = false;
+	}
+
+	/* Cable status changed */
+	if (old_connected != chg->cable.connected)
+		changed = true;
+
+	if (!changed)
+		return;
+
+	if (regulator_is_enabled(chg->regu))
+		is_charger_enabled = true;
+	else
+		is_charger_enabled = false;
+
+	if (is_charger_enabled && !chg->cable.connected) {
+		ret = max77693_enable_charger(chg, false);
+		if (ret < 0)
+			dev_err(chg->dev,
+				"failed to disable charger (%d)", ret);
+	} else if (!is_charger_enabled && chg->cable.connected) {
+		ret = max77693_enable_charger(chg, true);
+		if (ret < 0)
+			dev_err(chg->dev,
+				"cannot enable charger (%d)", ret);
+	}
+
+	if (changed)
+		power_supply_changed(chg->charger);
+}
+
+static int max77693_handle_cable_evt(struct notifier_block *nb,
+				unsigned long event, void *param)
+{
+	struct max77693_charger *chg =
+	    container_of(nb, struct max77693_charger, cable.nb);
+
+	schedule_work(&chg->cable.work);
+
+	return NOTIFY_OK;
+}
+
 /*
  * Sets charger registers to proper and safe default values.
  */
@@ -693,6 +816,45 @@ static int max77693_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	chg->regu = devm_regulator_get(chg->dev, "CHARGER");
+	if (IS_ERR(chg->regu)) {
+		ret = PTR_ERR(chg->regu);
+		dev_err(&pdev->dev,
+			"failed to get charger regulator %d\n", ret);
+		return ret;
+	}
+
+	chg->cable.edev = extcon_get_extcon_dev(MAX77693_EXTCON_DEV_NAME);
+	if (chg->cable.edev == NULL) {
+		dev_dbg(&pdev->dev, "%s is not ready, probe deferred\n",
+			MAX77693_EXTCON_DEV_NAME);
+		return -EPROBE_DEFER;
+	}
+
+	/* set initial value */
+	chg->cable.connected = false;
+
+	/* Register for extcon notification */
+	INIT_WORK(&chg->cable.work, max77693_extcon_evt_worker);
+	chg->cable.nb.notifier_call = max77693_handle_cable_evt;
+	ret = extcon_register_notifier(chg->cable.edev, EXTCON_CHG_USB_SDP,
+					&chg->cable.nb);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to register extcon notifier for SDP %d\n", ret);
+		return ret;
+	}
+
+	ret = extcon_register_notifier(chg->cable.edev, EXTCON_CHG_USB_DCP,
+					&chg->cable.nb);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to register extcon notifier for DCP %d\n", ret);
+		extcon_unregister_notifier(chg->cable.edev,
+				EXTCON_CHG_USB_SDP, &chg->cable.nb);
+		return ret;
+	}
+
 	ret = max77693_reg_init(chg);
 	if (ret)
 		return ret;
@@ -733,6 +895,10 @@ err:
 	device_remove_file(&pdev->dev, &dev_attr_top_off_timer);
 	device_remove_file(&pdev->dev, &dev_attr_top_off_threshold_current);
 	device_remove_file(&pdev->dev, &dev_attr_fast_charge_timer);
+	extcon_unregister_notifier(chg->cable.edev, EXTCON_CHG_USB_SDP,
+				   &chg->cable.nb);
+	extcon_unregister_notifier(chg->cable.edev, EXTCON_CHG_USB_DCP,
+					&chg->cable.nb);
 
 	return ret;
 }
@@ -745,6 +911,11 @@ static int max77693_charger_remove(struct platform_device *pdev)
 	device_remove_file(&pdev->dev, &dev_attr_top_off_threshold_current);
 	device_remove_file(&pdev->dev, &dev_attr_fast_charge_timer);
 
+	extcon_unregister_notifier(chg->cable.edev, EXTCON_CHG_USB_SDP,
+					&chg->cable.nb);
+	extcon_unregister_notifier(chg->cable.edev, EXTCON_CHG_USB_DCP,
+					&chg->cable.nb);
+
 	power_supply_unregister(chg->charger);
 
 	return 0;
-- 
2.8.0.rc3

