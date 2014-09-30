From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: arm_big_little: set 'physical_cluster' for each CPU
Date: Tue, 30 Sep 2014 09:55:20 +0530
Message-ID: <f2259e8d3cb418bce091b484e09718e9d7204b57.1412051036.git.viresh.kumar@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, tixy@linaro.org, broonie@linaro.org, viresh kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: viresh kumar <viresh.kumar@linaro.org>

Upstream commit ID: 8f3ba3d3257be80636ed15cc221d6a2efb6a6e82

We have a per-CPU variable for managing which cluster a CPU belongs to.
Currently, physical_cluster is set for policy->cpu only which leads to
the following on some SoC's:

 - There are two clusters:
   - Cluster 0 has four ARM Cortex A7 CPUs (slower ones): 0,1,2,3
   - Cluster 1 has four ARM Cortex A15 CPUs (faster ones): 4,5,6,7
 - CPUs are booted in order 0,1..7 and so initially policy->cpu for A7 cluster
   would be 0 and for A15 cluster would be 4.
 - Now CPU4 (i.e. A15_0) is hotplugged out and so policy->cpu for A15 cluster
   becomes 5 (i.e. A15_1).
 - But physical cluster is only set for CPU0 and CPU4 in ARM big LITTLE driver
   and isn't updated.
 - Now freq change request comes for A15 cluster and we would try to update freq
   of physical_cluster of CPU5, i.e. A15_1. And it is currently set to zero
   (default value of uninitialized global variables).
 - And so we actually try to change freq of A7 cluster instead of A15.
 - This also results in kernel crash as sometimes we might request freq above
   A7's limit and CPU may behave badly..

Fix this by initializing physical_cluster for all CPUs of a policy.

Based on previous work by Xin Wang.

Cc: <stable@vger.kernel.org> # 3.13
Cc: <stable@vger.kernel.org> # 3.14
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 5519933..ee409f0 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -446,9 +446,12 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	if (cur_cluster < MAX_CLUSTERS) {
+		int cpu;
+
 		cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
 
-		per_cpu(physical_cluster, policy->cpu) = cur_cluster;
+		for_each_cpu(cpu, policy->cpus)
+			per_cpu(physical_cluster, cpu) = cur_cluster;
 	} else {
 		/* Assumption: during init, we are always running on A15 */
 		per_cpu(physical_cluster, policy->cpu) = A15_CLUSTER;
-- 
2.0.3.693.g996b0fd
