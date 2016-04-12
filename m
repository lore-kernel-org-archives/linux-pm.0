From: Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH V1 5/5] cpufreq: Loongson1: Replace goto out with return in ls1x_cpufreq_probe()
Date: Tue, 12 Apr 2016 18:40:19 +0800
Message-ID: <1460457619-14786-5-git-send-email-keguang.zhang@gmail.com>
References: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Kelvin Cheung <keguang.zhang@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch replaces goto out with return in ls1x_cpufreq_probe().

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>

---
V1:
   Move the minor updates into patch#1.
   Fix the brace problem in ls1x_cpufreq_probe().
---
 drivers/cpufreq/loongson1-cpufreq.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
index f0d0156..be89416 100644
--- a/drivers/cpufreq/loongson1-cpufreq.c
+++ b/drivers/cpufreq/loongson1-cpufreq.c
@@ -141,8 +141,10 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int ret;
 
-	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name)
+	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name) {
+		dev_err(&pdev->dev, "platform data missing\n");
 		return -EINVAL;
+	}
 
 	cpufreq =
 	    devm_kzalloc(&pdev->dev, sizeof(struct ls1x_cpufreq), GFP_KERNEL);
@@ -155,8 +157,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get %s clock\n",
 			pdata->clk_name);
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
 	cpufreq->clk = clk;
 
@@ -164,8 +165,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
 			__clk_get_name(cpufreq->clk));
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
 	cpufreq->mux_clk = clk;
 
@@ -173,8 +173,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
 			__clk_get_name(cpufreq->mux_clk));
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
 	cpufreq->pll_clk = clk;
 
@@ -182,8 +181,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get %s clock\n",
 			pdata->osc_clk_name);
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
 	cpufreq->osc_clk = clk;
 
@@ -194,19 +192,18 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
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
+		dev_err(&pdev->dev,
+			"failed to register CPUFreq notifier: %d\n",ret);
+		cpufreq_unregister_driver(&ls1x_cpufreq_driver);
+	}
 
-	cpufreq_unregister_driver(&ls1x_cpufreq_driver);
-out:
 	return ret;
 }
 
-- 
1.9.1
