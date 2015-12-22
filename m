From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 17/17] cpufreq: dt: No need to allocate resources anymore
Date: Tue, 22 Dec 2015 15:46:18 +0530
Message-ID: <df2534b4ced57791ec3ee42eb34211e132aa423a.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34582 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbbLVKRZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2015 05:17:25 -0500
Received: by mail-pa0-f46.google.com with SMTP id uo6so10392886pac.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2015 02:17:25 -0800 (PST)
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

OPP layer manages it now and cpufreq-dt driver doesn't need it. But, we
still need to check for availability of resources for deferred probing.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 70 ++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 45 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index c9b7dafd986d..c778d20f8c37 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -31,7 +31,6 @@
 
 struct private_data {
 	struct device *cpu_dev;
-	struct regulator *cpu_reg;
 	struct thermal_cooling_device *cdev;
 	const char *reg_name;
 };
@@ -66,8 +65,7 @@ static const char *find_supply_name(struct device *dev)
 	return NULL;
 }
 
-static int allocate_resources(int cpu, struct device **cdev,
-			      struct regulator **creg, struct clk **cclk)
+static int resources_available(void)
 {
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
@@ -75,17 +73,14 @@ static int allocate_resources(int cpu, struct device **cdev,
 	int ret = 0;
 	char *reg_cpu0 = "cpu0", *reg_cpu = "cpu", *reg;
 
-	cpu_dev = get_cpu_device(cpu);
+	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev) {
-		pr_err("failed to get cpu%d device\n", cpu);
+		pr_err("failed to get cpu0 device\n");
 		return -ENODEV;
 	}
 
 	/* Try "cpu0" for older DTs */
-	if (!cpu)
-		reg = reg_cpu0;
-	else
-		reg = reg_cpu;
+	reg = reg_cpu0;
 
 try_again:
 	cpu_reg = regulator_get_optional(cpu_dev, reg);
@@ -95,8 +90,8 @@ static int allocate_resources(int cpu, struct device **cdev,
 		 * not yet registered, we should try defering probe.
 		 */
 		if (PTR_ERR(cpu_reg) == -EPROBE_DEFER) {
-			dev_dbg(cpu_dev, "cpu%d regulator not ready, retry\n",
-				cpu);
+			dev_dbg(cpu_dev, "cpu%s regulator not ready, retry\n",
+				reg);
 			return -EPROBE_DEFER;
 		}
 
@@ -105,17 +100,12 @@ static int allocate_resources(int cpu, struct device **cdev,
 			reg = reg_cpu;
 			goto try_again;
 		}
-
-		dev_dbg(cpu_dev, "no regulator for cpu%d: %ld\n",
-			cpu, PTR_ERR(cpu_reg));
+	} else {
+		regulator_put(cpu_reg);
 	}
 
 	cpu_clk = clk_get(cpu_dev, NULL);
 	if (IS_ERR(cpu_clk)) {
-		/* put regulator */
-		if (!IS_ERR(cpu_reg))
-			regulator_put(cpu_reg);
-
 		ret = PTR_ERR(cpu_clk);
 
 		/*
@@ -123,14 +113,11 @@ static int allocate_resources(int cpu, struct device **cdev,
 		 * registered, we should try defering probe.
 		 */
 		if (ret == -EPROBE_DEFER)
-			dev_dbg(cpu_dev, "cpu%d clock not ready, retry\n", cpu);
+			dev_dbg(cpu_dev, "cpu0 clock not ready, retry\n");
 		else
-			dev_err(cpu_dev, "failed to get cpu%d clock: %d\n", cpu,
-				ret);
+			dev_err(cpu_dev, "failed to get cpu0 clock: %d\n", ret);
 	} else {
-		*cdev = cpu_dev;
-		*creg = cpu_reg;
-		*cclk = cpu_clk;
+		clk_put(cpu_clk);
 	}
 
 	return ret;
@@ -141,7 +128,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	struct cpufreq_frequency_table *freq_table;
 	struct private_data *priv;
 	struct device *cpu_dev;
-	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
 	struct dev_pm_opp *suspend_opp;
 	unsigned int transition_latency;
@@ -149,9 +135,16 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	const char *name = NULL;
 	int ret;
 
-	ret = allocate_resources(policy->cpu, &cpu_dev, &cpu_reg, &cpu_clk);
-	if (ret) {
-		pr_err("%s: Failed to allocate resources: %d\n", __func__, ret);
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("failed to get cpu%d device\n", policy->cpu);
+		return -ENODEV;
+	}
+
+	cpu_clk = clk_get(cpu_dev, NULL);
+	if (IS_ERR(cpu_clk)) {
+		ret = PTR_ERR(cpu_clk);
+		dev_err(cpu_dev, "%s: failed to get clk: %d\n", __func__, ret);
 		return ret;
 	}
 
@@ -165,7 +158,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		if (ret == -ENOENT)
 			opp_v1 = true;
 		else
-			goto out_put_reg_clk;
+			goto out_put_clk;
 	}
 
 	/*
@@ -241,9 +234,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	priv->cpu_dev = cpu_dev;
-	priv->cpu_reg = cpu_reg;
 	policy->driver_data = priv;
-
 	policy->clk = cpu_clk;
 
 	rcu_read_lock();
@@ -284,10 +275,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
 	if (opp_v1)
 		dev_pm_opp_put_regulator(cpu_dev);
-out_put_reg_clk:
+out_put_clk:
 	clk_put(cpu_clk);
-	if (!IS_ERR(cpu_reg))
-		regulator_put(cpu_reg);
 
 	return ret;
 }
@@ -303,8 +292,6 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 		dev_pm_opp_put_regulator(priv->cpu_dev);
 
 	clk_put(policy->clk);
-	if (!IS_ERR(priv->cpu_reg))
-		regulator_put(priv->cpu_reg);
 	kfree(priv);
 
 	return 0;
@@ -357,9 +344,6 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 
 static int dt_cpufreq_probe(struct platform_device *pdev)
 {
-	struct device *cpu_dev;
-	struct regulator *cpu_reg;
-	struct clk *cpu_clk;
 	int ret;
 
 	/*
@@ -369,19 +353,15 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 	 *
 	 * FIXME: Is checking this only for CPU0 sufficient ?
 	 */
-	ret = allocate_resources(0, &cpu_dev, &cpu_reg, &cpu_clk);
+	ret = resources_available();
 	if (ret)
 		return ret;
 
-	clk_put(cpu_clk);
-	if (!IS_ERR(cpu_reg))
-		regulator_put(cpu_reg);
-
 	dt_cpufreq_driver.driver_data = dev_get_platdata(&pdev->dev);
 
 	ret = cpufreq_register_driver(&dt_cpufreq_driver);
 	if (ret)
-		dev_err(cpu_dev, "failed register driver: %d\n", ret);
+		dev_err(&pdev->dev, "failed register driver: %d\n", ret);
 
 	return ret;
 }
-- 
2.7.0.rc1.186.g94414c4

