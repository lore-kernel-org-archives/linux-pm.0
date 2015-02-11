From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 7/7] cpufreq-dt: Use DT to set policy->cpus/related_cpus
Date: Wed, 11 Feb 2015 16:16:30 +0800
Message-ID: <7f6fcfa7cbbcc48148487330011b05005c002ab5.1423642246.git.viresh.kumar@linaro.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33876 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbbBKIRS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Feb 2015 03:17:18 -0500
Received: by pdjg10 with SMTP id g10so2942986pdj.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2015 00:17:17 -0800 (PST)
In-Reply-To: <cover.1423642246.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1423642246.git.viresh.kumar@linaro.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, grant.likely@linaro.org, olof@lixom.net, nm@ti.com, Sudeep.Holla@arm.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, santosh.shilimkar@oracle.com, mike.turquette@linaro.org, kesavan.abhilash@gmail.com, catalin.marinas@arm.com, ta.omasab@gmail.com, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, l.stach@pengutronix.de, broonie@kernel.org, viswanath.puttagunta@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

This updates cpufreq-dt driver to read clock sharing information from new OPP
bindings. And then initialize OPPs for CPUs with help of new bindings.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index bab67db54b7e..6f307897e17a 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -208,8 +208,14 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		goto out_put_reg_clk;
 	}
 
+	pd = cpufreq_get_driver_data();
+	if (!pd || !pd->independent_clocks) {
+		if (of_get_cpus_sharing_opps(cpu_dev, policy->cpus))
+			cpumask_setall(policy->cpus);
+	}
+
 	/* OPPs might be populated at runtime, don't check for error here */
-	of_init_opp_table(cpu_dev);
+	of_cpumask_init_opp_table(policy->cpus);
 
 	/*
 	 * But we need OPP table to function so if it is not there let's
@@ -293,10 +299,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = transition_latency;
 
-	pd = cpufreq_get_driver_data();
-	if (!pd || !pd->independent_clocks)
-		cpumask_setall(policy->cpus);
-
 	of_node_put(np);
 
 	return 0;
@@ -306,7 +308,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 out_free_priv:
 	kfree(priv);
 out_free_opp:
-	of_free_opp_table(cpu_dev);
+	of_cpumask_free_opp_table(policy->cpus);
 	of_node_put(np);
 out_put_reg_clk:
 	clk_put(cpu_clk);
@@ -322,7 +324,7 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	of_free_opp_table(priv->cpu_dev);
+	of_cpumask_free_opp_table(policy->related_cpus);
 	clk_put(policy->clk);
 	if (!IS_ERR(priv->cpu_reg))
 		regulator_put(priv->cpu_reg);
-- 
2.3.0.rc0.44.ga94655d

