From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 15/16] cpufreq: dt: drop references to DT node
Date: Thu, 28 Jan 2016 13:50:44 +0530
Message-ID: <b0f0134c9d2488db1971d7be4b8bcdc27356eee4.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

We don't need to get reference to DT node now, lets drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/cpufreq/cpufreq-dt.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 13338365f24e..5ea41518df63 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -33,7 +33,6 @@ struct private_data {
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct thermal_cooling_device *cdev;
-	unsigned int voltage_tolerance; /* in percentage */
 	const char *reg_name;
 };
 
@@ -166,7 +165,6 @@ static int allocate_resources(int cpu, struct device **cdev,
 static int cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *freq_table;
-	struct device_node *np;
 	struct private_data *priv;
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
@@ -183,13 +181,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
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
@@ -200,7 +191,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		if (ret == -ENOENT)
 			opp_v1 = true;
 		else
-			goto out_node_put;
+			goto out_put_reg_clk;
 	}
 
 	/*
@@ -210,7 +201,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	name = find_supply_name(cpu_dev);
 	if (IS_ERR(name)) {
 		ret = PTR_ERR(name);
-		goto out_node_put;
+		goto out_put_reg_clk;
 	}
 
 	if (name) {
@@ -218,7 +209,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		if (ret) {
 			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
 				policy->cpu, ret);
-			goto out_node_put;
+			goto out_put_reg_clk;
 		}
 	}
 
@@ -268,7 +259,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	priv->reg_name = name;
-	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance);
 
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
@@ -310,8 +300,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = transition_latency;
 
-	of_node_put(np);
-
 	return 0;
 
 out_free_cpufreq_table:
@@ -322,8 +310,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
 	if (name)
 		dev_pm_opp_put_regulator(cpu_dev);
-out_node_put:
-	of_node_put(np);
 out_put_reg_clk:
 	clk_put(cpu_clk);
 	if (!IS_ERR(cpu_reg))
-- 
2.7.0.79.gdc08a19
