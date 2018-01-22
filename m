From: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 2/2] thermal: imx: add i.MX7 thermal sensor support
Date: Mon, 22 Jan 2018 15:25:49 +0800
Message-ID: <1516605949-14663-2-git-send-email-Anson.Huang@nxp.com>
References: <1516605949-14663-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1516605949-14663-1-git-send-email-Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, ping.bai-3arQi8VN3Tc@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, aisheng.dong-3arQi8VN3Tc@public.gmane.org, Linux-imx-3arQi8VN3Tc@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch adds i.MX7 thermal sensor support, most
of the i.MX7 thermal sensor functions are same with
i.MX6 except the registers offset/layout, so we move
those registers offset/layout definitions to soc data
structure.

i.MX7 uses single calibration data @25C, the calibration
data is located at OCOTP offset 0x4F0, bit[17:9], the
formula is as below:

Tmeas = (Nmeas - n1) + 25; n1 is the fuse value for 25C.

Signed-off-by: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Bai Ping <ping.bai-3arQi8VN3Tc@public.gmane.org>
---
 drivers/thermal/imx_thermal.c | 315 +++++++++++++++++++++++++++++++++---------
 1 file changed, 247 insertions(+), 68 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index e7d4ffc..b2a00d6 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -31,34 +31,58 @@
 #define REG_CLR		0x8
 #define REG_TOG		0xc
 
-#define MISC0				0x0150
-#define MISC0_REFTOP_SELBIASOFF		(1 << 3)
-#define MISC1				0x0160
-#define MISC1_IRQ_TEMPHIGH		(1 << 29)
+/* i.MX6 specific */
+#define IMX6_MISC0				0x0150
+#define IMX6_MISC0_REFTOP_SELBIASOFF		(1 << 3)
+#define IMX6_MISC1				0x0160
+#define IMX6_MISC1_IRQ_TEMPHIGH			(1 << 29)
 /* Below LOW and PANIC bits are only for TEMPMON_IMX6SX */
-#define MISC1_IRQ_TEMPLOW		(1 << 28)
-#define MISC1_IRQ_TEMPPANIC		(1 << 27)
-
-#define TEMPSENSE0			0x0180
-#define TEMPSENSE0_ALARM_VALUE_SHIFT	20
-#define TEMPSENSE0_ALARM_VALUE_MASK	(0xfff << TEMPSENSE0_ALARM_VALUE_SHIFT)
-#define TEMPSENSE0_TEMP_CNT_SHIFT	8
-#define TEMPSENSE0_TEMP_CNT_MASK	(0xfff << TEMPSENSE0_TEMP_CNT_SHIFT)
-#define TEMPSENSE0_FINISHED		(1 << 2)
-#define TEMPSENSE0_MEASURE_TEMP		(1 << 1)
-#define TEMPSENSE0_POWER_DOWN		(1 << 0)
-
-#define TEMPSENSE1			0x0190
-#define TEMPSENSE1_MEASURE_FREQ		0xffff
-/* Below TEMPSENSE2 is only for TEMPMON_IMX6SX */
-#define TEMPSENSE2			0x0290
-#define TEMPSENSE2_LOW_VALUE_SHIFT	0
-#define TEMPSENSE2_LOW_VALUE_MASK	0xfff
-#define TEMPSENSE2_PANIC_VALUE_SHIFT	16
-#define TEMPSENSE2_PANIC_VALUE_MASK	0xfff0000
+#define IMX6_MISC1_IRQ_TEMPLOW			(1 << 28)
+#define IMX6_MISC1_IRQ_TEMPPANIC		(1 << 27)
+
+#define IMX6_TEMPSENSE0				0x0180
+#define IMX6_TEMPSENSE0_ALARM_VALUE_SHIFT	20
+#define IMX6_TEMPSENSE0_ALARM_VALUE_MASK	(0xfff << 20)
+#define IMX6_TEMPSENSE0_TEMP_CNT_SHIFT		8
+#define IMX6_TEMPSENSE0_TEMP_CNT_MASK		(0xfff << 8)
+#define IMX6_TEMPSENSE0_FINISHED		(1 << 2)
+#define IMX6_TEMPSENSE0_MEASURE_TEMP		(1 << 1)
+#define IMX6_TEMPSENSE0_POWER_DOWN		(1 << 0)
+
+#define IMX6_TEMPSENSE1				0x0190
+#define IMX6_TEMPSENSE1_MEASURE_FREQ		0xffff
+#define IMX6_TEMPSENSE1_MEASURE_FREQ_SHIFT	0
 
