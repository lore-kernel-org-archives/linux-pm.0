From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 4/4] power: tps65217_charger: add support for NTC type, voltage and current charge
Date: Fri, 26 May 2017 13:04:13 +0200
Message-ID: <20170526110413.24836-4-enric.balletbo@collabora.com>
References: <20170526110413.24836-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38968 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940057AbdEZLEZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 May 2017 07:04:25 -0400
In-Reply-To: <20170526110413.24836-1-enric.balletbo@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, robh@kernel.org
Cc: mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@networkimprov.net

Allow the possibility to configure the charge and the current voltage of
the charger and also the NTC type for battery temperature measurement.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes since v2:
 - Requested by Sebastian Reichel
   - Use the simple-battery framework
   - Use device_property_read_u32 instead of of_property_read_u32
Changes since v1:
 - None

 drivers/power/supply/tps65217_charger.c | 194 ++++++++++++++++++++++++++++++--
 include/linux/mfd/tps65217.h            |   2 +
 2 files changed, 188 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 1f52340..5939e77 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -39,6 +39,12 @@
 #define NUM_CHARGER_IRQS	2
 #define POLL_INTERVAL		(HZ * 2)
 
+struct tps65217_charger_platform_data {
+	int	charge_voltage_uv;
+	int	charge_current_ua;
+	int	ntc_type;
+};
+
 struct tps65217_charger {
 	struct tps65217 *tps;
 	struct device *dev;
@@ -48,16 +54,84 @@ struct tps65217_charger {
 	int	prev_online;
 
 	struct task_struct	*poll_task;
+	struct tps65217_charger_platform_data *pdata;
 };
 
 static enum power_supply_property tps65217_charger_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 };
 
