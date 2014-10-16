From: Lucas Stach <l.stach@pengutronix.de>
Subject: [RESEND 2] cpufreq: dt: disable unsupported OPPs
Date: Thu, 16 Oct 2014 12:08:20 +0200
Message-ID: <1413454100-23009-1-git-send-email-l.stach@pengutronix.de>
References: <48734362.lRa73hezrZ@vostro.rjw.lan>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59799 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaJPKIX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Oct 2014 06:08:23 -0400
In-Reply-To: <48734362.lRa73hezrZ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

If the regulator connected to the CPU voltage plane doesn't
support an OPP specified voltage with the acceptable tolerance
it's better to just disable the OPP instead of constantly
failing the voltage scaling later on.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
resend 2:
- no functional change, rebase against latest Linus tree
- added Viresh's ack
resend:
- no functional change, split out from the imx5 cpufreq series
v2:
- rebase on top of pm/linux-next
---
 drivers/cpufreq/cpufreq-dt.c | 66 +++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 6bbb8b913446..4485c8eccdc2 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -185,6 +185,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
+	unsigned long min_uV = ~0, max_uV = 0;
 	unsigned int transition_latency;
 	int ret;
 
@@ -204,16 +205,10 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	/* OPPs might be populated at runtime, don't check for error here */
 	of_init_opp_table(cpu_dev);
 
-	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
-	if (ret) {
-		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
-		goto out_put_node;
-	}
-
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		ret = -ENOMEM;
-		goto out_free_table;
+		goto out_put_node;
 	}
 
 	of_property_read_u32(np, "voltage-tolerance", &priv->voltage_tolerance);
@@ -222,30 +217,49 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		transition_latency = CPUFREQ_ETERNAL;
 
 	if (!IS_ERR(cpu_reg)) {
-		struct dev_pm_opp *opp;
-		unsigned long min_uV, max_uV;
-		int i;
-
 		/*
-		 * OPP is maintained in order of increasing frequency, and
-		 * freq_table initialised from OPP is therefore sorted in the
-		 * same order.
+		 * Disable any OPPs where the connected regulator isn't able to
+		 * provide the specified voltage and record minimum and maximum
+		 * voltage levels.
 		 */
-		for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++)
-			;
-		rcu_read_lock();
-		opp = dev_pm_opp_find_freq_exact(cpu_dev,
-				freq_table[0].frequency * 1000, true);
-		min_uV = dev_pm_opp_get_voltage(opp);
-		opp = dev_pm_opp_find_freq_exact(cpu_dev,
-				freq_table[i-1].frequency * 1000, true);
-		max_uV = dev_pm_opp_get_voltage(opp);
-		rcu_read_unlock();
+		while (1) {
+			struct dev_pm_opp *opp;
+			unsigned long opp_freq = 0, opp_uV, tol_uV;
+
+			rcu_read_lock();
+			opp = dev_pm_opp_find_freq_ceil(cpu_dev, &opp_freq);
+			if (IS_ERR(opp)) {
+				rcu_read_unlock();
+				break;
+			}
+			opp_uV = dev_pm_opp_get_voltage(opp);
+			rcu_read_unlock();
+
+			tol_uV = opp_uV * priv->voltage_tolerance / 100;
+			if (regulator_is_supported_voltage(cpu_reg, opp_uV,
+							   opp_uV + tol_uV)) {
+				if (opp_uV < min_uV)
+					min_uV = opp_uV;
+				if (opp_uV > max_uV)
+					max_uV = opp_uV;
+			} else {
+				dev_pm_opp_disable(cpu_dev, opp_freq);
+			}
+
+			opp_freq++;
+		}
+
 		ret = regulator_set_voltage_time(cpu_reg, min_uV, max_uV);
 		if (ret > 0)
 			transition_latency += ret * 1000;
 	}
 
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
+	if (ret) {
+		pr_err("failed to init cpufreq table: %d\n", ret);
+		goto out_free_priv;
+	}
+
 	/*
 	 * For now, just loading the cooling device;
 	 * thermal DT code takes care of matching them.
@@ -275,9 +289,9 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 out_cooling_unregister:
 	cpufreq_cooling_unregister(priv->cdev);
-	kfree(priv);
-out_free_table:
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
+out_free_priv:
+	kfree(priv);
 out_put_node:
 	of_node_put(np);
 out_put_reg_clk:
-- 
2.1.1

