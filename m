From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 16/17] cpufreq: dt: drop references to DT node
Date: Tue, 22 Dec 2015 15:46:17 +0530
Message-ID: <23b112584bab2af92d7a3f0b78f8e2b788482b2e.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35281 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbbLVKRS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2015 05:17:18 -0500
Received: by mail-pa0-f54.google.com with SMTP id jx14so87422834pad.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Dec 2015 02:17:17 -0800 (PST)
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Viresh Kumar <viresh.kumar@linaro.org>

We don't need to get reference to DT node now, lets drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 89c89dfab237..c9b7dafd986d 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -33,7 +33,6 @@ struct private_data {
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct thermal_cooling_device *cdev;
-	unsigned int voltage_tolerance; /* in percentage */
 	const char *reg_name;
 };
 
@@ -140,7 +139,6 @@ static int allocate_resources(int cpu, struct device **cdev,
 static int cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *freq_table;
-	struct device_node *np;
 	struct private_data *priv;
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
@@ -157,13 +155,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
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
@@ -174,7 +165,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		if (ret == -ENOENT)
 			opp_v1 = true;
 		else
-			goto out_node_put;
+			goto out_put_reg_clk;
 	}
 
 	/*
@@ -242,7 +233,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	priv->reg_name = name;
-	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance);
 
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
 	if (ret) {
@@ -284,8 +274,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = transition_latency;
 
-	of_node_put(np);
-
 	return 0;
 
 out_free_cpufreq_table:
@@ -296,8 +284,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	dev_pm_opp_of_cpumask_remove_table(policy->cpus);
 	if (opp_v1)
 		dev_pm_opp_put_regulator(cpu_dev);
-out_node_put:
-	of_node_put(np);
 out_put_reg_clk:
 	clk_put(cpu_clk);
 	if (!IS_ERR(cpu_reg))
-- 
2.7.0.rc1.186.g94414c4

