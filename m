From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v8 2/6] cpufreq: powernv: Hot-plug safe the kworker thread
Date: Wed,  3 Feb 2016 01:11:38 +0530
Message-ID: <1454442102-1229-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, bsingharora@gmail.com, mpe@ellerman.id.au, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

In the kworker_thread powernv_cpufreq_work_fn(), we can end up
sending an IPI to a cpu going offline. This is a rare corner case
which is fixed using {get/put}_online_cpus(). Along with this fix,
this patch adds changes to do oneshot cpumask_{clear/and} operation.

Suggested-by: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Suggested-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
No changes from v7.

 drivers/cpufreq/powernv-cpufreq.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 53f980b..a271b0f 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -28,6 +28,7 @@
 #include <linux/of.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
+#include <linux/cpu.h>
 
 #include <asm/cputhreads.h>
 #include <asm/firmware.h>
@@ -423,18 +424,19 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
 {
 	struct chip *chip = container_of(work, struct chip, throttle);
 	unsigned int cpu;
-	cpumask_var_t mask;
+	cpumask_t mask;
 
-	smp_call_function_any(&chip->mask,
+	get_online_cpus();
+	cpumask_and(&mask, &chip->mask, cpu_online_mask);
+	smp_call_function_any(&mask,
 			      powernv_cpufreq_throttle_check, NULL, 0);
 
 	if (!chip->restore)
-		return;
+		goto out;
 
 	chip->restore = false;
-	cpumask_copy(mask, &chip->mask);
-	for_each_cpu_and(cpu, mask, cpu_online_mask) {
-		int index, tcpu;
+	for_each_cpu(cpu, &mask) {
+		int index;
 		struct cpufreq_policy policy;
 
 		cpufreq_get_policy(&policy, cpu);
@@ -442,9 +444,10 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
 					       policy.cur,
 					       CPUFREQ_RELATION_C, &index);
 		powernv_cpufreq_target_index(&policy, index);
-		for_each_cpu(tcpu, policy.cpus)
-			cpumask_clear_cpu(tcpu, mask);
+		cpumask_andnot(&mask, &mask, policy.cpus);
 	}
+out:
+	put_online_cpus();
 }
 
 static char throttle_reason[][30] = {
-- 
1.9.3
