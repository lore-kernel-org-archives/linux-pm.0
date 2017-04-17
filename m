From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 10/10] timer: Always queue timers on the local CPU
Date: Mon, 17 Apr 2017 20:32:51 +0200
Message-ID: <20170417184356.777719959@linutronix.de>
References: <20170417183241.244217993@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=timer_Place_timers_on_the_local_CPU.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>, Richard Cochran <rcochran@linutronix.de>
List-Id: linux-pm@vger.kernel.org

The timer pull model is in place so we can remove the heuristics which try
to guess the best target CPU at enqueue/modification time.

All non pinned timers are queued on the local cpu in the seperate storage
and eventually pulled at expiry time to a remote cpu.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timer.c |   20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -857,18 +857,6 @@ static inline struct timer_base *get_tim
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
-static inline struct timer_base *
-get_target_base(struct timer_base *base, unsigned tflags)
-{
-#ifdef CONFIG_SMP
-	if ((tflags & TIMER_PINNED) || !base->migration_enabled)
-		return get_timer_this_cpu_base(tflags);
-	return get_timer_cpu_base(tflags, get_nohz_timer_target());
-#else
-	return get_timer_this_cpu_base(tflags);
-#endif
-}
-
 static inline void forward_timer_base(struct timer_base *base)
 {
 	unsigned long jnow = READ_ONCE(jiffies);
@@ -890,12 +878,6 @@ static inline void forward_timer_base(st
 		base->clk = base->next_expiry;
 }
 #else
-static inline struct timer_base *
-get_target_base(struct timer_base *base, unsigned tflags)
-{
-	return get_timer_this_cpu_base(tflags);
-}
-
 static inline void forward_timer_base(struct timer_base *base) { }
 #endif
 
@@ -985,7 +967,7 @@ static inline int
 	if (!ret && pending_only)
 		goto out_unlock;
 
-	new_base = get_target_base(base, timer->flags);
+	new_base = get_timer_this_cpu_base(timer->flags);
 
 	if (base != new_base) {
 		/*
