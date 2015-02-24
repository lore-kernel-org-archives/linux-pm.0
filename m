From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 2/2] thermal: exynos: Clean-up code to use oneline entry for
 exynos compatible table
Date: Tue, 24 Feb 2015 13:56:55 +0900
Message-ID: <1424753815-15113-3-git-send-email-cw00.choi@samsung.com>
References: <1424753815-15113-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1424753815-15113-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: kgene@kernel.org, b.zolnierkie@samsung.com, amit.daniel@samsung.com, l.majewski@samsung.com, a.kesavan@samsung.com, inki.dae@samsung.com, kyungmin.park@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch cleanup the code to use oneline for entry of exynos compatible
table.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 38 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index a60f527..1d30b09 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -919,34 +919,16 @@ static irqreturn_t exynos_tmu_irq(int irq, void *id)
 }
 
 static const struct of_device_id exynos_tmu_match[] = {
-	{
-		.compatible = "samsung,exynos3250-tmu",
-	},
-	{
-		.compatible = "samsung,exynos4210-tmu",
-	},
-	{
-		.compatible = "samsung,exynos4412-tmu",
-	},
-	{
-		.compatible = "samsung,exynos5250-tmu",
-	},
-	{
-		.compatible = "samsung,exynos5260-tmu",
-	},
-	{
-		.compatible = "samsung,exynos5420-tmu",
-	},
-	{
-		.compatible = "samsung,exynos5420-tmu-ext-triminfo",
-	},
-	{
-		.compatible = "samsung,exynos5440-tmu",
-	},
-	{
-		.compatible = "samsung,exynos7-tmu",
-	},
-	{},
+	{ .compatible = "samsung,exynos3250-tmu", },
+	{ .compatible = "samsung,exynos4210-tmu", },
+	{ .compatible = "samsung,exynos4412-tmu", },
+	{ .compatible = "samsung,exynos5250-tmu", },
+	{ .compatible = "samsung,exynos5260-tmu", },
+	{ .compatible = "samsung,exynos5420-tmu", },
+	{ .compatible = "samsung,exynos5420-tmu-ext-triminfo", },
+	{ .compatible = "samsung,exynos5440-tmu", },
+	{ .compatible = "samsung,exynos7-tmu", },
+	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, exynos_tmu_match);
 
-- 
1.8.5.5
