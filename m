From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 3/3] thermal/powerclamp: stop sched tick in forced idle
Date: Mon, 14 Nov 2016 10:47:58 -0800
Message-ID: <1479149278-12418-4-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1479149278-12418-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62995 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934345AbcKNSt5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Nov 2016 13:49:57 -0500
In-Reply-To: <1479149278-12418-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jacob Pan <jacob.jun.pan@linux.intel.com>

With the introduction of play_idle(), idle injection kthread can
go through the normal idle task processing to get correct accounting
and turn off scheduler tick when possible.

Hrtimer is used to wake up since timeout is most likely to occur
during idle injection.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/thermal/intel_powerclamp.c | 35 +----------------------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 745fcec..68dd963 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -93,7 +93,6 @@ struct powerclamp_worker_data {
 	struct kthread_worker *worker;
 	struct kthread_work balancing_work;
 	struct kthread_delayed_work idle_injection_work;
-	struct timer_list wakeup_timer;
 	unsigned int cpu;
 	unsigned int count;
 	unsigned int guard;
@@ -278,11 +277,6 @@ static u64 pkg_state_counter(void)
 	return count;
 }
 
-static void noop_timer(unsigned long foo)
-{
-	/* empty... just the fact that we get the interrupt wakes us up */
-}
-
 static unsigned int get_compensation(int ratio)
 {
 	unsigned int comp = 0;
@@ -432,7 +426,6 @@ static void clamp_balancing_func(struct kthread_work *work)
 static void clamp_idle_injection_func(struct kthread_work *work)
 {
 	struct powerclamp_worker_data *w_data;
-	unsigned long target_jiffies;
 
 	w_data = container_of(work, struct powerclamp_worker_data,
 			      idle_injection_work.work);
@@ -453,31 +446,7 @@ static void clamp_idle_injection_func(struct kthread_work *work)
 	if (should_skip)
 		goto balance;
 
-	target_jiffies = jiffies + w_data->duration_jiffies;
-	mod_timer(&w_data->wakeup_timer, target_jiffies);
-	if (unlikely(local_softirq_pending()))
-		goto balance;
-	/*
-	 * stop tick sched during idle time, interrupts are still
-	 * allowed. thus jiffies are updated properly.
-	 */
-	preempt_disable();
-	/* mwait until target jiffies is reached */
-	while (time_before(jiffies, target_jiffies)) {
-		unsigned long ecx = 1;
-		unsigned long eax = target_mwait;
-
-		/*
-		 * REVISIT: may call enter_idle() to notify drivers who
-		 * can save power during cpu idle. same for exit_idle()
-		 */
-		local_touch_nmi();
-		stop_critical_timings();
-		mwait_idle_with_hints(eax, ecx);
-		start_critical_timings();
-		atomic_inc(&idle_wakeup_counter);
-	}
-	preempt_enable();
+	play_idle(jiffies_to_msecs(w_data->duration_jiffies));
 
 balance:
 	if (clamping && w_data->clamping && cpu_online(w_data->cpu))
@@ -540,7 +509,6 @@ static void start_power_clamp_worker(unsigned long cpu)
 	w_data->cpu = cpu;
 	w_data->clamping = true;
 	set_bit(cpu, cpu_clamping_mask);
-	setup_timer(&w_data->wakeup_timer, noop_timer, 0);
 	sched_setscheduler(worker->task, SCHED_FIFO, &sparam);
 	kthread_init_work(&w_data->balancing_work, clamp_balancing_func);
 	kthread_init_delayed_work(&w_data->idle_injection_work,
@@ -572,7 +540,6 @@ static void stop_power_clamp_worker(unsigned long cpu)
 	 * a big deal. The balancing work is fast and destroy kthread
 	 * will wait for it.
 	 */
-	del_timer_sync(&w_data->wakeup_timer);
 	clear_bit(w_data->cpu, cpu_clamping_mask);
 	kthread_destroy_worker(w_data->worker);
 
-- 
1.9.1

