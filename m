From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: exynos: simplify .init() for setting policy->cpus
Date: Thu, 31 Jan 2013 07:56:04 +0530
Message-ID: <f216e85846c302756d55cb6753863a66697f79a6.1359599087.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:58308 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab3AaC0P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jan 2013 21:26:15 -0500
Received: by mail-pb0-f44.google.com with SMTP id wz12so1336427pbc.17
        for <linux-pm@vger.kernel.org>; Wed, 30 Jan 2013 18:26:15 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, jc.lee@samsung.com
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, kgene.kim@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>

With the recent changes in cpufreq core, we just need to set mask of all
possible cpus into policy->cpus. Rest would be done by core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/exynos-cpufreq.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 7012ea8..81eb84a 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -227,19 +227,7 @@ static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	/* set the transition latency value */
 	policy->cpuinfo.transition_latency = 100000;
 
-	/*
-	 * EXYNOS4 multi-core processors has 2 cores
-	 * that the frequency cannot be set independently.
-	 * Each cpu is bound to the same speed.
-	 * So the affected cpu is all of the cpus.
-	 */
-	if (num_online_cpus() == 1) {
-		cpumask_copy(policy->related_cpus, cpu_possible_mask);
-		cpumask_copy(policy->cpus, cpu_online_mask);
-	} else {
-		policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
-		cpumask_setall(policy->cpus);
-	}
+	cpumask_setall(policy->cpus);
 
 	return cpufreq_frequency_table_cpuinfo(policy, exynos_info->freq_table);
 }
-- 
1.7.12.rc2.18.g61b472e

