From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 08/18] thermal: exynos: make ->tmu_initialize method void
Date: Thu, 26 Apr 2018 13:51:23 +0200
Message-ID: <1524743493-28113-9-git-send-email-b.zolnierkie@samsung.com>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115219epcas2p48747814c37573e56473fe246955656fd@epcas2p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

All implementations of ->tmu_initialize always return 0 so make
the method void and convert all implementations accordingly.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 26a0cb9..44a426a 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -220,7 +220,7 @@ struct exynos_tmu_data {
 	unsigned int ntrip;
 	bool enabled;
 
-	int (*tmu_initialize)(struct platform_device *pdev);
+	void (*tmu_initialize)(struct platform_device *pdev);
 	void (*tmu_control)(struct platform_device *pdev, bool on);
 	int (*tmu_read)(struct exynos_tmu_data *data);
 	void (*tmu_set_emulation)(struct exynos_tmu_data *data, int temp);
@@ -369,7 +369,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	if (!status)
 		ret = -EBUSY;
 	else
-		ret = data->tmu_initialize(pdev);
+		data->tmu_initialize(pdev);
 
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
@@ -409,13 +409,13 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 	mutex_unlock(&data->lock);
 }
 
-static int exynos4210_tmu_initialize(struct platform_device *pdev)
+static void exynos4210_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
 	const struct thermal_trip * const trips =
 		of_thermal_get_trip_points(tz);
-	int ret = 0, threshold_code, i;
+	int threshold_code, i;
 	unsigned long reference, temp;
 
 	sanitize_temp_error(data, readl(data->base + EXYNOS_TMU_REG_TRIMINFO));
@@ -432,17 +432,15 @@ static int exynos4210_tmu_initialize(struct platform_device *pdev)
 	}
 
 	data->tmu_clear_irqs(data);
-
-	return ret;
 }
 
-static int exynos4412_tmu_initialize(struct platform_device *pdev)
+static void exynos4412_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	const struct thermal_trip * const trips =
 		of_thermal_get_trip_points(data->tzd);
 	unsigned int trim_info, con, ctrl, rising_threshold;
-	int ret = 0, threshold_code, i;
+	int threshold_code, i;
 	unsigned long crit_temp = 0;
 
 	if (data->soc == SOC_ARCH_EXYNOS3250 ||
@@ -490,18 +488,16 @@ static int exynos4412_tmu_initialize(struct platform_device *pdev)
 	con = readl(data->base + EXYNOS_TMU_REG_CONTROL);
 	con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
-
-	return ret;
 }
 
-static int exynos5433_tmu_initialize(struct platform_device *pdev)
+static void exynos5433_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
 	unsigned int trim_info;
 	unsigned int rising_threshold = 0, falling_threshold = 0;
 	int temp, temp_hist;
-	int ret = 0, threshold_code, i, sensor_id, cal_type;
+	int threshold_code, i, sensor_id, cal_type;
 
 	trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
 	sanitize_temp_error(data, trim_info);
@@ -577,17 +573,15 @@ static int exynos5433_tmu_initialize(struct platform_device *pdev)
 	}
 
 	data->tmu_clear_irqs(data);
-
-	return ret;
 }
 
-static int exynos7_tmu_initialize(struct platform_device *pdev)
+static void exynos7_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tz = data->tzd;
 	unsigned int trim_info;
 	unsigned int rising_threshold = 0, falling_threshold = 0;
-	int ret = 0, threshold_code, i;
+	int threshold_code, i;
 	int temp, temp_hist;
 	unsigned int reg_off, bit_off;
 
@@ -643,8 +637,6 @@ static int exynos7_tmu_initialize(struct platform_device *pdev)
 	}
 
 	data->tmu_clear_irqs(data);
-
-	return ret;
 }
 
 static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
-- 
1.9.1
