From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 05/10] cpufreq: cpu0: use dev_{err|warn|dbg} instead of pr_{err|warn|debug}
Date: Thu, 28 Aug 2014 11:22:27 +0530
Message-ID: <5fbd6ae34f20cb1012452accc73b500c231a4647.1409201048.git.viresh.kumar@linaro.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:61776 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933131AbaH1FxL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Aug 2014 01:53:11 -0400
Received: by mail-pa0-f41.google.com with SMTP id lj1so1122621pab.14
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2014 22:53:10 -0700 (PDT)
In-Reply-To: <cover.1409201048.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409201048.git.viresh.kumar@linaro.org>
References: <cover.1409201048.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, t.figa@samsung.com, santosh.shilimkar@ti.com, thomas.petazzoni@free-electrons.com, pramod.gurav@smartplayin.com, Viresh Kumar <viresh.kumar@linaro.org>

We already have cpu_dev and is used at multiple places for printing errors using
dev_*(). But some prints are still using pr_*(). Lets make it consistent and
replace those pr_*() macros with dev_*() macros.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-cpu0.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index eb07e3f..741ff22 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -58,7 +58,8 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
 		opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_Hz);
 		if (IS_ERR(opp)) {
 			rcu_read_unlock();
-			pr_err("failed to find OPP for %ld\n", freq_Hz);
+			dev_err(cpu_dev, "failed to find OPP for %ld\n",
+				freq_Hz);
 			return PTR_ERR(opp);
 		}
 		volt = dev_pm_opp_get_voltage(opp);
@@ -67,22 +68,23 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
 		volt_old = regulator_get_voltage(cpu_reg);
 	}
 
-	pr_debug("%u MHz, %ld mV --> %u MHz, %ld mV\n",
-		 old_freq / 1000, volt_old ? volt_old / 1000 : -1,
-		 new_freq / 1000, volt ? volt / 1000 : -1);
+	dev_dbg(cpu_dev, "%u MHz, %ld mV --> %u MHz, %ld mV\n",
+		old_freq / 1000, volt_old ? volt_old / 1000 : -1,
+		new_freq / 1000, volt ? volt / 1000 : -1);
 
 	/* scaling up?  scale voltage before frequency */
 	if (!IS_ERR(cpu_reg) && new_freq > old_freq) {
 		ret = regulator_set_voltage_tol(cpu_reg, volt, tol);
 		if (ret) {
-			pr_err("failed to scale voltage up: %d\n", ret);
+			dev_err(cpu_dev, "failed to scale voltage up: %d\n",
+				ret);
 			return ret;
 		}
 	}
 
 	ret = clk_set_rate(cpu_clk, freq_exact);
 	if (ret) {
-		pr_err("failed to set clock rate: %d\n", ret);
+		dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
 		if (!IS_ERR(cpu_reg))
 			regulator_set_voltage_tol(cpu_reg, volt_old, tol);
 		return ret;
@@ -92,7 +94,8 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
 	if (!IS_ERR(cpu_reg) && new_freq < old_freq) {
 		ret = regulator_set_voltage_tol(cpu_reg, volt, tol);
 		if (ret) {
-			pr_err("failed to scale voltage down: %d\n", ret);
+			dev_err(cpu_dev, "failed to scale voltage down: %d\n",
+				ret);
 			clk_set_rate(cpu_clk, old_freq * 1000);
 		}
 	}
@@ -129,7 +132,7 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 
 	np = of_node_get(cpu_dev->of_node);
 	if (!np) {
-		pr_err("failed to find cpu0 node\n");
+		dev_err(cpu_dev, "failed to find cpu0 node\n");
 		return -ENOENT;
 	}
 
@@ -144,8 +147,8 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 			ret = -EPROBE_DEFER;
 			goto out_put_node;
 		}
-		pr_warn("failed to get cpu0 regulator: %ld\n",
-			PTR_ERR(cpu_reg));
+		dev_warn(cpu_dev, "failed to get cpu0 regulator: %ld\n",
+			 PTR_ERR(cpu_reg));
 	}
 
 	cpu_clk = clk_get(cpu_dev, NULL);
@@ -169,7 +172,7 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
-		pr_err("failed to init cpufreq table: %d\n", ret);
+		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
 		goto out_put_clk;
 	}
 
@@ -205,7 +208,7 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 
 	ret = cpufreq_register_driver(&cpu0_cpufreq_driver);
 	if (ret) {
-		pr_err("failed register driver: %d\n", ret);
+		dev_err(cpu_dev, "failed to register driver: %d\n", ret);
 		goto out_free_table;
 	}
 
@@ -216,8 +219,9 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 	if (of_find_property(np, "#cooling-cells", NULL)) {
 		cdev = of_cpufreq_cooling_register(np, cpu_present_mask);
 		if (IS_ERR(cdev))
-			pr_err("running cpufreq without cooling device: %ld\n",
-			       PTR_ERR(cdev));
+			dev_err(cpu_dev,
+				"running cpufreq without cooling device: %ld\n",
+				PTR_ERR(cdev));
 	}
 
 	of_node_put(np);
-- 
2.0.3.693.g996b0fd

