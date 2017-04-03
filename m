From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 2/2] power: tps65217_charger: Add properties like voltage and current charge
Date: Mon,  3 Apr 2017 18:44:46 +0200
Message-ID: <20170403164446.28076-2-enric.balletbo@collabora.com>
References: <20170403164446.28076-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170403164446.28076-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Allow the possibility to configure the charge and the current voltage of
the charger and also the NTC type for battery temperature measurement.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 .../bindings/power/supply/tps65217_charger.txt     |  15 ++
 drivers/power/supply/tps65217_charger.c            | 187 +++++++++++++++++++--
 include/linux/mfd/tps65217.h                       |   2 +
 3 files changed, 192 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
index a11072c..600da6e 100644
--- a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
@@ -6,6 +6,18 @@ Required Properties:
              Should be <0> for the USB charger and <1> for the AC adapter.
 -interrupt-names: Should be "USB" and "AC"
 
+Optional properties:
+-ti,charge-voltage-uvolt: set the charge voltage. The value can be: 4100000,
+	4150000, 4200000, 4250000; default: 4100000
+
+-ti,charge-current-uamp: set the charging current. The value can be: 300000,
+	400000, 500000, 700000; default: 500000
+
+-ti,ntc-type: set the NTC type for battery temperature measurement. The value
+	must be 0 or 1, where:
+	  0 – 100k (curve 1, B = 3960)
+	  1 – 10k  (curve 2, B = 3480) (default)
+
 This node is a subnode of the tps65217 PMIC.
 
 Example:
@@ -14,4 +26,7 @@ Example:
 		compatible = "ti,tps65217-charger";
 		interrupts = <0>, <1>;
 		interrupt-names = "USB", "AC";
+		ti,charge-voltage-uvolt = <4100000>;
+		ti,charge-current-uamp = <500000>;
+		ti,ntc-type = <1>;
 	};
diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 1f52340..1d7055d 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -39,6 +39,12 @@
 #define NUM_CHARGER_IRQS	2
 #define POLL_INTERVAL		(HZ * 2)
 
+struct tps65217_charger_platform_data {
+	u32	charge_current_uamp;
+	u32	charge_voltage_uvolt;
+	int	ntc_type;
+};
+
 struct tps65217_charger {
 	struct tps65217 *tps;
 	struct device *dev;
@@ -48,16 +54,82 @@ struct tps65217_charger {
 	int	prev_online;
 
 	struct task_struct	*poll_task;
+	struct tps65217_charger_platform_data *pdata;
 };
 
 static enum power_supply_property tps65217_charger_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
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
@@ -74,14 +146,57 @@ static int tps65217_config_charger(struct tps65217_charger *charger)
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
+	ret = tps65217_set_charge_voltage(charger, pdata->charge_voltage_uvolt);
 	if (ret) {
 		dev_err(charger->dev,
-			"failed to set 100k NTC setting: %d\n", ret);
+			"failed to set charge voltage setting: %d\n", ret);
+		return ret;
+	}
+
+	ret = tps65217_set_charge_current(charger, pdata->charge_current_uamp);
+	if (ret) {
+		dev_err(charger->dev,
+			"failed to set charge current setting: %d\n", ret);
+		return ret;
+	}
+
+	ret = tps65217_set_ntc_type(charger, pdata->ntc_type);
+	if (ret) {
+		dev_err(charger->dev,
+			"failed to set NTC type setting: %d\n", ret);
 		return ret;
 	}
 
@@ -185,6 +300,48 @@ static int tps65217_charger_poll_task(void *data)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct tps65217_charger_platform_data *tps65217_charger_pdata_init(
+		struct platform_device *pdev)
+{
+	struct tps65217_charger_platform_data *pdata;
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	if (!np) {
+		dev_err(&pdev->dev, "No charger OF node\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	ret = of_property_read_u32(np, "ti,charge-voltage-uvolt",
+				   &pdata->charge_voltage_uvolt);
+	if (ret)
+		pdata->charge_voltage_uvolt = 4100000;
+
+	ret = of_property_read_u32(np, "ti,charge-current-uamp",
+				   &pdata->charge_current_uamp);
+	if (ret)
+		pdata->charge_current_uamp = 500000;
+
+	ret = of_property_read_u32(np, "ti,ntc-type",
+				   &pdata->ntc_type);
+	if (ret)
+		pdata->ntc_type = 1;	/* 10k  (curve 2, B = 3480) */
+
+	return pdata;
+}
+#else /* CONFIG_OF */
+static struct tps65217_charger_platform_data *tps65217_charger_pdata_init(
+		struct platform_device *pdev)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
+
 static const struct power_supply_desc tps65217_charger_desc = {
 	.name			= "tps65217-charger",
 	.type			= POWER_SUPPLY_TYPE_MAINS,
@@ -214,6 +371,18 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	cfg.of_node = pdev->dev.of_node;
 	cfg.drv_data = charger;
 
+	charger->pdata = tps65217_charger_pdata_init(pdev);
+	if (IS_ERR(charger->pdata)) {
+		dev_err(charger->dev, "failed: getting platform data\n");
+		return PTR_ERR(charger->pdata);
+	}
+
+	ret = tps65217_config_charger(charger);
+	if (ret < 0) {
+		dev_err(charger->dev, "charger config failed, err %d\n", ret);
+		return ret;
+	}
+
 	charger->psy = devm_power_supply_register(&pdev->dev,
 						  &tps65217_charger_desc,
 						  &cfg);
@@ -225,12 +394,6 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	irq[0] = platform_get_irq_byname(pdev, "USB");
 	irq[1] = platform_get_irq_byname(pdev, "AC");
 
-	ret = tps65217_config_charger(charger);
-	if (ret < 0) {
-		dev_err(charger->dev, "charger config failed, err %d\n", ret);
-		return ret;
-	}
-
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
