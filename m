From: Bai Ping <b51503@freescale.com>
Subject: [PATCH] cpufreq: imx: use the managed interfaces for resources allocation
Date: Tue, 1 Sep 2015 01:05:30 +0800
Message-ID: <1441040730-16391-1-git-send-email-b51503@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1bn0105.outbound.protection.outlook.com ([157.56.110.105]:46720
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750922AbbHaJCJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 31 Aug 2015 05:02:09 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Replace the clk_get() and regulator_get() with the managed interfaces
then the error path can be simplified.

Signed-off-by: Bai Ping <b51503@freescale.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 52 +++++++++++------------------------------
 1 file changed, 13 insertions(+), 39 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 380a90d..1439f93 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -174,25 +174,25 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	arm_clk = clk_get(cpu_dev, "arm");
-	pll1_sys_clk = clk_get(cpu_dev, "pll1_sys");
-	pll1_sw_clk = clk_get(cpu_dev, "pll1_sw");
-	step_clk = clk_get(cpu_dev, "step");
-	pll2_pfd2_396m_clk = clk_get(cpu_dev, "pll2_pfd2_396m");
+	arm_clk = devm_clk_get(cpu_dev, "arm");
+	pll1_sys_clk = devm_clk_get(cpu_dev, "pll1_sys");
+	pll1_sw_clk = devm_clk_get(cpu_dev, "pll1_sw");
+	step_clk = devm_clk_get(cpu_dev, "step");
+	pll2_pfd2_396m_clk = devm_clk_get(cpu_dev, "pll2_pfd2_396m");
 	if (IS_ERR(arm_clk) || IS_ERR(pll1_sys_clk) || IS_ERR(pll1_sw_clk) ||
 	    IS_ERR(step_clk) || IS_ERR(pll2_pfd2_396m_clk)) {
 		dev_err(cpu_dev, "failed to get clocks\n");
 		ret = -ENOENT;
-		goto put_clk;
+		goto put_node;
 	}
 
-	arm_reg = regulator_get(cpu_dev, "arm");
-	pu_reg = regulator_get_optional(cpu_dev, "pu");
-	soc_reg = regulator_get(cpu_dev, "soc");
+	arm_reg = devm_regulator_get(cpu_dev, "arm");
+	pu_reg = devm_regulator_get_optional(cpu_dev, "pu");
+	soc_reg = devm_regulator_get(cpu_dev, "soc");
 	if (IS_ERR(arm_reg) || IS_ERR(soc_reg)) {
 		dev_err(cpu_dev, "failed to get regulators\n");
 		ret = -ENOENT;
-		goto put_reg;
+		goto put_node;
 	}
 
 	/*
@@ -205,7 +205,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		ret = of_init_opp_table(cpu_dev);
 		if (ret < 0) {
 			dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
-			goto put_reg;
+			goto put_node;
 		}
 
 		/* Because we have added the OPPs here, we must free them */
@@ -222,7 +222,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
 		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
-		goto put_reg;
+		goto out_free_opp;
 	}
 
 	/* Make imx6_soc_volt array's size same as arm opp number */
@@ -313,24 +313,7 @@ free_freq_table:
 out_free_opp:
 	if (free_opp)
 		of_free_opp_table(cpu_dev);
-put_reg:
-	if (!IS_ERR(arm_reg))
-		regulator_put(arm_reg);
-	if (!IS_ERR(pu_reg))
-		regulator_put(pu_reg);
-	if (!IS_ERR(soc_reg))
-		regulator_put(soc_reg);
-put_clk:
-	if (!IS_ERR(arm_clk))
-		clk_put(arm_clk);
-	if (!IS_ERR(pll1_sys_clk))
-		clk_put(pll1_sys_clk);
-	if (!IS_ERR(pll1_sw_clk))
-		clk_put(pll1_sw_clk);
-	if (!IS_ERR(step_clk))
-		clk_put(step_clk);
-	if (!IS_ERR(pll2_pfd2_396m_clk))
-		clk_put(pll2_pfd2_396m_clk);
+put_node:
 	of_node_put(np);
 	return ret;
 }
@@ -341,15 +324,6 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 	if (free_opp)
 		of_free_opp_table(cpu_dev);
-	regulator_put(arm_reg);
-	if (!IS_ERR(pu_reg))
-		regulator_put(pu_reg);
-	regulator_put(soc_reg);
-	clk_put(arm_clk);
-	clk_put(pll1_sys_clk);
-	clk_put(pll1_sw_clk);
-	clk_put(step_clk);
-	clk_put(pll2_pfd2_396m_clk);
 
 	return 0;
 }
-- 
1.9.1

