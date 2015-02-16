From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 3/3] thermal: exynos: Clean-up code to use oneline entry for
 exynos compatible table
Date: Mon, 16 Feb 2015 23:20:14 +0900
Message-ID: <1424096414-4327-4-git-send-email-cw00.choi@samsung.com>
References: <1424096414-4327-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59374 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbbBPOUV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Feb 2015 09:20:21 -0500
In-reply-to: <1424096414-4327-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: kgene@kernel.org, b.zolnierkie@samsung.com, kyungmin.park@samsung.com, amit.daniel@samsung.com, l.majewski@samsung.com, a.kesavan@samsung.com, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patch cleanup the code to use oneline for entry of exynos compatible
table.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 38 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index b199fff..7e6baf5 100644
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

