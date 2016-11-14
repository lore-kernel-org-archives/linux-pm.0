From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 1/3] idle: add support for tasks that inject idle
Date: Mon, 14 Nov 2016 10:47:56 -0800
Message-ID: <1479149278-12418-2-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1479149278-12418-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479149278-12418-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Idle injection drivers such as Intel powerclamp and ACPI PAD drivers use
realtime tasks to take control of CPU then inject idle. There are two issues
with this approach:
 1. Low efficiency: injected idle task is treated as busy so sched ticks do
    not stop during injected idle period, the result of these unwanted
    wakeups can be ~20% loss in power savings.
 2. Idle accounting: injected idle time is presented to user as busy.

This patch addresses the issues by introducing a new PF_IDLE flag which
allows any given task to be treated as idle task while the flag is set.
Therefore, idle injection tasks can run through the normal flow of NOHZ idle
enter/exit to get the correct accounting as well as tick stop when possible.

The implication is that idle task is then no longer limited to PID == 0.
Inheriting PF_IDLE flag from parents is also prevented.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/linux/cpu.h   |   2 +
 include/linux/sched.h |   3 +-
 kernel/fork.c         |   3 +
 kernel/sched/core.c   |   1 +
 kernel/sched/idle.c   | 174 +++++++++++++++++++++++++++++++-------------------
 5 files changed, 118 insertions(+), 65 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index b886dc1..ac0efae 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -245,6 +245,8 @@ static inline void enable_nonboot_cpus(void) {}
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
+void play_idle(unsigned long duration_ms);
+
 #ifdef CONFIG_HOTPLUG_CPU
 bool cpu_wait_death(unsigned int cpu, int seconds);
 bool cpu_report_death(void);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 348f51b..114c7fc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2254,6 +2254,7 @@ static inline cputime_t task_gtime(struct task_struct *t)
 /*
  * Per process flags
  */
+#define PF_IDLE		0x00000002	/* I am an IDLE thread */
 #define PF_EXITING	0x00000004	/* getting shut down */
 #define PF_EXITPIDONE	0x00000008	/* pi exit done on shut down */
 #define PF_VCPU		0x00000010	/* I'm a virtual CPU */
