From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 09/18] thermal: exynos: clear IRQs later in
 exynos4412_tmu_initialize()
Date: Thu, 26 Apr 2018 13:51:24 +0200
Message-ID: <1524743493-28113-10-git-send-email-b.zolnierkie@samsung.com>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115221epcas2p29faeae4b9bd5eb023e9696e2c33c01e9@epcas2p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Clear IRQs after enabling thermal tripping (it should make no
difference in driver operation). This prepares the driver code
to moving IRQs clearing call from ->tmu_initialize method to
exynos_tmu_initialize().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 44a426a..1664d37 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -470,8 +470,6 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 	writel(rising_threshold, data->base + EXYNOS_THD_TEMP_RISE);
 	writel(get_th_reg(data, 0, true), data->base + EXYNOS_THD_TEMP_FALL);
 
-	data->tmu_clear_irqs(data);
-
 	/* if last threshold limit is also present */
 	for (i = 0; i < of_thermal_get_ntrips(data->tzd); i++) {
 		if (trips[i].type == THERMAL_TRIP_CRITICAL) {
@@ -488,6 +486,8 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 	con = readl(data->base + EXYNOS_TMU_REG_CONTROL);
 	con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
+
+	data->tmu_clear_irqs(data);
 }
 
 static void exynos5433_tmu_initialize(struct platform_device *pdev)
-- 
1.9.1
