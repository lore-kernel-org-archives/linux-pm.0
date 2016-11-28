From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 3/4] thermal/intel_powerclamp: Convert to CPU hotplug state
Date: Mon, 28 Nov 2016 13:44:51 -0800
Message-ID: <1480369492-23901-4-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1480369492-23901-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23833 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755524AbcK1Vqp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Nov 2016 16:46:45 -0500
In-Reply-To: <1480369492-23901-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

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
 drivers/thermal/intel_powerclamp.c | 73 +++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 22971da..1310283 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -43,7 +43,6 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
-#include <linux/freezer.h>
 #include <linux/cpu.h>
 #include <linux/thermal.h>
 #include <linux/slab.h>
@@ -530,8 +529,7 @@ static void start_power_clamp_worker(unsigned long cpu)
 	struct powerclamp_worker_data *w_data = per_cpu_ptr(worker_data, cpu);
 	struct kthread_worker *worker;
 
-	worker = kthread_create_worker_on_cpu(cpu, KTW_FREEZABLE,
-					      "kidle_inject/%ld", cpu);
+	worker = kthread_create_worker_on_cpu(cpu, 0, "kidle_inject/%ld", cpu);
 	if (IS_ERR(worker))
 		return;
 
@@ -622,43 +620,35 @@ static void end_power_clamp(void)
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
@@ -785,6 +775,8 @@ static inline void powerclamp_create_debug_files(void)
 	debugfs_remove_recursive(debug_dir);
 }
 
+static enum cpuhp_state hp_state;
+
 static int __init powerclamp_init(void)
 {
 	int retval;
@@ -802,7 +794,14 @@ static int __init powerclamp_init(void)
 
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
@@ -827,7 +826,7 @@ static int __init powerclamp_init(void)
 exit_free_thread:
 	free_percpu(worker_data);
 exit_unregister:
-	unregister_hotcpu_notifier(&powerclamp_cpu_notifier);
+	cpuhp_remove_state_nocalls(hp_state);
 exit_free:
 	kfree(cpu_clamping_mask);
 	return retval;
@@ -836,8 +835,8 @@ static int __init powerclamp_init(void)
 
 static void __exit powerclamp_exit(void)
 {
-	unregister_hotcpu_notifier(&powerclamp_cpu_notifier);
 	end_power_clamp();
+	cpuhp_remove_state_nocalls(hp_state);
 	free_percpu(worker_data);
 	thermal_cooling_device_unregister(cooling_dev);
 	kfree(cpu_clamping_mask);
-- 
1.9.1

