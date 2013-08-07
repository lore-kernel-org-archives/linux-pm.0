From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Subject: [PATCH] thermal: exynos_tmu: fix wrong error check for mapped memory
Date: Wed, 07 Aug 2013 14:01:09 +0530
Message-ID: <1375864269-9197-1-git-send-email-ch.naveen@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, rui.zhang@intel.com, eduardo.valentin@ti.com
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com
List-Id: linux-pm@vger.kernel.org

The error check is checking for a "base" mapped memory base
instead of "base_common". Fixing the same.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ec01dfe..a033dbb 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -592,7 +592,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 
 	data->base_common = devm_ioremap(&pdev->dev, res.start,
 					resource_size(&res));
-	if (!data->base) {
+	if (!data->base_common) {
 		dev_err(&pdev->dev, "Failed to ioremap memory\n");
 		return -ENOMEM;
 	}
-- 
1.7.9.5
