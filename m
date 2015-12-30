From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] thermal: hisilicon: increase temperature resolution
Date: Wed, 30 Dec 2015 13:13:02 +0800
Message-ID: <1451452382-4498-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kongxinwei <kong.kongxinwei@hisilicon.com>
Cc: Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

When calculate temperature, old code firstly do division and then
convert to "millicelsius" unit. This will lose resolution and only can
read back temperature with "Celsius" unit.

So firstly scale step value to "millicelsius" and then do division, so
finally we can increase resolution for temperature value. Also refine
the calculation from temperature value to step value.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 36d0729..5e820b5 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -68,12 +68,12 @@ static inline int _step_to_temp(int step)
 	 * Every step equals (1 * 200) / 255 celsius, and finally
 	 * need convert to millicelsius.
 	 */
-	return (HISI_TEMP_BASE + (step * 200 / 255)) * 1000;
+	return (HISI_TEMP_BASE * 1000 + (step * 200000 / 255));
 }
 
 static inline long _temp_to_step(long temp)
 {
-	return ((temp / 1000 - HISI_TEMP_BASE) * 255 / 200);
+	return ((temp - HISI_TEMP_BASE * 1000) * 255) / 200000;
 }
 
 static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data *data,
-- 
1.9.1