-#define OCOTP_MEM0			0x0480
-#define OCOTP_ANA1			0x04e0
+/* Below TEMPSENSE2 is only for TEMPMON_IMX6SX */
+#define IMX6_TEMPSENSE2				0x0290
+#define IMX6_TEMPSENSE2_LOW_VALUE_SHIFT		0
+#define IMX6_TEMPSENSE2_LOW_VALUE_MASK		0xfff
+#define IMX6_TEMPSENSE2_PANIC_VALUE_SHIFT	16
+#define IMX6_TEMPSENSE2_PANIC_VALUE_MASK	0xfff0000
+
+/* i.MX7 specific */
+#define IMX7_ANADIG_DIGPROG			0x800
+#define IMX7_TEMPSENSE0				0x300
+#define IMX7_TEMPSENSE0_PANIC_ALARM_SHIFT	18
+#define IMX7_TEMPSENSE0_PANIC_ALARM_MASK	(0x1ff << 18)
+#define IMX7_TEMPSENSE0_HIGH_ALARM_SHIFT	9
+#define IMX7_TEMPSENSE0_HIGH_ALARM_MASK		(0x1ff << 9)
+#define IMX7_TEMPSENSE0_LOW_ALARM_SHIFT		0
+#define IMX7_TEMPSENSE0_LOW_ALARM_MASK		0x1ff
+
+#define IMX7_TEMPSENSE1				0x310
+#define IMX7_TEMPSENSE1_MEASURE_FREQ_SHIFT	16
+#define IMX7_TEMPSENSE1_MEASURE_FREQ_MASK	(0xffff << 16)
+#define IMX7_TEMPSENSE1_FINISHED		(1 << 11)
+#define IMX7_TEMPSENSE1_MEASURE_TEMP		(1 << 10)
+#define IMX7_TEMPSENSE1_POWER_DOWN		(1 << 9)
+#define IMX7_TEMPSENSE1_TEMP_VALUE_SHIFT	0
+#define IMX7_TEMPSENSE1_TEMP_VALUE_MASK		0x1ff
+
+#define IMX6_OCOTP_MEM0				0x0480
+#define IMX6_OCOTP_ANA1				0x04e0
+#define IMX7_OCOTP_TESTER3			0x0440
+#define IMX7_OCOTP_ANA1				0x04f0
 
 /* The driver supports 1 passive trip point and 1 critical trip point */
 enum imx_thermal_trip {
@@ -76,17 +100,110 @@ enum imx_thermal_trip {
 
 #define TEMPMON_IMX6Q			1
 #define TEMPMON_IMX6SX			2
+#define TEMPMON_IMX7			3
 
 struct thermal_soc_data {
 	u32 version;
+
+	u32 sensor_ctrl;
+	u32 power_down_mask;
+	u32 measure_temp_mask;
+
+	u32 measure_freq_ctrl;
+	u32 measure_freq_mask;
+	u32 measure_freq_shift;
+
+	u32 temp_data;
+	u32 temp_value_mask;
+	u32 temp_value_shift;
+	u32 temp_valid_mask;
+
+	u32 panic_alarm_ctrl;
+	u32 panic_alarm_mask;
+	u32 panic_alarm_shift;
+
+	u32 high_alarm_ctrl;
+	u32 high_alarm_mask;
+	u32 high_alarm_shift;
+
+	u32 low_alarm_ctrl;
+	u32 low_alarm_mask;
+	u32 low_alarm_shift;
 };
 
 static struct thermal_soc_data thermal_imx6q_data = {
 	.version = TEMPMON_IMX6Q,
+
+	.sensor_ctrl = IMX6_TEMPSENSE0,
+	.power_down_mask = IMX6_TEMPSENSE0_POWER_DOWN,
+	.measure_temp_mask = IMX6_TEMPSENSE0_MEASURE_TEMP,
+
+	.measure_freq_ctrl = IMX6_TEMPSENSE1,
+	.measure_freq_shift = IMX6_TEMPSENSE1_MEASURE_FREQ_SHIFT,
+	.measure_freq_mask = IMX6_TEMPSENSE1_MEASURE_FREQ,
+
+	.temp_data = IMX6_TEMPSENSE0,
+	.temp_value_mask = IMX6_TEMPSENSE0_TEMP_CNT_MASK,
+	.temp_value_shift = IMX6_TEMPSENSE0_TEMP_CNT_SHIFT,
+	.temp_valid_mask = IMX6_TEMPSENSE0_FINISHED,
+
+	.high_alarm_ctrl = IMX6_TEMPSENSE0,
+	.high_alarm_mask = IMX6_TEMPSENSE0_ALARM_VALUE_MASK,
+	.high_alarm_shift = IMX6_TEMPSENSE0_ALARM_VALUE_SHIFT,
 };
 
 static struct thermal_soc_data thermal_imx6sx_data = {
 	.version = TEMPMON_IMX6SX,
+
+	.sensor_ctrl = IMX6_TEMPSENSE0,
+	.power_down_mask = IMX6_TEMPSENSE0_POWER_DOWN,
+	.measure_temp_mask = IMX6_TEMPSENSE0_MEASURE_TEMP,
+
+	.measure_freq_ctrl = IMX6_TEMPSENSE1,
+	.measure_freq_shift = IMX6_TEMPSENSE1_MEASURE_FREQ_SHIFT,
+	.measure_freq_mask = IMX6_TEMPSENSE1_MEASURE_FREQ,
+
+	.temp_data = IMX6_TEMPSENSE0,
+	.temp_value_mask = IMX6_TEMPSENSE0_TEMP_CNT_MASK,
+	.temp_value_shift = IMX6_TEMPSENSE0_TEMP_CNT_SHIFT,
+	.temp_valid_mask = IMX6_TEMPSENSE0_FINISHED,
+
+	.high_alarm_ctrl = IMX6_TEMPSENSE0,
+	.high_alarm_mask = IMX6_TEMPSENSE0_ALARM_VALUE_MASK,
+	.high_alarm_shift = IMX6_TEMPSENSE0_ALARM_VALUE_SHIFT,
+
+	.panic_alarm_ctrl = IMX6_TEMPSENSE2,
+	.panic_alarm_mask = IMX6_TEMPSENSE2_PANIC_VALUE_MASK,
+	.panic_alarm_shift = IMX6_TEMPSENSE2_PANIC_VALUE_SHIFT,
+};
+
+static struct thermal_soc_data thermal_imx7_data = {
+	.version = TEMPMON_IMX7,
+
+	.sensor_ctrl = IMX7_TEMPSENSE1,
+	.power_down_mask = IMX7_TEMPSENSE1_POWER_DOWN,
+	.measure_temp_mask = IMX7_TEMPSENSE1_MEASURE_TEMP,
+
+	.measure_freq_ctrl = IMX7_TEMPSENSE1,
+	.measure_freq_shift = IMX7_TEMPSENSE1_MEASURE_FREQ_SHIFT,
+	.measure_freq_mask = IMX7_TEMPSENSE1_MEASURE_FREQ_MASK,
+
+	.temp_data = IMX7_TEMPSENSE1,
+	.temp_value_mask = IMX7_TEMPSENSE1_TEMP_VALUE_MASK,
+	.temp_value_shift = IMX7_TEMPSENSE1_TEMP_VALUE_SHIFT,
+	.temp_valid_mask = IMX7_TEMPSENSE1_FINISHED,
+
+	.panic_alarm_ctrl = IMX7_TEMPSENSE1,
+	.panic_alarm_mask = IMX7_TEMPSENSE0_PANIC_ALARM_MASK,
+	.panic_alarm_shift = IMX7_TEMPSENSE0_PANIC_ALARM_SHIFT,
+
+	.high_alarm_ctrl = IMX7_TEMPSENSE0,
+	.high_alarm_mask = IMX7_TEMPSENSE0_HIGH_ALARM_MASK,
+	.high_alarm_shift = IMX7_TEMPSENSE0_HIGH_ALARM_SHIFT,
+
+	.low_alarm_ctrl = IMX7_TEMPSENSE0,
+	.low_alarm_mask = IMX7_TEMPSENSE0_LOW_ALARM_MASK,
+	.low_alarm_shift = IMX7_TEMPSENSE0_LOW_ALARM_SHIFT,
 };
 
 struct imx_thermal_data {
@@ -112,30 +229,44 @@ static void imx_set_panic_temp(struct imx_thermal_data *data,
 			       int panic_temp)
 {
 	struct regmap *map = data->tempmon;
+	const struct thermal_soc_data *soc_data = data->socdata;
 	int critical_value;
 
-	critical_value = (data->c2 - panic_temp) / data->c1;
-	regmap_write(map, TEMPSENSE2 + REG_CLR, TEMPSENSE2_PANIC_VALUE_MASK);
-	regmap_write(map, TEMPSENSE2 + REG_SET, critical_value <<
-			TEMPSENSE2_PANIC_VALUE_SHIFT);
+	if (data->socdata->version == TEMPMON_IMX7)
+		critical_value = panic_temp / 1000 + data->c1 - 25;
+	else
+		critical_value = (data->c2 - panic_temp) / data->c1;
+
+	regmap_write(map, soc_data->panic_alarm_ctrl + REG_CLR,
+		     soc_data->panic_alarm_mask);
+	regmap_write(map, soc_data->panic_alarm_ctrl + REG_SET,
+		     critical_value << soc_data->panic_alarm_shift);
 }
 
 static void imx_set_alarm_temp(struct imx_thermal_data *data,
 			       int alarm_temp)
 {
 	struct regmap *map = data->tempmon;
+	const struct thermal_soc_data *soc_data = data->socdata;
 	int alarm_value;
 
 	data->alarm_temp = alarm_temp;
-	alarm_value = (data->c2 - alarm_temp) / data->c1;
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_ALARM_VALUE_MASK);
-	regmap_write(map, TEMPSENSE0 + REG_SET, alarm_value <<
-			TEMPSENSE0_ALARM_VALUE_SHIFT);
+
+	if (data->socdata->version == TEMPMON_IMX7)
+		alarm_value = alarm_temp / 1000 + data->c1 - 25;
+	else
+		alarm_value = (data->c2 - alarm_temp) / data->c1;
+
+	regmap_write(map, soc_data->high_alarm_ctrl + REG_CLR,
+		     soc_data->high_alarm_mask);
+	regmap_write(map, soc_data->high_alarm_ctrl + REG_SET,
+		     alarm_value << soc_data->high_alarm_shift);
 }
 
 static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct imx_thermal_data *data = tz->devdata;
+	const struct thermal_soc_data *soc_data = data->socdata;
 	struct regmap *map = data->tempmon;
 	unsigned int n_meas;
 	bool wait;
@@ -143,16 +274,18 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	if (data->mode == THERMAL_DEVICE_ENABLED) {
 		/* Check if a measurement is currently in progress */
-		regmap_read(map, TEMPSENSE0, &val);
-		wait = !(val & TEMPSENSE0_FINISHED);
+		regmap_read(map, soc_data->temp_data, &val);
+		wait = !(val & soc_data->temp_valid_mask);
 	} else {
 		/*
 		 * Every time we measure the temperature, we will power on the
 		 * temperature sensor, enable measurements, take a reading,
 		 * disable measurements, power off the temperature sensor.
 		 */
-		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
-		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
+		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
+			    soc_data->power_down_mask);
+		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
+			    soc_data->measure_temp_mask);
 
 		wait = true;
 	}
