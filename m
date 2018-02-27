From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3] thermal: exynos: Reading temperature makes sense only
 when TMU is turned on
Date: Tue, 27 Feb 2018 15:23:11 +0100
Message-ID: <20180227142311.32538-1-m.szyprowski@samsung.com>
References: <CGME20180227142315eucas1p250e3fc053bd1e8e8085aebea32dc5a07@eucas1p2.samsung.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: stable@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

When thermal sensor is not yet enabled, reading temperature might return
random value. This might even result in stopping system booting when such
temperature is higher than the critical value. Fix this by checking if TMU
has been actually enabled before reading the temperature.

This change fixes booting of Exynos4210-based board with TMU enabled (for
example Samsung Trats board), which was broken since v4.4 kernel release.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 9e4249b40340 ("thermal: exynos: Fix first temperature read after registering sensor")
CC: stable@vger.kernel.org # v4.6+
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
This issue is there since commit 9e4249b40340 ("thermal: exynos: Fix
first temperature read after registering sensor"), but this patch applies
cleanly only to v4.6+ kernels.
---
 drivers/thermal/samsung/exynos_tmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ed805c7c5ace..986cbd01aaaa 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -185,6 +185,7 @@
  * @regulator: pointer to the TMU regulator structure.
  * @reg_conf: pointer to structure to register with core thermal.
  * @ntrip: number of supported trip points.
+ * @enabled: current status of TMU device
  * @tmu_initialize: SoC specific TMU initialization method
  * @tmu_control: SoC specific TMU control method
  * @tmu_read: SoC specific TMU temperature read method
@@ -205,6 +206,7 @@ struct exynos_tmu_data {
 	struct regulator *regulator;
 	struct thermal_zone_device *tzd;
 	unsigned int ntrip;
+	bool enabled;
 
 	int (*tmu_initialize)(struct platform_device *pdev);
 	void (*tmu_control)(struct platform_device *pdev, bool on);
@@ -398,6 +400,7 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
 	data->tmu_control(pdev, on);
+	data->enabled = on;
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 }
@@ -890,7 +893,7 @@ static int exynos_get_temp(void *p, int *temp)
 {
 	struct exynos_tmu_data *data = p;
 
-	if (!data || !data->tmu_read)
+	if (!data || !data->tmu_read || !data->enabled)
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
-- 
2.15.0
