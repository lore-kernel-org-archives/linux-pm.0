From: Maciej Purski <m.purski@samsung.com>
Subject: [PATCH] thermal: exynos: Read soc_type from match data
Date: Tue, 20 Feb 2018 13:15:48 +0100
Message-ID: <1519128948-11818-1-git-send-email-m.purski@samsung.com>
References: <CGME20180220121554eucas1p1e97fba2b784a024233d3537c33989f6a@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Maciej Purski <m.purski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Device context's field data->soc is currently obtained by comparing
of_compatible's. Provide soc_type as .data field in device's match
table, as it is done in most drivers.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 74 +++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 40 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ed805c7..40c0d33 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -29,7 +29,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
@@ -1097,47 +1097,41 @@ static irqreturn_t exynos_tmu_irq(int irq, void *id)
 }
 
 static const struct of_device_id exynos_tmu_match[] = {
-	{ .compatible = "samsung,exynos3250-tmu", },
-	{ .compatible = "samsung,exynos4210-tmu", },
-	{ .compatible = "samsung,exynos4412-tmu", },
-	{ .compatible = "samsung,exynos5250-tmu", },
-	{ .compatible = "samsung,exynos5260-tmu", },
-	{ .compatible = "samsung,exynos5420-tmu", },
-	{ .compatible = "samsung,exynos5420-tmu-ext-triminfo", },
-	{ .compatible = "samsung,exynos5433-tmu", },
-	{ .compatible = "samsung,exynos5440-tmu", },
-	{ .compatible = "samsung,exynos7-tmu", },
-	{ /* sentinel */ },
+	{
+		.compatible = "samsung,exynos3250-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS3250,
+	}, {
+		.compatible = "samsung,exynos4210-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS4210,
+	}, {
+		.compatible = "samsung,exynos4412-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS4412,
+	}, {
+		.compatible = "samsung,exynos5250-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS5250,
+	}, {
+		.compatible = "samsung,exynos5260-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS5260,
+	}, {
+		.compatible = "samsung,exynos5420-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS5420,
+	}, {
+		.compatible = "samsung,exynos5420-tmu-ext-triminfo",
+		.data = (const void *)SOC_ARCH_EXYNOS5420_TRIMINFO,
+	}, {
+		.compatible = "samsung,exynos5433-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS5433,
+	}, {
+		.compatible = "samsung,exynos5440-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS5440,
+	}, {
+		.compatible = "samsung,exynos7-tmu",
+		.data = (const void *)SOC_ARCH_EXYNOS7,
+	},
+	{ },
 };
 MODULE_DEVICE_TABLE(of, exynos_tmu_match);
 
-static int exynos_of_get_soc_type(struct device_node *np)
-{
-	if (of_device_is_compatible(np, "samsung,exynos3250-tmu"))
-		return SOC_ARCH_EXYNOS3250;
-	else if (of_device_is_compatible(np, "samsung,exynos4210-tmu"))
-		return SOC_ARCH_EXYNOS4210;
-	else if (of_device_is_compatible(np, "samsung,exynos4412-tmu"))
-		return SOC_ARCH_EXYNOS4412;
-	else if (of_device_is_compatible(np, "samsung,exynos5250-tmu"))
-		return SOC_ARCH_EXYNOS5250;
-	else if (of_device_is_compatible(np, "samsung,exynos5260-tmu"))
-		return SOC_ARCH_EXYNOS5260;
-	else if (of_device_is_compatible(np, "samsung,exynos5420-tmu"))
-		return SOC_ARCH_EXYNOS5420;
-	else if (of_device_is_compatible(np,
-					 "samsung,exynos5420-tmu-ext-triminfo"))
-		return SOC_ARCH_EXYNOS5420_TRIMINFO;
-	else if (of_device_is_compatible(np, "samsung,exynos5433-tmu"))
-		return SOC_ARCH_EXYNOS5433;
-	else if (of_device_is_compatible(np, "samsung,exynos5440-tmu"))
-		return SOC_ARCH_EXYNOS5440;
-	else if (of_device_is_compatible(np, "samsung,exynos7-tmu"))
-		return SOC_ARCH_EXYNOS7;
-
-	return -EINVAL;
-}
-
 static int exynos_of_sensor_conf(struct device_node *np,
 				 struct exynos_tmu_platform_data *pdata)
 {
@@ -1211,7 +1205,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 
 	exynos_of_sensor_conf(pdev->dev.of_node, pdata);
 	data->pdata = pdata;
-	data->soc = exynos_of_get_soc_type(pdev->dev.of_node);
+	data->soc = (enum soc_type)of_device_get_match_data(&pdev->dev);
 
 	switch (data->soc) {
 	case SOC_ARCH_EXYNOS4210:
-- 
2.7.4
