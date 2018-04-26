From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 10/18] thermal: exynos: move IRQs clearing to
 exynos_tmu_initialize()
Date: Thu, 26 Apr 2018 13:51:25 +0200
Message-ID: <1524743493-28113-11-git-send-email-b.zolnierkie@samsung.com>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115224epcas1p3dde7044de7d11c7ec7a7411df1123552@epcas1p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Move ->tmu_clear_irqs call from ->tmu_initialize method to
exynos_tmu_initialize().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 1664d37..82484c5 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -368,8 +368,10 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
 	if (!status)
 		ret = -EBUSY;
-	else
+	else {
 		data->tmu_initialize(pdev);
+		data->tmu_clear_irqs(data);
+	}
 
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
@@ -430,8 +432,6 @@ static void exynos4210_tmu_initialize(struct platform_device *pdev)
 		writeb(temp - reference, data->base +
 		       EXYNOS4210_TMU_REG_TRIG_LEVEL0 + i * 4);
 	}
-
-	data->tmu_clear_irqs(data);
 }
 
 static void exynos4412_tmu_initialize(struct platform_device *pdev)
@@ -486,8 +486,6 @@ static void exynos4412_tmu_initialize(struct platform_device *pdev)
 	con = readl(data->base + EXYNOS_TMU_REG_CONTROL);
 	con |= (1 << EXYNOS_TMU_THERM_TRIP_EN_SHIFT);
 	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
-
-	data->tmu_clear_irqs(data);
 }
 
 static void exynos5433_tmu_initialize(struct platform_device *pdev)
@@ -571,8 +569,6 @@ static void exynos5433_tmu_initialize(struct platform_device *pdev)
 		falling_threshold |= (threshold_code << j * 8);
 		writel(falling_threshold, data->base + falling_reg_offset);
 	}
-
-	data->tmu_clear_irqs(data);
 }
 
 static void exynos7_tmu_initialize(struct platform_device *pdev)
@@ -635,8 +631,6 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
 		writel(falling_threshold,
 		       data->base + EXYNOS7_THD_TEMP_FALL7_6 + reg_off);
 	}
-
-	data->tmu_clear_irqs(data);
 }
 
 static void exynos4210_tmu_control(struct platform_device *pdev, bool on)
-- 
1.9.1
