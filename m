From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 3/3] thermal/intel_powerclamp: Convert to CPU hotplug
 state
Date: Fri, 11 Nov 2016 18:34:10 +0100
Message-ID: <20161111173410.GA15785@pathway.suse.cz>
References: <1476707572-32215-1-git-send-email-pmladek@suse.com>
 <1476707572-32215-4-git-send-email-pmladek@suse.com>
 <20161021132118.4239af86@jacob-builder>
 <20161024154807.GQ23809@pathway.suse.cz>
 <20161024095529.2b1855b4@icelake>
 <20161027145348.GV23809@pathway.suse.cz>
 <20161027151726.s2uavcnnbtjvmboq@linutronix.de>
 <20161027132736.2a74c0b6@jacob-builder>
 <20161111093330.GE2324@pathway.suse.cz>
 <20161111100713.GF2324@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934006AbcKKReS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Nov 2016 12:34:18 -0500
Content-Disposition: inline
In-Reply-To: <20161111100713.GF2324@pathway.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Zhang Rui <rui.zhang@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri 2016-11-11 11:07:13, Petr Mladek wrote:
> I am going to do some more tests and will send a fix. It should
> be enough to remove the KTW_FREEZABLE flag from the
> kthread_create_worker_on_cpu() call.

Please, find below an updated patch that fixes the suspend with
kidle_inject kthreads running. The kthread worker must not
get catched by the freezer.

Please, let me known if I should do this as a separate patch
and/or resend the patchset.


>From ffdabb3d61d4ac4fe48bc170a47d2be93cf58e48 Mon Sep 17 00:00:00 2001
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Thu, 1 Sep 2016 11:23:57 +0200
Subject: [PATCH] thermal/intel_powerclamp: Convert to CPU hotplug state

This is a conversation to the new hotplug state machine with
the difference that CPU_DEAD becomes CPU_PREDOWN.

At the same time it makes the handling of the two states symmetrical.
stop_power_clamp_worker() is called unconditionally and the controversial
error message is removed.

The kthread worker must not be freezable. Otherwise it could _not_ be
destroyed in the cpu predown callback. In particular, kthread_stop()
or kthread_flush_worker() would hang. These calls wait for the kthread
to do some job and it would never happen when it was frozen.

Finally, the hotplug state callbacks are removed after the powerclamping
is stopped to avoid a potential race.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[pmladek@suse.com: Fixed freezer and a possible race in powerclamp_exit().]
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 drivers/thermal/intel_powerclamp.c | 73 +++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 2b99c0627043..d9b9e0fb4e48 100644
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
@@ -778,6 +768,8 @@ static inline void powerclamp_create_debug_files(void)
 	debugfs_remove_recursive(debug_dir);
 }
 
+static enum cpuhp_state hp_state;
+
 static int __init powerclamp_init(void)
 {
 	int retval;
@@ -795,7 +787,14 @@ static int __init powerclamp_init(void)
 
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
@@ -820,7 +819,7 @@ static int __init powerclamp_init(void)
 exit_free_thread:
 	free_percpu(worker_data);
 exit_unregister:
-	unregister_hotcpu_notifier(&powerclamp_cpu_notifier);
+	cpuhp_remove_state_nocalls(hp_state);
 exit_free:
 	kfree(cpu_clamping_mask);
 	return retval;
@@ -829,8 +828,8 @@ static int __init powerclamp_init(void)
 
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

