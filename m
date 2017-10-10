From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 20/25] thermal/drivers/hisi: Add platform prefix to function name
Date: Tue, 10 Oct 2017 20:02:45 +0200
Message-ID: <1507658570-32675-20-git-send-email-daniel.lezcano@linaro.org>
References: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
 <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:49043 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932623AbdJJSFU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2017 14:05:20 -0400
Received: by mail-wm0-f47.google.com with SMTP id i124so7424611wmf.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2017 11:05:19 -0700 (PDT)
In-Reply-To: <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wangtao@linaro.org

From: Kevin Wangtao <kevin.wangtao@linaro.org>

As the next patches will provide support for the hikey3660's sensor, several
functions with the same purpose but for different platforms will be introduced.
In order to make a clear distinction between them, let's prefix the function
names with the platform name.

This patch has no functional changes.

Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 145 +++++++++++++++++++++--------------------
 1 file changed, 73 insertions(+), 72 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index ff9055a..8a70ab7 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -26,25 +26,24 @@
 
 #include "thermal_core.h"
 
-#define TEMP0_LAG			(0x0)
-#define TEMP0_TH			(0x4)
-#define TEMP0_RST_TH			(0x8)
-#define TEMP0_CFG			(0xC)
-#define TEMP0_CFG_SS_MSK		(0xF000)
-#define TEMP0_CFG_HDAK_MSK		(0x30)
-#define TEMP0_EN			(0x10)
-#define TEMP0_INT_EN			(0x14)
-#define TEMP0_INT_CLR			(0x18)
-#define TEMP0_RST_MSK			(0x1C)
-#define TEMP0_VALUE			(0x28)
-
-#define HISI_TEMP_BASE			(-60000)
-#define HISI_TEMP_RESET			(100000)
-#define HISI_TEMP_STEP			(785)
-#define HISI_TEMP_LAG			(3500)
-
-#define HISI_MAX_SENSORS		4
-#define HISI_DEFAULT_SENSOR		2
+#define HI6220_TEMP0_LAG			(0x0)
+#define HI6220_TEMP0_TH				(0x4)
+#define HI6220_TEMP0_RST_TH			(0x8)
+#define HI6220_TEMP0_CFG			(0xC)
+#define HI6220_TEMP0_CFG_SS_MSK		(0xF000)
+#define HI6220_TEMP0_CFG_HDAK_MSK		(0x30)
+#define HI6220_TEMP0_EN				(0x10)
+#define HI6220_TEMP0_INT_EN			(0x14)
+#define HI6220_TEMP0_INT_CLR			(0x18)
+#define HI6220_TEMP0_RST_MSK			(0x1C)
+#define HI6220_TEMP0_VALUE			(0x28)
+
+#define HI6220_TEMP_BASE			(-60000)
+#define HI6220_TEMP_RESET			(100000)
+#define HI6220_TEMP_STEP			(785)
+#define HI6220_TEMP_LAG			(3500)
+
+#define HI6220_DEFAULT_SENSOR		2
 
 struct hisi_thermal_sensor {
 	struct thermal_zone_device *tzd;
@@ -78,14 +77,14 @@ struct hisi_thermal_data {
  *	steps = (Temp - TempBase) / 785
  *
  */
-static inline int hisi_thermal_step_to_temp(int step)
+static inline int hi6220_thermal_step_to_temp(int step)
 {
-	return HISI_TEMP_BASE + (step * HISI_TEMP_STEP);
+	return HI6220_TEMP_BASE + (step * HI6220_TEMP_STEP);
 }
 
-static inline int hisi_thermal_temp_to_step(int temp)
+static inline int hi6220_thermal_temp_to_step(int temp)
 {
-	return DIV_ROUND_UP(temp - HISI_TEMP_BASE, HISI_TEMP_STEP);
+	return DIV_ROUND_UP(temp - HI6220_TEMP_BASE, HI6220_TEMP_STEP);
 }
 
 /*
@@ -112,51 +111,53 @@ static inline int hisi_thermal_temp_to_step(int temp)
  *
  * [0:4] : lag register
  *
- * The temperature is coded in steps, cf. HISI_TEMP_STEP.
+ * The temperature is coded in steps, cf. HI6220_TEMP_STEP.
  *
  * Min : 0x00 :  0.0 °C
  * Max : 0x1F : 24.3 °C
  *
  * The 'value' parameter is in milliCelsius.
  */
-static inline void hisi_thermal_set_lag(void __iomem *addr, int value)
+static inline void hi6220_thermal_set_lag(void __iomem *addr, int value)
 {
-	writel(DIV_ROUND_UP(value, HISI_TEMP_STEP) & 0x1F, addr + TEMP0_LAG);
+	writel(DIV_ROUND_UP(value, HI6220_TEMP_STEP) & 0x1F,
+			addr + HI6220_TEMP0_LAG);
 }
 
-static inline void hisi_thermal_alarm_clear(void __iomem *addr, int value)
+static inline void hi6220_thermal_alarm_clear(void __iomem *addr, int value)
 {
-	writel(value, addr + TEMP0_INT_CLR);
+	writel(value, addr + HI6220_TEMP0_INT_CLR);
 }
 
-static inline void hisi_thermal_alarm_enable(void __iomem *addr, int value)
+static inline void hi6220_thermal_alarm_enable(void __iomem *addr, int value)
 {
-	writel(value, addr + TEMP0_INT_EN);
+	writel(value, addr + HI6220_TEMP0_INT_EN);
 }
 
-static inline void hisi_thermal_alarm_set(void __iomem *addr, int temp)
+static inline void hi6220_thermal_alarm_set(void __iomem *addr, int temp)
 {
-	writel(hisi_thermal_temp_to_step(temp) | 0x0FFFFFF00, addr + TEMP0_TH);
+	writel(hi6220_thermal_temp_to_step(temp) | 0x0FFFFFF00,
+			addr + HI6220_TEMP0_TH);
 }
 
-static inline void hisi_thermal_reset_set(void __iomem *addr, int temp)
+static inline void hi6220_thermal_reset_set(void __iomem *addr, int temp)
 {
-	writel(hisi_thermal_temp_to_step(temp), addr + TEMP0_RST_TH);
+	writel(hi6220_thermal_temp_to_step(temp), addr + HI6220_TEMP0_RST_TH);
 }
 
-static inline void hisi_thermal_reset_enable(void __iomem *addr, int value)
+static inline void hi6220_thermal_reset_enable(void __iomem *addr, int value)
 {
-	writel(value, addr + TEMP0_RST_MSK);
+	writel(value, addr + HI6220_TEMP0_RST_MSK);
 }
 
-static inline void hisi_thermal_enable(void __iomem *addr, int value)
+static inline void hi6220_thermal_enable(void __iomem *addr, int value)
 {
-	writel(value, addr + TEMP0_EN);
+	writel(value, addr + HI6220_TEMP0_EN);
 }
 
-static inline int hisi_thermal_get_temperature(void __iomem *addr)
+static inline int hi6220_thermal_get_temperature(void __iomem *addr)
 {
-	return hisi_thermal_step_to_temp(readl(addr + TEMP0_VALUE));
+	return hi6220_thermal_step_to_temp(readl(addr + HI6220_TEMP0_VALUE));
 }
 
 /*
@@ -169,10 +170,10 @@ static inline int hisi_thermal_get_temperature(void __iomem *addr)
  * 0x2: remote sensor 2 (ACPU cluster 0)
  * 0x3: remote sensor 3 (G3D)
  */
-static inline void hisi_thermal_sensor_select(void __iomem *addr, int sensor)
+static inline void hi6220_thermal_sensor_select(void __iomem *addr, int sensor)
 {
-	writel((readl(addr + TEMP0_CFG) & ~TEMP0_CFG_SS_MSK ) |
-	       (sensor << 12), addr + TEMP0_CFG);
+	writel((readl(addr + HI6220_TEMP0_CFG) & ~HI6220_TEMP0_CFG_SS_MSK) |
+	       (sensor << 12), addr + HI6220_TEMP0_CFG);
 }
 
 /*
@@ -185,24 +186,24 @@ static inline void hisi_thermal_sensor_select(void __iomem *addr, int sensor)
  * 0x2 :  49.152 ms
  * 0x3 : 393.216 ms
  */
-static inline void hisi_thermal_hdak_set(void __iomem *addr, int value)
+static inline void hi6220_thermal_hdak_set(void __iomem *addr, int value)
 {
-	writel((readl(addr + TEMP0_CFG) & ~TEMP0_CFG_HDAK_MSK) |
-	       (value << 4), addr + TEMP0_CFG);
+	writel((readl(addr + HI6220_TEMP0_CFG) & ~HI6220_TEMP0_CFG_HDAK_MSK) |
+	       (value << 4), addr + HI6220_TEMP0_CFG);
 }
 
-static void hisi_thermal_disable_sensor(struct hisi_thermal_data *data)
+static void hi6220_thermal_disable_sensor(struct hisi_thermal_data *data)
 {
 	/* disable sensor module */
-	hisi_thermal_enable(data->regs, 0);
-	hisi_thermal_alarm_enable(data->regs, 0);
-	hisi_thermal_reset_enable(data->regs, 0);
+	hi6220_thermal_enable(data->regs, 0);
+	hi6220_thermal_alarm_enable(data->regs, 0);
+	hi6220_thermal_reset_enable(data->regs, 0);
 
 	clk_disable_unprepare(data->clk);
 }
 
 
-static int hisi_thermal_setup(struct hisi_thermal_data *data)
+static int hi6220_thermal_enable_sensor(struct hisi_thermal_data *data)
 {
 	struct hisi_thermal_sensor *sensor = &data->sensor;
 	int ret;
@@ -213,29 +214,29 @@ static int hisi_thermal_setup(struct hisi_thermal_data *data)
 		return ret;
 
 	/* disable module firstly */
-	hisi_thermal_reset_enable(data->regs, 0);
-	hisi_thermal_enable(data->regs, 0);
+	hi6220_thermal_reset_enable(data->regs, 0);
+	hi6220_thermal_enable(data->regs, 0);
 
 	/* select sensor id */
-	hisi_thermal_sensor_select(data->regs, sensor->id);
+	hi6220_thermal_sensor_select(data->regs, sensor->id);
 
 	/* setting the hdak time */
-	hisi_thermal_hdak_set(data->regs, 0);
+	hi6220_thermal_hdak_set(data->regs, 0);
 
 	/* setting lag value between current temp and the threshold */
-	hisi_thermal_set_lag(data->regs, HISI_TEMP_LAG);
+	hi6220_thermal_set_lag(data->regs, HI6220_TEMP_LAG);
 
 	/* enable for interrupt */
-	hisi_thermal_alarm_set(data->regs, sensor->thres_temp);
+	hi6220_thermal_alarm_set(data->regs, sensor->thres_temp);
 
-	hisi_thermal_reset_set(data->regs, HISI_TEMP_RESET);
+	hi6220_thermal_reset_set(data->regs, HI6220_TEMP_RESET);
 
 	/* enable module */
-	hisi_thermal_reset_enable(data->regs, 1);
-	hisi_thermal_enable(data->regs, 1);
+	hi6220_thermal_reset_enable(data->regs, 1);
+	hi6220_thermal_enable(data->regs, 1);
 
-	hisi_thermal_alarm_clear(data->regs, 0);
-	hisi_thermal_alarm_enable(data->regs, 1);
+	hi6220_thermal_alarm_clear(data->regs, 0);
+	hi6220_thermal_alarm_enable(data->regs, 1);
 
 	return 0;
 }
@@ -244,7 +245,7 @@ static int hisi_thermal_get_temp(void *__data, int *temp)
 	struct hisi_thermal_data *data = __data;
 	struct hisi_thermal_sensor *sensor = &data->sensor;
 
-	*temp = hisi_thermal_get_temperature(data->regs);
+	*temp = hi6220_thermal_get_temperature(data->regs);
 
 	dev_dbg(&data->pdev->dev, "id=%d, temp=%d, thres=%d\n",
 		sensor->id, *temp, sensor->thres_temp);
@@ -260,11 +261,11 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 {
 	struct hisi_thermal_data *data = dev;
 	struct hisi_thermal_sensor *sensor = &data->sensor;
-	int temp;
+	int temp = 0;
 
-	hisi_thermal_alarm_clear(data->regs, 1);
+	hi6220_thermal_alarm_clear(data->regs, 1);
 
-	temp = hisi_thermal_get_temperature(data->regs);
+	hisi_thermal_get_temp(data, &temp);
 
 	if (temp >= sensor->thres_temp) {
 		dev_crit(&data->pdev->dev, "THERMAL ALARM: %d > %d\n",
@@ -273,7 +274,7 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 		thermal_zone_device_update(data->sensor.tzd,
 					   THERMAL_EVENT_UNSPECIFIED);
 
-	} else if (temp < sensor->thres_temp) {
+	} else {
 		dev_crit(&data->pdev->dev, "THERMAL ALARM stopped: %d < %d\n",
 			 temp, sensor->thres_temp);
 	}
@@ -365,14 +366,14 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 
 	ret = hisi_thermal_register_sensor(pdev, data,
 					   &data->sensor,
-					   HISI_DEFAULT_SENSOR);
+					   HI6220_DEFAULT_SENSOR);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register thermal sensor: %d\n",
 			ret);
 		return ret;
 	}
 
-	ret = hisi_thermal_setup(data);
+	ret = hi6220_thermal_enable_sensor(data);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to setup the sensor: %d\n", ret);
 		return ret;
@@ -397,7 +398,7 @@ static int hisi_thermal_remove(struct platform_device *pdev)
 	struct hisi_thermal_sensor *sensor = &data->sensor;
 
 	hisi_thermal_toggle_sensor(sensor, false);
-	hisi_thermal_disable_sensor(data);
+	hi6220_thermal_disable_sensor(data);
 
 	return 0;
 }
@@ -407,7 +408,7 @@ static int hisi_thermal_suspend(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
 
-	hisi_thermal_disable_sensor(data);
+	hi6220_thermal_disable_sensor(data);
 
 	return 0;
 }
@@ -416,7 +417,7 @@ static int hisi_thermal_resume(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
 
-	return hisi_thermal_setup(data);
+	return hi6220_thermal_enable_sensor(data);
 }
 #endif
 
-- 
2.7.4
