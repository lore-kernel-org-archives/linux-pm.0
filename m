From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 11/16] cpufreq: dt: Pass regulator name to the OPP core
Date: Thu, 28 Jan 2016 13:50:40 +0530
Message-ID: <d59a1d27c9e2f4cc023dfc9a2b72cb920cbac43a.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1453965717.git.viresh.kumar@linaro.org>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

OPP core can handle the regulators by itself, and but it needs to know
the name of the regulator to fetch. Add support for that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 4c9f8a828f6f..15637734986a 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -34,6 +34,7 @@ struct private_data {
 	struct regulator *cpu_reg;
 	struct thermal_cooling_device *cdev;
 	unsigned int voltage_tolerance; /* in percentage */
+	const char *reg_name;
 };
 
 static struct freq_attr *cpufreq_dt_attr[] = {
@@ -119,6 +120,49 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
 	return ret;
 }
 
+/*
+ * An earlier version of opp-v1 bindings used to name the regulator
+ * "cpu0-supply", we still need to handle that for backwards compatibility.
+ */
+static const char *find_supply_name(struct device *dev)
+{
+	struct regulator *cpu_reg;
+	char *reg_cpu0 = "cpu0", *reg_cpu = "cpu", *reg;
+	int cpu = dev->id, ret;
+
+	/* Try "cpu0" for older DTs */
+	if (!cpu)
+		reg = reg_cpu0;
+	else
+		reg = reg_cpu;
+
+try_again:
+	cpu_reg = regulator_get_optional(dev, reg);
+	ret = PTR_ERR_OR_ZERO(cpu_reg);
+	if (!ret) {
+		regulator_put(cpu_reg);
+		return reg;
+	}
+
+	/*
+	 * If cpu's regulator supply node is present, but regulator is not yet
+	 * registered, we should try defering probe.
+	 */
+	if (ret == -EPROBE_DEFER) {
+		dev_dbg(dev, "cpu%d regulator not ready, retry\n", cpu);
+		return ERR_PTR(ret);
+	}
+
+	/* Try with "cpu-supply" */
+	if (reg == reg_cpu0) {
+		reg = reg_cpu;
+		goto try_again;
+	}
+
+	dev_dbg(dev, "no regulator for cpu%d: %d\n", cpu, ret);
+	return NULL;
+}
+
 static int allocate_resources(int cpu, struct device **cdev,
 			      struct regulator **creg, struct clk **cclk)
 {
@@ -200,6 +244,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	unsigned long min_uV = ~0, max_uV = 0;
 	unsigned int transition_latency;
 	bool opp_v1 = false;
+	const char *name = NULL;
 	int ret;
 
 	ret = allocate_resources(policy->cpu, &cpu_dev, &cpu_reg, &cpu_clk);
@@ -229,6 +274,25 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	/*
+	 * OPP layer will be taking care of regulators now, but it needs to know
+	 * the name of the regulator first.
+	 */
+	name = find_supply_name(cpu_dev);
+	if (IS_ERR(name)) {
+		ret = PTR_ERR(name);
+		goto out_node_put;
+	}
+
+	if (name) {
+		ret = dev_pm_opp_set_regulator(cpu_dev, name);
+		if (ret) {
+			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
+				policy->cpu, ret);
+			goto out_node_put;
+		}
+	}
+
+	/*
 	 * Initialize OPP tables for all policy->cpus. They will be shared by
 	 * all CPUs which have marked their CPUs shared with OPP bindings.
 	 *
@@ -273,6 +337,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		goto out_free_opp;
 	}
 
+	priv->reg_name = name;
 	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance);
 
 	transition_latency = dev_pm_opp_get_max_clock_latency(cpu_dev);
@@ -366,6 +431,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	kfree(priv);
 out_free_opp:
 	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
+	if (name)
+		dev_pm_opp_put_regulator(cpu_dev);
 out_node_put:
 	of_node_put(np);
 out_put_reg_clk:
@@ -383,6 +450,9 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
+	if (priv->reg_name)
+		dev_pm_opp_put_regulator(priv->cpu_dev);
+
 	clk_put(policy->clk);
 	if (!IS_ERR(priv->cpu_reg))
 		regulator_put(priv->cpu_reg);
-- 
2.7.0.79.gdc08a19
