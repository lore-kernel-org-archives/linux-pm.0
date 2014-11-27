From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 4/4] cpufreq-dt: register cooling device from ->ready() callback
Date: Thu, 27 Nov 2014 06:07:52 +0530
Message-ID: <9ea95c03d129b45140948d94cc4ebcf1bcbbac44.1417048449.git.viresh.kumar@linaro.org>
References: <cover.1417048449.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:57284 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbaK0Aig (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 19:38:36 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so3762672pdb.22
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 16:38:35 -0800 (PST)
In-Reply-To: <cover.1417048449.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417048449.git.viresh.kumar@linaro.org>
References: <cover.1417048449.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, l.majewski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>

Currently we are calling of_cpufreq_cooling_register() from ->init() callback.
At this point of time cpufreq driver's policy isn't completely ready to be used
as few of its fields/structure/pointers aren't yet initialized.

Because of_cpufreq_cooling_register() tries to access policy with help of
cpufreq_cpu_get() and then tries to get freq-table as well, these calls fail.

To fix this, register the cooling device after the policy is ready to be used.
And the right callback for it is the newly added ->ready() one.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Eduardo Valentin <edubezval@gmail.com>
Tested-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/cpufreq-dt.c | 51 +++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 7374fc4..e720954 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -186,7 +186,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct cpufreq_dt_platform_data *pd;
 	struct cpufreq_frequency_table *freq_table;
-	struct thermal_cooling_device *cdev;
 	struct device_node *np;
 	struct private_data *priv;
 	struct device *cpu_dev;
@@ -269,20 +268,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		goto out_free_priv;
 	}
 
-	/*
-	 * For now, just loading the cooling device;
-	 * thermal DT code takes care of matching them.
-	 */
-	if (of_find_property(np, "#cooling-cells", NULL)) {
-		cdev = of_cpufreq_cooling_register(np, policy->related_cpus);
-		if (IS_ERR(cdev))
-			dev_err(cpu_dev,
-				"running cpufreq without cooling device: %ld\n",
-				PTR_ERR(cdev));
-		else
-			priv->cdev = cdev;
-	}
-
 	priv->cpu_dev = cpu_dev;
 	priv->cpu_reg = cpu_reg;
 	policy->driver_data = priv;
@@ -292,7 +277,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	if (ret) {
 		dev_err(cpu_dev, "%s: invalid frequency table: %d\n", __func__,
 			ret);
-		goto out_cooling_unregister;
+		goto out_free_cpufreq_table;
 	}
 
 	policy->cpuinfo.transition_latency = transition_latency;
@@ -305,8 +290,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	return 0;
 
-out_cooling_unregister:
-	cpufreq_cooling_unregister(priv->cdev);
+out_free_cpufreq_table:
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 out_free_priv:
 	kfree(priv);
@@ -324,7 +308,8 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct private_data *priv = policy->driver_data;
 
-	cpufreq_cooling_unregister(priv->cdev);
+	if (priv->cdev)
+		cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	clk_put(policy->clk);
 	if (!IS_ERR(priv->cpu_reg))
@@ -334,6 +319,33 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static void cpufreq_ready(struct cpufreq_policy *policy)
+{
+	struct private_data *priv = policy->driver_data;
+	struct device_node *np = of_node_get(priv->cpu_dev->of_node);
+
+	if (WARN_ON(!np))
+		return;
+
+	/*
+	 * For now, just loading the cooling device;
+	 * thermal DT code takes care of matching them.
+	 */
+	if (of_find_property(np, "#cooling-cells", NULL)) {
+		priv->cdev = of_cpufreq_cooling_register(np,
+							 policy->related_cpus);
+		if (IS_ERR(priv->cdev)) {
+			dev_err(priv->cpu_dev,
+				"running cpufreq without cooling device: %ld\n",
+				PTR_ERR(priv->cdev));
+
+			priv->cdev = NULL;
+		}
+	}
+
+	of_node_put(np);
+}
+
 static struct cpufreq_driver dt_cpufreq_driver = {
 	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify = cpufreq_generic_frequency_table_verify,
@@ -341,6 +353,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.get = cpufreq_generic_get,
 	.init = cpufreq_init,
 	.exit = cpufreq_exit,
+	.ready = cpufreq_ready,
 	.name = "cpufreq-dt",
 	.attr = cpufreq_generic_attr,
 };
-- 
2.0.3.693.g996b0fd

