From: Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/3] thermal/intel_powerclamp: Convert the kthread to kthread worker API
Date: Mon, 17 Oct 2016 14:32:51 +0200
Message-ID: <1476707572-32215-3-git-send-email-pmladek@suse.com>
References: <1476707572-32215-1-git-send-email-pmladek@suse.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933970AbcJQMdT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Oct 2016 08:33:19 -0400
In-Reply-To: <1476707572-32215-1-git-send-email-pmladek@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>

Kthreads are currently implemented as an infinite loop. Each
has its own variant of checks for terminating, freezing,
awakening. In many cases it is unclear to say in which state
it is and sometimes it is done a wrong way.

The plan is to convert kthreads into kthread_worker or workqueues
API. It allows to split the functionality into separate operations.
It helps to make a better structure. Also it defines a clean state
where no locks are taken, IRQs blocked, the kthread might sleep
or even be safely migrated.

The kthread worker API is useful when we want to have a dedicated
single thread for the work. It helps to make sure that it is
available when needed. Also it allows a better control, e.g.
define a scheduling priority.

This patch converts the intel powerclamp kthreads into the kthread
worker because they need to have a good control over the assigned
CPUs.

IMHO, the most natural way is to split one cycle into two works.
First one does some balancing and let the CPU work normal
way for some time. The second work checks what the CPU has done
in the meantime and put it into C-state to reach the required
idle time ratio. The delay between the two works is achieved
by the delayed kthread work.

The two works have to share some data that used to be local
variables of the single kthread function. This is achieved
by the new per-CPU struct kthread_worker_data. It might look
as a complication. On the other hand, the long original kthread
function was not nice either.

The patch tries to avoid extra init and cleanup works. All the
actions might be done outside the thread. They are moved
to the functions that create or destroy the worker. Especially,
I checked that the timers are assigned to the right CPU.

The two works are queuing each other. It makes it a bit tricky to
break it when we want to stop the worker. We use the global and
per-worker "clamping" variables to make sure that the re-queuing
eventually stops. We also cancel the works to make it faster.
Note that the canceling is not reliable because the handling
of the two variables and queuing is not synchronized via a lock.
But it is not a big deal because it is just an optimization.
The job is stopped faster than before in most cases.

