From: Tushar Behera <tushar.behera@linaro.org>
Subject: [PATCH] thermal: samsung: Only update available threshold limits
Date: Mon, 14 Apr 2014 11:08:15 +0530
Message-ID: <1397453895-6688-1-git-send-email-tushar.behera@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, eduardo.valentin@ti.com
List-Id: linux-pm@vger.kernel.org

Currently the threshold limits are updated in 2 stages, once for all
software trigger levels and again for hardware trip point.

While updating the software trigger levels, it overwrites the threshold
limit for hardware trip point thereby forcing the Exynos core to issue
an emergency shutdown.

Updating only the required fields in threshold register fixes this issue.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
Based on v3.15-rc1.

 drivers/thermal/samsung/exynos_tmu.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 0d96a51..ffccc89 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -225,6 +225,8 @@ skip_calib_data:
 			trigger_levs++;
 	}
 
+	rising_threshold = readl(data->base + reg->threshold_th0);
+
 	if (data->soc == SOC_ARCH_EXYNOS4210) {
 		/* Write temperature code for threshold */
 		threshold_code = temp_to_code(data, pdata->threshold);
@@ -249,6 +251,7 @@ skip_calib_data:
 				ret = threshold_code;
 				goto out;
 			}
+			rising_threshold &= ~(0xff << 8 * i);
 			rising_threshold |= threshold_code << 8 * i;
 			if (pdata->threshold_falling) {
 				threshold_code = temp_to_code(data,
@@ -281,6 +284,7 @@ skip_calib_data:
 			}
 			if (i == EXYNOS_MAX_TRIGGER_PER_REG - 1) {
 				/* 1-4 level to be assigned in th0 reg */
+				rising_threshold &= ~(0xff << 8 * i);
 				rising_threshold |= threshold_code << 8 * i;
 				writel(rising_threshold,
 					data->base + reg->threshold_th0);
-- 
1.7.9.5
