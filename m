From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 12/17] cpufreq: dt: Pass regulator name to the OPP core for V1 bindings
Date: Tue, 22 Dec 2015 15:46:13 +0530
Message-ID: <981905b802879bff26d839b0aab19ad67a3aa1ff.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34719 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbbLVKRF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2015 05:17:05 -0500
Received: by mail-pf0-f176.google.com with SMTP id u7so57928285pfb.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2015 02:17:05 -0800 (PST)
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

OPP core can handle the regulators by itself, and it allocates the
regulator based on device's name. But for older V1 bindings, many DT
files have used names like 'cpu-supply' instead of 'cpu0-supply'.

The cpufreq-dt driver needs to tell the right name of the regulator in
this case to the OPP core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index a6f91da7283e..39df4f1a06d2 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -34,6 +34,7 @@ struct private_data {
 	struct regulator *cpu_reg;
 	struct thermal_cooling_device *cdev;
 	unsigned int voltage_tolerance; /* in percentage */
+	const char *reg_name;
 };
 
 static struct freq_attr *cpufreq_dt_attr[] = {
@@ -118,6 +119,22 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
 	return ret;
 }
 
+/*
+ * An earlier version of opp-v1 bindings used to name the regulator
+ * "cpu-supply", we still need to handle that for backwards compatibility.
+ */
+static const char *find_supply_name(struct device *dev)
+{
+	struct regulator *cpu_reg;
+
+	cpu_reg = regulator_get_optional(dev, dev_name(dev));
+	if (IS_ERR(cpu_reg))
+		return "cpu";
+
+	regulator_put(cpu_reg);
+	return NULL;
+}
+
 static int allocate_resources(int cpu, struct device **cdev,
 			      struct regulator **creg, struct clk **cclk)
 {
@@ -200,6 +217,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	unsigned long min_uV = ~0, max_uV = 0;
 	unsigned int transition_latency;
 	bool opp_v1 = false;
+	const char *name = NULL;
 	int ret;
 
 	ret = allocate_resources(policy->cpu, &cpu_dev, &cpu_reg, &cpu_clk);
@@ -229,6 +247,25 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	/*
+	 * OPP layer will be taking care of regulators now, but it needs to know
+	 * the name of the regulator for v1 bindings.
+	 */
+	if (opp_v1) {
+		name = find_supply_name(cpu_dev);
+		if (name) {
+			ret = dev_pm_opp_set_regulator(cpu_dev, name);
+			if (ret) {
+				/*
+				 * Regulators aren't compulsory on few
+				 * platforms, don't error out for them.
+				 */
+				dev_dbg(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
+					policy->cpu, ret);
+			}
+		}
+	}
+
+	/*
 	 * Initialize OPP tables for all policy->cpus. They will be shared by
 	 * all CPUs which have marked their CPUs shared with OPP bindings.
 	 *
@@ -273,6 +310,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		goto out_free_opp;
 	}
 
+	priv->reg_name = name;
 	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance);
 
 	transition_latency = dev_pm_opp_get_max_clock_latency(cpu_dev);
@@ -366,6 +404,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	kfree(priv);
 out_free_opp:
 	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
+	if (opp_v1)
+		dev_pm_opp_put_regulator(cpu_dev);
 out_node_put:
 	of_node_put(np);
 out_put_reg_clk:
@@ -383,6 +423,9 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
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
2.7.0.rc1.186.g94414c4

