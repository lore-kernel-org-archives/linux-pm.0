From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 3/3] thermal/powerclamp: use PF_IDLE in injection kthread
Date: Wed,  9 Nov 2016 11:05:12 -0800
Message-ID: <1478718312-12847-4-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1478718312-12847-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478718312-12847-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Petr Mladek <pmladek@suse.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

With the introduction of play_idle(), idle injection kthread can
go through the normal idle task processing to get correct accounting
and turn off scheduler tick when possible.

Hrtimer is used to wake up since timeout is most likely to occur
during idle injection.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/thermal/intel_powerclamp.c | 58 ++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 745fcec..c82b41f 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -51,6 +51,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/sched/rt.h>
+#include <linux/cpuidle.h>
 
 #include <asm/nmi.h>
 #include <asm/msr.h>
@@ -93,7 +94,7 @@ struct powerclamp_worker_data {
 	struct kthread_worker *worker;
 	struct kthread_work balancing_work;
 	struct kthread_delayed_work idle_injection_work;
-	struct timer_list wakeup_timer;
+	struct hrtimer timer;
 	unsigned int cpu;
 	unsigned int count;
 	unsigned int guard;
@@ -278,11 +279,6 @@ static u64 pkg_state_counter(void)
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
@@ -429,14 +425,24 @@ static void clamp_balancing_func(struct kthread_work *work)
 					   sleeptime);
 }
 
+static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *hrtimer)
+{
+	set_tsk_need_resched(current);
+	return HRTIMER_NORESTART;
+}
+
 static void clamp_idle_injection_func(struct kthread_work *work)
 {
 	struct powerclamp_worker_data *w_data;
-	unsigned long target_jiffies;
+	unsigned long end_time;
+	unsigned int duration_ms;
 
 	w_data = container_of(work, struct powerclamp_worker_data,
 			      idle_injection_work.work);
 
+	hrtimer_init(&w_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
+	w_data->timer.function = idle_inject_timer_fn;
+
 	/*
 	 * only elected controlling cpu can collect stats and update
 	 * control parameters.
@@ -453,31 +459,17 @@ static void clamp_idle_injection_func(struct kthread_work *work)
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
+	end_time = jiffies + w_data->duration_jiffies;
+	duration_ms = jiffies_to_msecs(w_data->duration_jiffies);
+	hrtimer_start(&w_data->timer, ms_to_ktime(duration_ms),
+		HRTIMER_MODE_REL_PINNED);
+
+	cpuidle_use_deepest_state(true);
+	while (time_after(end_time, jiffies))
+		play_idle();
+	cpuidle_use_deepest_state(false);
+
+	hrtimer_cancel(&w_data->timer);
 
 balance:
 	if (clamping && w_data->clamping && cpu_online(w_data->cpu))
@@ -540,7 +532,6 @@ static void start_power_clamp_worker(unsigned long cpu)
 	w_data->cpu = cpu;
 	w_data->clamping = true;
 	set_bit(cpu, cpu_clamping_mask);
-	setup_timer(&w_data->wakeup_timer, noop_timer, 0);
 	sched_setscheduler(worker->task, SCHED_FIFO, &sparam);
 	kthread_init_work(&w_data->balancing_work, clamp_balancing_func);
 	kthread_init_delayed_work(&w_data->idle_injection_work,
@@ -572,7 +563,6 @@ static void stop_power_clamp_worker(unsigned long cpu)
 	 * a big deal. The balancing work is fast and destroy kthread
 	 * will wait for it.
 	 */
-	del_timer_sync(&w_data->wakeup_timer);
 	clear_bit(w_data->cpu, cpu_clamping_mask);
 	kthread_destroy_worker(w_data->worker);
 
-- 
1.9.1
