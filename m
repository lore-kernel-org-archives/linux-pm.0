From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: [PATCH v2 2/3] cpufreq: mt8173: migrate to use operating-points-v2 bindings
Date: Sun, 27 Dec 2015 14:21:57 +0800
Message-ID: <1451197318-12418-3-git-send-email-pi-cheng.chen@linaro.org>
References: <1451197318-12418-1-git-send-email-pi-cheng.chen@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35799 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbbL0GWP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Dec 2015 01:22:15 -0500
Received: by mail-pf0-f175.google.com with SMTP id 78so96446202pfw.2
        for <linux-pm@vger.kernel.org>; Sat, 26 Dec 2015 22:22:15 -0800 (PST)
In-Reply-To: <1451197318-12418-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-mediatek@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Modify mt8173-cpufreq driver to get OPP-sharing information and set up
OPP table provided by operating-points-v2 bindings.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
---
 drivers/cpufreq/mt8173-cpufreq.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index fd601b9..1efba34 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -390,7 +390,15 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	/* Both presence and absence of sram regulator are valid cases. */
 	sram_reg = regulator_get_exclusive(cpu_dev, "sram");
 
-	ret = dev_pm_opp_of_add_table(cpu_dev);
+	/* Get OPP-sharing information from "operating-points-v2" bindings */
+	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, &info->cpus);
+	if (ret) {
+		pr_err("failed to get OPP-sharing information for cpu%d\n",
+		       cpu);
+		goto out_free_resources;
+	}
+
+	ret = dev_pm_opp_of_cpumask_add_table(&info->cpus);
 	if (ret) {
 		pr_warn("no OPP table for cpu%d\n", cpu);
 		goto out_free_resources;
@@ -421,13 +429,10 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 	 */
 	info->need_voltage_tracking = !IS_ERR(sram_reg);
 
-	/* CPUs in the same cluster share a clock and power domain. */
-	cpumask_copy(&info->cpus, &cpu_topology[cpu].core_sibling);
-
 	return 0;
 
 out_free_opp_table:
-	dev_pm_opp_of_remove_table(cpu_dev);
+	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
 
 out_free_resources:
 	if (!IS_ERR(proc_reg))
@@ -453,7 +458,7 @@ static void mtk_cpu_dvfs_info_release(struct mtk_cpu_dvfs_info *info)
 	if (!IS_ERR(info->inter_clk))
 		clk_put(info->inter_clk);
 
-	dev_pm_opp_of_remove_table(info->cpu_dev);
+	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
 }
 
 static int mtk_cpufreq_init(struct cpufreq_policy *policy)
-- 
1.9.1

