From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 3/3] thermal/intel_powerclamp: Convert to CPU hotplug
 state
Date: Fri, 11 Nov 2016 10:33:30 +0100
Message-ID: <20161111093330.GE2324@pathway.suse.cz>
References: <1476707572-32215-1-git-send-email-pmladek@suse.com>
 <1476707572-32215-4-git-send-email-pmladek@suse.com>
 <20161021132118.4239af86@jacob-builder>
 <20161024154807.GQ23809@pathway.suse.cz>
 <20161024095529.2b1855b4@icelake>
 <20161027145348.GV23809@pathway.suse.cz>
 <20161027151726.s2uavcnnbtjvmboq@linutronix.de>
 <20161027132736.2a74c0b6@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754136AbcKKJdd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Nov 2016 04:33:33 -0500
Content-Disposition: inline
In-Reply-To: <20161027132736.2a74c0b6@jacob-builder>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Zhang Rui <rui.zhang@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu 2016-10-27 13:27:36, Jacob Pan wrote:
> On Thu, 27 Oct 2016 17:17:26 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > On 2016-10-27 16:53:48 [+0200], Petr Mladek wrote:
> > > 
> > > In each case, I wonder if the problem is caused by the conversion
> > > to the kthread worker or by the CPU hotplug state conversion.  
> > 
> > drop the hotplug patch and you will see.
> > 
> Petr,
> 
> I dropped hp patch no long see the hang during suspend to s3. However,
> the problem seems to be this line,
> 
> diff --git a/drivers/thermal/intel_powerclamp.c
> b/drivers/thermal/intel_powerclamp.c index 390e50b..b61da57 100644
> --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -574,7 +574,7 @@ static void stop_power_clamp_worker(unsigned long
> cpu) */
>         del_timer_sync(&w_data->wakeup_timer);
>         clear_bit(w_data->cpu, cpu_clamping_mask);
> -       kthread_destroy_worker(w_data->worker);
> +//     kthread_destroy_worker(w_data->worker);
>  
>         w_data->worker = NULL;
>  }
> 
> If I do the above, everything works with S3 and CPU HP patch.
> 
> Inside kthread_destroy_worker()
> 	kthread_flush_worker(worker);
> never completes then blocks s3 entry!

The kthread_flush_worker() was not needed because the queue was empty
in this case (runtime checked). But it still hangs on

  kthread_destroy_worker()
    kthread_stop(task);


Then I tried to revert the conversion to the kthread worker
API (2nd patch from this patchset), see below. And it still
hangs during the suspend inside

	powerclamp_cpu_predown()
	  kthread_stop(*percpu_thread);


Note that both kthread_flush_worker() and kthread_stop()
waits until the kthread gets scheduled and do some job.
Also note that the kthread is bound to the given CPU.

My guess is that the kthread cannot be scheduled at this stage.
I wonder if the CPU is already partially down or that tasks
are freezed so that "normal" tasks are not scheduled at
this point. I am still trying to understand the code
related to suspend, cpu hotplug, and scheduler.


Just for record. Below is the conversion to the new
CPU hotplug state that can be applied on top
of the 1st patch from this patchset ("thermal/intel_powerclamp:
 Remove duplicated code that starts the kthread").
It allows to rule out the kthread worker API for the moment.


>From 928b066ea07532d82c802912e17b44bd01ec5665 Mon Sep 17 00:00:00 2001
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Thu, 1 Sep 2016 11:23:57 +0200
Subject: [PATCH] thermal/intel_powerclamp: Convert to CPU hotplug state

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
 drivers/thermal/intel_powerclamp.c | 70 ++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 0244805b7b86..4ebfea3f0f1e 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -572,45 +572,38 @@ static void end_power_clamp(void)
 	}
 }
 
-static int powerclamp_cpu_callback(struct notifier_block *nfb,
-				unsigned long action, void *hcpu)
+static int powerclamp_cpu_online(unsigned int cpu)
+{
+	if (clamping == false)
+		return 0;
+	start_power_clamp_thread(cpu);
+	/* prefer BSP as controlling CPU */
+	if (cpu == 0) {
+		control_cpu = 0;
+		smp_mb();
+	}
+	return 0;
+}
+
+static int powerclamp_cpu_predown(unsigned int cpu)
 {
-	unsigned long cpu = (unsigned long)hcpu;
 	struct task_struct **percpu_thread =
 		per_cpu_ptr(powerclamp_thread, cpu);
 
-	if (false == clamping)
-		goto exit_ok;
+	if (clamping == false)
+		return 0;
 
-	switch (action) {
-	case CPU_ONLINE:
-		start_power_clamp_thread(cpu);
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
-			kthread_stop(*percpu_thread);
-		}
-		if (cpu == control_cpu) {
-			control_cpu = smp_processor_id();
-			smp_mb();
-		}
-	}
+	kthread_stop(*percpu_thread);
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
@@ -730,6 +723,8 @@ static inline void powerclamp_create_debug_files(void)
 	debugfs_remove_recursive(debug_dir);
 }
 
+static enum cpuhp_state hp_state;
+
 static int __init powerclamp_init(void)
 {
 	int retval;
@@ -747,7 +742,14 @@ static int __init powerclamp_init(void)
 
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
 
 	powerclamp_thread = alloc_percpu(struct task_struct *);
 	if (!powerclamp_thread) {
@@ -772,7 +774,7 @@ static int __init powerclamp_init(void)
 exit_free_thread:
 	free_percpu(powerclamp_thread);
 exit_unregister:
-	unregister_hotcpu_notifier(&powerclamp_cpu_notifier);
+	cpuhp_remove_state_nocalls(hp_state);
 exit_free:
 	kfree(cpu_clamping_mask);
 	return retval;
@@ -781,8 +783,8 @@ static int __init powerclamp_init(void)
 
 static void __exit powerclamp_exit(void)
 {
-	unregister_hotcpu_notifier(&powerclamp_cpu_notifier);
 	end_power_clamp();
+	cpuhp_remove_state_nocalls(hp_state);
 	free_percpu(powerclamp_thread);
 	thermal_cooling_device_unregister(cooling_dev);
 	kfree(cpu_clamping_mask);
-- 
1.8.5.6

