From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 4/4] thermal/intel_powerclamp: stop sched tick in forced idle
Date: Mon, 28 Nov 2016 13:44:52 -0800
Message-ID: <1480369492-23901-5-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1480369492-23901-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21651 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755533AbcK1Vqp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Nov 2016 16:46:45 -0500
In-Reply-To: <1480369492-23901-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jacob Pan <jacob.jun.pan@linux.intel.com>

With the introduction of play_idle(), idle injection kthread can
go through the normal idle task processing to get correct accounting
and turn off scheduler tick when possible.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/thermal/intel_powerclamp.c | 35 +----------------------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 1310283..83e6971 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -92,7 +92,6 @@ struct powerclamp_worker_data {
 	struct kthread_worker *worker;
 	struct kthread_work balancing_work;
 	struct kthread_delayed_work idle_injection_work;
-	struct timer_list wakeup_timer;
 	unsigned int cpu;
 	unsigned int count;
 	unsigned int guard;
@@ -277,11 +276,6 @@ static u64 pkg_state_counter(void)
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
@@ -431,7 +425,6 @@ static void clamp_balancing_func(struct kthread_work *work)
 static void clamp_idle_injection_func(struct kthread_work *work)
 {
 	struct powerclamp_worker_data *w_data;
-	unsigned long target_jiffies;
 
 	w_data = container_of(work, struct powerclamp_worker_data,
 			      idle_injection_work.work);
@@ -452,31 +445,7 @@ static void clamp_idle_injection_func(struct kthread_work *work)
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
@@ -538,7 +507,6 @@ static void start_power_clamp_worker(unsigned long cpu)
 	w_data->cpu = cpu;
 	w_data->clamping = true;
 	set_bit(cpu, cpu_clamping_mask);
-	setup_timer(&w_data->wakeup_timer, noop_timer, 0);
 	sched_setscheduler(worker->task, SCHED_FIFO, &sparam);
 	kthread_init_work(&w_data->balancing_work, clamp_balancing_func);
 	kthread_init_delayed_work(&w_data->idle_injection_work,
@@ -570,7 +538,6 @@ static void stop_power_clamp_worker(unsigned long cpu)
 	 * a big deal. The balancing work is fast and destroy kthread
 	 * will wait for it.
 	 */
-	del_timer_sync(&w_data->wakeup_timer);
 	clear_bit(w_data->cpu, cpu_clamping_mask);
 	kthread_destroy_worker(w_data->worker);
 
-- 
1.9.1

