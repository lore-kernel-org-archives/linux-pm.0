From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 08/10] timer: Implement the hierarchical pull model
Date: Mon, 17 Apr 2017 20:32:49 +0200
Message-ID: <20170417184356.618193258@linutronix.de>
References: <20170417183241.244217993@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:48383 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755441AbdDQSxg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 14:53:36 -0400
Content-Disposition: inline;
 filename=timer--Implement-the-hierarchical-pull-model.patch
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>

Placing timers at enqueue time on a target CPU based on dubious heuristics
does not make any sense:

 1) Most timer wheel timers are canceled or rearmed before they expire.

 2) The heuristics to predict which CPU will be busy when the timer expires
    are wrong by definition.

So we waste precious cycles to place timers at enqueue time.

The proper solution to this problem is to always queue the timers on the
local CPU and allow the non pinned timers to be pulled onto a busy CPU at
expiry time.

To achieve this the timer storage has been split into local pinned and
global timers. Local pinned timers are always expired on the CPU on which
they have been queued. Global timers can be expired on any CPU.

As long as a CPU is busy it expires both local and global timers. When a
CPU goes idle it arms for the first expiring local timer. If the first
expiring pinned (local) timer is before the first expiring movable timer,
then no action is required because the CPU will wake up before the first
movable timer expires. If the first expiring movable timer is before the
first expiring pinned (local) timer, then this timer is queued into a idle
timerqueue and eventually expired by some other active CPU.

To avoid global locking the timerqueues are implemented as a hierarchy. The
lowest level of the hierarchy holds the CPUs. The CPUs are associated to
groups of 8, which are seperated per node. If more than one CPU group
exist, then a second level in the hierarchy collects the groups. Depending
on the size of the system more than 2 levels are required. Each group has a
"migrator" which checks the timerqueue during the tick for remote expirable
timers.

If the last CPU in a group goes idle it reports the first expiring event in
the group up to the next group(s) in the hierarchy. If the last CPU goes
idle it arms its timer for the first system wide expiring timer to ensure
that no timer event is missed.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/cpuhotplug.h    |    1 
 kernel/time/Makefile          |    1 
 kernel/time/tick-sched.c      |   92 +++++-
 kernel/time/tick-sched.h      |    3 
 kernel/time/timer.c           |   31 +-
 kernel/time/timer_migration.c |  642 ++++++++++++++++++++++++++++++++++++++++++
 kernel/time/timer_migration.h |   89 +++++
 7 files changed, 847 insertions(+), 12 deletions(-)

--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -137,6 +137,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_ARM_CCN_ONLINE,
 	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
 	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
