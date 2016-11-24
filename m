From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 1/3] idle: add support for tasks that inject idle
Date: Thu, 24 Nov 2016 10:50:16 +0100
Message-ID: <20161124095016.GD3092@twins.programming.kicks-ass.net>
References: <1479931990-11732-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1479931990-11732-2-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:49550 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935913AbcKXJu2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2016 04:50:28 -0500
Content-Disposition: inline
In-Reply-To: <1479931990-11732-2-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On Wed, Nov 23, 2016 at 12:13:08PM -0800, Jacob Pan wrote:
> @@ -280,6 +272,58 @@ bool cpu_in_idle(unsigned long pc)
>  		pc < (unsigned long)__cpuidle_text_end;
>  }
>  
> +static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *hrtimer)
> +{
> +	set_tsk_need_resched(current);
> +	return HRTIMER_NORESTART;
> +}
> +
> +void play_idle(unsigned long duration_ms)
> +{
> +	struct hrtimer timer;
> +	unsigned long end_time;
> +
> +	/*
> +	 * Only FIFO tasks can disable the tick since they don't need the forced
> +	 * preemption.
> +	 */
> +	WARN_ON_ONCE(current->policy != SCHED_FIFO);
> +	WARN_ON_ONCE(current->nr_cpus_allowed != 1);
> +	WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
> +	WARN_ON_ONCE(!(current->flags & PF_NO_SETAFFINITY));
> +
> +	rcu_sleep_check();
> +	preempt_disable();
> +	current->flags |= PF_IDLE;
> +	cpuidle_use_deepest_state(true);
> +
> +	/*
> +	 * If duration is 0, we will return after a natural wake event occurs. If
> +	 * duration is none zero, we will go back to sleep if we were woken up earlier.
> +	 * We also set up a timer to make sure we don't oversleep in deep idle.
> +	 */
> +	if (!duration_ms)
> +		do_idle();

OK, so that doesn't make any sense, you should not be calling this
without a timeout.

> +	else {
> +		hrtimer_init_on_stack(&timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +		timer.function = idle_inject_timer_fn;
> +		hrtimer_start(&timer, ms_to_ktime(duration_ms),
> +			HRTIMER_MODE_REL_PINNED);
> +		end_time = jiffies + msecs_to_jiffies(duration_ms);
> +
> +		while (time_after(end_time, jiffies))
> +			do_idle();
> +	}
> +	hrtimer_cancel(&timer);
> +
> +	cpuidle_use_deepest_state(false);
> +	current->flags &= ~PF_IDLE;
> +
> +	preempt_fold_need_resched();
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL_GPL(play_idle);


How about something like so... (since I had to edit, I fixed up most
things Ingo complained about as well).

Note that it doesn't build because of a distinct lack of
cpuidle_use_deepest_state() in my kernel tree.

---
Subject: idle: add support for tasks that inject idle
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 23 Nov 2016 12:13:08 -0800

Idle injection drivers such as Intel powerclamp and ACPI PAD drivers use
realtime tasks to take control of CPU then inject idle. There are two
issues with this approach:

 1. Low efficiency: injected idle task is treated as busy so sched ticks
    do not stop during injected idle period, the result of these
    unwanted wakeups can be ~20% loss in power savings.

 2. Idle accounting: injected idle time is presented to user as busy.

This patch addresses the issues by introducing a new PF_IDLE flag which
allows any given task to be treated as idle task while the flag is set.
Therefore, idle injection tasks can run through the normal flow of NOHZ
idle enter/exit to get the correct accounting as well as tick stop when
possible.

The implication is that idle task is then no longer limited to PID == 0.

Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/cpu.h   |    2 
 include/linux/sched.h |    3 
 kernel/fork.c         |    2 
 kernel/sched/core.c   |    1 
 kernel/sched/idle.c   |  165 +++++++++++++++++++++++++++++++-------------------
 5 files changed, 109 insertions(+), 64 deletions(-)

--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -245,6 +245,8 @@ void arch_cpu_idle_dead(void);
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
+void play_idle(unsigned long duration_ms);
+
 #ifdef CONFIG_HOTPLUG_CPU
 bool cpu_wait_death(unsigned int cpu, int seconds);
 bool cpu_report_death(void);
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2284,6 +2284,7 @@ extern void thread_group_cputime_adjuste
 /*
  * Per process flags
  */
+#define PF_IDLE		0x00000002	/* I am an IDLE thread */
 #define PF_EXITING	0x00000004	/* getting shut down */
 #define PF_EXITPIDONE	0x00000008	/* pi exit done on shut down */
 #define PF_VCPU		0x00000010	/* I'm a virtual CPU */
@@ -2645,7 +2646,7 @@ extern struct task_struct *idle_task(int
  */
 static inline bool is_idle_task(const struct task_struct *p)
 {
-	return p->pid == 0;
+	return !!(p->flags & PF_IDLE);
 }
 extern struct task_struct *curr_task(int cpu);
 extern void ia64_set_curr_task(int cpu, struct task_struct *p);
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1542,7 +1542,7 @@ static __latent_entropy struct task_stru
 		goto bad_fork_cleanup_count;
 
 	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
-	p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER);
+	p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE);
 	p->flags |= PF_FORKNOEXEC;
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5298,6 +5298,7 @@ void init_idle(struct task_struct *idle,
 	__sched_fork(0, idle);
 	idle->state = TASK_RUNNING;
 	idle->se.exec_start = sched_clock();
+	idle->flags |= PF_IDLE;
 
 	kasan_unpoison_task_stack(idle);
 
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -202,76 +202,65 @@ static void cpuidle_idle_call(void)
  *
  * Called with polling cleared.
  */
-static void cpu_idle_loop(void)
+static void do_idle(void)
 {
-	int cpu = smp_processor_id();
-
-	while (1) {
-		/*
-		 * If the arch has a polling bit, we maintain an invariant:
-		 *
-		 * Our polling bit is clear if we're not scheduled (i.e. if
-		 * rq->curr != rq->idle).  This means that, if rq->idle has
-		 * the polling bit set, then setting need_resched is
-		 * guaranteed to cause the cpu to reschedule.
-		 */
+	/*
+	 * If the arch has a polling bit, we maintain an invariant:
+	 *
+	 * Our polling bit is clear if we're not scheduled (i.e. if rq->curr !=
+	 * rq->idle). This means that, if rq->idle has the polling bit set,
+	 * then setting need_resched is guaranteed to cause the CPU to
+	 * reschedule.
+	 */
 
-		__current_set_polling();
-		quiet_vmstat();
-		tick_nohz_idle_enter();
-
-		while (!need_resched()) {
-			check_pgt_cache();
-			rmb();
-
-			if (cpu_is_offline(cpu)) {
-				cpuhp_report_idle_dead();
-				arch_cpu_idle_dead();
-			}
-
-			local_irq_disable();
-			arch_cpu_idle_enter();
-
-			/*
-			 * In poll mode we reenable interrupts and spin.
-			 *
-			 * Also if we detected in the wakeup from idle
-			 * path that the tick broadcast device expired
-			 * for us, we don't want to go deep idle as we
-			 * know that the IPI is going to arrive right
-			 * away
-			 */
-			if (cpu_idle_force_poll || tick_check_broadcast_expired())
-				cpu_idle_poll();
-			else
-				cpuidle_idle_call();
+	__current_set_polling();
+	tick_nohz_idle_enter();
 
-			arch_cpu_idle_exit();
+	while (!need_resched()) {
+		check_pgt_cache();
+		rmb();
+
+		if (cpu_is_offline(smp_processor_id())) {
+			cpuhp_report_idle_dead();
+			arch_cpu_idle_dead();
 		}
 
-		/*
-		 * Since we fell out of the loop above, we know
-		 * TIF_NEED_RESCHED must be set, propagate it into
-		 * PREEMPT_NEED_RESCHED.
-		 *
-		 * This is required because for polling idle loops we will
-		 * not have had an IPI to fold the state for us.
-		 */
-		preempt_set_need_resched();
-		tick_nohz_idle_exit();
-		__current_clr_polling();
+		local_irq_disable();
+		arch_cpu_idle_enter();
 
 		/*
-		 * We promise to call sched_ttwu_pending and reschedule
-		 * if need_resched is set while polling is set.  That
-		 * means that clearing polling needs to be visible
-		 * before doing these things.
+		 * In poll mode we reenable interrupts and spin. Also if we
+		 * detected in the wakeup from idle path that the tick
+		 * broadcast device expired for us, we don't want to go deep
+		 * idle as we know that the IPI is going to arrive right away.
 		 */
-		smp_mb__after_atomic();
-
-		sched_ttwu_pending();
-		schedule_preempt_disabled();
+		if (cpu_idle_force_poll || tick_check_broadcast_expired())
+			cpu_idle_poll();
+		else
+			cpuidle_idle_call();
+		arch_cpu_idle_exit();
 	}
+
+	/*
+	 * Since we fell out of the loop above, we know TIF_NEED_RESCHED must
+	 * be set, propagate it into PREEMPT_NEED_RESCHED.
+	 *
+	 * This is required because for polling idle loops we will not have had
+	 * an IPI to fold the state for us.
+	 */
+	preempt_set_need_resched();
+	tick_nohz_idle_exit();
+	__current_clr_polling();
+
+	/*
+	 * We promise to call sched_ttwu_pending() and reschedule if
+	 * need_resched() is set while polling is set. That means that clearing
+	 * polling needs to be visible before doing these things.
+	 */
+	smp_mb__after_atomic();
+
+	sched_ttwu_pending();
+	schedule_preempt_disabled();
 }
 
 bool cpu_in_idle(unsigned long pc)
@@ -280,6 +269,56 @@ bool cpu_in_idle(unsigned long pc)
 		pc < (unsigned long)__cpuidle_text_end;
 }
 
+struct idle_timer {
+	struct hrtimer timer;
+	int done;
+};
+
+static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
+{
+	struct idle_timer *it = container_of(timer, struct idle_timer, timer);
+
+	WRITE_ONCE(it->done, 1);
+	set_tsk_need_resched(current);
+
+	return HRTIMER_NORESTART;
+}
+
+void play_idle(unsigned long duration_ms)
+{
+	struct idle_timer it;
+
+	/*
+	 * Only FIFO tasks can disable the tick since they don't need the forced
+	 * preemption.
+	 */
+	WARN_ON_ONCE(current->policy != SCHED_FIFO);
+	WARN_ON_ONCE(current->nr_cpus_allowed != 1);
+	WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
+	WARN_ON_ONCE(!(current->flags & PF_NO_SETAFFINITY));
+	WARN_ON_ONCE(!duration_ms);
+
+	rcu_sleep_check();
+	preempt_disable();
+	current->flags |= PF_IDLE;
+	cpuidle_use_deepest_state(true);
+
+	it.done = 0;
+	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	it.timer.function = idle_inject_timer_fn;
+	hrtimer_start(&it.timer, ms_to_ktime(duration_ms), HRTIMER_MODE_REL_PINNED);
+
+	while (!READ_ONCE(it.done))
+		do_idle();
+
+	cpuidle_use_deepest_state(false);
+	current->flags &= ~PF_IDLE;
+
+	preempt_fold_need_resched();
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(play_idle);
+
 void cpu_startup_entry(enum cpuhp_state state)
 {
 	/*
@@ -299,5 +338,6 @@ void cpu_startup_entry(enum cpuhp_state
 #endif
 	arch_cpu_idle_prepare();
 	cpuhp_online_idle(state);
-	cpu_idle_loop();
+	while (1)
+		do_idle();
 }
