From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 04/13] thermal/drivers/hisi: Simplify the temperature/step computation
Date: Wed, 30 Aug 2017 10:47:28 +0200
Message-ID: <1504082857-21702-4-git-send-email-daniel.lezcano@linaro.org>
References: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504082857-21702-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, leo.yan@linaro.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The step and the base temperature are fixed values, we can simplify the
computation by converting the base temperature to milli celsius and use a
pre-computed step value. That saves us a lot of mult + div for nothing at
runtime.

Take also the opportunity to change the function names to be consistent with
the rest of the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 67db523..b58ad40 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -35,8 +35,9 @@
 #define TEMP0_RST_MSK			(0x1C)
 #define TEMP0_VALUE			(0x28)
 
-#define HISI_TEMP_BASE			(-60)
+#define HISI_TEMP_BASE			(-60000)
 #define HISI_TEMP_RESET			(100000)
+#define HISI_TEMP_STEP			(784)
 
 #define HISI_MAX_SENSORS		4
 #define HISI_DEFAULT_SENSOR		2
@@ -61,19 +62,32 @@ struct hisi_thermal_data {
 	void __iomem *regs;
 };
 
-/* in millicelsius */
-static inline int _step_to_temp(int step)
+/*
+ * The temperature computation on the tsensor is as follow:
+ *	Unit: millidegree Celsius
+ *	Step: 255/200 (0.7843)
+ *	Temperature base: -60°C
+ *
+ * The register is programmed in temperature steps, every step is 784
+ * millidegree and begins at -60 000 m°C
+ *
+ * The temperature from the steps:
+ *
+ *	Temp = TempBase + (steps x 784)
+ *
+ * and the steps from the temperature:
+ *
+ *	steps = (Temp - TempBase) / 784
+ *
+ */
+static inline int hisi_thermal_step_to_temp(int step)
 {
-	/*
-	 * Every step equals (1 * 200) / 255 celsius, and finally
-	 * need convert to millicelsius.
-	 */
-	return (HISI_TEMP_BASE * 1000 + (step * 200000 / 255));
+	return HISI_TEMP_BASE + (step * HISI_TEMP_STEP);
 }
 
-static inline long _temp_to_step(long temp)
+static inline long hisi_thermal_temp_to_step(long temp)
 {
-	return ((temp - HISI_TEMP_BASE * 1000) * 255) / 200000;
+	return (temp - HISI_TEMP_BASE) / HISI_TEMP_STEP;
 }
 
 static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data *data,
@@ -99,7 +113,7 @@ static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data *data,
 	usleep_range(3000, 5000);
 
 	val = readl(data->regs + TEMP0_VALUE);
-	val = _step_to_temp(val);
+	val = hisi_thermal_step_to_temp(val);
 
 	mutex_unlock(&data->thermal_lock);
 
@@ -126,10 +140,11 @@ static void hisi_thermal_enable_bind_irq_sensor
 	writel((sensor->id << 12), data->regs + TEMP0_CFG);
 
 	/* enable for interrupt */
-	writel(_temp_to_step(sensor->thres_temp) | 0x0FFFFFF00,
+	writel(hisi_thermal_temp_to_step(sensor->thres_temp) | 0x0FFFFFF00,
 	       data->regs + TEMP0_TH);
 
-	writel(_temp_to_step(HISI_TEMP_RESET), data->regs + TEMP0_RST_TH);
+	writel(hisi_thermal_temp_to_step(HISI_TEMP_RESET),
+	       data->regs + TEMP0_RST_TH);
 
 	/* enable module */
 	writel(0x1, data->regs + TEMP0_RST_MSK);
-- 
2.7.4