@@ -164,22 +297,28 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (wait)
 		usleep_range(20, 50);
 
-	regmap_read(map, TEMPSENSE0, &val);
+	regmap_read(map, soc_data->temp_data, &val);
 
 	if (data->mode != THERMAL_DEVICE_ENABLED) {
-		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
-		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
+			     soc_data->measure_temp_mask);
+		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
+			     soc_data->power_down_mask);
 	}
 
-	if ((val & TEMPSENSE0_FINISHED) == 0) {
+	if ((val & soc_data->temp_valid_mask) == 0) {
 		dev_dbg(&tz->device, "temp measurement never finished\n");
 		return -EAGAIN;
 	}
 
-	n_meas = (val & TEMPSENSE0_TEMP_CNT_MASK) >> TEMPSENSE0_TEMP_CNT_SHIFT;
+	n_meas = (val & soc_data->temp_value_mask)
+		>> soc_data->temp_value_shift;
 
 	/* See imx_init_calib() for formula derivation */
-	*temp = data->c2 - n_meas * data->c1;
+	if (data->socdata->version == TEMPMON_IMX7)
+		*temp = (n_meas - data->c1 + 25) * 1000;
+	else
+		*temp = data->c2 - n_meas * data->c1;
 
 	/* Update alarm value to next higher trip point for TEMPMON_IMX6Q */
 	if (data->socdata->version == TEMPMON_IMX6Q) {
@@ -223,21 +362,26 @@ static int imx_set_mode(struct thermal_zone_device *tz,
 {
 	struct imx_thermal_data *data = tz->devdata;
 	struct regmap *map = data->tempmon;
+	const struct thermal_soc_data *soc_data = data->socdata;
 
 	if (mode == THERMAL_DEVICE_ENABLED) {
 		tz->polling_delay = IMX_POLLING_DELAY;
 		tz->passive_delay = IMX_PASSIVE_DELAY;
 
-		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
-		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
+		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
+			     soc_data->power_down_mask);
+		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
+			     soc_data->measure_temp_mask);
 
 		if (!data->irq_enabled) {
 			data->irq_enabled = true;
 			enable_irq(data->irq);
 		}
 	} else {
-		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
-		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
+			     soc_data->measure_temp_mask);
+		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
+			     soc_data->power_down_mask);
 
 		tz->polling_delay = 0;
 		tz->passive_delay = 0;
@@ -359,6 +503,15 @@ static int imx_init_calib(struct platform_device *pdev, u32 val)
 	}
 
 	/*
+	 * On i.MX7, we only use the calibration data at 25C to get the temp,
+	 * Tmeas = ( Nmeas - n1) + 25; n1 is the fuse value for 25C.
+	 */
+	if (data->socdata->version == TEMPMON_IMX7) {
+		data->c1 = (val >> 9) & 0x1ff;
+		return 0;
+	}
+
+	/*
 	 * Sensor data layout:
 	 *   [31:20] - sensor value @ 25C
 	 * Use universal formula now and only need sensor value @ 25C
@@ -426,6 +579,7 @@ static void imx_init_temp_grade(struct platform_device *pdev, u32 val)
 
 static int imx_init_from_tempmon_data(struct platform_device *pdev)
 {
+	struct imx_thermal_data *data = platform_get_drvdata(pdev);
 	struct regmap *map;
 	int ret;
 	u32 val;
@@ -438,7 +592,11 @@ static int imx_init_from_tempmon_data(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = regmap_read(map, OCOTP_ANA1, &val);
+	if (data->socdata->version == TEMPMON_IMX7)
+		ret = regmap_read(map, IMX7_OCOTP_ANA1, &val);
+	else
+		ret = regmap_read(map, IMX6_OCOTP_ANA1, &val);
+
 	if (ret) {
 		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
 		return ret;
@@ -447,7 +605,11 @@ static int imx_init_from_tempmon_data(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = regmap_read(map, OCOTP_MEM0, &val);
+	/* use OTP for thermal grade */
+	if (data->socdata->version == TEMPMON_IMX7)
+		ret = regmap_read(map, IMX7_OCOTP_TESTER3, &val);
+	else
+		ret = regmap_read(map, IMX6_OCOTP_MEM0, &val);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
 		return ret;
