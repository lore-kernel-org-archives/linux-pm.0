From: Tao Wang <kevin.wangtao@hisilicon.com>
Subject: [PATCH 8/9] thermal/drivers/hisi: add support for hi3660 SoC
Date: Fri, 22 Sep 2017 17:42:11 +0800
Message-ID: <1506073332-92438-9-git-send-email-kevin.wangtao@hisilicon.com>
References: <1506073332-92438-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Y"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506073332-92438-1-git-send-email-kevin.wangtao@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: leo.yan@linaro.org, lonela.Voinescu@arm.com, Valentin.Schneider@arm.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, sunzhaosheng@hisilicon.com, gengyanping@hisilicon.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Wangtao <kevin.wangtao@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Kevin Wangtao <kevin.wangtao@linaro.org>

This patch adds the support for thermal sensor of Hi3660 SoC.
Hi3660 tsensor support alarm interrupt and have three configurable
alarm thresholds, it also has a configurable hysteresis interval,
interrupt will be triggered when temperature rise above the alarm
threshold or fall below the hysteresis threshold.

Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 146 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 718376b..133238a 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -39,12 +39,24 @@
 #define HI6220_TEMP0_RST_MSK			(0x1C)
 #define HI6220_TEMP0_VALUE			(0x28)
 
+#define HI3660_OFFSET(chan)		((chan) * 0x40)
+#define HI3660_TEMP(chan)		(HI3660_OFFSET(chan) + 0x1C)
+#define HI3660_TH(chan)			(HI3660_OFFSET(chan) + 0x20)
+#define HI3660_LAG(chan)		(HI3660_OFFSET(chan) + 0x28)
+#define HI3660_INT_EN(chan)		(HI3660_OFFSET(chan) + 0x2C)
+#define HI3660_INT_CLR(chan)		(HI3660_OFFSET(chan) + 0x30)
+
 #define HI6220_TEMP_BASE			(-60000)
 #define HI6220_TEMP_RESET			(100000)
 #define HI6220_TEMP_STEP			(785)
 #define HI6220_TEMP_LAG				(3500)
 
+#define HI3660_TEMP_BASE		(-63780)
+#define HI3660_TEMP_STEP		(205)
+#define HI3660_TEMP_LAG			(4000)
+
 #define HI6220_DEFAULT_SENSOR		2
+#define HI3660_DEFAULT_SENSOR		1
 
 #define MAX_THRES_NUM			2
 
@@ -96,6 +108,24 @@ static inline int hi6220_thermal_temp_to_step(int temp)
 }
 
 /*
+ * for Hi3660,
+ *	Step: 189/922 (0.205)
+ *	Temperature base: -63.780°C
+ *
+ * The register is programmed in temperature steps, every step is 205
+ * millidegree and begins at -63 780 m°C
+ */
+static inline int hi3660_thermal_step_to_temp(int step)
+{
+	return HI3660_TEMP_BASE + step * HI3660_TEMP_STEP;
+}
+
+static inline int hi3660_thermal_temp_to_step(int temp)
+{
+	return DIV_ROUND_UP(temp - HI3660_TEMP_BASE, HI3660_TEMP_STEP);
+}
+
+/*
  * The lag register contains 5 bits encoding the temperature in steps.
  *
  * Each time the temperature crosses the threshold boundary, an
@@ -169,6 +199,45 @@ static inline int hi6220_thermal_get_temperature(void __iomem *addr)
 }
 
 /*
+ * [0:6] lag register
+ *
+ * The temperature is coded in steps, cf. HI3660_TEMP_STEP.
+ *
+ * Min : 0x00 :  0.0 °C
+ * Max : 0x7F : 26.0 °C
+ *
+ */
+static inline void hi3660_thermal_set_lag(void __iomem *addr,
+					  int id, int value)
+{
+	writel(DIV_ROUND_UP(value, HI3660_TEMP_STEP) & 0x7F,
+			addr + HI3660_LAG(id));
+}
+
+static inline void hi3660_thermal_alarm_clear(void __iomem *addr,
+					      int id, int value)
+{
+	writel(value, addr + HI3660_INT_CLR(id));
+}
+
+static inline void hi3660_thermal_alarm_enable(void __iomem *addr,
+					       int id, int value)
+{
+	writel(value, addr + HI3660_INT_EN(id));
+}
+
+static inline void hi3660_thermal_alarm_set(void __iomem *addr,
+					    int id, int value)
+{
+	writel(value, addr + HI3660_TH(id));
+}
+
+static inline int hi3660_thermal_get_temperature(void __iomem *addr, int id)
+{
+	return hi3660_thermal_step_to_temp(readl(addr + HI3660_TEMP(id)));
+}
+
+/*
  * Temperature configuration register - Sensor selection
  *
  * Bits [19:12]
@@ -206,11 +275,22 @@ static int hi6220_thermal_irq_handler(struct hisi_thermal_data *data)
 	return 0;
 }
 
+static int hi3660_thermal_irq_handler(struct hisi_thermal_data *data)
+{
+	hi3660_thermal_alarm_clear(data->regs, data->sensor.id, 1);
+	return 0;
+}
+
 static int hi6220_thermal_get_temp(struct hisi_thermal_data *data)
 {
 	return hi6220_thermal_get_temperature(data->regs);
 }
 
+static int hi3660_thermal_get_temp(struct hisi_thermal_data *data)
+{
+	return hi3660_thermal_get_temperature(data->regs, data->sensor.id);
+}
+
 static int hi6220_thermal_disable_sensor(struct hisi_thermal_data *data)
 {
 	/* disable sensor module */