-static int tps65217_config_charger(struct tps65217_charger *charger)
+static int tps65217_set_charge_current(struct tps65217_charger *charger,
+				       unsigned int uamp)
+{
+	int ret, val;
+
+	dev_dbg(charger->dev, "setting charge current to %d uA\n", uamp);
+
+	if (uamp == 300000)
+		val = 0x00;
+	else if (uamp == 400000)
+		val = 0x01;
+	else if (uamp == 500000)
+		val = 0x02;
+	else if (uamp == 700000)
+		val = 0x03;
+	else
+		return -EINVAL;
+
+	ret = tps65217_set_bits(charger->tps, TPS65217_REG_CHGCONFIG3,
+				TPS65217_CHGCONFIG3_ICHRG_MASK,
+				val << TPS65217_CHGCONFIG3_ICHRG_SHIFT,
+				TPS65217_PROTECT_NONE);
+	if (ret) {
+		dev_err(charger->dev,
+			"failed to set ICHRG setting to 0x%02x (err: %d)\n",
+			val, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tps65217_set_charge_voltage(struct tps65217_charger *charger,
+				       unsigned int uvolt)
+{
+	int ret, val;
+
+	dev_dbg(charger->dev, "setting charge voltage to %d uV\n", uvolt);
+
+	if (uvolt != 4100000 && uvolt != 4150000 &&
+	    uvolt != 4200000 && uvolt != 4250000)
+		return -EINVAL;
+
+	val = (uvolt - 4100000) / 50000;
+
+	ret = tps65217_set_bits(charger->tps, TPS65217_REG_CHGCONFIG2,
+				TPS65217_CHGCONFIG2_VOREG_MASK,
+				val << TPS65217_CHGCONFIG2_VOREG_SHIFT,
+				TPS65217_PROTECT_NONE);
+	if (ret) {
+		dev_err(charger->dev,
+			"failed to set VOCHG setting to 0x%02x (err: %d)\n",
+			val, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tps65217_set_ntc_type(struct tps65217_charger *charger,
+				 unsigned int ntc)
 {
 	int ret;
 
+	dev_dbg(charger->dev, "setting NTC type to %d\n", ntc);
+
+	if (ntc != 0 && ntc != 1)
+		return -EINVAL;
+
 	/*
 	 * tps65217 rev. G, p. 31 (see p. 32 for NTC schematic)
 	 *
@@ -74,14 +148,57 @@ static int tps65217_config_charger(struct tps65217_charger *charger)
 	 * NTC TYPE (for battery temperature measurement)
 	 *   0 – 100k (curve 1, B = 3960)
 	 *   1 – 10k  (curve 2, B = 3480) (default on reset)
-	 *
 	 */
-	ret = tps65217_clear_bits(charger->tps, TPS65217_REG_CHGCONFIG1,
-				  TPS65217_CHGCONFIG1_NTC_TYPE,
-				  TPS65217_PROTECT_NONE);
+	if (ntc) {
+		ret = tps65217_set_bits(charger->tps, TPS65217_REG_CHGCONFIG1,
+					TPS65217_CHGCONFIG1_NTC_TYPE,
+					TPS65217_CHGCONFIG1_NTC_TYPE,
+					TPS65217_PROTECT_NONE);
+		if (ret) {
+			dev_err(charger->dev,
+				"failed to set NTC type to 10K: %d\n", ret);
+			return ret;
+		}
+	} else {
+		ret = tps65217_clear_bits(charger->tps, TPS65217_REG_CHGCONFIG1,
+					  TPS65217_CHGCONFIG1_NTC_TYPE,
+					  TPS65217_PROTECT_NONE);
+		if (ret) {
+			dev_err(charger->dev,
+				"failed to set NTC type to 100K: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int tps65217_config_charger(struct tps65217_charger *charger)
+{
+	int ret;
+	struct tps65217_charger_platform_data *pdata = charger->pdata;
+
+	if (!charger->pdata)
+		return -EINVAL;
+
+	ret = tps65217_set_charge_voltage(charger, pdata->charge_voltage_uv);
+	if (ret) {
+		dev_err(charger->dev,
+			"failed to set charge voltage setting: %d\n", ret);
+		return ret;
+	}
+
+	ret = tps65217_set_charge_current(charger, pdata->charge_current_ua);
+	if (ret) {
+		dev_err(charger->dev,
+			"failed to set charge current setting: %d\n", ret);
+		return ret;
+	}
+
+	ret = tps65217_set_ntc_type(charger, pdata->ntc_type);
 	if (ret) {
 		dev_err(charger->dev,
-			"failed to set 100k NTC setting: %d\n", ret);
+			"failed to set NTC type setting: %d\n", ret);
 		return ret;
 	}
 
@@ -118,11 +235,23 @@ static int tps65217_charger_get_property(struct power_supply *psy,
 					 union power_supply_propval *val)
 {
 	struct tps65217_charger *charger = power_supply_get_drvdata(psy);
+	struct tps65217_charger_platform_data *pdata = charger->pdata;
 
 	if (psp == POWER_SUPPLY_PROP_ONLINE) {
 		val->intval = charger->online;
 		return 0;
 	}
+
+	if (psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE) {
+		val->intval = pdata->charge_voltage_uv;
+		return 0;
+	}
+
+	if (psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT) {
+		val->intval = pdata->charge_current_ua;
+		return 0;
+	}
+
 	return -EINVAL;
 }
 
@@ -185,6 +314,49 @@ static int tps65217_charger_poll_task(void *data)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct tps65217_charger_platform_data *tps65217_charger_pdata_init(
+		struct tps65217_charger *charger)
+{
+	struct tps65217_charger_platform_data *pdata;
+	struct power_supply_battery_info info = {};
+	int ret;
+
+	pdata = devm_kzalloc(charger->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * If battery info is not supplied just ignore and program default
+	 * values.
+	 */
+	power_supply_get_battery_info(charger->psy, &info);
+
+	if (info.charge_voltage_uv > 0)
+		pdata->charge_voltage_uv = info.charge_voltage_uv;
+	else
+		pdata->charge_voltage_uv = 4100000;
+
+	if (info.charge_current_ua > 0)
+		pdata->charge_current_ua = info.charge_current_ua;
+	else
+		pdata->charge_current_ua = 500000;
+
+	ret = device_property_read_u32(charger->dev, "ti,ntc-type",
+				       &pdata->ntc_type);
+	if (ret)
+		pdata->ntc_type = 1;	/* 10k  (curve 2, B = 3480) */
+
+	return pdata;
+}
+#else /* CONFIG_OF */
+static struct tps65217_charger_platform_data *tps65217_charger_pdata_init(
+		struct tps65217_charger *charger)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
+
 static const struct power_supply_desc tps65217_charger_desc = {
 	.name			= "tps65217-charger",
 	.type			= POWER_SUPPLY_TYPE_MAINS,
@@ -222,8 +394,11 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(charger->psy);
 	}
 
-	irq[0] = platform_get_irq_byname(pdev, "USB");
-	irq[1] = platform_get_irq_byname(pdev, "AC");
+	charger->pdata = tps65217_charger_pdata_init(charger);
+	if (IS_ERR(charger->pdata)) {
+		dev_err(charger->dev, "failed: getting platform data\n");
+		return PTR_ERR(charger->pdata);
+	}
 
 	ret = tps65217_config_charger(charger);
 	if (ret < 0) {
@@ -231,6 +406,9 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	irq[0] = platform_get_irq_byname(pdev, "USB");
+	irq[1] = platform_get_irq_byname(pdev, "AC");
+
 	/* Create a polling thread if an interrupt is invalid */
 	if (irq[0] < 0 || irq[1] < 0) {
 		poll_task = kthread_run(tps65217_charger_poll_task,
diff --git a/include/linux/mfd/tps65217.h b/include/linux/mfd/tps65217.h
index eac2857..d040062 100644
--- a/include/linux/mfd/tps65217.h
+++ b/include/linux/mfd/tps65217.h
@@ -103,8 +103,10 @@
 #define TPS65217_CHGCONFIG2_DYNTMR	BIT(7)
 #define TPS65217_CHGCONFIG2_VPREGHG	BIT(6)
 #define TPS65217_CHGCONFIG2_VOREG_MASK	0x30
+#define TPS65217_CHGCONFIG2_VOREG_SHIFT	4
 
 #define TPS65217_CHGCONFIG3_ICHRG_MASK	0xC0
+#define TPS65217_CHGCONFIG3_ICHRG_SHIFT	6
 #define TPS65217_CHGCONFIG3_DPPMTH_MASK	0x30
 #define TPS65217_CHGCONFIG2_PCHRGT	BIT(3)
 #define TPS65217_CHGCONFIG2_TERMIF	0x06
-- 
2.9.3