+	CPUHP_AP_TMIGR_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -15,5 +15,6 @@ ifeq ($(CONFIG_GENERIC_CLOCKEVENTS_BROAD
 endif
 obj-$(CONFIG_GENERIC_SCHED_CLOCK)		+= sched_clock.o
 obj-$(CONFIG_TICK_ONESHOT)			+= tick-oneshot.o tick-sched.o
+obj-$(CONFIG_NO_HZ_COMMON)			+= timer_migration.o
 obj-$(CONFIG_DEBUG_FS)				+= timekeeping_debug.o
 obj-$(CONFIG_TEST_UDELAY)			+= test_udelay.o
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -30,6 +30,7 @@
 
 #include <asm/irq_regs.h>
 
+#include "timer_migration.h"
 #include "tick-internal.h"
 
 #include <trace/events/timer.h>
@@ -680,11 +681,46 @@ static void tick_nohz_restart(struct tic
 		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 }
 
+#ifdef CONFIG_SMP
+static u64
+tick_tmigr_idle(struct tick_sched *ts, u64 next_global, u64 next_local)
+{
+	ts->tmigr_idle = 1;
+
+	/*
+	 * If next_global is after next_local, event does not have to
+	 * be queued in the timer migration hierarchy, but cpu needs
+	 * to be marked as idle.
+	 */
+	if (next_global >= next_local)
+		next_global = KTIME_MAX;
+
+	next_global = tmigr_cpu_idle(next_global);
+
+	return min_t(u64, next_local, next_global);
+}
+
+static void tick_tmigr_stop_idle(struct tick_sched *ts)
+{
+	if (ts->tmigr_idle) {
+		ts->tmigr_idle = 0;
+		tmigr_cpu_activate();
+	}
+}
+#else
+static u64
+tick_tmigr_idle(struct tick_sched *ts, u64 next_global, u64 next_local)
+{
+	return min_t(u64, next_global, next_local);
+}
+static inline void tick_tmigr_stop_idle(struct tick_sched *ts) { }
+#endif /*CONFIG_SMP*/
+
 static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
 					 ktime_t now, int cpu)
 {
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
-	u64 basemono, next_tick, next_local, next_global, next_rcu, delta, expires;
+	u64 basemono, next_local, next_global, next_rcu, delta, expires;
 	unsigned long basejiff;
 	ktime_t	tick;
 
@@ -693,7 +729,12 @@ static ktime_t tick_nohz_stop_sched_tick
 
 	if (rcu_needs_cpu(basemono, &next_rcu) ||
 	    arch_needs_cpu() || irq_work_needs_cpu()) {
-		next_tick = basemono + TICK_NSEC;
+		/*
+		 * If anyone needs the CPU, treat this as a local
+		 * timer expiring in a jiffy.
+		 */
+		next_global = KTIME_MAX;
+		next_local = basemono + TICK_NSEC;
 	} else {
 		/*
 		 * Get the next pending timer. If high resolution
@@ -704,21 +745,48 @@ static ktime_t tick_nohz_stop_sched_tick
 		 */
 		next_local = get_next_timer_interrupt(basejiff, basemono,
 						      &next_global);
-		next_local = min(next_local, next_global);
-		ts->next_timer = next_local;
-		/* Take the next rcu event into account */
-		next_tick = next_rcu < next_local ? next_rcu : next_local;
+		/*
+		 * Take RCU into account.  Even though rcu_needs_cpu()
+		 * returned false, RCU might need a wake up event
+		 * after all, as reflected in the value of next_rcu.
+		 */
+		next_local = min_t(u64, next_rcu, next_local);
 	}
 
 	/*
+	 * The CPU might be the last one going inactive in the timer
+	 * migration hierarchy. Mark the CPU inactive and get the next
+	 * timer event returned, if the next local event is more than a
+	 * tick away.
+	 *
+	 * If the CPU is the last one to go inactive, then the earliest
+	 * event (next local or next global event in the hierarchy) is
+	 * returned.
+	 *
+	 * Otherwise the next local event is returned and the next global
+	 * event of this CPU is queued in the hierarchy.
+	 */
+	delta = next_local - basemono;
+	if (delta > (u64)TICK_NSEC)
+		next_local = tick_tmigr_idle(ts, next_local, next_global);
+
+	ts->next_timer = next_local;
+
+	/*
 	 * If the tick is due in the next period, keep it ticking or
 	 * force prod the timer.
 	 */
-	delta = next_tick - basemono;
+	delta = next_local - basemono;
 	if (delta <= (u64)TICK_NSEC) {
 		tick = 0;
 
 		/*
+		 * If the CPU deactivated itself in the timer migration
+		 * hierarchy, activate it again.
+		 */
+		tick_tmigr_stop_idle(ts);
+
+		/*
 		 * Tell the timer code that the base is not idle, i.e. undo
 		 * the effect of get_next_timer_interrupt():
 		 */
@@ -782,7 +850,7 @@ static ktime_t tick_nohz_stop_sched_tick
 	else
 		expires = KTIME_MAX;
 
-	expires = min_t(u64, expires, next_tick);
+	expires = min_t(u64, expires, next_local);
 	tick = expires;
 
 	/* Skip reprogram of event if its not changed */
@@ -1047,6 +1115,8 @@ void tick_nohz_idle_exit(void)
 
 	ts->inidle = 0;
 
+	tick_tmigr_stop_idle(ts);
+
 	if (ts->idle_active || ts->tick_stopped)
 		now = ktime_get();
 
@@ -1126,8 +1196,12 @@ static inline void tick_nohz_irq_enter(v
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 	ktime_t now;
 
-	if (!ts->idle_active && !ts->tick_stopped)
+	if (!ts->idle_active && !ts->tick_stopped && !ts->tmigr_idle)
 		return;
+
+	/* FIMXE: Is this really needed ???? */
+	tick_tmigr_stop_idle(ts);
+
 	now = ktime_get();
 	if (ts->idle_active)
 		tick_nohz_stop_idle(ts, now);
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -27,7 +27,9 @@ enum tick_nohz_mode {
  *			timer is modified for nohz sleeps. This is necessary
  *			to resume the tick timer operation in the timeline
  *			when the CPU returns from nohz sleep.
+ * @inidle:		Indicator that the CPU is in the tick idle mode
  * @tick_stopped:	Indicator that the idle tick has been stopped
+ * @tmigr_idle:		Indicator that the CPU is idle vs. timer migration
  * @idle_jiffies:	jiffies at the entry to idle for idle time accounting
  * @idle_calls:		Total number of idle calls
  * @idle_sleeps:	Number of idle calls, where the sched tick was stopped
@@ -46,6 +48,7 @@ struct tick_sched {
 	ktime_t				last_tick;
 	int				inidle;
 	int				tick_stopped;
+	int				tmigr_idle;
 	unsigned long			idle_jiffies;
 	unsigned long			idle_calls;
 	unsigned long			idle_sleeps;
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -51,6 +51,7 @@
 #include <asm/timex.h>
 #include <asm/io.h>
 
+#include "timer_migration.h"
 #include "tick-internal.h"
 
 #define CREATE_TRACE_POINTS
@@ -185,6 +186,10 @@ EXPORT_SYMBOL(jiffies_64);
 #define WHEEL_SIZE	(LVL_SIZE * LVL_DEPTH)
 
 #ifdef CONFIG_NO_HZ_COMMON
+/*
+ * If multiple bases need to be locked, use the base ordering for lock
+ * nesting, i.e. lowest number first.
+ */
 # define NR_BASES	3
 # define BASE_LOCAL	0
 # define BASE_GLOBAL	1
@@ -216,7 +221,7 @@ unsigned int sysctl_timer_migration = 1;
 
 void timers_update_migration(bool update_nohz)
 {
-	bool on = sysctl_timer_migration && tick_nohz_active;
+	bool on = sysctl_timer_migration && tick_nohz_active && tmigr_enabled;
 	unsigned int cpu;
 
 	/* Avoid the loop, if nothing to update */
@@ -1619,13 +1624,27 @@ static int collect_expired_timers(struct
 	}
 	return __collect_expired_timers(base, heads);
 }
-#else
+
+static inline void __run_timers(struct timer_base *base);
+
+#ifdef CONFIG_SMP
+void timer_expire_remote(unsigned int cpu)
+{
+	struct timer_base *base = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	spin_lock_irq(&base->lock);
+	__run_timers(base);
+	spin_unlock_irq(&base->lock);
+}
+#endif
+
+#else /* CONFIG_NO_HZ_COMMON */
 static inline int collect_expired_timers(struct timer_base *base,
 					 struct hlist_head *heads)
 {
 	return __collect_expired_timers(base, heads);
 }
-#endif
+#endif /* !CONFIG_NO_HZ_COMMON */
 
 /*
  * Called from the timer interrupt handler to charge one tick to the current
@@ -1689,11 +1708,16 @@ static void run_timer_base(int index, bo
  */
 static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
+
 	run_timer_base(BASE_LOCAL, false);
 
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
 		run_timer_base(BASE_GLOBAL, false);
 		run_timer_base(BASE_DEF, true);
+
+		if (base->nohz_active)
+			tmigr_handle_remote();
 	}
 }
 
@@ -1909,6 +1933,7 @@ void __init init_timers(void)
 {
 	init_timer_cpus();
 	open_softirq(TIMER_SOFTIRQ, run_timer_softirq);
+	tmigr_init();
 }
 
 /**
--- /dev/null
+++ b/kernel/time/timer_migration.c
@@ -0,0 +1,642 @@
+/*
+ * Infrastructure for migrateable timers
+ *
+ * Copyright(C) 2016 linutronix GmbH
+ *
+ * This code is licenced under the GPL version 2. For details see
+ * kernel-base/COPYING.
+ */
+#include <linux/cpuhotplug.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/spinlock.h>
+#include <linux/timerqueue.h>
+#include <linux/timer.h>
+
+#include "timer_migration.h"
+#include "tick-internal.h"
+
+#ifdef DEBUG
+# define DBG_BUG_ON(x)	BUG_ON(x)
+#else
+# define DBG_BUG_ON(x)
+#endif
+
+/* Per group capacity. Must be a power of 2! */
+static const unsigned int tmigr_childs_per_group = 8;
+
+bool tmigr_enabled __read_mostly;
+static unsigned int tmigr_hierarchy_levels __read_mostly;
+static unsigned int tmigr_crossnode_level __read_mostly;
+static struct list_head *tmigr_level_list __read_mostly;
+
+static DEFINE_MUTEX(tmigr_mutex);
+
+static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
+
+static void tmigr_add_evt(struct tmigr_group *group, struct tmigr_event *evt)
+{
+	/*
+	 * Can be called with @evt == NULL, an already queued @evt or
+	 * an event that do not need to be queued (expires ==
+	 * KTIME_MAX)
+	 */
+	if (!evt || !RB_EMPTY_NODE(&evt->nextevt.node) ||
+	    evt->nextevt.expires == KTIME_MAX)
+		return;
+
+	/* @group->group event must not be queued in the parent group */
+	DBG_BUG_ON(!RB_EMPTY_NODE(&group->groupevt.nextevt.node));
+
+	/*  If this is the new first to expire event, update group event */
+	if (timerqueue_add(&group->events, &evt->nextevt)) {
+		group->groupevt.nextevt.expires = evt->nextevt.expires;
+		group->groupevt.cpu = evt->cpu;
+	}
+}
+
+static void tmigr_remove_evt(struct tmigr_group *group, struct tmigr_event *evt)
+{
+	struct timerqueue_node *next;
+	struct tmigr_event *nextevt;
+	bool first;
+
+	/*
+	 * It's safe to modify the group event of this group, because it is
+	 * not queued in the parent group.
+	 */
+	DBG_BUG_ON(!RB_EMPTY_NODE(&group->groupevt.nextevt.node));
+
+	/* Remove the child event, if pending */
+	if (!evt || RB_EMPTY_NODE(&evt->nextevt.node))
+		return;
+	/*
+	 * If this was the last queued event in the group, clear
+	 * the group event. If this was the first event to expire,
+	 * update the group.
+	 */
+	first = (timerqueue_getnext(&group->events) == &evt->nextevt);
+
+	if (!timerqueue_del(&group->events, &evt->nextevt)) {
+		group->groupevt.nextevt.expires = KTIME_MAX;
+		group->groupevt.cpu = TMIGR_NONE;
+	} else if (first) {
+		next = timerqueue_getnext(&group->events);
+		nextevt = container_of(next, struct tmigr_event, nextevt);
+		group->groupevt.nextevt.expires = nextevt->nextevt.expires;
+		group->groupevt.cpu = nextevt->cpu;
+	}
+}
+
+static void tmigr_update_remote(unsigned int cpu, u64 now, unsigned long jif)
+{
+	struct tmigr_cpu *tmc = per_cpu_ptr(&tmigr_cpu, cpu);
+	struct tmigr_group *group = tmc->tmgroup;
+	u64 next_local, next_global;
+
+	/*
+	 * Here the migrator CPU races with the target CPU.  The migrator
+	 * removed @tmc->nextevt from the group's queue, but it then dropped
+	 * the group lock.  Concurrently the target CPU might have serviced
+	 * an interrupt and therefore have called tmigr_cpu_activate() and
+	 * possibly tmigr_cpu_idle() which requeued CPUs @tmc into @group.
+	 *
+	 * Must hold @tmc->lock for changing @tmc->nextevt and @group->lock
+	 * to protect the timer queue of @group.
+	 */
+	raw_spin_lock_irq(&tmc->lock);
+	raw_spin_lock(&group->lock);
+
+	/*
+	 * If the cpu went offline or marked itself active again, nothing
+	 * more to do.
+	 */
+	if (!tmc->online || cpumask_test_cpu(cpu, group->cpus))
+		goto done;
+
+	/*
+	 * Although __timgr_handle_remote() just dequeued the event, still
+	 * the target CPU might have added it again after the lock got
+	 * dropped. If it's queued the group queue is up to date.
+	 */
+	if (!RB_EMPTY_NODE(&tmc->cpuevt.nextevt.node))
+		goto done;
+
+	/*
+	 * Recalculate next event. Needs to be calculated while holding the
+	 * lock because the first expiring global timer could have been
+	 * removed since the last evaluation.
+	 */
+	next_local = get_next_timer_interrupt(jif, now, &next_global);
+
+	/*
+	 * If next_global is after next_local, event does not have to
+	 * be queued.
+	 */
+	if (next_global >= next_local)
+		next_global = KTIME_MAX;
+
+	tmc->cpuevt.nextevt.expires = next_global;
+
+	/* Queue @cpu event (is not ne queued if expires == KTIME_MAX) */
+	tmigr_add_evt(group, &tmc->cpuevt);
+
+done:
+	raw_spin_unlock(&group->lock);
+	raw_spin_unlock_irq(&tmc->lock);
+}
+
+static void __tmigr_handle_remote(struct tmigr_group *group, unsigned int cpu,
+				  u64 now, unsigned long jif, bool walkup)
+{
+	struct timerqueue_node *tmr;
+	struct tmigr_group *parent;
+	struct tmigr_event *evt;
+
+again:
+	raw_spin_lock_irq(&group->lock);
+	/*
+	 * Handle the group only if @cpu is the migrator or if the group
+	 * has no migrator. Otherwise the group is active and is handled by
+	 * its own migrator.
+	 */
+	if (group->migrator != cpu && group->migrator != TMIGR_NONE) {
+		raw_spin_unlock_irq(&group->lock);
+		return;
+	}
+
+	tmr = timerqueue_getnext(&group->events);
+	if (tmr && now >= tmr->expires) {
+		/*
+		 * Remove the expired entry from the queue and handle
+		 * it. If this is a leaf group, call the timer poll
+		 * function for the given cpu. Otherwise handle the group
+		 * itself.  Drop the group lock here in both cases to avoid
+		 * lock ordering inversions.
+		 */
+		evt = container_of(tmr, struct tmigr_event, nextevt);
+		tmigr_remove_evt(group, evt);
+
+		raw_spin_unlock_irq(&group->lock);
+
+		/*
+		 * If the event is a group event walk down the hierarchy of
+		 * that group to the CPU leafs. If not, handle the expired
+		 * timer from the remote CPU.
+		 */
+		if (evt->group) {
+			__tmigr_handle_remote(evt->group, cpu, now, jif, false);
+		} else {
+			timer_expire_remote(evt->cpu);
+			tmigr_update_remote(evt->cpu, now, jif);
+		}
+		goto again;
+	}
+
+	/*
+	 * If @group is not active, queue the next event in the parent
+	 * group. This is required, because the next event of @group
+	 * could have been changed by tmigr_update_remote() above.
+	 */
+	parent = group->parent;
+	if (parent && !group->active) {
+		raw_spin_lock_nested(&parent->lock, parent->level);
+		tmigr_add_evt(parent, &group->groupevt);
+		raw_spin_unlock(&parent->lock);
+	}
+	raw_spin_unlock_irq(&group->lock);
+
+	/* Walk the hierarchy up? */
+	if (!walkup || !parent)
+		return;
+
+	/* Racy lockless check: See comment in tmigr_handle_remote() */
+	if (parent->migrator == cpu)
+		__tmigr_handle_remote(parent, cpu, now, jif, true);
+}
+
+/**
+ * tmigr_handle_remote - Handle migratable timers on remote idle CPUs
+ *
+ * Called from the timer soft interrupt with interrupts enabled.
+ */
+void tmigr_handle_remote(void)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	int cpu = smp_processor_id();
+	unsigned long basej;
+	ktime_t now;
+
+	if (!tmigr_enabled)
+		return;
+
+	/*
+	 * Check whether this CPU is responsible for handling the global
+	 * timers of other CPUs. Do a racy lockless check to avoid lock
+	 * contention for the busy case where timer soft interrupts happen
+	 * in parallel. It's not an issue, if the CPU misses a concurrent
+	 * update of the migrator role for its base group. It's not more
+	 * racy than doing this check under the lock, if the update happens
+	 * right after the lock is dropped. There is no damage in such a
+	 * case other than potentially expiring a global timer one tick
+	 * late.
+	 */
+	if (tmc->tmgroup->migrator != cpu)
+		return;
+
+	now = get_jiffies_update(&basej);
+	__tmigr_handle_remote(tmc->tmgroup, cpu, now, basej, true);
+}
+
+/**
+ * tmigr_set_cpu_inactive - Set a CPU inactive in the group
+ * @group:	The group from which @cpu is removed
+ * @child:	The child group which was updated before
+ * @evt:	The event to queue in @group
+ * @cpu:	The CPU which becomes inactive
+ *
+ * Remove @cpu from @group and propagate it through the hierarchy if
+ * @cpu was the migrator of @group.
+ *
+ * Returns KTIME_MAX if @cpu is not the last outgoing CPU in the
+ * hierarchy. Otherwise it returns the first expiring global event.
+ */
+static u64 tmigr_set_cpu_inactive(struct tmigr_group *group,
+				  struct tmigr_group *child,
+				  struct tmigr_event *evt,
+				  unsigned int cpu)
+{
+	struct tmigr_group *parent;
+	u64 nextevt = KTIME_MAX;
+
+	raw_spin_lock_nested(&group->lock, group->level);
+
+	DBG_BUG_ON(!group->active);
+
+	cpumask_clear_cpu(cpu, group->cpus);
+	group->active--;
+
+	/*
+	 * If @child is not NULL, then this is a recursive invocation to
+	 * propagate the deactivation of @cpu. If @child has a new migrator
+	 * set it active in @group.
+	 */
+	if (child && child->migrator != TMIGR_NONE) {
+		cpumask_set_cpu(child->migrator, group->cpus);
+		group->active++;
+	}
+
+	/* Add @evt to @group */
+	tmigr_add_evt(group, evt);
+
+	/* If @cpu is not the active migrator, everything is up to date */
+	if (group->migrator != cpu)
+		goto done;
+
+	/* Update the migrator. */
+	if (!group->active)
+		group->migrator = TMIGR_NONE;
+	else
+		group->migrator = cpumask_first(group->cpus);
+
+	parent = group->parent;
+	if (parent) {
+		/*
+		 * @cpu was the migrator in @group, so it is marked as
+		 * active in its parent group(s) as well. Propagate the
+		 * migrator change.
+		 */
+		evt = group->active ? NULL : &group->groupevt;
+		nextevt = tmigr_set_cpu_inactive(parent, group, evt, cpu);
+	} else {
+		/*
+		 * This is the top level of the hierarchy. If @cpu is about
+		 * to go offline wake up some random other cpu so it will
+		 * take over the migrator duty and program its timer
+		 * proper. Ideally wake the cpu with the closest expiry
+		 * time, but that's overkill to figure out.
+		 */
+		if (!per_cpu(tmigr_cpu, cpu).online) {
+			cpu = cpumask_any_but(cpu_online_mask, cpu);
+			smp_send_reschedule(cpu);
+		}
+		/*
+		 * Return the earliest event of the top level group to make
+		 * sure that its handled.
+		 *
+		 * This could be optimized by keeping track of the last
+		 * global scheduled event and only arming it on @cpu if the
+		 * new event is earlier. Not sure if its worth the
+		 * complexity.
+		 */
+		nextevt = group->groupevt.nextevt.expires;
+	}
+done:
+	raw_spin_unlock(&group->lock);
+	return nextevt;
+}
+
+/**
+ * tmigr_cpu_idle - Put current CPU into idle state
+ * @nextevt:	The next timer event set in the current CPU
+ *
+ * Returns either the next event of the current CPU or the next event from
+ * the hierarchy if this CPU is the top level migrator.
+ *
+ * Must be called with interrupts disabled.
+ */
+u64 tmigr_cpu_idle(u64 nextevt)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	struct tmigr_group *group = tmc->tmgroup;
+	int cpu = smp_processor_id();
+
+	if (!tmc->online)
+		return nextevt;
+
+	raw_spin_lock(&tmc->lock);
+	tmc->cpuevt.nextevt.expires = nextevt;
+	nextevt = tmigr_set_cpu_inactive(group, NULL, &tmc->cpuevt, cpu);
+	raw_spin_unlock(&tmc->lock);
+	return nextevt;
+}
+
+/*
+ * tmigr_set_cpu_active - Propagate the activation of a CPU
+ * @group:	The group in which the CPU is activated
+ * @evt:	The event which is removed from @group
+ * @cpu:	The CPU which is activated
+ */
+static void tmigr_set_cpu_active(struct tmigr_group *group,
+				 struct tmigr_event *evt,
+				 unsigned int cpu)
+{
+	raw_spin_lock_nested(&group->lock, group->level);
+
+	if (WARN_ON(group->active == group->num_childs)) {
+		raw_spin_unlock(&group->lock);
+		return;
+	}
+
+	cpumask_set_cpu(cpu, group->cpus);
+	group->active++;
+
+	/* The first active cpu in a group takes the migrator role */
+	if (group->active == 1) {
+		struct tmigr_group *parent = group->parent;
+
+		group->migrator = cpu;
+		/* Propagate through the hierarchy */
+		if (parent)
+			tmigr_set_cpu_active(parent, &group->groupevt, cpu);
+	}
+	/*
+	 * Update groupevt and dequeue @evt. Must be called after parent
+	 * groups have been updated above so @group->groupevt is inactive.
+	 */
+	tmigr_remove_evt(group, evt);
+	raw_spin_unlock(&group->lock);
+}
+
+/**
+ * tmigr_cpu_activate - Activate current CPU
+ *
+ * Called from the NOHZ and cpu online code.
+ */
+void tmigr_cpu_activate(void)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	struct tmigr_group *group = tmc->tmgroup;
+	int cpu = smp_processor_id();
+	unsigned long flags;
+
+	if (!tmc->online || !group)
+		return;
+
+	local_irq_save(flags);
+	tmigr_set_cpu_active(group, &tmc->cpuevt, cpu);
+	local_irq_restore(flags);
+}
+
+static void tmigr_free_group(struct tmigr_group *group)
+{
+	if (group->parent) {
+		group->parent->num_childs--;
+		if (!group->parent->num_childs)
+			tmigr_free_group(group->parent);
+	}
+	list_del(&group->list);
+	free_cpumask_var(group->cpus);
+	kfree(group);
+}
+
+static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
+			     unsigned int node)
+{
+	raw_spin_lock_init(&group->lock);
+	group->level = lvl;
+	group->numa_node = lvl < tmigr_crossnode_level ? node : NUMA_NO_NODE;
+	group->migrator = TMIGR_NONE;
+	timerqueue_init_head(&group->events);
+	timerqueue_init(&group->groupevt.nextevt);
+	group->groupevt.group = group;
+	group->groupevt.nextevt.expires = KTIME_MAX;
+	group->groupevt.cpu = TMIGR_NONE;
+	group->num_childs = 1;
+}
+
+static struct tmigr_group *tmigr_get_group(unsigned int node, unsigned int lvl)
+{
+	struct tmigr_group *group;
+
+	/* Try to attach to an exisiting group first */
+	list_for_each_entry(group, &tmigr_level_list[lvl], list) {
+		/*
+		 * If @lvl is below the cross numa node level, check
+		 * whether this group belongs to the same numa node.
+		 */
+		if (lvl < tmigr_crossnode_level && group->numa_node != node)
+			continue;
+		/* If the group has capacity, use it */
+		if (group->num_childs < tmigr_childs_per_group) {
+			group->num_childs++;
+			return group;
+		}
+	}
+	/* Allocate and set up a new group */
+	group = kzalloc_node(sizeof(*group), GFP_KERNEL, node);
+	if (!group)
+		return ERR_PTR(-ENOMEM);
+
+	if (!zalloc_cpumask_var_node(&group->cpus, GFP_KERNEL, node)) {
+		kfree(group);
+		return ERR_PTR(-ENOMEM);
+	}
+	tmigr_init_group(group, lvl, node);
+	/* Setup successful. Add it to the hierarchy */
+	list_add(&group->list, &tmigr_level_list[lvl]);
+	return group;
+}
+
+static int tmigr_setup_parents(unsigned int lvl)
+{
+	struct list_head *lvllist = &tmigr_level_list[lvl];
+	struct tmigr_group *group, *parent;
+	int ret = 0;
+
+	/* End of hierarchy reached? */
+	if (list_is_singular(lvllist))
+		return 0;
+
+	DBG_BUG_ON(lvl == tmigr_hierarchy_levels);
+
+	list_for_each_entry(group, lvllist, list) {
+		if (group->parent)
+			continue;
+		parent = tmigr_get_group(group->numa_node, lvl + 1);
+		if (IS_ERR(parent))
+			return PTR_ERR(parent);
+
+		raw_spin_lock_irq(&group->lock);
+		group->parent = parent;
+		if (group->active)
+			tmigr_set_cpu_active(parent, NULL, group->migrator);
+		raw_spin_unlock_irq(&group->lock);
+		ret = 1;
+	}
+	return ret;
+}
+
+static int tmigr_check_hierarchy(void)
+{
+	int lvl, ret = 0;
+
+	for (lvl = 0; lvl < tmigr_hierarchy_levels; lvl++) {
+		ret = tmigr_setup_parents(lvl);
+		if (ret != 1)
+			break;
+	}
+	return ret;
+}
+
+static struct tmigr_group *tmigr_add_cpu(unsigned int cpu)
+{
+	unsigned int node = cpu_to_node(cpu);
+	struct tmigr_group *group;
+
+	mutex_lock(&tmigr_mutex);
+	group = tmigr_get_group(node, 0);
+	if (IS_ERR(group))
+		goto out;
+	/*
+	 * If the group was newly allocated, connect it
+	 * to parent group(s) if necessary.
+	 */
+	if (group->num_childs == 1) {
+		int ret = tmigr_check_hierarchy();
+
+		if (ret < 0) {
+			tmigr_free_group(group);
+			group = ERR_PTR(ret);
+		}
+	}
+out:
+	mutex_unlock(&tmigr_mutex);
+	return group;
+}
+
+static int tmigr_cpu_online(unsigned int cpu)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	struct tmigr_group *group;
+
+	/* First online attempt? Initialize cpu data */
+	if (!tmc->tmgroup) {
+		raw_spin_lock_init(&tmc->lock);
+		timerqueue_init(&tmc->cpuevt.nextevt);
+		tmc->cpuevt.group = NULL;
+		tmc->cpuevt.cpu = cpu;
+		group = tmigr_add_cpu(cpu);
+		if (IS_ERR(group))
+			return PTR_ERR(group);
+		tmc->tmgroup = group;
+	}
+	tmc->online = true;
+	tmigr_cpu_activate();
+	return 0;
+}
+
+static int tmigr_cpu_offline(unsigned int cpu)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	struct tmigr_group *group = tmc->tmgroup;
+
+	local_irq_disable();
+	tmc->online = false;
+	tmigr_set_cpu_inactive(group, NULL, NULL, cpu);
+	local_irq_enable();
+
+	return 0;
+}
+
+void __init tmigr_init(void)
+{
+	unsigned int cpulvl, nodelvl, cpus_per_node, i;
+	unsigned int nnodes = num_possible_nodes();
+	unsigned int ncpus = num_possible_cpus();
+	struct tmigr_group *group;
+	size_t sz;
+
+	/*
+	 * Calculate the required hierarchy levels. Unfortunately there is
+	 * no reliable information available, unless all possible CPUs have
+	 * been brought up and all numa nodes are populated.
+	 *
+	 * Estimate the number of levels with the number of possible nodes and
+	 * the number of possible cpus. Assume CPUs are spread evenly accross
+	 * nodes.
+	 */
+	cpus_per_node = DIV_ROUND_UP(ncpus, nnodes);
+	/* Calc the hierarchy levels required to hold the CPUs of a node */
+	cpulvl = DIV_ROUND_UP(order_base_2(cpus_per_node),
+			      ilog2(tmigr_childs_per_group));
+	/* Calculate the extra levels to connect all nodes */
+	nodelvl = DIV_ROUND_UP(order_base_2(nnodes),
+			       ilog2(tmigr_childs_per_group));
+
+	tmigr_hierarchy_levels = cpulvl + nodelvl;
+	/*
+	 * If a numa node spawns more than one CPU level group then the
+	 * next level(s) of the hierarchy contains groups which handle all
+	 * CPU groups of the same numa node. The level above goes accross
+	 * numa nodes. Store this information for the setup code to decide
+	 * when node matching is not longer required.
+	 */
+	tmigr_crossnode_level = cpulvl;
+
+	sz = sizeof(struct list_head) * tmigr_hierarchy_levels;
+	tmigr_level_list = kzalloc(sz, GFP_KERNEL);
+	if (!tmigr_level_list)
+		goto err;
+
+	for (i = 0; i < tmigr_hierarchy_levels; i++)
+		INIT_LIST_HEAD(&tmigr_level_list[i]);
+
+	if (cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
+			      tmigr_cpu_online, tmigr_cpu_offline))
+		goto hp_err;
+
+	tmigr_enabled = true;
+	pr_info("Timer migration: %d hierarchy levels\n", tmigr_hierarchy_levels);
+	return;
+
+hp_err:
+	/* Walk levels and free already allocated groups */
+	for (i = 0; i < tmigr_hierarchy_levels; i++) {
+		list_for_each_entry(group, &tmigr_level_list[i], list)
+			tmigr_free_group(group);
+	}
+	kfree(tmigr_level_list);
+err:
+	pr_err("Timer migration setup failed\n");
+}
--- /dev/null
+++ b/kernel/time/timer_migration.h
@@ -0,0 +1,89 @@
+/*
+ * Infrastructure for migrateable timers
+ *
+ * Copyright(C) 2016 linutronix GmbH
+ *
+ * This code is licenced under the GPL version 2. For details see
+ * kernel-base/COPYING.
+ */
+#ifndef _KERNEL_TIME_MIGRATION_H
+#define _KERNEL_TIME_MIGRATION_H
+
+#ifdef CONFIG_NO_HZ_COMMON
+extern bool tmigr_enabled;
+void tmigr_init(void);
+#else
+static inline void tmigr_init(void) { }
+#endif
+
+#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
+extern void tmigr_handle_remote(void);
+extern u64 tmigr_cpu_idle(u64 nextevt);
+extern void tmigr_cpu_activate(void);
+extern void timer_expire_remote(unsigned int cpu);
+#else
+static inline void tmigr_handle_remote(void) { }
+static inline u64 tmigr_cpu_idle(u64 nextevt) { }
+static inline void tmigr_cpu_activate(void) { }
+#endif
+
+#define TMIGR_NONE		(~0U)
+
+/**
+ * struct tmigr_event - A timer event associated to a CPU or a group
+ * @nextevt:	The node to enqueue an event in the group queue
+ * @group:	The group to which this event belongs (NULL if a cpu event)
+ * @cpu:	The cpu to which this event belongs (TMIGR_NONE if a group
+ *		event)
+ */
+struct tmigr_event {
+	struct timerqueue_node	nextevt;
+	struct tmigr_group	*group;
+	unsigned int		cpu;
+};
+
+/**
+ * struct tmigr_group - the hierachical group for timer migration structure
+ * @lock:	Group serialization. Must be taken with interrupts disabled.
+ * @active:	Specifies the number of active (not offline and not idle)
+ *		childs of the group
+ * @migrator:	CPU id of the migrator for this group or TMIGR_NONE
+ * @events:	timerqueue head of all events of the group
+ * @groupevt:	Next event of the group
+ * @parent:	Pointer to the parent group. Null if top level group
+ * @cpus:	CPU mask to track the active CPUs
+ * @list:	List head to queue in the global group level lists
+ * @level:	Specifies the hierarchy level of the group
+ * @numa_node:	Specifies the numa node of the group. NUMA_NO_NODE if the
+ *		group spawns multiple numa nodes
+ * @num_childs:	Number of childs of a group that are connected with the group
+ */
+struct tmigr_group {
+	raw_spinlock_t		lock;
+	unsigned int		active;
+	unsigned int		migrator;
+	struct timerqueue_head	events;
+	struct tmigr_event	groupevt;
+	struct tmigr_group	*parent;
+	cpumask_var_t		cpus;
+	struct list_head	list;
+	unsigned int		level;
+	unsigned int		numa_node;
+	unsigned int		num_childs;
+};
+
+/**
+ * struct tmigr_cpu - Per CPU entry connected to a leaf group in the hierarchy
+ * @lock:	Protection for the per cpu data
+ * @online:	Online marker vs. the timer migration functionality.
+ * @cpuevt:	Specifies the next timer event of the CPU
+ * @tmgroup:	Pointer to the leaf group to which this CPU belongs
+ */
+struct tmigr_cpu {
+	raw_spinlock_t		lock;
+	bool			online;
+	struct tmigr_event	cpuevt;
+	struct tmigr_group	*tmgroup;
+};
+
+#endif
