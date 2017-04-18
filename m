From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 04/10] timer: Keep the pinned timers separate from the
 others
Date: Tue, 18 Apr 2017 13:11:06 +0200
Message-ID: <20170418111400.679690312@linutronix.de>
References: <20170418111102.490432548@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:52274 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdDRQmm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2017 12:42:42 -0400
Content-Disposition: inline;
 filename=timer_Keep_the_pinned_timers_separate_from_the_others.patch
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>, Richard Cochran <rcochran@linutronix.de>

Seperate the storage space for pinned timers.

This is preparatory work for changing the NOHZ timer placement from a push
at enqueue time to a pull at expiry time model.

No functional change.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timer.c |   98 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 70 insertions(+), 28 deletions(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -185,12 +185,14 @@ EXPORT_SYMBOL(jiffies_64);
 #define WHEEL_SIZE	(LVL_SIZE * LVL_DEPTH)
 
 #ifdef CONFIG_NO_HZ_COMMON
-# define NR_BASES	2
-# define BASE_STD	0
-# define BASE_DEF	1
+# define NR_BASES	3
+# define BASE_LOCAL	0
+# define BASE_GLOBAL	1
+# define BASE_DEF	2
 #else
 # define NR_BASES	1
-# define BASE_STD	0
+# define BASE_LOCAL	0
+# define BASE_GLOBAL	0
 # define BASE_DEF	0
 #endif
 
@@ -218,16 +220,18 @@ void timers_update_migration(bool update
 	unsigned int cpu;
 
 	/* Avoid the loop, if nothing to update */
-	if (this_cpu_read(timer_bases[BASE_STD].migration_enabled) == on)
+	if (this_cpu_read(timer_bases[BASE_GLOBAL].migration_enabled) == on)
 		return;
 
 	for_each_possible_cpu(cpu) {
-		per_cpu(timer_bases[BASE_STD].migration_enabled, cpu) = on;
+		per_cpu(timer_bases[BASE_LOCAL].migration_enabled, cpu) = on;
+		per_cpu(timer_bases[BASE_GLOBAL].migration_enabled, cpu) = on;
 		per_cpu(timer_bases[BASE_DEF].migration_enabled, cpu) = on;
 		per_cpu(hrtimer_bases.migration_enabled, cpu) = on;
 		if (!update_nohz)
 			continue;
-		per_cpu(timer_bases[BASE_STD].nohz_active, cpu) = true;
+		per_cpu(timer_bases[BASE_LOCAL].nohz_active, cpu) = true;
+		per_cpu(timer_bases[BASE_GLOBAL].nohz_active, cpu) = true;
 		per_cpu(timer_bases[BASE_DEF].nohz_active, cpu) = true;
 		per_cpu(hrtimer_bases.nohz_active, cpu) = true;
 	}
@@ -810,7 +814,10 @@ static int detach_if_pending(struct time
 
 static inline struct timer_base *get_timer_cpu_base(u32 tflags, u32 cpu)
 {
-	struct timer_base *base = per_cpu_ptr(&timer_bases[BASE_STD], cpu);
+	int index = tflags & TIMER_PINNED ? BASE_LOCAL : BASE_GLOBAL;
+	struct timer_base *base;
+
+	base = per_cpu_ptr(&timer_bases[index], cpu);
 
 	/*
 	 * If the timer is deferrable and nohz is active then we need to use
@@ -824,7 +831,10 @@ static inline struct timer_base *get_tim
 
 static inline struct timer_base *get_timer_this_cpu_base(u32 tflags)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	int index = tflags & TIMER_PINNED ? BASE_LOCAL : BASE_GLOBAL;
+	struct timer_base *base;
+
+	base = this_cpu_ptr(&timer_bases[index]);
 
 	/*
 	 * If the timer is deferrable and nohz is active then we need to use
@@ -1468,10 +1478,10 @@ static u64 cmp_next_hrtimer_event(u64 ba
  */
 u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	unsigned long nextevt, nextevt_local, nextevt_global;
+	bool local_empty, global_empty, local_first, is_idle;
+	struct timer_base *base_local, *base_global;
 	u64 expires = KTIME_MAX;
-	unsigned long nextevt;
-	bool is_empty;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -1480,26 +1490,49 @@ u64 get_next_timer_interrupt(unsigned lo
 	if (cpu_is_offline(smp_processor_id()))
 		return expires;
 
-	spin_lock(&base->lock);
-	is_empty = __next_timer_interrupt(base);
-	nextevt = base->next_expiry;
+	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
+	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
+
+	spin_lock(&base_global->lock);
+	spin_lock_nested(&base_local->lock, SINGLE_DEPTH_NESTING);
+
+	local_empty = __next_timer_interrupt(base_local);
+	nextevt_local = base_local->next_expiry;
+
+	global_empty = __next_timer_interrupt(base_global);
+	nextevt_global = base_global->next_expiry;
+
 	/*
 	 * We have a fresh next event. Check whether we can forward the
 	 * base. We can only do that when @basej is past base->clk
 	 * otherwise we might rewind base->clk.
 	 */
-	if (time_after(basej, base->clk)) {
-		if (time_after(nextevt, basej))
-			base->clk = basej;
-		else if (time_after(nextevt, base->clk))
-			base->clk = nextevt;
+	if (time_after(basej, base_local->clk)) {
+		if (time_after(nextevt_local, basej))
+			base_local->clk = basej;
+		else if (time_after(nextevt_local, base_local->clk))
+			base_local->clk = nextevt_local;
+	}
+
+	if (time_after(basej, base_global->clk)) {
+		if (time_after(nextevt_global, basej))
+			base_global->clk = basej;
+		else if (time_after(nextevt_global, base_global->clk))
+			base_global->clk = nextevt_global;
 	}
 
 	/* Base is idle if the next event is more than a tick away. */
-	base->is_idle = time_after(nextevt, basej + 1);
-	spin_unlock(&base->lock);
+	local_first = time_before_eq(nextevt_local, nextevt_global);
+	nextevt = local_first ? nextevt_local : nextevt_global;
+	is_idle = time_after(nextevt, basej + 1);
+
+	/* We need to mark both bases in sync */
+	base_local->is_idle = base_global->is_idle = is_idle;
 
-	if (!is_empty) {
+	spin_unlock(&base_local->lock);
+	spin_unlock(&base_global->lock);
+
+	if (!local_empty || !global_empty) {
 		/* If we missed a tick already, force 0 delta */
 		if (time_before_eq(nextevt, basej))
 			nextevt = basej;
@@ -1516,7 +1549,7 @@ u64 get_next_timer_interrupt(unsigned lo
  */
 void timer_clear_idle(void)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
 
 	/*
 	 * We do this unlocked. The worst outcome is a remote enqueue sending
@@ -1525,6 +1558,9 @@ void timer_clear_idle(void)
 	 * the lock in the exit from idle path.
 	 */
 	base->is_idle = false;
+
+	base = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
+	base->is_idle = false;
 }
 
 static int collect_expired_timers(struct timer_base *base,
@@ -1614,11 +1650,17 @@ static inline void __run_timers(struct t
  */
 static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
 
 	__run_timers(base);
-	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && base->nohz_active)
-		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
+	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
+		base = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
+		__run_timers(base);
+
+		base = this_cpu_ptr(&timer_bases[BASE_DEF]);
+		if (base->nohz_active)
+			__run_timers(base);
+	}
 }
 
 /*
@@ -1626,7 +1668,7 @@ static __latent_entropy void run_timer_s
  */
 void run_local_timers(void)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
 
 	hrtimer_run_queues();
 	/* Raise the softirq only if required. */
