From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/5] power: supply: sc27xx: Add fuel gauge calibration
Date: Wed, 14 Nov 2018 17:07:05 +0800
Message-ID: <d6f49e2c91dfd130e2b19f5a5ff9961308236bab.1542185618.git.baolin.wang@linaro.org>
References: <cover.1542185618.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1542185618.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1542185618.git.baolin.wang@linaro.org>
References: <cover.1542185618.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds support to read calibration values from the eFuse controller
to calibrate the ADC values corresponding to current and voltage, which can
make the current and voltage data more accurate.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |   62 ++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 8613584..66f4db2 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -6,10 +6,12 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
+#include <linux/slab.h>
 
 /* PMIC global control registers definition */
 #define SC27XX_MODULE_EN0		0xc08
@@ -39,8 +41,6 @@
 #define SC27XX_FGU_CLBCNT_MASK		GENMASK(15, 0)
 #define SC27XX_FGU_CLBCNT_SHIFT		16
 
-#define SC27XX_FGU_1000MV_ADC		686
-#define SC27XX_FGU_1000MA_ADC		1372
 #define SC27XX_FGU_CUR_BASIC_ADC	8192
 #define SC27XX_FGU_SAMPLE_HZ		2
 
@@ -59,6 +59,8 @@
  * @init_clbcnt: the initial coulomb counter
  * @max_volt: the maximum constant input voltage in millivolt
  * @table_len: the capacity table length
+ * @cur_1000ma_adc: ADC value corresponding to 1000 mA
+ * @vol_1000mv_adc: ADC value corresponding to 1000 mV
  * @cap_table: capacity table with corresponding ocv
  */
 struct sc27xx_fgu_data {
@@ -76,6 +78,8 @@ struct sc27xx_fgu_data {
 	int init_clbcnt;
 	int max_volt;
 	int table_len;
+	int cur_1000ma_adc;
+	int vol_1000mv_adc;
 	struct power_supply_battery_ocv_table *cap_table;
 };
 
@@ -86,14 +90,14 @@ struct sc27xx_fgu_data {
 	"sc2723_charger",
 };
 
-static int sc27xx_fgu_adc_to_current(int adc)
+static int sc27xx_fgu_adc_to_current(struct sc27xx_fgu_data *data, int adc)
 {
-	return DIV_ROUND_CLOSEST(adc * 1000, SC27XX_FGU_1000MA_ADC);
+	return DIV_ROUND_CLOSEST(adc * 1000, data->cur_1000ma_adc);
 }
 
-static int sc27xx_fgu_adc_to_voltage(int adc)
+static int sc27xx_fgu_adc_to_voltage(struct sc27xx_fgu_data *data, int adc)
 {
-	return DIV_ROUND_CLOSEST(adc * 1000, SC27XX_FGU_1000MV_ADC);
+	return DIV_ROUND_CLOSEST(adc * 1000, data->vol_1000mv_adc);
 }
 
 /*
@@ -116,7 +120,7 @@ static int sc27xx_fgu_get_boot_capacity(struct sc27xx_fgu_data *data, int *cap)
 		return ret;
 
 	cur <<= 1;
-	oci = sc27xx_fgu_adc_to_current(cur - SC27XX_FGU_CUR_BASIC_ADC);
+	oci = sc27xx_fgu_adc_to_current(data, cur - SC27XX_FGU_CUR_BASIC_ADC);
 
 	/*
 	 * Should get the OCV from SC27XX_FGU_POCV register at the system
@@ -127,7 +131,7 @@ static int sc27xx_fgu_get_boot_capacity(struct sc27xx_fgu_data *data, int *cap)
 	if (ret)
 		return ret;
 
-	volt = sc27xx_fgu_adc_to_voltage(volt);
+	volt = sc27xx_fgu_adc_to_voltage(data, volt);
 	ocv = volt * 1000 - oci * data->internal_resist;
 
 	/*
@@ -201,7 +205,7 @@ static int sc27xx_fgu_get_capacity(struct sc27xx_fgu_data *data, int *cap)
 	 * as 100 to improve the precision.
 	 */
 	temp = DIV_ROUND_CLOSEST(delta_clbcnt, 360);
-	temp = sc27xx_fgu_adc_to_current(temp);
+	temp = sc27xx_fgu_adc_to_current(data, temp);
 
 	/*
 	 * Convert to capacity percent of the battery total capacity,
@@ -225,7 +229,7 @@ static int sc27xx_fgu_get_vbat_vol(struct sc27xx_fgu_data *data, int *val)
 	 * It is ADC values reading from registers which need to convert to
 	 * corresponding voltage values.
 	 */
-	*val = sc27xx_fgu_adc_to_voltage(vol);
+	*val = sc27xx_fgu_adc_to_voltage(data, vol);
 
 	return 0;
 }
@@ -242,7 +246,7 @@ static int sc27xx_fgu_get_current(struct sc27xx_fgu_data *data, int *val)
 	 * It is ADC values reading from registers which need to convert to
 	 * corresponding current values.
 	 */
-	*val = sc27xx_fgu_adc_to_current(cur - SC27XX_FGU_CUR_BASIC_ADC);
+	*val = sc27xx_fgu_adc_to_current(data, cur - SC27XX_FGU_CUR_BASIC_ADC);
 
 	return 0;
 }
@@ -469,6 +473,38 @@ static int sc27xx_fgu_cap_to_clbcnt(struct sc27xx_fgu_data *data, int capacity)
 	return DIV_ROUND_CLOSEST(cur_cap * 36, 10);
 }
 
+static int sc27xx_fgu_calibration(struct sc27xx_fgu_data *data)
+{
+	struct nvmem_cell *cell;
+	int calib_data, cal_4200mv;
+	void *buf;
+	size_t len;
+
+	cell = nvmem_cell_get(data->dev, "fgu_calib");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	memcpy(&calib_data, buf, min(len, sizeof(u32)));
+
+	/*
+	 * Get the ADC value corresponding to 4200 mV from eFuse controller
+	 * according to below formula. Then convert to ADC values corresponding
+	 * to 1000 mV and 1000 mA.
+	 */
+	cal_4200mv = (calib_data & 0x1ff) + 6963 - 4096 - 256;
+	data->vol_1000mv_adc = DIV_ROUND_CLOSEST(cal_4200mv * 10, 42);
+	data->cur_1000ma_adc = data->vol_1000mv_adc * 4;
+
+	kfree(buf);
+	return 0;
+}
+
 static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 {
 	struct power_supply_battery_info info = { };
@@ -503,6 +539,10 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 
 	power_supply_put_battery_info(data->battery, &info);
 
+	ret = sc27xx_fgu_calibration(data);
+	if (ret)
+		return ret;
+
 	/* Enable the FGU module */
 	ret = regmap_update_bits(data->regmap, SC27XX_MODULE_EN0,
 				 SC27XX_FGU_EN, SC27XX_FGU_EN);
-- 
1.7.9.5
