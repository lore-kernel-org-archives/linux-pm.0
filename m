From: Petr Mladek <pmladek@suse.com>
Subject: [PATCH 3/3] thermal/intel_powerclamp: Convert to CPU hotplug state
Date: Mon, 17 Oct 2016 14:32:52 +0200
Message-ID: <1476707572-32215-4-git-send-email-pmladek@suse.com>
References: <1476707572-32215-1-git-send-email-pmladek@suse.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934148AbcJQMdV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Oct 2016 08:33:21 -0400
In-Reply-To: <1476707572-32215-1-git-send-email-pmladek@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This is a conversation to the new hotplug state machine with
the difference that CPU_DEAD becomes CPU_PREDOWN.

At the same time it makes the handling of the two states symmetrical.
stop_power_clamp_worker() is called unconditionally and the controversial
error message is removed.

Finally, the hotplug state callbacks are removed after the powerclamping
is stopped to avoid a potential race.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[pmladek@suse.com: Fixed the possible race in powerclamp_exit()]
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 drivers/thermal/intel_powerclamp.c | 69 +++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index a94f7c849a4e..390e50b97324 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -622,43 +622,35 @@ static void end_power_clamp(void)
 	}
 }
 
-static int powerclamp_cpu_callback(struct notifier_block *nfb,
-				unsigned long action, void *hcpu)
+static int powerclamp_cpu_online(unsigned int cpu)
 {
-	unsigned long cpu = (unsigned long)hcpu;
+	if (clamping == false)
+		return 0;
+	start_power_clamp_worker(cpu);
+	/* prefer BSP as controlling CPU */
+	if (cpu == 0) {
+		control_cpu = 0;
+		smp_mb();
+	}
+	return 0;
+}
 
-	if (false == clamping)
-		goto exit_ok;
+static int powerclamp_cpu_predown(unsigned int cpu)
+{
+	if (clamping == false)
+		return 0;
 
-	switch (action) {
-	case CPU_ONLINE:
-		start_power_clamp_worker(cpu);
-		/* prefer BSP as controlling CPU */
-		if (cpu == 0) {
-			control_cpu = 0;
-			smp_mb();
-		}
-		break;
-	case CPU_DEAD:
-		if (test_bit(cpu, cpu_clamping_mask)) {
-			pr_err("cpu %lu dead but powerclamping thread is not\n",
-				cpu);
-			stop_power_clamp_worker(cpu);
-		}
-		if (cpu == control_cpu) {
-			control_cpu = smp_processor_id();
-			smp_mb();
-		}
-	}
+	stop_power_clamp_worker(cpu);
+	if (cpu != control_cpu)
+		return 0;
 
-exit_ok:
-	return NOTIFY_OK;
+	control_cpu = cpumask_first(cpu_online_mask);
+	if (control_cpu == cpu)
+		control_cpu = cpumask_next(cpu, cpu_online_mask);
+	smp_mb();
+	return 0;
 }
 
-static struct notifier_block powerclamp_cpu_notifier = {
-	.notifier_call = powerclamp_cpu_callback,
-};
-
 static int powerclamp_get_max_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
 {
@@ -788,6 +780,8 @@ static inline void powerclamp_create_debug_files(void)
 	debugfs_remove_recursive(debug_dir);
 }
 
+static enum cpuhp_state hp_state;
+
 static int __init powerclamp_init(void)
 {
 	int retval;
@@ -805,7 +799,14 @@ static int __init powerclamp_init(void)
 
 	/* set default limit, maybe adjusted during runtime based on feedback */
 	window_size = 2;
-	register_hotcpu_notifier(&powerclamp_cpu_notifier);
+	retval = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					   "thermal/intel_powerclamp:online",
+					   powerclamp_cpu_online,
+					   powerclamp_cpu_predown);
+	if (retval < 0)
+		goto exit_free;
+
+	hp_state = retval;
 
 	worker_data = alloc_percpu(struct powerclamp_worker_data);
 	if (!worker_data) {
@@ -830,7 +831,7 @@ static int __init powerclamp_init(void)
 exit_free_thread:
 	free_percpu(worker_data);
 exit_unregister:
-	unregister_hotcpu_notifier(&powerclamp_cpu_notifier);
+	cpuhp_remove_state_nocalls(hp_state);
 exit_free:
 	kfree(cpu_clamping_mask);
 	return retval;
@@ -839,8 +840,8 @@ static int __init powerclamp_init(void)
 
 static void __exit powerclamp_exit(void)
 {
-	unregister_hotcpu_notifier(&powerclamp_cpu_notifier);
 	end_power_clamp();
+	cpuhp_remove_state_nocalls(hp_state);
 	free_percpu(worker_data);
 	thermal_cooling_device_unregister(cooling_dev);
 	kfree(cpu_clamping_mask);
-- 
1.8.5.6

