From: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Subject: [PATCH v3] cpufreq: cppc_cpufreq: Initialize shared cpu's perf capabilities
Date: Fri, 6 Apr 2018 10:43:49 +0800
Message-ID: <1522982629-7557-1-git-send-email-shunyong.yang@hxt-semitech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shunyong Yang <shunyong.yang@hxt-semitech.com>, Joey Zheng <yu.zheng@hxt-semitech.com>
List-Id: linux-pm@vger.kernel.org

When multiple cpus are related in one cpufreq policy, the first online
cpu will be chosen by default to handle cpufreq operations. Let's take
cpu0 and cpu1 as an example.

When cpu0 is offline, policy->cpu will be shifted to cpu1. Cpu1's perf
capabilities should be initialized. Otherwise, perf capabilities are 0s
and speed change can not take effect.

This patch copies perf capabilities of the first online cpu to other
shared cpus when policy shared type is CPUFREQ_SHARED_TYPE_ANY.

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---

Changes in v3:
  -Remove unnecessary wrap per Kumar's comments.

Changes in v2:
  -Add unlikely in cpu comparison per Kumar's comments.
  -Fix coding style per Kumar's comments.

Changes in v1:
  -Drop RFC tag,
     The original RFC link,
     https://patchwork.kernel.org/patch/10299055/.

     This patch solves same issue as RFC above.

     Patch name is changed as code is too much different with RFC above.

  -Remove extra init() per Viresh Kumar's comments and only handle
   CPPC CPUFREQ_SHARED_TYPE_ANY case.

---
 drivers/cpufreq/cppc_cpufreq.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 8300a9fcb80c..8b432d6e846d 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -167,9 +167,19 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		NSEC_PER_USEC;
 	policy->shared_type = cpu->shared_type;
 
-	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
+	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
+		int i;
+
 		cpumask_copy(policy->cpus, cpu->shared_cpu_map);
-	else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
+
+		for_each_cpu(i, policy->cpus) {
+			if (unlikely(i == policy->cpu))
+				continue;
+
+			memcpy(&all_cpu_data[i]->perf_caps, &cpu->perf_caps,
+			       sizeof(cpu->perf_caps));
+		}
+	} else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
 		/* Support only SW_ANY for now. */
 		pr_debug("Unsupported CPU co-ord type\n");
 		return -EFAULT;
-- 
1.8.3.1
