From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 15/16] cpufreq: dt: No need to fetch voltage-tolerance
Date: Tue,  9 Feb 2016 10:30:47 +0530
Message-ID: <b6e6858b6316a096ca24ec15f6c36b84b9ad0177.1454992187.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Its already done by core and we don't need to get it anymore.  And so,
we don't need to get of node in cpufreq_init() anymore, move that to
find_supply_name() instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/cpufreq/cpufreq-dt.c | 46 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 150a172c7d0a..bbafd7b63d1a 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -33,7 +33,6 @@ struct private_data {
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct thermal_cooling_device *cdev;
-	unsigned int voltage_tolerance; /* in percentage */
 	const char *reg_name;
 };
 
@@ -55,24 +54,38 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
  * An earlier version of opp-v1 bindings used to name the regulator
  * "cpu0-supply", we still need to handle that for backwards compatibility.
  */
-static const char *find_supply_name(struct device *dev, struct device_node *np)
+static const char *find_supply_name(struct device *dev)
 {
+	struct device_node *np;
 	struct property *pp;
 	int cpu = dev->id;
+	const char *name = NULL;
+
+	np = of_node_get(dev->of_node);
+
+	/* This must be valid for sure */
+	if (WARN_ON(!np))
+		return NULL;
 
 	/* Try "cpu0" for older DTs */
 	if (!cpu) {
 		pp = of_find_property(np, "cpu0-supply", NULL);
-		if (pp)
-			return "cpu0";
+		if (pp) {
+			name = "cpu0";
+			goto node_put;
+		}
 	}
 
 	pp = of_find_property(np, "cpu-supply", NULL);
-	if (pp)
-		return "cpu";
+	if (pp) {
+		name = "cpu";
+		goto node_put;
+	}
 
 	dev_dbg(dev, "no regulator for cpu%d\n", cpu);
-	return NULL;
+node_put:
+	of_node_put(np);
+	return name;
 }
 
 static int allocate_resources(int cpu, struct device **cdev,
@@ -147,7 +160,6 @@ static int allocate_resources(int cpu, struct device **cdev,
 static int cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *freq_table;
-	struct device_node *np;
 	struct private_data *priv;
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
@@ -164,13 +176,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
-	np = of_node_get(cpu_dev->of_node);
-	if (!np) {
-		dev_err(cpu_dev, "failed to find cpu%d node\n", policy->cpu);
-		ret = -ENOENT;
-		goto out_put_reg_clk;
-	}
-
 	/* Get OPP-sharing information from "operating-points-v2" bindings */
 	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, policy->cpus);
 	if (ret) {
@@ -181,20 +186,20 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		if (ret == -ENOENT)
 			opp_v1 = true;
 		else
-			goto out_node_put;
+			goto out_put_reg_clk;
 	}
 
 	/*
 	 * OPP layer will be taking care of regulators now, but it needs to know
 	 * the name of the regulator first.
 	 */
-	name = find_supply_name(cpu_dev, np);
+	name = find_supply_name(cpu_dev);
 	if (name) {
 		ret = dev_pm_opp_set_regulator(cpu_dev, name);
 		if (ret) {
 			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
 				policy->cpu, ret);
-			goto out_node_put;
+			goto out_put_reg_clk;
 		}
 	}
 
@@ -244,7 +249,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	priv->reg_name = name;
-	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance);
 
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
@@ -286,8 +290,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = transition_latency;
 
-	of_node_put(np);
-
 	return 0;
 
 out_free_cpufreq_table:
@@ -298,8 +300,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
 	if (name)
 		dev_pm_opp_put_regulator(cpu_dev);
-out_node_put:
-	of_node_put(np);
 out_put_reg_clk:
 	clk_put(cpu_clk);
 	if (!IS_ERR(cpu_reg))
-- 
2.7.1.370.gb2aa7f8
