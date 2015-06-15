From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/10] cpufreq-dt: Add support for operating-points-v2 bindings
Date: Mon, 15 Jun 2015 17:27:36 +0530
Message-ID: <a486d730c2c2dacd387feee13a4c800fdc641077.1434369079.git.viresh.kumar@linaro.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35729 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045AbbFOL6d (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 07:58:33 -0400
Received: by pacyx8 with SMTP id yx8so64443319pac.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 04:58:32 -0700 (PDT)
In-Reply-To: <cover.1434369079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434369079.git.viresh.kumar@linaro.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, Viresh Kumar <viresh.kumar@linaro.org>

Support for parsing operating-points-v2 bindings is in place now, lets
modify cpufreq-dt driver to use them.

For backward compatibility we will continue to support earlier bindings.
Special handling for that is required, to make sure OPPs are initialized
for all the CPUs.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 58 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index bab67db54b7e..f7bb2976059a 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -184,7 +184,6 @@ static int allocate_resources(int cpu, struct device **cdev,
 
 static int cpufreq_init(struct cpufreq_policy *policy)
 {
-	struct cpufreq_dt_platform_data *pd;
 	struct cpufreq_frequency_table *freq_table;
 	struct device_node *np;
 	struct private_data *priv;
@@ -192,7 +191,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
 	unsigned long min_uV = ~0, max_uV = 0;
-	unsigned int transition_latency;
+	unsigned int transition_latency = 0;
+	bool need_update = false;
 	int ret;
 
 	ret = allocate_resources(policy->cpu, &cpu_dev, &cpu_reg, &cpu_clk);
@@ -208,8 +208,47 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		goto out_put_reg_clk;
 	}
 
-	/* OPPs might be populated at runtime, don't check for error here */
-	of_init_opp_table(cpu_dev);
+	/* Get OPP-sharing information from "operating-points-v2" bindings */
+	ret = of_get_cpus_sharing_opps(cpu_dev, policy->cpus);
+	if (ret) {
+		/*
+		 * operating-points-v2 not supported, fallback to old method of
+		 * finding shared-OPPs for backward compatibility.
+		 */
+		if (ret == -ENOENT)
+			need_update = true;
+		else
+			goto out_node_put;
+	}
+
+	/*
+	 * Initialize OPP tables for all policy->cpus. They will be shared by
+	 * all CPUs which have marked their CPUs shared with OPP bindings.
+	 *
+	 * For platforms not using operating-points-v2 bindings, we do this
+	 * before updating policy->cpus. Otherwise, we will end up creating
+	 * duplicate OPPs for policy->cpus.
+	 *
+	 * OPPs might be populated at runtime, don't check for error here
+	 */
+	of_cpumask_init_opp_table(policy->cpus);
+
+	if (need_update) {
+		struct cpufreq_dt_platform_data *pd = cpufreq_get_driver_data();
+
+		if (!pd || !pd->independent_clocks)
+			cpumask_setall(policy->cpus);
+
+		/*
+		 * OPP tables are initialized only for policy->cpu, do it for
+		 * others as well.
+		 */
+		set_cpus_sharing_opps(cpu_dev, policy->cpus);
+
+		of_property_read_u32(np, "clock-latency", &transition_latency);
+	} else {
+		transition_latency = dev_pm_opp_get_max_clock_latency(cpu_dev);
+	}
 
 	/*
 	 * But we need OPP table to function so if it is not there let's
@@ -230,7 +269,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance);
 
-	if (of_property_read_u32(np, "clock-latency", &transition_latency))
+	if (!transition_latency)
 		transition_latency = CPUFREQ_ETERNAL;
 
 	if (!IS_ERR(cpu_reg)) {
@@ -293,10 +332,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = transition_latency;
 
-	pd = cpufreq_get_driver_data();
-	if (!pd || !pd->independent_clocks)
-		cpumask_setall(policy->cpus);
-
 	of_node_put(np);
 
 	return 0;
@@ -306,7 +341,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 out_free_priv:
 	kfree(priv);
 out_free_opp:
-	of_free_opp_table(cpu_dev);
+	of_cpumask_free_opp_table(policy->cpus);
+out_node_put:
 	of_node_put(np);
 out_put_reg_clk:
 	clk_put(cpu_clk);
@@ -322,7 +358,7 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	of_free_opp_table(priv->cpu_dev);
+	of_cpumask_free_opp_table(policy->related_cpus);
 	clk_put(policy->clk);
 	if (!IS_ERR(priv->cpu_reg))
 		regulator_put(priv->cpu_reg);
-- 
2.4.0

