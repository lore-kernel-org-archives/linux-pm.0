From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 05/10] timer: Retrieve next expiry of pinned/non-pinned timers
 seperately
Date: Mon, 17 Apr 2017 20:32:46 +0200
Message-ID: <20170417184356.378418394@linutronix.de>
References: <20170417183241.244217993@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:48354 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755066AbdDQSx0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 14:53:26 -0400
Content-Disposition: inline;
 filename=timer_Provide_both_pinned_and_movable_expiration_times.patch
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>, Richard Cochran <rcochran@linutronix.de>

To prepare for the conversion of the NOHZ timer placement to a pull at
expiry time model it's required to have seperate expiry times for the
pinned and the non-pinned (movable) timers.

No functional change

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/tick-internal.h |    3 ++-
 kernel/time/tick-sched.c    |   10 ++++++----
 kernel/time/timer.c         |   41 +++++++++++++++++++++++++++++++++++------
 3 files changed, 43 insertions(+), 11 deletions(-)

--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -163,5 +163,6 @@ static inline void timers_update_migrati
 
 DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
 
-extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
+extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem,
+				    u64 *global_evt);
 void timer_clear_idle(void);
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -666,7 +666,7 @@ static ktime_t tick_nohz_stop_sched_tick
 					 ktime_t now, int cpu)
 {
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
-	u64 basemono, next_tick, next_tmr, next_rcu, delta, expires;
+	u64 basemono, next_tick, next_local, next_global, next_rcu, delta, expires;
 	unsigned long seq, basejiff;
 	ktime_t	tick;
 
@@ -689,10 +689,12 @@ static ktime_t tick_nohz_stop_sched_tick
 		 * disabled this also looks at the next expiring
 		 * hrtimer.
 		 */
-		next_tmr = get_next_timer_interrupt(basejiff, basemono);
-		ts->next_timer = next_tmr;
+		next_local = get_next_timer_interrupt(basejiff, basemono,
+						      &next_global);
+		next_local = min(next_local, next_global);
+		ts->next_timer = next_local;
 		/* Take the next rcu event into account */
-		next_tick = next_rcu < next_tmr ? next_rcu : next_tmr;
+		next_tick = next_rcu < next_local ? next_rcu : next_local;
 	}
 
 	/*
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1472,23 +1472,27 @@ static u64 cmp_next_hrtimer_event(u64 ba
  * get_next_timer_interrupt - return the time (clock mono) of the next timer
  * @basej:	base time jiffies
  * @basem:	base time clock monotonic
+ * @global_evt:	Pointer to store the expiry time of the next global timer
  *
  * Returns the tick aligned clock monotonic time of the next pending
  * timer or KTIME_MAX if no timer is pending.
  */
-u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
+u64 get_next_timer_interrupt(unsigned long basej, u64 basem, u64 *global_evt)
 {
 	unsigned long nextevt, nextevt_local, nextevt_global;
 	bool local_empty, global_empty, local_first, is_idle;
 	struct timer_base *base_local, *base_global;
-	u64 expires = KTIME_MAX;
+	u64 local_evt = KTIME_MAX;
+
+	/* Preset global event */
+	*global_evt = KTIME_MAX;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
 	 * Possible pending timers will be migrated later to an active cpu.
 	 */
 	if (cpu_is_offline(smp_processor_id()))
-		return expires;
+		return local_evt;
 
 	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
 	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
@@ -1532,14 +1536,39 @@ u64 get_next_timer_interrupt(unsigned lo
 	spin_unlock(&base_local->lock);
 	spin_unlock(&base_global->lock);
 
-	if (!local_empty || !global_empty) {
+	/*
+	 * If the bases are not marked idle, i.e one of the events is at
+	 * max. one tick away, use the next event for calculating next
+	 * local expiry value. The next global event is left as KTIME_MAX,
+	 * so this CPU will not queue itself in the global expiry
+	 * mechanism.
+	 */
+	if (!is_idle) {
 		/* If we missed a tick already, force 0 delta */
 		if (time_before_eq(nextevt, basej))
 			nextevt = basej;
-		expires = basem + (nextevt - basej) * TICK_NSEC;
+		local_evt = basem + (nextevt - basej) * TICK_NSEC;
+		return cmp_next_hrtimer_event(basem, local_evt);
 	}
 
-	return cmp_next_hrtimer_event(basem, expires);
+	/*
+	 * If the bases are marked idle, i.e. the next event on both the
+	 * local and the global queue are farther away than a tick,
+	 * evaluate both bases. No need to check whether one of the bases
+	 * has an already expired timer as this is caught by the !is_idle
+	 * condition above.
+	 */
+	if (!local_empty)
+		local_evt = basem + (nextevt_local - basej) * TICK_NSEC;
+
+	/*
+	 * If the local queue expires first, there is no requirement for
+	 * queuing the CPU in the global expiry mechanism.
+	 */
+	if (!local_first && !global_empty)
+		*global_evt = basem + (nextevt_global - basej) * TICK_NSEC;
+
+	return cmp_next_hrtimer_event(basem, local_evt);
 }
 
 /**
