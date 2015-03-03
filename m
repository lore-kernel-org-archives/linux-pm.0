From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 1/2] cpufreq-dt: support cluster level clock
Date: Tue,  3 Mar 2015 21:03:36 +0800
Message-ID: <1425387817-11382-2-git-send-email-leo.yan@linaro.org>
References: <1425387817-11382-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:40470 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756560AbbCCNDv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 08:03:51 -0500
Received: by pdbfp1 with SMTP id fp1so11118594pdb.7
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2015 05:03:51 -0800 (PST)
In-Reply-To: <1425387817-11382-1-git-send-email-leo.yan@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@linaro.org>

In the previous code, cpufreq-dt driver support single clock shared by
all CPUs or every CPU has dedicated clock; but it cannot support cluster
level clock domain, which is very common implementation for ARM SoCs.

So this patch add the support for cluster level clock; which use the
platform parameter "clk_domain_boundary" to indicate whether the clock
domain is bound to system level, cluster level or CPU level.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/cpufreq/Kconfig      |  5 +++--
 drivers/cpufreq/cpufreq-dt.c | 14 +++++++++++++-
 include/linux/cpufreq-dt.h   | 16 ++++++++++++----
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index a171fef..fe1aee1 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -193,8 +193,9 @@ config CPUFREQ_DT
 	select PM_OPP
 	help
 	  This adds a generic DT based cpufreq driver for frequency management.
-	  It supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
-	  systems which share clock and voltage across all CPUs.
+	  It supports uniprocessor (UP), and symmetric multiprocessor (SMP)
+	  systems which share clock and voltage across all CPUs; and it also
+	  supports cluster level or cpu level's clock domain.
 
 	  If in doubt, say N.
 
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index bab67db..c03532c 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -294,8 +294,20 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = transition_latency;
 
 	pd = cpufreq_get_driver_data();
-	if (!pd || !pd->independent_clocks)
+	if (!pd || pd->clk_domain_boundary == CPUFREQ_DT_CLK_PER_SYS)
 		cpumask_setall(policy->cpus);
+	else if (pd->clk_domain_boundary == CPUFREQ_DT_CLK_PER_CLUSTER)
+		cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
+	else if (pd->clk_domain_boundary != CPUFREQ_DT_CLK_PER_CPU) {
+		/*
+		 * If each CPU has its own clock, don't need bind cpus;
+		 * otherwise will handle wrong parameter.
+		 */
+		dev_err(cpu_dev, "%s: invalid clk boundary value: %d\n",
+			__func__, pd->clk_domain_boundary);
+		ret = -EINVAL;
+		goto out_free_cpufreq_table;
+	}
 
 	of_node_put(np);
 
diff --git a/include/linux/cpufreq-dt.h b/include/linux/cpufreq-dt.h
index 0414009..d6fe6e3 100644
--- a/include/linux/cpufreq-dt.h
+++ b/include/linux/cpufreq-dt.h
@@ -10,13 +10,21 @@
 #ifndef __CPUFREQ_DT_H__
 #define __CPUFREQ_DT_H__
 
+enum cpufreq_dt_clk_type {
+	CPUFREQ_DT_CLK_PER_SYS = 0,
+	CPUFREQ_DT_CLK_PER_CLUSTER,
+	CPUFREQ_DT_CLK_PER_CPU,
+};
+
 struct cpufreq_dt_platform_data {
 	/*
-	 * True when each CPU has its own clock to control its
-	 * frequency, false when all CPUs are controlled by a single
-	 * clock.
+	 * Use this to distinguish three kinds of clock domain:
+	 *
+	 * - all CPUs are controlled by a single clock;
+	 * - all CPUs in cluster share one clock;
+	 * - each CPU has its own clock to control its frequency;
 	 */
-	bool independent_clocks;
+	enum cpufreq_dt_clk_type clk_domain_boundary;
 };
 
 #endif /* __CPUFREQ_DT_H__ */
-- 
1.9.1

