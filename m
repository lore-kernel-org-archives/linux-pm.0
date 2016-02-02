From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 15/16] cpufreq: dt: drop references to DT node
Date: Tue, 2 Feb 2016 11:41:32 +0530
Message-ID: <20160202061132.GD31828@vireshk>
References: <cover.1453965717.git.viresh.kumar@linaro.org>
 <b0f0134c9d2488db1971d7be4b8bcdc27356eee4.1453965717.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b0f0134c9d2488db1971d7be4b8bcdc27356eee4.1453965717.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 28-01-16, 13:50, Viresh Kumar wrote:
> We don't need to get reference to DT node now, lets drop it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

And because of changes in 11/16, this got updated as well:

-------------------------8<-------------------------
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 8 Sep 2015 17:34:26 +0530
Subject: [PATCH 08/20] cpufreq: dt: No need to fetch voltage-tolerance

Its already done by core and we don't need to get it anymore.  And so,
we don't need to get of node in cpufreq_init() anymore, move that to
find_supply_name() instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 48 ++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 35c5ec3b333c..3c43fda48bdf 100644
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
+	if (!np) {
+		dev_err(dev, "failed to find cpu%d node\n", cpu);
+		return ERR_PTR(-ENOENT);
+	}
 
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
@@ -181,17 +186,17 @@ static int cpufreq_init(struct cpufreq_policy *policy)
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
 	if (IS_ERR(name)) {
 		ret = PTR_ERR(name);
-		goto out_node_put;
+		goto out_put_reg_clk;
 	}
 
 	if (name) {
@@ -199,7 +204,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		if (ret) {
 			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
 				policy->cpu, ret);
-			goto out_node_put;
+			goto out_put_reg_clk;
 		}
 	}
 
@@ -249,7 +254,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	priv->reg_name = name;
-	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance);
 
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
@@ -291,8 +295,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = transition_latency;
 
-	of_node_put(np);
-
 	return 0;
 
 out_free_cpufreq_table:
@@ -303,8 +305,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
 	if (name)
 		dev_pm_opp_put_regulator(cpu_dev);
-out_node_put:
-	of_node_put(np);
 out_put_reg_clk:
 	clk_put(cpu_clk);
 	if (!IS_ERR(cpu_reg))
