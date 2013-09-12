From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5/5] cpufreq: use correct values of cpus in __cpufreq_remove_dev_finish()
Date: Thu, 12 Sep 2013 10:55:48 +0530
Message-ID: <8f777cc6b41b2fed4bf71ce2adc36800353d5738.1378963070.git.viresh.kumar@linaro.org>
References: <cover.1378963070.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1378963070.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1378963070.git.viresh.kumar@linaro.org>
References: <cover.1378963070.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, swarren@wwwdotorg.org, srivatsa.bhat@linux.vnet.ibm.com
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This broke after a recent change "cedb70a cpufreq: Split __cpufreq_remove_dev()
into two parts" from Srivatsa..

Consider a scenario where we have two CPUs in a policy (0 & 1) and we are
removing cpu 1. On the call to __cpufreq_remove_dev_prepare() we have cleared 1
from policy->cpus and now on a call to __cpufreq_remove_dev_finish() we read
cpumask_weight of policy->cpus, which will come as 1 and this code will behave
as if we are removing the last cpu from policy :)

Fix it by clearing cpu mask in __cpufreq_remove_dev_finish() instead of
__cpufreq_remove_dev_prepare().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0e11fcb..b556d46 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1175,12 +1175,9 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 			policy->governor->name, CPUFREQ_NAME_LEN);
 #endif
 
-	WARN_ON(lock_policy_rwsem_write(cpu));
+	lock_policy_rwsem_read(cpu);
 	cpus = cpumask_weight(policy->cpus);
-
-	if (cpus > 1)
-		cpumask_clear_cpu(cpu, policy->cpus);
-	unlock_policy_rwsem_write(cpu);
+	unlock_policy_rwsem_read(cpu);
 
 	if (cpu != policy->cpu) {
 		if (!frozen)
@@ -1222,9 +1219,12 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 		return -EINVAL;
 	}
 
-	lock_policy_rwsem_read(cpu);
+	WARN_ON(lock_policy_rwsem_write(cpu));
 	cpus = cpumask_weight(policy->cpus);
-	unlock_policy_rwsem_read(cpu);
+
+	if (cpus > 1)
+		cpumask_clear_cpu(cpu, policy->cpus);
+	unlock_policy_rwsem_write(cpu);
 
 	/* If cpu is last user of policy, free policy */
 	if (cpus == 1) {
-- 
1.7.12.rc2.18.g61b472e