@@ -500,6 +662,7 @@ static irqreturn_t imx_thermal_alarm_irq_thread(int irq, void *dev)
 static const struct of_device_id of_imx_thermal_match[] = {
 	{ .compatible = "fsl,imx6q-tempmon", .data = &thermal_imx6q_data, },
 	{ .compatible = "fsl,imx6sx-tempmon", .data = &thermal_imx6sx_data, },
+	{ .compatible = "fsl,imx7-tempmon", .data = &thermal_imx7_data, },
 	{ /* end */ }
 };
 MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
@@ -531,14 +694,15 @@ static int imx_thermal_probe(struct platform_device *pdev)
 
 	/* make sure the IRQ flag is clear before enabling irq on i.MX6SX */
 	if (data->socdata->version == TEMPMON_IMX6SX) {
-		regmap_write(map, MISC1 + REG_CLR, MISC1_IRQ_TEMPHIGH |
-			MISC1_IRQ_TEMPLOW | MISC1_IRQ_TEMPPANIC);
+		regmap_write(map, IMX6_MISC1 + REG_CLR,
+			IMX6_MISC1_IRQ_TEMPHIGH | IMX6_MISC1_IRQ_TEMPLOW
+			| IMX6_MISC1_IRQ_TEMPPANIC);
 		/*
 		 * reset value of LOW ALARM is incorrect, set it to lowest
 		 * value to avoid false trigger of low alarm.
 		 */
-		regmap_write(map, TEMPSENSE2 + REG_SET,
-			TEMPSENSE2_LOW_VALUE_MASK);
+		regmap_write(map, IMX6_TEMPSENSE2 + REG_SET,
+			IMX6_TEMPSENSE2_LOW_VALUE_MASK);
 	}
 
 	data->irq = platform_get_irq(pdev, 0);