@@ -222,6 +302,13 @@ static int hi6220_thermal_disable_sensor(struct hisi_thermal_data *data)
 	return 0;
 }
 
+static int hi3660_thermal_disable_sensor(struct hisi_thermal_data *data)
+{
+	/* disable sensor module */
+	hi3660_thermal_alarm_enable(data->regs, data->sensor.id, 0);
+	return 0;
+}
+
 static int hi6220_thermal_enable_sensor(struct hisi_thermal_data *data)
 {
 	struct hisi_thermal_sensor *sensor = &data->sensor;
@@ -260,6 +347,29 @@ static int hi6220_thermal_enable_sensor(struct hisi_thermal_data *data)
 	return 0;
 }
 
+static int hi3660_thermal_enable_sensor(struct hisi_thermal_data *data)
+{
+	unsigned int value;
+	struct hisi_thermal_sensor *sensor = &data->sensor;
+
+	/* disable interrupt */
+	hi3660_thermal_alarm_enable(data->regs, sensor->id, 0);
+
+	/* setting lag value between current temp and the threshold */
+	hi3660_thermal_set_lag(data->regs, sensor->id, HI3660_TEMP_LAG);
+
+	/* set interrupt threshold */
+	value = hi3660_thermal_temp_to_step(sensor->thres_temp[0]);
+	value |= hi3660_thermal_temp_to_step(sensor->thres_temp[1]) << 10;
+	hi3660_thermal_alarm_set(data->regs, sensor->id, value);
+
+	/* enable interrupt */
+	hi3660_thermal_alarm_clear(data->regs, sensor->id, 1);
+	hi3660_thermal_alarm_enable(data->regs, sensor->id, 1);
+
+	return 0;
+}
+
 static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 {
 	struct platform_device *pdev = data->pdev;
@@ -296,6 +406,33 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 	return 0;
 }
 
+static int hi3660_thermal_probe(struct hisi_thermal_data *data)
+{
+	struct platform_device *pdev = data->pdev;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+
+	data->get_temp = hi3660_thermal_get_temp;
+	data->enable_sensor = hi3660_thermal_enable_sensor;
+	data->disable_sensor = hi3660_thermal_disable_sensor;
+	data->irq_handler = hi3660_thermal_irq_handler;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->regs)) {
+		dev_err(dev, "failed to get io address\n");
+		return PTR_ERR(data->regs);
+	}
+
+	data->irq = platform_get_irq(pdev, 0);
+	if (data->irq < 0)
+		return data->irq;
+
+	data->sensor.id = HI3660_DEFAULT_SENSOR;
+
+	return 0;
+}
+
 
 static int hisi_thermal_get_temp(void *__data, int *temp)
 {
@@ -371,7 +508,14 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 }
 
 static const struct of_device_id of_hisi_thermal_match[] = {
-	{ .compatible = "hisilicon,tsensor", .data = hi6220_thermal_probe },
+	{
+		.compatible = "hisilicon,tsensor",
+		.data = hi6220_thermal_probe
+	},
+	{
+		.compatible = "hisilicon,hi3660-tsensor",
+		.data = hi3660_thermal_probe
+	},
 	{ /* end */ }
 };
 MODULE_DEVICE_TABLE(of, of_hisi_thermal_match);
-- 
2.8.1
