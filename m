From: Zhuoyu Zhang <Zhuoyu.Zhang@freescale.com>
Subject: [PATCH] cpufreq: powerpc: add cpufreq transition latency for FSL e500mc Socs
Date: Mon, 17 Mar 2014 14:24:57 +0800
Message-ID: <1395037497-5737-1-git-send-email-Zhuoyu.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Yuantian.Tang@freescale.com, Zhuoyu.Zhang@freescale.com
List-Id: linux-pm@vger.kernel.org

According to the data provided by HW Team, at least 12 internal platform
clock cycles are required to stabilize a DFS clock switch on FSL e500mc Socs.
This patch replaces the CPUFREQ_ETERNAL with appropriate HW clock transition
latency to make DFS governors work normally on Freescale e500mc boards.

Signed-off-by: Zhuoyu Zhang <Zhuoyu.Zhang@freescale.com>
---
 drivers/cpufreq/ppc-corenet-cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index 051000f..88f08a6 100644
--- a/drivers/cpufreq/ppc-corenet-cpufreq.c
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
+#include <sysdev/fsl_soc.h>
 
 /**
  * struct cpu_data - per CPU data struct
@@ -133,7 +134,7 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	struct device_node *np;
 	int i, count, ret;
-	u32 freq, mask;
+	u32 freq, sysclk, mask;
 	struct clk *clk;
 	struct cpufreq_frequency_table *table;
 	struct cpu_data *data;
@@ -205,7 +206,8 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	for_each_cpu(i, per_cpu(cpu_mask, cpu))
 		per_cpu(cpu_data, i) = data;
 
-	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+	sysclk = fsl_get_sys_freq();
+	policy->cpuinfo.transition_latency = (12 * NSEC_PER_SEC) / sysclk;
 	of_node_put(np);
 
 	return 0;
-- 
1.8.4