@@ -565,11 +729,17 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	}
 
 	/* Make sure sensor is in known good state for measurements */
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
-	regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
-	regmap_write(map, MISC0 + REG_SET, MISC0_REFTOP_SELBIASOFF);
-	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
+		     data->socdata->power_down_mask);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
+		     data->socdata->measure_temp_mask);
+	regmap_write(map, data->socdata->measure_freq_ctrl + REG_CLR,
+		     data->socdata->measure_freq_mask);
+	if (data->socdata->version != TEMPMON_IMX7)
+		regmap_write(map, IMX6_MISC0 + REG_SET,
+			IMX6_MISC0_REFTOP_SELBIASOFF);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
+		     data->socdata->power_down_mask);
 
 	data->policy = cpufreq_cpu_get(0);
 	if (!data->policy) {
@@ -634,16 +804,20 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		 data->temp_passive / 1000);
 
 	/* Enable measurements at ~ 10 Hz */
-	regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
+	regmap_write(map, data->socdata->measure_freq_ctrl + REG_CLR,
+		     data->socdata->measure_freq_mask);
 	measure_freq = DIV_ROUND_UP(32768, 10); /* 10 Hz */
-	regmap_write(map, TEMPSENSE1 + REG_SET, measure_freq);
+	regmap_write(map, data->socdata->measure_freq_ctrl + REG_SET,
+		     measure_freq << data->socdata->measure_freq_shift);
 	imx_set_alarm_temp(data, data->temp_passive);
 
 	if (data->socdata->version == TEMPMON_IMX6SX)
 		imx_set_panic_temp(data, data->temp_critical);
 
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
-	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
+		     data->socdata->power_down_mask);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
+		     data->socdata->measure_temp_mask);
 
 	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
 			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
@@ -669,7 +843,8 @@ static int imx_thermal_remove(struct platform_device *pdev)
 	struct regmap *map = data->tempmon;
 
 	/* Disable measurements */
-	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
+		     data->socdata->power_down_mask);
 	if (!IS_ERR(data->thermal_clk))
 		clk_disable_unprepare(data->thermal_clk);
 
@@ -692,8 +867,10 @@ static int imx_thermal_suspend(struct device *dev)
 	 * temperature will be read as the thermal sensor is powered
 	 * down.
 	 */
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
-	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
+		     data->socdata->measure_temp_mask);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
+		     data->socdata->power_down_mask);
 	data->mode = THERMAL_DEVICE_DISABLED;
 	clk_disable_unprepare(data->thermal_clk);
 
@@ -710,8 +887,10 @@ static int imx_thermal_resume(struct device *dev)
 	if (ret)
 		return ret;
 	/* Enabled thermal sensor after resume */
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
-	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
+		     data->socdata->power_down_mask);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
+		     data->socdata->measure_temp_mask);
 	data->mode = THERMAL_DEVICE_ENABLED;
 
 	return 0;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
