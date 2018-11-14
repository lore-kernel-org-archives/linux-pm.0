From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 3/5] power: supply: sc27xx: Add fuel gauge low voltage alarm
Date: Wed, 14 Nov 2018 17:07:06 +0800
Message-ID: <ee1dd39f126bd03fb88381de9663d32df994d341.1542185618.git.baolin.wang@linaro.org>
References: <cover.1542185618.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1542185618.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1542185618.git.baolin.wang@linaro.org>
References: <cover.1542185618.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

Add low voltage alarm support to make sure the battery capacity
more accurate in lower voltage stage.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |  171 +++++++++++++++++++++++++++++-
 1 file changed, 170 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 66f4db2..962d0f8 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -31,8 +31,11 @@
 #define SC27XX_FGU_OCV			0x24
 #define SC27XX_FGU_POCV			0x28
 #define SC27XX_FGU_CURRENT		0x2c
+#define SC27XX_FGU_LOW_OVERLOAD		0x34
 #define SC27XX_FGU_CLBCNT_SETH		0x50
 #define SC27XX_FGU_CLBCNT_SETL		0x54
+#define SC27XX_FGU_CLBCNT_DELTH		0x58
+#define SC27XX_FGU_CLBCNT_DELTL		0x5c
 #define SC27XX_FGU_CLBCNT_VALH		0x68
 #define SC27XX_FGU_CLBCNT_VALL		0x6c
 #define SC27XX_FGU_CLBCNT_QMAXL		0x74
@@ -40,6 +43,11 @@
 #define SC27XX_WRITE_SELCLB_EN		BIT(0)
 #define SC27XX_FGU_CLBCNT_MASK		GENMASK(15, 0)
 #define SC27XX_FGU_CLBCNT_SHIFT		16
+#define SC27XX_FGU_LOW_OVERLOAD_MASK	GENMASK(12, 0)
+
+#define SC27XX_FGU_INT_MASK		GENMASK(9, 0)
+#define SC27XX_FGU_LOW_OVERLOAD_INT	BIT(0)
+#define SC27XX_FGU_CLBCNT_DELTA_INT	BIT(2)
 
 #define SC27XX_FGU_CUR_BASIC_ADC	8192
 #define SC27XX_FGU_SAMPLE_HZ		2
@@ -56,8 +64,10 @@
  * @internal_resist: the battery internal resistance in mOhm
  * @total_cap: the total capacity of the battery in mAh
  * @init_cap: the initial capacity of the battery in mAh
+ * @alarm_cap: the alarm capacity
  * @init_clbcnt: the initial coulomb counter
  * @max_volt: the maximum constant input voltage in millivolt
+ * @min_volt: the minimum drained battery voltage in microvolt
  * @table_len: the capacity table length
  * @cur_1000ma_adc: ADC value corresponding to 1000 mA
  * @vol_1000mv_adc: ADC value corresponding to 1000 mV
@@ -75,14 +85,18 @@ struct sc27xx_fgu_data {
 	int internal_resist;
 	int total_cap;
 	int init_cap;
+	int alarm_cap;
 	int init_clbcnt;
 	int max_volt;
+	int min_volt;
 	int table_len;
 	int cur_1000ma_adc;
 	int vol_1000mv_adc;
 	struct power_supply_battery_ocv_table *cap_table;
 };
 
+static int sc27xx_fgu_cap_to_clbcnt(struct sc27xx_fgu_data *data, int capacity);
+
 static const char * const sc27xx_charger_supply_name[] = {
 	"sc2731_charger",
 	"sc2720_charger",
@@ -100,6 +114,11 @@ static int sc27xx_fgu_adc_to_voltage(struct sc27xx_fgu_data *data, int adc)
 	return DIV_ROUND_CLOSEST(adc * 1000, data->vol_1000mv_adc);
 }
 
