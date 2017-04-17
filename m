From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 06/10] timer: Restructure internal locking
Date: Mon, 17 Apr 2017 20:32:47 +0200
Message-ID: <20170417184356.460158385@linutronix.de>
References: <20170417183241.244217993@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=timer_Restructure_internal_locking.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>, Richard Cochran <rcochran@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Move the locking out from __run_timers() to the call sites, so the
protected section can be extended at the call site. Preparatory patch for
changing the NOHZ timer placement to a pull at expiry time model.

No functional change.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timer.c |   33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1651,17 +1651,14 @@ void update_process_times(int user_tick)
 /**
  * __run_timers - run all expired timers (if any) on this CPU.
  * @base: the timer vector to be processed.
+ *
+ * Caller must hold the base lock.
  */
 static inline void __run_timers(struct timer_base *base)
 {
 	struct hlist_head heads[LVL_DEPTH];
 	int levels;
 
-	if (!time_after_eq(jiffies, base->clk))
-		return;
-
-	spin_lock_irq(&base->lock);
-
 	while (time_after_eq(jiffies, base->clk)) {
 
 		levels = collect_expired_timers(base, heads);
@@ -1671,7 +1668,20 @@ static inline void __run_timers(struct t
 			expire_timers(base, heads + levels);
 	}
 	base->running_timer = NULL;
-	spin_unlock_irq(&base->lock);
+}
+
+static void run_timer_base(int index, bool check_nohz)
+{
+	struct timer_base *base = this_cpu_ptr(&timer_bases[index]);
+
+	if (check_nohz && !base->nohz_active)
+		return;
+
+	if (time_after_eq(jiffies, base->clk)) {
+		spin_lock_irq(&base->lock);
+		__run_timers(base);
+		spin_unlock_irq(&base->lock);
+	}
 }
 
 /*
@@ -1679,16 +1689,11 @@ static inline void __run_timers(struct t
  */
 static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
+	run_timer_base(BASE_LOCAL, false);
 
-	__run_timers(base);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
-		base = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
-		__run_timers(base);
-
-		base = this_cpu_ptr(&timer_bases[BASE_DEF]);
-		if (base->nohz_active)
-			__run_timers(base);
+		run_timer_base(BASE_GLOBAL, false);
+		run_timer_base(BASE_DEF, true);
 	}
 }
 
