From: Tao Wang <kevin.wangtao@hisilicon.com>
Subject: [PATCH 2/9] thermal/drivers/hisi: use round up step value
Date: Fri, 22 Sep 2017 17:42:05 +0800
Message-ID: <1506073332-92438-3-git-send-email-kevin.wangtao@hisilicon.com>
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

Use round up divide to ensure the programmed value of threshold and
lag not less than we set, and in order to keep the accuracy while
using round up divide, the step value should also be a round up value.
Then there is no need to use hisi_thermal_round_temp.

Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index c43e3df..c8b651d 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -40,7 +40,7 @@
 
 #define HISI_TEMP_BASE			(-60000)
 #define HISI_TEMP_RESET			(100000)
-#define HISI_TEMP_STEP			(784)
+#define HISI_TEMP_STEP			(785)
 #define HISI_TEMP_LAG			(3500)
 
 #define HISI_MAX_SENSORS		4
@@ -63,19 +63,19 @@ struct hisi_thermal_data {
 /*
  * The temperature computation on the tsensor is as follow:
  *	Unit: millidegree Celsius
- *	Step: 255/200 (0.7843)
+ *	Step: 200/255 (0.7843)
  *	Temperature base: -60°C
  *
- * The register is programmed in temperature steps, every step is 784
+ * The register is programmed in temperature steps, every step is 785
  * millidegree and begins at -60 000 m°C
  *
  * The temperature from the steps:
  *
- *	Temp = TempBase + (steps x 784)
+ *	Temp = TempBase + (steps x 785)
  *
  * and the steps from the temperature:
  *
- *	steps = (Temp - TempBase) / 784
+ *	steps = (Temp - TempBase) / 785
  *
  */
 static inline int hisi_thermal_step_to_temp(int step)
@@ -85,13 +85,7 @@ static inline int hisi_thermal_step_to_temp(int step)
 
 static inline int hisi_thermal_temp_to_step(int temp)
 {
-	return (temp - HISI_TEMP_BASE) / HISI_TEMP_STEP;
-}
-
-static inline int hisi_thermal_round_temp(int temp)
-{
-	return hisi_thermal_step_to_temp(
-		hisi_thermal_temp_to_step(temp));
+	return DIV_ROUND_UP(temp - HISI_TEMP_BASE, HISI_TEMP_STEP);
 }
 
 /*
@@ -127,7 +121,7 @@ static inline int hisi_thermal_round_temp(int temp)
  */
 static inline void hisi_thermal_set_lag(void __iomem *addr, int value)
 {
-	writel((value / HISI_TEMP_STEP) & 0x1F, addr + TEMP0_LAG);
+	writel(DIV_ROUND_UP(value, HISI_TEMP_STEP) & 0x1F, addr + TEMP0_LAG);
 }
 
 static inline void hisi_thermal_alarm_clear(void __iomem *addr, int value)
@@ -274,7 +268,7 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 
 	for (i = 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
 		if (trip[i].type == THERMAL_TRIP_PASSIVE) {
-			sensor->thres_temp = hisi_thermal_round_temp(trip[i].temperature);
+			sensor->thres_temp = trip[i].temperature;
 			break;
 		}
 	}
-- 
2.8.1
