From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 1/5] cpufreq: powernv: Hot-plug safe the kworker thread
Date: Fri, 22 Jan 2016 12:49:01 +0530
Message-ID: <1453447145-17722-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1453447145-17722-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:39896 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbcAVHUI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2016 02:20:08 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Fri, 22 Jan 2016 17:20:06 +1000
In-Reply-To: <1453447145-17722-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

In the kworker_thread powernv_cpufreq_work_fn(), we can end up
sending an IPI to a cpu going offline. This is a rare corner case
which is fixed using {get/put}_online_cpus(). Along with this fix,
this patch adds changes to do oneshot cpumask_{clear/and} operation.

Suggested-by: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Suggested-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
Changes form v5:
- Fix the kbuild-error:
drivers/cpufreq/powernv-cpufreq.c:428:2: error: implicit declaration of
function 'get_online_cpus' [-Werror=implicit-function-declaration

 drivers/cpufreq/powernv-cpufreq.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 547890f..140c75f 100644
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

