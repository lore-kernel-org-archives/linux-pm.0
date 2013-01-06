From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH 2/5 RESEND] thermal: exynos: Miscellaneous fixes to support falling threshold interrupt
Date: Sun,  6 Jan 2013 15:50:48 -0800
Message-ID: <1357516248-31350-1-git-send-email-amit.daniel@samsung.com>
References: <1353937640-9939-3-git-send-email-amit.kachhap@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1353937640-9939-3-git-send-email-amit.kachhap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Below fixes are done to support falling threshold interrupt,
* Falling interrupt status macro corrected according to exynos5 data sheet.
* The get trend function modified to calculate trip temperature correctly.
* The clearing of interrupt status in the isr is now done after handling
  the event that caused the interrupt.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/thermal/exynos_thermal.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index dcd13f7..0d17d41 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -82,7 +82,7 @@
 
 #define EXYNOS_TRIMINFO_RELOAD		0x1
 #define EXYNOS_TMU_CLEAR_RISE_INT	0x111
-#define EXYNOS_TMU_CLEAR_FALL_INT	(0x111 << 16)
+#define EXYNOS_TMU_CLEAR_FALL_INT	(0x111 << 12)
 #define EXYNOS_MUX_ADDR_VALUE		6
 #define EXYNOS_MUX_ADDR_SHIFT		20
 #define EXYNOS_TMU_TRIP_MODE_SHIFT	13
@@ -373,12 +373,19 @@ static int exynos_get_temp(struct thermal_zone_device *thermal,
 static int exynos_get_trend(struct thermal_zone_device *thermal,
 			int trip, enum thermal_trend *trend)
 {
-	if (thermal->temperature >= trip)
+	int ret = 0;
+	unsigned long trip_temp;
+
+	ret = exynos_get_trip_temp(thermal, trip, &trip_temp);
+	if (ret < 0)
+		return ret;
+
+	if (thermal->temperature >= trip_temp)
 		*trend = THERMAL_TREND_RAISING;
 	else
 		*trend = THERMAL_TREND_DROPPING;
 
-	return 0;
+	return ret;
 }
 /* Operation callback functions for thermal zone */
 static struct thermal_zone_device_ops const exynos_dev_ops = {
@@ -712,10 +719,9 @@ static void exynos_tmu_work(struct work_struct *work)
 	struct exynos_tmu_data *data = container_of(work,
 			struct exynos_tmu_data, irq_work);
 
+	exynos_report_trigger();
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
-
-
 	if (data->soc == SOC_ARCH_EXYNOS)
 		writel(EXYNOS_TMU_CLEAR_RISE_INT |
 				EXYNOS_TMU_CLEAR_FALL_INT,
@@ -723,10 +729,9 @@ static void exynos_tmu_work(struct work_struct *work)
 	else
 		writel(EXYNOS4210_TMU_INTCLEAR_VAL,
 				data->base + EXYNOS_TMU_REG_INTCLEAR);
-
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
-	exynos_report_trigger();
+
 	enable_irq(data->irq);
 }
 
-- 
1.7.5.4