Signed-off-by: Petr Mladek <pmladek@suse.com>
CC: Zhang Rui <rui.zhang@intel.com>
CC: Eduardo Valentin <edubezval@gmail.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: linux-pm@vger.kernel.org
Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/thermal/intel_powerclamp.c | 292 +++++++++++++++++++++----------------
 1 file changed, 170 insertions(+), 122 deletions(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 63657d193db5..a94f7c849a4e 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -86,11 +86,27 @@
 				  */
 static bool clamping;
 
+static const struct sched_param sparam = {
+	.sched_priority = MAX_USER_RT_PRIO / 2,
+};
+struct powerclamp_worker_data {
+	struct kthread_worker *worker;
+	struct kthread_work balancing_work;
+	struct kthread_delayed_work idle_injection_work;
+	struct timer_list wakeup_timer;
+	unsigned int cpu;
+	unsigned int count;
+	unsigned int guard;
+	unsigned int window_size_now;
+	unsigned int target_ratio;
+	unsigned int duration_jiffies;
+	bool clamping;
+};
 
-static struct task_struct * __percpu *powerclamp_thread;
+static struct powerclamp_worker_data * __percpu worker_data;
 static struct thermal_cooling_device *cooling_dev;
 static unsigned long *cpu_clamping_mask;  /* bit map for tracking per cpu
-					   * clamping thread
+					   * clamping kthread worker
 					   */
 
 static unsigned int duration;
@@ -368,103 +384,104 @@ static bool powerclamp_adjust_controls(unsigned int target_ratio,
 	return set_target_ratio + guard <= current_ratio;
 }
 
-static int clamp_thread(void *arg)
+static void clamp_balancing_func(struct kthread_work *work)
 {
-	int cpunr = (unsigned long)arg;
-	DEFINE_TIMER(wakeup_timer, noop_timer, 0, 0);
-	static const struct sched_param param = {
-		.sched_priority = MAX_USER_RT_PRIO/2,
-	};
-	unsigned int count = 0;
-	unsigned int target_ratio;
+	struct powerclamp_worker_data *w_data;
+	int sleeptime;
+	unsigned long target_jiffies;
+	unsigned int compensated_ratio;
+	int interval; /* jiffies to sleep for each attempt */
 
-	set_bit(cpunr, cpu_clamping_mask);
-	set_freezable();
-	init_timer_on_stack(&wakeup_timer);
-	sched_setscheduler(current, SCHED_FIFO, &param);
-
-	while (true == clamping && !kthread_should_stop() &&
-		cpu_online(cpunr)) {
-		int sleeptime;
-		unsigned long target_jiffies;
-		unsigned int guard;
-		unsigned int compensated_ratio;
-		int interval; /* jiffies to sleep for each attempt */
-		unsigned int duration_jiffies = msecs_to_jiffies(duration);
-		unsigned int window_size_now;
-
-		try_to_freeze();
-		/*
-		 * make sure user selected ratio does not take effect until
-		 * the next round. adjust target_ratio if user has changed
-		 * target such that we can converge quickly.
-		 */
-		target_ratio = set_target_ratio;
-		guard = 1 + target_ratio/20;
-		window_size_now = window_size;
-		count++;
+	w_data = container_of(work, struct powerclamp_worker_data,
+			      balancing_work);
 
-		/*
-		 * systems may have different ability to enter package level
-		 * c-states, thus we need to compensate the injected idle ratio
-		 * to achieve the actual target reported by the HW.
-		 */
-		compensated_ratio = target_ratio +
-			get_compensation(target_ratio);
-		if (compensated_ratio <= 0)
-			compensated_ratio = 1;
-		interval = duration_jiffies * 100 / compensated_ratio;
-
-		/* align idle time */
-		target_jiffies = roundup(jiffies, interval);
-		sleeptime = target_jiffies - jiffies;
-		if (sleeptime <= 0)
-			sleeptime = 1;
-		schedule_timeout_interruptible(sleeptime);
-		/*
-		 * only elected controlling cpu can collect stats and update
-		 * control parameters.
-		 */
-		if (cpunr == control_cpu && !(count%window_size_now)) {
-			should_skip =
-				powerclamp_adjust_controls(target_ratio,
-							guard, window_size_now);
-			smp_mb();
-		}
+	/*
+	 * make sure user selected ratio does not take effect until
+	 * the next round. adjust target_ratio if user has changed
+	 * target such that we can converge quickly.
+	 */
+	w_data->target_ratio = READ_ONCE(set_target_ratio);
+	w_data->guard = 1 + w_data->target_ratio / 20;
+	w_data->window_size_now = window_size;
+	w_data->duration_jiffies = msecs_to_jiffies(duration);
+	w_data->count++;
+
+	/*
+	 * systems may have different ability to enter package level
+	 * c-states, thus we need to compensate the injected idle ratio
+	 * to achieve the actual target reported by the HW.
+	 */
+	compensated_ratio = w_data->target_ratio +
+		get_compensation(w_data->target_ratio);
+	if (compensated_ratio <= 0)
+		compensated_ratio = 1;
+	interval = w_data->duration_jiffies * 100 / compensated_ratio;
+
+	/* align idle time */
+	target_jiffies = roundup(jiffies, interval);
+	sleeptime = target_jiffies - jiffies;
+	if (sleeptime <= 0)
+		sleeptime = 1;
+
+	if (clamping && w_data->clamping && cpu_online(w_data->cpu))
+		kthread_queue_delayed_work(w_data->worker,
+					   &w_data->idle_injection_work,
+					   sleeptime);
+}
+
+static void clamp_idle_injection_func(struct kthread_work *work)
+{
+	struct powerclamp_worker_data *w_data;
+	unsigned long target_jiffies;
+
+	w_data = container_of(work, struct powerclamp_worker_data,
+			      idle_injection_work.work);
+
+	/*
+	 * only elected controlling cpu can collect stats and update
+	 * control parameters.
+	 */
+	if (w_data->cpu == control_cpu &&
+	    !(w_data->count % w_data->window_size_now)) {
+		should_skip =
+			powerclamp_adjust_controls(w_data->target_ratio,
+						   w_data->guard,
+						   w_data->window_size_now);
+		smp_mb();
+	}
 
-		if (should_skip)
-			continue;
+	if (should_skip)
+		goto balance;
+
+	target_jiffies = jiffies + w_data->duration_jiffies;
+	mod_timer(&w_data->wakeup_timer, target_jiffies);
+	if (unlikely(local_softirq_pending()))
+		goto balance;
+	/*
+	 * stop tick sched during idle time, interrupts are still
+	 * allowed. thus jiffies are updated properly.
+	 */
+	preempt_disable();
+	/* mwait until target jiffies is reached */
+	while (time_before(jiffies, target_jiffies)) {
+		unsigned long ecx = 1;
+		unsigned long eax = target_mwait;
 
-		target_jiffies = jiffies + duration_jiffies;
-		mod_timer(&wakeup_timer, target_jiffies);
-		if (unlikely(local_softirq_pending()))
-			continue;
 		/*
-		 * stop tick sched during idle time, interrupts are still
-		 * allowed. thus jiffies are updated properly.
+		 * REVISIT: may call enter_idle() to notify drivers who
+		 * can save power during cpu idle. same for exit_idle()
 		 */
-		preempt_disable();
-		/* mwait until target jiffies is reached */
-		while (time_before(jiffies, target_jiffies)) {
-			unsigned long ecx = 1;
-			unsigned long eax = target_mwait;
-
-			/*
-			 * REVISIT: may call enter_idle() to notify drivers who
-			 * can save power during cpu idle. same for exit_idle()
-			 */
-			local_touch_nmi();
-			stop_critical_timings();
-			mwait_idle_with_hints(eax, ecx);
-			start_critical_timings();
-			atomic_inc(&idle_wakeup_counter);
-		}
-		preempt_enable();
+		local_touch_nmi();
+		stop_critical_timings();
+		mwait_idle_with_hints(eax, ecx);
+		start_critical_timings();
+		atomic_inc(&idle_wakeup_counter);
 	}
-	del_timer_sync(&wakeup_timer);
-	clear_bit(cpunr, cpu_clamping_mask);
+	preempt_enable();
 
-	return 0;
+balance:
+	if (clamping && w_data->clamping && cpu_online(w_data->cpu))
+		kthread_queue_work(w_data->worker, &w_data->balancing_work);
 }
 
 /*
@@ -508,22 +525,58 @@ static void poll_pkg_cstate(struct work_struct *dummy)
 		schedule_delayed_work(&poll_pkg_cstate_work, HZ);
 }
 
-static void start_power_clamp_thread(unsigned long cpu)
+static void start_power_clamp_worker(unsigned long cpu)
 {
-	struct task_struct **p = per_cpu_ptr(powerclamp_thread, cpu);
-	struct task_struct *thread;
-
-	thread = kthread_create_on_node(clamp_thread,
-					(void *) cpu,
-					cpu_to_node(cpu),
-					"kidle_inject/%ld", cpu);
-	if (IS_ERR(thread))
+	struct powerclamp_worker_data *w_data = per_cpu_ptr(worker_data, cpu);
+	struct kthread_worker *worker;
+
+	worker = kthread_create_worker_on_cpu(cpu, KTW_FREEZABLE,
+					      "kidle_inject/%ld", cpu);
+	if (IS_ERR(worker))
 		return;
 
-	/* bind to cpu here */
-	kthread_bind(thread, cpu);
-	wake_up_process(thread);
-	*p = thread;
+	w_data->worker = worker;
+	w_data->count = 0;
+	w_data->cpu = cpu;
+	w_data->clamping = true;
+	set_bit(cpu, cpu_clamping_mask);
+	setup_timer(&w_data->wakeup_timer, noop_timer, 0);
+	sched_setscheduler(worker->task, SCHED_FIFO, &sparam);
+	kthread_init_work(&w_data->balancing_work, clamp_balancing_func);
+	kthread_init_delayed_work(&w_data->idle_injection_work,
+				  clamp_idle_injection_func);
+	kthread_queue_work(w_data->worker, &w_data->balancing_work);
+}
+
+static void stop_power_clamp_worker(unsigned long cpu)
+{
+	struct powerclamp_worker_data *w_data = per_cpu_ptr(worker_data, cpu);
+
+	if (!w_data->worker)
+		return;
+
+	w_data->clamping = false;
+	/*
+	 * Make sure that all works that get queued after this point see
+	 * the clamping disabled. The counter part is not needed because
+	 * there is an implicit memory barrier when the queued work
+	 * is proceed.
+	 */
+	smp_wmb();
+	kthread_cancel_work_sync(&w_data->balancing_work);
+	kthread_cancel_delayed_work_sync(&w_data->idle_injection_work);
+	/*
+	 * The balancing work still might be queued here because
+	 * the handling of the "clapming" variable, cancel, and queue
+	 * operations are not synchronized via a lock. But it is not
+	 * a big deal. The balancing work is fast and destroy kthread
+	 * will wait for it.
+	 */
+	del_timer_sync(&w_data->wakeup_timer);
+	clear_bit(w_data->cpu, cpu_clamping_mask);
+	kthread_destroy_worker(w_data->worker);
+
+	w_data->worker = NULL;
 }
 
 static int start_power_clamp(void)
@@ -542,9 +595,9 @@ static int start_power_clamp(void)
 	clamping = true;
 	schedule_delayed_work(&poll_pkg_cstate_work, 0);
 
-	/* start one thread per online cpu */
+	/* start one kthread worker per online cpu */
 	for_each_online_cpu(cpu) {
-		start_power_clamp_thread(cpu);
+		start_power_clamp_worker(cpu);
 	}
 	put_online_cpus();
 
@@ -554,20 +607,17 @@ static int start_power_clamp(void)
 static void end_power_clamp(void)
 {
 	int i;
-	struct task_struct *thread;
 
-	clamping = false;
 	/*
-	 * make clamping visible to other cpus and give per cpu clamping threads
-	 * sometime to exit, or gets killed later.
+	 * Block requeuing in all the kthread workers. They will flush and
+	 * stop faster.
 	 */
-	smp_mb();
-	msleep(20);
+	clamping = false;
 	if (bitmap_weight(cpu_clamping_mask, num_possible_cpus())) {
 		for_each_set_bit(i, cpu_clamping_mask, num_possible_cpus()) {
-			pr_debug("clamping thread for cpu %d alive, kill\n", i);
-			thread = *per_cpu_ptr(powerclamp_thread, i);
-			kthread_stop(thread);
+			pr_debug("clamping worker for cpu %d alive, destroy\n",
+				 i);
+			stop_power_clamp_worker(i);
 		}
 	}
 }
@@ -576,15 +626,13 @@ static int powerclamp_cpu_callback(struct notifier_block *nfb,
 				unsigned long action, void *hcpu)
 {
 	unsigned long cpu = (unsigned long)hcpu;
-	struct task_struct **percpu_thread =
-		per_cpu_ptr(powerclamp_thread, cpu);
 
 	if (false == clamping)
 		goto exit_ok;
 
 	switch (action) {
 	case CPU_ONLINE:
-		start_power_clamp_thread(cpu);
+		start_power_clamp_worker(cpu);
 		/* prefer BSP as controlling CPU */
 		if (cpu == 0) {
 			control_cpu = 0;
@@ -595,7 +643,7 @@ static int powerclamp_cpu_callback(struct notifier_block *nfb,
 		if (test_bit(cpu, cpu_clamping_mask)) {
 			pr_err("cpu %lu dead but powerclamping thread is not\n",
 				cpu);
-			kthread_stop(*percpu_thread);
+			stop_power_clamp_worker(cpu);
 		}
 		if (cpu == control_cpu) {
 			control_cpu = smp_processor_id();
@@ -759,8 +807,8 @@ static int __init powerclamp_init(void)
 	window_size = 2;
 	register_hotcpu_notifier(&powerclamp_cpu_notifier);
 
-	powerclamp_thread = alloc_percpu(struct task_struct *);
-	if (!powerclamp_thread) {
+	worker_data = alloc_percpu(struct powerclamp_worker_data);
+	if (!worker_data) {
 		retval = -ENOMEM;
 		goto exit_unregister;
 	}
@@ -780,7 +828,7 @@ static int __init powerclamp_init(void)
 	return 0;
 
 exit_free_thread:
-	free_percpu(powerclamp_thread);
+	free_percpu(worker_data);
 exit_unregister:
 	unregister_hotcpu_notifier(&powerclamp_cpu_notifier);
 exit_free:
@@ -793,7 +841,7 @@ static void __exit powerclamp_exit(void)
 {
 	unregister_hotcpu_notifier(&powerclamp_cpu_notifier);
 	end_power_clamp();
-	free_percpu(powerclamp_thread);
+	free_percpu(worker_data);
 	thermal_cooling_device_unregister(cooling_dev);
 	kfree(cpu_clamping_mask);
 
-- 
1.8.5.6

