From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv3 6/8] devfreq: exynos4: Fix power-leakage of clock on suspend
 state
Date: Fri, 14 Mar 2014 18:30:06 +0900
Message-ID: <1394789408-14648-7-git-send-email-cw00.choi@samsung.com>
References: <1394789408-14648-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1394789408-14648-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, b.zolnierkie@samsaung.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch disable ppmu clocks before entering suspend state to remove
power-leakage and enable ppmu clocks on resume function.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/exynos/exynos4_bus.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
index e5d2c5a..65e097a 100644
--- a/drivers/devfreq/exynos/exynos4_bus.c
+++ b/drivers/devfreq/exynos/exynos4_bus.c
@@ -1251,14 +1251,37 @@ static int exynos4_busfreq_remove(struct platform_device *pdev)
 static int exynos4_busfreq_resume(struct device *dev)
 {
 	struct busfreq_data *data = dev_get_drvdata(dev);
+	int i;
+
+	/* Enable clock after wake-up from suspend state */
+	for (i = 0; i < PPMU_END; i++)
+		clk_prepare_enable(data->clk_ppmu[i]);
+
+	/* Reset PPMU to check utilization again */
 
 	busfreq_mon_reset(data);
+
 	return 0;
 }
+
+static int exynos4_busfreq_suspend(struct device *dev)
+{
+	struct busfreq_data *data = dev_get_drvdata(dev);
+	int i;
+
+	/*
+	 * Disable clock before entering suspend state
+	 * to reduce leakage power on suspend state.
+	 */
+	for (i = 0; i < PPMU_END; i++)
+		clk_disable_unprepare(data->clk_ppmu[i]);
+
+	return 0;
+};
 #endif
 
 static const struct dev_pm_ops exynos4_busfreq_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(NULL, exynos4_busfreq_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(exynos4_busfreq_suspend, exynos4_busfreq_resume)
 };
 
 static const struct platform_device_id exynos4_busfreq_id[] = {
-- 
1.8.0
