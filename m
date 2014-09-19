From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 1/5] cpufreq: cpu0: disable unsupported OPPs
Date: Fri, 19 Sep 2014 18:16:17 +0200
Message-ID: <1411143381-10516-2-git-send-email-l.stach@pengutronix.de>
References: <1411143381-10516-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48955 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797AbaISQQg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Sep 2014 12:16:36 -0400
In-Reply-To: <1411143381-10516-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, kernel@pengutronix.de

If the regulator connected to the CPU voltage plane doesn't
support an OPP specified voltage with the acceptable tolerance
it's better to just disable the OPP instead of constantly
failing the voltage scaling later on.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/cpufreq/cpufreq-cpu0.c | 60 ++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index 0d2172b07765..83296bd2089e 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -117,6 +117,7 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
 	int ret;
+	unsigned long opp_freq = 0, min_uV = ~0, max_uV = 0, tol;
 
 	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev) {
@@ -155,42 +156,55 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 	/* OPPs might be populated at runtime, don't check for error here */
 	of_init_opp_table(cpu_dev);
 
-	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
-	if (ret) {
-		pr_err("failed to init cpufreq table: %d\n", ret);
-		goto out_put_clk;
-	}
-
 	of_property_read_u32(np, "voltage-tolerance", &voltage_tolerance);
 
 	if (of_property_read_u32(np, "clock-latency", &transition_latency))
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
+			unsigned long opp_uV;
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
+			tol = opp_uV * voltage_tolerance / 100;
+			if (regulator_is_supported_voltage(cpu_reg, opp_uV,
+							   opp_uV + tol)) {
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
+		goto out_put_clk;
+	}
+
 	ret = cpufreq_register_driver(&cpu0_cpufreq_driver);
 	if (ret) {
 		pr_err("failed register driver: %d\n", ret);
-- 
2.1.0