+static int sc27xx_fgu_voltage_to_adc(struct sc27xx_fgu_data *data, int vol)
+{
+	return DIV_ROUND_CLOSEST(vol * data->vol_1000mv_adc, 1000);
+}
+
 /*
  * When system boots on, we can not read battery capacity from coulomb
  * registers, since now the coulomb registers are invalid. So we should
@@ -428,6 +447,92 @@ static void sc27xx_fgu_external_power_changed(struct power_supply *psy)
 	.external_power_changed	= sc27xx_fgu_external_power_changed,
 };
 
+static void sc27xx_fgu_adjust_cap(struct sc27xx_fgu_data *data, int cap)
+{
+	data->init_cap = cap;
+	data->init_clbcnt = sc27xx_fgu_cap_to_clbcnt(data, data->init_cap);
+}
+
+static irqreturn_t sc27xx_fgu_interrupt(int irq, void *dev_id)
+{
+	struct sc27xx_fgu_data *data = dev_id;
+	int ret, cap, ocv, adc;
+	u32 status;
+
+	mutex_lock(&data->lock);
+
+	ret = regmap_read(data->regmap, data->base + SC27XX_FGU_INT_STS,
+			  &status);
+	if (ret)
+		goto out;
+
+	ret = regmap_update_bits(data->regmap, data->base + SC27XX_FGU_INT_CLR,
+				 status, status);
+	if (ret)
+		goto out;
+
+	/*
+	 * When low overload voltage interrupt happens, we should calibrate the
+	 * battery capacity in lower voltage stage.
+	 */
+	if (!(status & SC27XX_FGU_LOW_OVERLOAD_INT))
+		goto out;
+
+	ret = sc27xx_fgu_get_capacity(data, &cap);
+	if (ret)
+		goto out;
+
+	ret = sc27xx_fgu_get_vbat_ocv(data, &ocv);
+	if (ret)
+		goto out;
+
+	/*
+	 * If current OCV value is less than the minimum OCV value in OCV table,
+	 * which means now battery capacity is 0%, and we should adjust the
+	 * inititial capacity to 0.
+	 */
+	if (ocv <= data->cap_table[data->table_len - 1].ocv) {
+		sc27xx_fgu_adjust_cap(data, 0);
+	} else if (ocv <= data->min_volt) {
+		/*
+		 * If current OCV value is less than the low alarm voltage, but
+		 * current capacity is larger than the alarm capacity, we should
+		 * adjust the inititial capacity to alarm capacity.
+		 */
+		if (cap > data->alarm_cap) {
+			sc27xx_fgu_adjust_cap(data, data->alarm_cap);
+		} else if (cap <= 0) {
+			int cur_cap;
+
+			/*
+			 * If current capacity is equal with 0 or less than 0
+			 * (some error occurs), we should adjust inititial
+			 * capacity to the capacity corresponding to current OCV
+			 * value.
+			 */
+			cur_cap = power_supply_ocv2cap_simple(data->cap_table,
+							      data->table_len,
+							      ocv);
+			sc27xx_fgu_adjust_cap(data, cur_cap);
+		}
+
+		/*
+		 * After adjusting the battery capacity, we should set the
+		 * lowest alarm voltage instead.
+		 */
+		data->min_volt = data->cap_table[data->table_len - 1].ocv;
+		adc = sc27xx_fgu_voltage_to_adc(data, data->min_volt / 1000);
+		regmap_update_bits(data->regmap, data->base + SC27XX_FGU_LOW_OVERLOAD,
+				   SC27XX_FGU_LOW_OVERLOAD_MASK, adc);
+	}
+
+out:
+	mutex_unlock(&data->lock);
+
+	power_supply_changed(data->battery);
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t sc27xx_fgu_bat_detection(int irq, void *dev_id)
 {
 	struct sc27xx_fgu_data *data = dev_id;
@@ -509,7 +614,7 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 {
 	struct power_supply_battery_info info = { };
 	struct power_supply_battery_ocv_table *table;
-	int ret;
+	int ret, delta_clbcnt, alarm_adc;
 
 	ret = power_supply_get_battery_info(data->battery, &info);
 	if (ret) {
@@ -520,6 +625,7 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 	data->total_cap = info.charge_full_design_uah / 1000;
 	data->max_volt = info.constant_charge_voltage_max_uv / 1000;
 	data->internal_resist = info.factory_internal_resistance_uohm / 1000;
+	data->min_volt = info.voltage_min_design_uv;
 
 	/*
 	 * For SC27XX fuel gauge device, we only use one ocv-capacity
@@ -537,6 +643,10 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 		return -ENOMEM;
 	}
 
+	data->alarm_cap = power_supply_ocv2cap_simple(data->cap_table,
+						      data->table_len,
+						      data->min_volt);
+
 	power_supply_put_battery_info(data->battery, &info);
 
 	ret = sc27xx_fgu_calibration(data);
@@ -559,6 +669,50 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 		goto disable_fgu;
 	}
 
+	ret = regmap_update_bits(data->regmap, data->base + SC27XX_FGU_INT_CLR,
+				 SC27XX_FGU_INT_MASK, SC27XX_FGU_INT_MASK);
+	if (ret) {
+		dev_err(data->dev, "failed to clear interrupt status\n");
+		goto disable_clk;
+	}
+
+	/*
+	 * Set the voltage low overload threshold, which means when the battery
+	 * voltage is lower than this threshold, the controller will generate
+	 * one interrupt to notify.
+	 */
+	alarm_adc = sc27xx_fgu_voltage_to_adc(data, data->min_volt / 1000);
+	ret = regmap_update_bits(data->regmap, data->base + SC27XX_FGU_LOW_OVERLOAD,
+				 SC27XX_FGU_LOW_OVERLOAD_MASK, alarm_adc);
+	if (ret) {
+		dev_err(data->dev, "failed to set fgu low overload\n");
+		goto disable_clk;
+	}
+
+	/*
+	 * Set the coulomb counter delta threshold, that means when the coulomb
+	 * counter change is multiples of the delta threshold, the controller
+	 * will generate one interrupt to notify the users to update the battery
+	 * capacity. Now we set the delta threshold as a counter value of 1%
+	 * capacity.
+	 */
+	delta_clbcnt = sc27xx_fgu_cap_to_clbcnt(data, 1);
+
+	ret = regmap_update_bits(data->regmap, data->base + SC27XX_FGU_CLBCNT_DELTL,
+				 SC27XX_FGU_CLBCNT_MASK, delta_clbcnt);
+	if (ret) {
+		dev_err(data->dev, "failed to set low delta coulomb counter\n");
+		goto disable_clk;
+	}
+
+	ret = regmap_update_bits(data->regmap, data->base + SC27XX_FGU_CLBCNT_DELTH,
+				 SC27XX_FGU_CLBCNT_MASK,
+				 delta_clbcnt >> SC27XX_FGU_CLBCNT_SHIFT);
+	if (ret) {
+		dev_err(data->dev, "failed to set high delta coulomb counter\n");
+		goto disable_clk;
+	}
+
 	/*
 	 * Get the boot battery capacity when system powers on, which is used to
 	 * initialize the coulomb counter. After that, we can read the coulomb
@@ -658,6 +812,21 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no irq resource specified\n");
+		return irq;
+	}
+
+	ret = devm_request_threaded_irq(data->dev, irq, NULL,
+					sc27xx_fgu_interrupt,
+					IRQF_NO_SUSPEND | IRQF_ONESHOT,
+					pdev->name, data);
+	if (ret) {
+		dev_err(data->dev, "failed to request fgu IRQ\n");
+		return ret;
+	}
+
 	irq = gpiod_to_irq(data->gpiod);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "failed to translate GPIO to IRQ\n");
-- 
1.7.9.5
