From: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Subject: [RFC PATCH] cpufreq: Calling init() of cpufreq_driver  when policy inactive cpu online
Date: Wed, 21 Mar 2018 18:21:43 +0800
Message-ID: <1521627703-7728-1-git-send-email-shunyong.yang@hxt-semitech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shunyong Yang <shunyong.yang@hxt-semitech.com>, Wang Dongsheng <dongsheng.wang@hxt-semitech.com>, Joey Zheng <yu.zheng@hxt-semitech.com>
List-Id: linux-pm@vger.kernel.org

When multiple cpus are related in one cpufreq policy, the first online cpu
will be chosen by default to handle cpufreq operations. In a CPPC case,
let's take two related cpus, cpu0 and cpu1 as an example.

After system start, cpu0 is the first online cpu. Cpufreq policy will be
allocated and init() in cpufreq_driver will be called to initialize cpu0's
perf capabilities and policy parameters. When cpu1 is online, current code
will not call init() in cpufreq_driver as policy has been allocated and
activated by cpu0. So, cpu1's perf capabilities are not initialized
(all 0s).

When cpu0 is offline, policy->cpu will be shifted to cpu1. As cpu1's perf
capabilities are 0s, speed change will not take effect when setting
speed.

This patch adds calling init() of cpufreq_driver when policy inactive cpu
comes to online. Moreover, perf capabilities of all online cpus are
initialized when init() is called.

This patch is tested on CPPC enabled system. I am not sure it's influnce
on other cpufreq_driver. So, this RFC is sent for comments.

Cc: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 45 ++++++++++++++++++++++++++++++------------
 drivers/cpufreq/cpufreq.c      | 18 ++++++++++++++++-
 2 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index a1c3025f9df7..f23a2007dd66 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -125,23 +125,12 @@ static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 				cpu->perf_caps.lowest_perf, cpu_num, ret);
 }
 
-static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
+static int cppc_cpufreq_update_policy(struct cpufreq_policy *policy,
+				      struct cppc_cpudata *cpu)
 {
-	struct cppc_cpudata *cpu;
 	unsigned int cpu_num = policy->cpu;
 	int ret = 0;
 
-	cpu = all_cpu_data[policy->cpu];
-
-	cpu->cpu = cpu_num;
-	ret = cppc_get_perf_caps(policy->cpu, &cpu->perf_caps);
-
-	if (ret) {
-		pr_debug("Err reading CPU%d perf capabilities. ret:%d\n",
-				cpu_num, ret);
-		return ret;
-	}
-
 	cppc_dmi_max_khz = cppc_get_dmi_max_khz();
 
 	/*
@@ -186,6 +175,36 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu;
+	unsigned int cpu_num;
+	int ret = 0;
+
+	for_each_cpu(cpu_num, policy->cpus) {
+		cpu = all_cpu_data[cpu_num];
+
+		cpu->cpu = cpu_num;
+		ret = cppc_get_perf_caps(cpu_num, &cpu->perf_caps);
+		if (ret) {
+			pr_debug("Err reading CPU%d perf capabilities. ret:%d\n",
+				cpu_num, ret);
+			return ret;
+		}
+
+		if (policy->cpu == cpu_num) {
+			ret = cppc_cpufreq_update_policy(policy, cpu);
+			if (ret) {
+				pr_debug("Err update CPU%d perf capabilities. ret:%d\n",
+					cpu_num, ret);
+				return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+
 static struct cpufreq_driver cppc_cpufreq_driver = {
 	.flags = CPUFREQ_CONST_LOOPS,
 	.verify = cppc_verify_policy,
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 239063fb6afc..3317c5e55e7f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1192,8 +1192,24 @@ static int cpufreq_online(unsigned int cpu)
 	policy = per_cpu(cpufreq_cpu_data, cpu);
 	if (policy) {
 		WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus));
-		if (!policy_is_inactive(policy))
+		if (!policy_is_inactive(policy)) {
+			/*
+			 * Parameters of policy inactive CPU should be
+			 * initialized here to make cpufreq work correctly
+			 * when policy active CPU is switched to offline.
+			 * When initialization failed, goto out_destroy_policy
+			 * to destroy.
+			 */
+			if (cpu != policy->cpu) {
+				ret = cpufreq_driver->init(policy);
+				if (ret) {
+					pr_debug("inactive cpu initialization failed\n");
+					goto out_destroy_policy;
+				}
+			}
+
 			return cpufreq_add_policy_cpu(policy, cpu);
+		}
 
 		/* This is the only online CPU for the policy.  Start over. */
 		new_policy = false;
-- 
1.8.3.1
