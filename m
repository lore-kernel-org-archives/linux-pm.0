From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 07/13] thermal/drivers/hisi: Encapsulate register writes into helpers
Date: Wed, 30 Aug 2017 10:47:31 +0200
Message-ID: <1504082857-21702-7-git-send-email-daniel.lezcano@linaro.org>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, leo.yan@linaro.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hopefully, the function name can help to clarify the semantic of the operations
when writing in the register.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 96 +++++++++++++++++++++++++++++++-----------
 1 file changed, 72 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 6f0dab1..d77a938 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -26,6 +26,7 @@
 
 #include "thermal_core.h"
 
+#define TEMP0_LAG			(0x0)
 #define TEMP0_TH			(0x4)
 #define TEMP0_RST_TH			(0x8)
 #define TEMP0_CFG			(0xC)
@@ -96,6 +97,56 @@ static inline long hisi_thermal_round_temp(int temp)
 		hisi_thermal_temp_to_step(temp));
 }
 
+static inline void hisi_thermal_set_lag(void __iomem *addr, int value)
+{
+	writel(value, addr + TEMP0_LAG);
+}
+
+static inline void hisi_thermal_alarm_clear(void __iomem *addr, int value)
+{
+	writel(value, addr + TEMP0_INT_CLR);
+}
+
+static inline void hisi_thermal_alarm_enable(void __iomem *addr, int value)
+{
+	writel(value, addr + TEMP0_INT_EN);
+}
+
+static inline void hisi_thermal_alarm_set(void __iomem *addr, int temp)
+{
+	writel(hisi_thermal_temp_to_step(temp) | 0x0FFFFFF00, addr + TEMP0_TH);
+}
+
+static inline void hisi_thermal_reset_set(void __iomem *addr, int temp)
+{
+        writel(hisi_thermal_temp_to_step(temp), addr + TEMP0_RST_TH);
+}
+
+static inline void hisi_thermal_reset_enable(void __iomem *addr, int value)
+{
+        writel(value, addr + TEMP0_RST_MSK);
+}
+
+static inline void hisi_thermal_enable(void __iomem *addr, int value)
+{
+	writel(value, addr + TEMP0_EN);
+}
+
+static inline void hisi_thermal_sensor_select(void __iomem *addr, int sensor)
+{
+	writel((sensor << 12), addr + TEMP0_CFG);
+}
+
+static inline int hisi_thermal_get_temperature(void __iomem *addr)
+{
+	return hisi_thermal_step_to_temp(readl(addr + TEMP0_VALUE));
+}
+
+static inline void hisi_thermal_hdak_set(void __iomem *addr, int value)
+{
+	writel(value, addr + TEMP0_CFG);
+}
+
 static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data *data,
 					 struct hisi_thermal_sensor *sensor)
 {
@@ -104,22 +155,21 @@ static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data *data,
 	mutex_lock(&data->thermal_lock);
 
 	/* disable interrupt */
-	writel(0x0, data->regs + TEMP0_INT_EN);
-	writel(0x1, data->regs + TEMP0_INT_CLR);
+	hisi_thermal_alarm_enable(data->regs, 0);
+	hisi_thermal_alarm_clear(data->regs, 1);
 
 	/* disable module firstly */
-	writel(0x0, data->regs + TEMP0_EN);
+	hisi_thermal_enable(data->regs, 0);
 
 	/* select sensor id */
-	writel((sensor->id << 12), data->regs + TEMP0_CFG);
+	hisi_thermal_sensor_select(data->regs, sensor->id);
 
 	/* enable module */
-	writel(0x1, data->regs + TEMP0_EN);
+	hisi_thermal_enable(data->regs, 1);
 
 	usleep_range(3000, 5000);
 
-	val = readl(data->regs + TEMP0_VALUE);
-	val = hisi_thermal_step_to_temp(val);
+	val = hisi_thermal_get_temperature(data->regs);
 
 	mutex_unlock(&data->thermal_lock);
 
@@ -136,29 +186,27 @@ static void hisi_thermal_enable_bind_irq_sensor
 	sensor = &data->sensors;
 
 	/* setting the hdak time */
-	writel(0x0, data->regs + TEMP0_CFG);
+	hisi_thermal_hdak_set(data->regs, 0);
 
 	/* disable module firstly */
-	writel(0x0, data->regs + TEMP0_RST_MSK);
-	writel(0x0, data->regs + TEMP0_EN);
+	hisi_thermal_reset_enable(data->regs, 0);
+	hisi_thermal_enable(data->regs, 0);
 
 	/* select sensor id */
-	writel((sensor->id << 12), data->regs + TEMP0_CFG);
+	hisi_thermal_sensor_select(data->regs, sensor->id);
 
 	/* enable for interrupt */
-	writel(hisi_thermal_temp_to_step(sensor->thres_temp) | 0x0FFFFFF00,
-	       data->regs + TEMP0_TH);
+	hisi_thermal_alarm_set(data->regs, sensor->thres_temp);
 
-	writel(hisi_thermal_temp_to_step(HISI_TEMP_RESET),
-	       data->regs + TEMP0_RST_TH);
+	hisi_thermal_reset_set(data->regs, HISI_TEMP_RESET);
 
 	/* enable module */
-	writel(0x1, data->regs + TEMP0_RST_MSK);
-	writel(0x1, data->regs + TEMP0_EN);
-
-	writel(0x0, data->regs + TEMP0_INT_CLR);
-	writel(0x1, data->regs + TEMP0_INT_EN);
+	hisi_thermal_reset_enable(data->regs, 1);
+	hisi_thermal_enable(data->regs, 1);
 
+	hisi_thermal_alarm_clear(data->regs, 0);
+	hisi_thermal_alarm_enable(data->regs, 1);
+	
 	usleep_range(3000, 5000);
 
 	mutex_unlock(&data->thermal_lock);
@@ -169,10 +217,10 @@ static void hisi_thermal_disable_sensor(struct hisi_thermal_data *data)
 	mutex_lock(&data->thermal_lock);
 
 	/* disable sensor module */
-	writel(0x0, data->regs + TEMP0_INT_EN);
-	writel(0x0, data->regs + TEMP0_RST_MSK);
-	writel(0x0, data->regs + TEMP0_EN);
-
+	hisi_thermal_enable(data->regs, 0);
+	hisi_thermal_alarm_enable(data->regs, 0);
+	hisi_thermal_reset_enable(data->regs, 0);
+	
 	mutex_unlock(&data->thermal_lock);
 }
 
-- 
2.7.4
