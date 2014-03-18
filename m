From: Zhuoyu Zhang <Zhuoyu.Zhang@freescale.com>
Subject: [PATCH v2] cpufreq: powerpc: add cpufreq transition latency for FSL e500mc Socs
Date: Tue, 18 Mar 2014 13:41:25 +0800
Message-ID: <1395121285-15383-1-git-send-email-Zhuoyu.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [216.32.181.184] ([216.32.181.184]:38714 "EHLO
	ch1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750957AbaCRGZr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Mar 2014 02:25:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Yuantian.Tang@freescale.com, Zhuoyu.Zhang@freescale.com

According to the data provided by HW Team, at least 12 internal platform
clock cycles are required to stabilize a DFS clock switch on FSL e500mc Socs.
This patch replaces the CPUFREQ_ETERNAL with appropriate HW clock transition
latency to make DFS governors work normally on Freescale e500mc boards.

Signed-off-by: Zhuoyu Zhang <Zhuoyu.Zhang@freescale.com>
---
 drivers/cpufreq/ppc-corenet-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index 051000f..5977f57 100644
--- a/drivers/cpufreq/ppc-corenet-cpufreq.c
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
+#include <sysdev/fsl_soc.h>
 
 /**
  * struct cpu_data - per CPU data struct
@@ -205,7 +206,8 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	for_each_cpu(i, per_cpu(cpu_mask, cpu))
 		per_cpu(cpu_data, i) = data;
 
-	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+	policy->cpuinfo.transition_latency =
+				(12 * NSEC_PER_SEC) / fsl_get_sys_freq();
 	of_node_put(np);
 
 	return 0;
-- 
1.8.4


