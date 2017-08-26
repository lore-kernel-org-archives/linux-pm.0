From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v3 5/5] power: bq24190_charger: Add power_supply_battery_info support
Date: Fri, 25 Aug 2017 22:14:13 -0700
Message-ID: <20170826051413.24569-6-liam@networkimprov.net>
References: <20170826051413.24569-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36679 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbdHZFOx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Aug 2017 01:14:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id a2so351140pfj.3
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2017 22:14:53 -0700 (PDT)
In-Reply-To: <20170826051413.24569-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Set pre-charge and charge-term current, obtained from power_supply_battery_info.
Add sysfs attributes precharge_current & charge_term_current.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq24190_charger.c | 86 ++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 450f3ab3..7681a67a 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -59,9 +59,13 @@
 #define BQ24190_REG_PCTCC_IPRECHG_MASK		(BIT(7) | BIT(6) | BIT(5) | \
 						 BIT(4))
 #define BQ24190_REG_PCTCC_IPRECHG_SHIFT		4
+#define BQ24190_REG_PCTCC_IPRECHG_MIN			128
+#define BQ24190_REG_PCTCC_IPRECHG_MAX			2048
 #define BQ24190_REG_PCTCC_ITERM_MASK		(BIT(3) | BIT(2) | BIT(1) | \
 						 BIT(0))
 #define BQ24190_REG_PCTCC_ITERM_SHIFT		0
+#define BQ24190_REG_PCTCC_ITERM_MIN			128
+#define BQ24190_REG_PCTCC_ITERM_MAX			2048
 
 #define BQ24190_REG_CVC		0x04 /* Charge Voltage Control */
 #define BQ24190_REG_CVC_VREG_MASK		(BIT(7) | BIT(6) | BIT(5) | \
@@ -162,6 +166,8 @@ struct bq24190_dev_info {
 	bool				initialized;
 	bool				irq_event;
 	u16				sys_min;
+	u16				iprechg;
+	u16				iterm;
 	struct mutex			f_reg_lock;
 	u8				f_reg;
 	u8				ss_reg;
@@ -543,6 +549,26 @@ static int bq24190_set_config(struct bq24190_dev_info *bdi)
 			return ret;
 	}
 
+	if (bdi->iprechg) {
+		v = bdi->iprechg / 128 - 1; // manual section 9.5.1.4, table 11
+		ret = bq24190_write_mask(bdi, BQ24190_REG_PCTCC,
+					 BQ24190_REG_PCTCC_IPRECHG_MASK,
+					 BQ24190_REG_PCTCC_IPRECHG_SHIFT,
+					 v);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (bdi->iterm) {
+		v = bdi->iterm / 128 - 1; // manual section 9.5.1.4, table 11
+		ret = bq24190_write_mask(bdi, BQ24190_REG_PCTCC,
+					 BQ24190_REG_PCTCC_ITERM_MASK,
+					 BQ24190_REG_PCTCC_ITERM_SHIFT,
+					 v);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -787,6 +813,38 @@ static int bq24190_charger_set_temp_alert_max(struct bq24190_dev_info *bdi,
 	return bq24190_battery_set_temp_alert_max(bdi, val);
 }
 
+static int bq24190_charger_get_precharge(struct bq24190_dev_info *bdi,
+		union power_supply_propval *val)
+{
+	u8 v;
+	int ret;
+
+	ret = bq24190_read_mask(bdi, BQ24190_REG_PCTCC,
+			BQ24190_REG_PCTCC_IPRECHG_MASK,
+			BQ24190_REG_PCTCC_IPRECHG_SHIFT, &v);
+	if (ret < 0)
+		return ret;
+
+	val->intval = ++v * 128 * 1000;
+	return 0;
+}
+
+static int bq24190_charger_get_charge_term(struct bq24190_dev_info *bdi,
+		union power_supply_propval *val)
+{
+	u8 v;
+	int ret;
+
+	ret = bq24190_read_mask(bdi, BQ24190_REG_PCTCC,
+			BQ24190_REG_PCTCC_ITERM_MASK,
+			BQ24190_REG_PCTCC_ITERM_SHIFT, &v);
+	if (ret < 0)
+		return ret;
+
+	val->intval = ++v * 128 * 1000;
+	return 0;
+}
+
 static int bq24190_charger_get_current(struct bq24190_dev_info *bdi,
 		union power_supply_propval *val)
 {
@@ -907,6 +965,12 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
 		ret =  bq24190_charger_get_temp_alert_max(bdi, val);
 		break;
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+		ret = bq24190_charger_get_precharge(bdi, val);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		ret = bq24190_charger_get_charge_term(bdi, val);
+		break;
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		ret = bq24190_charger_get_current(bdi, val);
 		break;
@@ -1006,6 +1070,8 @@ static enum power_supply_property bq24190_charger_properties[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
+	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
@@ -1485,6 +1551,7 @@ static int bq24190_get_config(struct bq24190_dev_info *bdi)
 {
 #ifdef CONFIG_OF
 	const char * const s = "ti,system-minimum-microvolt";
+	struct power_supply_battery_info info = {};
 	int v;
 
 	if (!bdi->dev->of_node)
@@ -1499,6 +1566,24 @@ static int bq24190_get_config(struct bq24190_dev_info *bdi)
 			dev_warn(bdi->dev, "invalid value for %s: %u\n", s, v);
 	}
 
+	if (!power_supply_get_battery_info(bdi->charger, &info)) {
+		v = info.precharge_current_ua / 1000;
+		if (v >= BQ24190_REG_PCTCC_IPRECHG_MIN
+		 && v <= BQ24190_REG_PCTCC_IPRECHG_MAX)
+			bdi->iprechg = v;
+		else
+			dev_warn(bdi->dev, "invalid value for battery:precharge-current-microamp: %d\n",
+				 v);
+
+		v = info.charge_term_current_ua / 1000;
+		if (v >= BQ24190_REG_PCTCC_ITERM_MIN
+		 && v <= BQ24190_REG_PCTCC_ITERM_MAX)
+			bdi->iterm = v;
+		else
+			dev_warn(bdi->dev, "invalid value for battery:charge-term-current-microamp: %d\n",
+				 v);
+	}
+
 #endif
 	return 0;
 }
@@ -1567,6 +1652,7 @@ static int bq24190_probe(struct i2c_client *client,
 	}
 
 	charger_cfg.drv_data = bdi;
+	charger_cfg.of_node = dev->of_node;
 	charger_cfg.supplied_to = bq24190_charger_supplied_to;
 	charger_cfg.num_supplicants = ARRAY_SIZE(bq24190_charger_supplied_to),
 	bdi->charger = power_supply_register(dev, &bq24190_charger_desc,
-- 
2.13.2
