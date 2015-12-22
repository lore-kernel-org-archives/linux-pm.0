From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 14/17] cpufreq: dt: Reuse dev_pm_opp_get_max_transition_latency()
Date: Tue, 22 Dec 2015 15:46:15 +0530
Message-ID: <25c4f290a6d03cee3239ea68273bc229c8f939d3.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34768 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbbLVKRL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2015 05:17:11 -0500
Received: by mail-pf0-f173.google.com with SMTP id u7so57929585pfb.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2015 02:17:11 -0800 (PST)
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

OPP layer has all the information now to calculate transition latency
(clock_latency + voltage_latency). Lets reuse the OPP layer helper
dev_pm_opp_get_max_transition_latency() instead of open coding the same
in cpufreq-dt driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 48 ++++----------------------------------------
 1 file changed, 4 insertions(+), 44 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 8b6e55f62852..01a7354b1ada 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -214,7 +214,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
 	struct dev_pm_opp *suspend_opp;
-	unsigned long min_uV = ~0, max_uV = 0;
 	unsigned int transition_latency;
 	bool opp_v1 = false;
 	const char *name = NULL;
@@ -313,49 +312,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
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
@@ -390,6 +346,10 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		cpufreq_dt_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
 	}
 
+	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
+	if (!transition_latency)
+		transition_latency = CPUFREQ_ETERNAL;
+
 	policy->cpuinfo.transition_latency = transition_latency;
 
 	of_node_put(np);
-- 
2.7.0.rc1.186.g94414c4

