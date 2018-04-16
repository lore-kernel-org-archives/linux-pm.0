From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 01/14] thermal: exynos: Reading temperature makes sense only
 when TMU is turned on
Date: Mon, 16 Apr 2018 12:11:52 +0200
Message-ID: <1523873525-23718-2-git-send-email-b.zolnierkie@samsung.com>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101339epcas2p171d462b70a85a6fff3bb939fca6d469d@epcas2p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

When thermal sensor is not yet enabled, reading temperature might return
random value. This might even result in stopping system booting when such
temperature is higher than the critical value. Fix this by checking if TMU
has been actually enabled before reading the temperature.

This change fixes booting of Exynos4210-based board with TMU enabled (for
example Samsung Trats board), which was broken since v4.4 kernel release.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 9e4249b40340 ("thermal: exynos: Fix first temperature read after registering sensor")
CC: stable@vger.kernel.org # v4.6+
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ed805c7..986cbd0 100644
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
1.9.1
