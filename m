From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 13/16] cpufreq: dt: Reuse dev_pm_opp_get_max_transition_latency()
Date: Tue,  9 Feb 2016 10:30:45 +0530
Message-ID: <434aede394a1dd52ce381f0e5390d85d1b6995ba.1454992187.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454992186.git.viresh.kumar@linaro.org>
References: <cover.1454992186.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

OPP layer has all the information now to calculate transition latency
(clock_latency + voltage_latency). Lets reuse the OPP layer helper
dev_pm_opp_get_max_transition_latency() instead of open coding the same
in cpufreq-dt driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/cpufreq/cpufreq-dt.c | 48 ++++----------------------------------------
 1 file changed, 4 insertions(+), 44 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index c3fe89461ff4..6f80ce56b4ec 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -222,7 +222,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
 	struct dev_pm_opp *suspend_opp;
-	unsigned long min_uV = ~0, max_uV = 0;
 	unsigned int transition_latency;
 	bool opp_v1 = false;
 	const char *name;
@@ -316,49 +315,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	priv->reg_name = name;
 	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance);
 
-	transition_latency = dev_pm_opp_get_max_clock_latency(cpu_dev);
-	if (!transition_latency)
-		transition_latency = CPUFREQ_ETERNAL;
-
-	if (!IS_ERR(cpu_reg)) {
-		unsigned long opp_freq = 0;
-
-		/*
-		 * Disable any OPPs where the connected regulator isn't able to
-		 * provide the specified voltage and record minimum and maximum
-		 * voltage levels.
-		 */
-		while (1) {
-			struct dev_pm_opp *opp;
-			unsigned long opp_uV, tol_uV;
-
-			rcu_read_lock();
-			opp = dev_pm_opp_find_freq_ceil(cpu_dev, &opp_freq);
-			if (IS_ERR(opp)) {
-				rcu_read_unlock();
-				break;
-			}
-			opp_uV = dev_pm_opp_get_voltage(opp);
-			rcu_read_unlock();
-
-			tol_uV = opp_uV * priv->voltage_tolerance / 100;
-			if (regulator_is_supported_voltage(cpu_reg,
-							   opp_uV - tol_uV,
-							   opp_uV + tol_uV)) {
-				if (opp_uV < min_uV)
-					min_uV = opp_uV;
-				if (opp_uV > max_uV)
-					max_uV = opp_uV;
-			}
-
-			opp_freq++;
-		}
-
-		ret = regulator_set_voltage_time(cpu_reg, min_uV, max_uV);
-		if (ret > 0)
-			transition_latency += ret * 1000;
-	}
-
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
 		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
@@ -393,6 +349,10 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		cpufreq_dt_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
 	}
 
+	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
+	if (!transition_latency)
+		transition_latency = CPUFREQ_ETERNAL;
+
 	policy->cpuinfo.transition_latency = transition_latency;
 
 	of_node_put(np);
-- 
2.7.1.370.gb2aa7f8
