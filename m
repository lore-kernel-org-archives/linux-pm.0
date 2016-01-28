From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 16/16] cpufreq: dt: No need to allocate resources anymore
Date: Thu, 28 Jan 2016 13:50:45 +0530
Message-ID: <6c45d5257ba11485719d3cb3a795ccb6ca1670d5.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

OPP layer manages it now and cpufreq-dt driver doesn't need it. But, we
still need to check for availability of resources for deferred probing.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 94 ++++++++++++--------------------------------
 1 file changed, 26 insertions(+), 68 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 5ea41518df63..82d23288c70f 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -31,7 +31,6 @@
 
 struct private_data {
 	struct device *cpu_dev;
-	struct regulator *cpu_reg;
 	struct thermal_cooling_device *cdev;
 	const char *reg_name;
 };
@@ -93,70 +92,36 @@ static const char *find_supply_name(struct device *dev)
 	return NULL;
 }
 
-static int allocate_resources(int cpu, struct device **cdev,
-			      struct regulator **creg, struct clk **cclk)
+static int resources_available(void)
 {
 	struct device *cpu_dev;
-	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
 	int ret = 0;
-	char *reg_cpu0 = "cpu0", *reg_cpu = "cpu", *reg;
+	const char *name;
 
-	cpu_dev = get_cpu_device(cpu);
+	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev) {
-		pr_err("failed to get cpu%d device\n", cpu);
+		pr_err("failed to get cpu0 device\n");
 		return -ENODEV;
 	}
 
-	/* Try "cpu0" for older DTs */
-	if (!cpu)
-		reg = reg_cpu0;
-	else
-		reg = reg_cpu;
-
-try_again:
-	cpu_reg = regulator_get_optional(cpu_dev, reg);
-	ret = PTR_ERR_OR_ZERO(cpu_reg);
-	if (ret) {
-		/*
-		 * If cpu's regulator supply node is present, but regulator is
-		 * not yet registered, we should try defering probe.
-		 */
-		if (ret == -EPROBE_DEFER) {
-			dev_dbg(cpu_dev, "cpu%d regulator not ready, retry\n",
-				cpu);
-			return ret;
-		}
-
-		/* Try with "cpu-supply" */
-		if (reg == reg_cpu0) {
-			reg = reg_cpu;
-			goto try_again;
-		}
-
-		dev_dbg(cpu_dev, "no regulator for cpu%d: %d\n", cpu, ret);
-	}
+	name = find_supply_name(cpu_dev);
+	if (IS_ERR(name))
+		return PTR_ERR(name);
 
 	cpu_clk = clk_get(cpu_dev, NULL);
 	ret = PTR_ERR_OR_ZERO(cpu_clk);
 	if (ret) {
-		/* put regulator */
-		if (!IS_ERR(cpu_reg))
-			regulator_put(cpu_reg);
-
 		/*
 		 * If cpu's clk node is present, but clock is not yet
 		 * registered, we should try defering probe.
 		 */
 		if (ret == -EPROBE_DEFER)
-			dev_dbg(cpu_dev, "cpu%d clock not ready, retry\n", cpu);
+			dev_dbg(cpu_dev, "clock not ready, retry\n");
 		else
-			dev_err(cpu_dev, "failed to get cpu%d clock: %d\n", cpu,
-				ret);
+			dev_err(cpu_dev, "failed to get clock: %d\n", ret);
 	} else {
-		*cdev = cpu_dev;
-		*creg = cpu_reg;
-		*cclk = cpu_clk;
+		clk_put(cpu_clk);
 	}
 
 	return ret;
@@ -167,7 +132,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	struct cpufreq_frequency_table *freq_table;
 	struct private_data *priv;
 	struct device *cpu_dev;
-	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
 	struct dev_pm_opp *suspend_opp;
 	unsigned int transition_latency;
@@ -175,9 +139,16 @@ static int cpufreq_init(struct cpufreq_policy *policy)
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
 
@@ -191,7 +162,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		if (ret == -ENOENT)
 			opp_v1 = true;
 		else
-			goto out_put_reg_clk;
+			goto out_put_clk;
 	}
 
 	/*
@@ -201,7 +172,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	name = find_supply_name(cpu_dev);
 	if (IS_ERR(name)) {
 		ret = PTR_ERR(name);
-		goto out_put_reg_clk;
+		goto out_put_clk;
 	}
 
 	if (name) {
@@ -209,7 +180,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		if (ret) {
 			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
 				policy->cpu, ret);
-			goto out_put_reg_clk;
+			goto out_put_clk;
 		}
 	}
 
@@ -267,9 +238,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	priv->cpu_dev = cpu_dev;
-	priv->cpu_reg = cpu_reg;
 	policy->driver_data = priv;
-
 	policy->clk = cpu_clk;
 
 	rcu_read_lock();
@@ -310,10 +279,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
 	if (name)
 		dev_pm_opp_put_regulator(cpu_dev);
-out_put_reg_clk:
+out_put_clk:
 	clk_put(cpu_clk);
-	if (!IS_ERR(cpu_reg))
-		regulator_put(cpu_reg);
 
 	return ret;
 }
@@ -329,8 +296,6 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 		dev_pm_opp_put_regulator(priv->cpu_dev);
 
 	clk_put(policy->clk);
-	if (!IS_ERR(priv->cpu_reg))
-		regulator_put(priv->cpu_reg);
 	kfree(priv);
 
 	return 0;
@@ -383,9 +348,6 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 
 static int dt_cpufreq_probe(struct platform_device *pdev)
 {
-	struct device *cpu_dev;
-	struct regulator *cpu_reg;
-	struct clk *cpu_clk;
 	int ret;
 
 	/*
@@ -395,19 +357,15 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
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
2.7.0.79.gdc08a19