@@ -2609,7 +2610,7 @@ extern int sched_setattr(struct task_struct *,
  */
 static inline bool is_idle_task(const struct task_struct *p)
 {
-	return p->pid == 0;
+	return !!(p->flags & PF_IDLE);
 }
 extern struct task_struct *curr_task(int cpu);
 extern void ia64_set_curr_task(int cpu, struct task_struct *p);
diff --git a/kernel/fork.c b/kernel/fork.c
index 997ac1d..73edbcd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1819,6 +1819,9 @@ static __latent_entropy struct task_struct *copy_process(
 	threadgroup_change_end(current);
 	perf_event_fork(p);
 
+	/* do not inherit idle task */
+	p->flags &= ~PF_IDLE;
+
 	trace_task_newtask(p, clone_flags);
 	uprobe_copy_process(p, clone_flags);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 154fd68..c95fbcd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5279,6 +5279,7 @@ void init_idle(struct task_struct *idle, int cpu)
 	__sched_fork(0, idle);
 	idle->state = TASK_RUNNING;
 	idle->se.exec_start = sched_clock();
+	idle->flags |= PF_IDLE;
 
 	kasan_unpoison_task_stack(idle);
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 1d8718d..cb6442f 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -202,76 +202,68 @@ static void cpuidle_idle_call(void)
  *
  * Called with polling cleared.
  */
-static void cpu_idle_loop(void)
+static void do_idle(void)
 {
-	int cpu = smp_processor_id();
+	/*
+	 * If the arch has a polling bit, we maintain an invariant:
+	 *
+	 * Our polling bit is clear if we're not scheduled (i.e. if
+	 * rq->curr != rq->idle).  This means that, if rq->idle has
+	 * the polling bit set, then setting need_resched is
+	 * guaranteed to cause the cpu to reschedule.
+	 */
 
-	while (1) {
-		/*
-		 * If the arch has a polling bit, we maintain an invariant:
-		 *
-		 * Our polling bit is clear if we're not scheduled (i.e. if
-		 * rq->curr != rq->idle).  This means that, if rq->idle has
-		 * the polling bit set, then setting need_resched is
-		 * guaranteed to cause the cpu to reschedule.
-		 */
+	__current_set_polling();
+	tick_nohz_idle_enter();
 
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
-
-			arch_cpu_idle_exit();
-		}
+	while (!need_resched()) {
+		check_pgt_cache();
+		rmb();
 
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
+		if (cpu_is_offline(smp_processor_id())) {
+			cpuhp_report_idle_dead();
+			arch_cpu_idle_dead();
+		}
 
-		/*
-		 * We promise to call sched_ttwu_pending and reschedule
-		 * if need_resched is set while polling is set.  That
-		 * means that clearing polling needs to be visible
-		 * before doing these things.
-		 */
-		smp_mb__after_atomic();
+		local_irq_disable();
+		arch_cpu_idle_enter();
 
-		sched_ttwu_pending();
-		schedule_preempt_disabled();
+	/* In poll mode we reenable interrupts and spin.
+	 * Also if we detected in the wakeup from idle
+	 * path that the tick broadcast device expired
+	 * for us, we don't want to go deep idle as we
+	 * know that the IPI is going to arrive right
+	 * away
+	 */
+		if (cpu_idle_force_poll || tick_check_broadcast_expired())
+			cpu_idle_poll();
+		else
+			cpuidle_idle_call();
+		arch_cpu_idle_exit();
 	}
+
+	/*
+	 * Since we fell out of the loop above, we know
+	 * TIF_NEED_RESCHED must be set, propagate it into
+	 * PREEMPT_NEED_RESCHED.
+	 *
+	 * This is required because for polling idle loops we will
+	 * not have had an IPI to fold the state for us.
+	 */
+	preempt_set_need_resched();
+	tick_nohz_idle_exit();
+	__current_clr_polling();
+
+	/*
+	 * We promise to call sched_ttwu_pending and reschedule
+	 * if need_resched is set while polling is set.  That
+	 * means that clearing polling needs to be visible
+	 * before doing these things.
+	 */
+	smp_mb__after_atomic();
+
+	sched_ttwu_pending();
+	schedule_preempt_disabled();
 }
 
 bool cpu_in_idle(unsigned long pc)
@@ -280,6 +272,58 @@ bool cpu_in_idle(unsigned long pc)
 		pc < (unsigned long)__cpuidle_text_end;
 }
 
+static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *hrtimer)
+{
+	set_tsk_need_resched(current);
+	return HRTIMER_NORESTART;
+}
+
+void play_idle(unsigned long duration_ms)
+{
+	struct hrtimer timer;
+	unsigned long end_time;
+
+	/*
+	 * Only FIFO tasks can disable the tick since they don't need the forced
+	 * preemption.
+	 */
+	WARN_ON_ONCE(current->policy != SCHED_FIFO);
+	WARN_ON_ONCE(current->nr_cpus_allowed != 1);
+	WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
+	WARN_ON_ONCE(!(current->flags & PF_NO_SETAFFINITY));
+
+	rcu_sleep_check();
+	preempt_disable();
+	current->flags |= PF_IDLE;
+	cpuidle_use_deepest_state(true);
+
+	/*
+	 * If duration is 0, we will return after a natural wake event occurs. If
+	 * duration is none zero, we will go back to sleep if we were woken up earlier.
+	 * We also set up a timer to make sure we don't oversleep in deep idle.
+	 */
+	if (!duration_ms)
+		do_idle();
+	else {
+		hrtimer_init_on_stack(&timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		timer.function = idle_inject_timer_fn;
+		hrtimer_start(&timer, ms_to_ktime(duration_ms),
+			HRTIMER_MODE_REL_PINNED);
+		end_time = jiffies + msecs_to_jiffies(duration_ms);
+
+		while (time_after(end_time, jiffies))
+			do_idle();
+	}
+	hrtimer_cancel(&timer);
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
@@ -299,5 +343,7 @@ void cpu_startup_entry(enum cpuhp_state state)
 #endif
 	arch_cpu_idle_prepare();
 	cpuhp_online_idle(state);
-	cpu_idle_loop();
+	while (1)
+		do_idle();
+
 }
-- 
1.9.1
