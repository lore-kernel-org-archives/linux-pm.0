From: Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 5/5] cpufreq: Loongson1: Replace goto out with return in ls1x_cpufreq_probe()
Date: Mon, 11 Apr 2016 19:55:59 +0800
Message-ID: <1460375759-20705-5-git-send-email-keguang.zhang@gmail.com>
References: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Kelvin Cheung <keguang.zhang@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch replaces goto out with return in ls1x_cpufreq_probe(),
and also includes some minor fixes.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/cpufreq/loongson1-cpufreq.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
index 5074f5e..1bc90af 100644
--- a/drivers/cpufreq/loongson1-cpufreq.c
+++ b/drivers/cpufreq/loongson1-cpufreq.c
@@ -1,7 +1,7 @@
 /*
  * CPU Frequency Scaling for Loongson 1 SoC
  *
- * Copyright (C) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (C) 2014-2016 Zhang, Keguang <keguang.zhang@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -141,7 +141,8 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int ret;
 
-	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name)
+	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name) {
+		dev_err(&pdev->dev, "platform data missing\n");
 		return -EINVAL;
 
 	cpufreq =
@@ -155,8 +156,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get %s clock\n",
 			pdata->clk_name);
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
 	cpufreq->clk = clk;
 
@@ -164,8 +164,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
 			__clk_get_name(cpufreq->clk));
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
 	cpufreq->mux_clk = clk;
 
@@ -173,8 +172,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
 			__clk_get_name(cpufreq->mux_clk));
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
 	cpufreq->pll_clk = clk;
 
@@ -182,8 +180,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get %s clock\n",
 			pdata->osc_clk_name);
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
 	cpufreq->osc_clk = clk;
 
@@ -194,32 +191,30 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"failed to register CPUFreq driver: %d\n", ret);
-		goto out;
+		return ret;
 	}
 
 	ret = cpufreq_register_notifier(&ls1x_cpufreq_notifier_block,
 					CPUFREQ_TRANSITION_NOTIFIER);
 
-	if (!ret)
-		goto out;
-
-	dev_err(&pdev->dev, "failed to register cpufreq notifier: %d\n", ret);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register CPUFreq notifier: %d\n", ret);
+		cpufreq_unregister_driver(&ls1x_cpufreq_driver);
+	}
 
-	cpufreq_unregister_driver(&ls1x_cpufreq_driver);
-out:
 	return ret;
 }
 
 static struct platform_driver ls1x_cpufreq_platdrv = {
-	.driver = {
+	.probe	= ls1x_cpufreq_probe,
+	.remove	= ls1x_cpufreq_remove,
+	.driver	= {
 		.name	= "ls1x-cpufreq",
 	},
-	.probe		= ls1x_cpufreq_probe,
-	.remove		= ls1x_cpufreq_remove,
 };
 
 module_platform_driver(ls1x_cpufreq_platdrv);
 
 MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
-MODULE_DESCRIPTION("Loongson 1 CPUFreq driver");
+MODULE_DESCRIPTION("Loongson1 CPUFreq driver");
 MODULE_LICENSE("GPL");
-- 
1.9.1
