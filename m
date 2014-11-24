From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq-dt: register cooling device after validating cpufreq table
Date: Mon, 24 Nov 2014 16:29:13 +0530
Message-ID: <b4a56cad08c5ef701cf268881697caabe5229994.1416826729.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:43226 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683AbaKXK7U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Nov 2014 05:59:20 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so9474364pdb.22
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2014 02:59:20 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, l.majewski@samsung.com, edubezval@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>

of_cpufreq_cooling_register() can use frequency values from
policy->min/max/cpuinfo.min_freq/cpuinfo.max_freq, which are available only
after calling cpufreq_table_validate_and_show().

The right order of calling should be: cpufreq_table_validate_and_show() followed
by of_cpufreq_cooling_register(). Fix it.

Reported-by: Lukasz Majewski <l.majewski@samsung.com>
Reported-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
For 3.18.
---
 drivers/cpufreq/cpufreq-dt.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 8cba13d..22eb6e5 100644
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
-		cdev = of_cpufreq_cooling_register(np, cpu_present_mask);
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
@@ -292,7 +277,22 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	if (ret) {
 		dev_err(cpu_dev, "%s: invalid frequency table: %d\n", __func__,
 			ret);
-		goto out_cooling_unregister;
+		goto out_free_cpufreq_table;
+	}
+
+	/*
+	 * For now, just loading the cooling device;
+	 * thermal DT code takes care of matching them.
+	 */
+	if (of_find_property(np, "#cooling-cells", NULL)) {
+		priv->cdev = of_cpufreq_cooling_register(np, cpu_present_mask);
+		if (IS_ERR(priv->cdev)) {
+			dev_err(cpu_dev,
+				"running cpufreq without cooling device: %ld\n",
+				PTR_ERR(priv->cdev));
+
+			priv->cdev = NULL;
+		}
 	}
 
 	policy->cpuinfo.transition_latency = transition_latency;
@@ -305,8 +305,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	return 0;
 
-out_cooling_unregister:
-	cpufreq_cooling_unregister(priv->cdev);
+out_free_cpufreq_table:
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 out_free_priv:
 	kfree(priv);
-- 
2.0.3.693.g996b0fd

