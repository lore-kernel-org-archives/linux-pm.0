From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 03/10] timers: Rework idle logic
Date: Mon, 17 Apr 2017 20:32:44 +0200
Message-ID: <20170417184356.210595106@linutronix.de>
References: <20170417183241.244217993@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=timers--Rework-idle-logic.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>
List-Id: linux-pm@vger.kernel.org

Storing next event and determining whether the base is idle can be done in
__next_timer_interrupt(). 

Preparatory patch for new call sites which need this information as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timer.c |   43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1358,8 +1358,11 @@ static int next_pending_bucket(struct ti
 /*
  * Search the first expiring timer in the various clock levels. Caller must
  * hold base->lock.
+ *
+ * Stores the next expiry time in base. The return value indicates whether
+ * the base is empty or not.
  */
-static unsigned long __next_timer_interrupt(struct timer_base *base)
+static bool __next_timer_interrupt(struct timer_base *base)
 {
 	unsigned long clk, next, adj;
 	unsigned lvl, offset = 0;
@@ -1416,7 +1419,10 @@ static unsigned long __next_timer_interr
 		clk >>= LVL_CLK_SHIFT;
 		clk += adj;
 	}
-	return next;
+	/* Store the next event in the base */
+	base->next_expiry = next;
+	/* Return whether the base is empty or not */
+	return next == base->clk + NEXT_TIMER_MAX_DELTA;
 }
 
 /*
@@ -1465,7 +1471,7 @@ u64 get_next_timer_interrupt(unsigned lo
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 	u64 expires = KTIME_MAX;
 	unsigned long nextevt;
-	bool is_max_delta;
+	bool is_empty;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -1475,9 +1481,8 @@ u64 get_next_timer_interrupt(unsigned lo
 		return expires;
 
 	spin_lock(&base->lock);
-	nextevt = __next_timer_interrupt(base);
-	is_max_delta = (nextevt == base->clk + NEXT_TIMER_MAX_DELTA);
-	base->next_expiry = nextevt;
+	is_empty = __next_timer_interrupt(base);
+	nextevt = base->next_expiry;
 	/*
 	 * We have a fresh next event. Check whether we can forward the
 	 * base. We can only do that when @basej is past base->clk
@@ -1490,20 +1495,17 @@ u64 get_next_timer_interrupt(unsigned lo
 			base->clk = nextevt;
 	}
 
-	if (time_before_eq(nextevt, basej)) {
-		expires = basem;
-		base->is_idle = false;
-	} else {
-		if (!is_max_delta)
-			expires = basem + (nextevt - basej) * TICK_NSEC;
-		/*
-		 * If we expect to sleep more than a tick, mark the base idle:
-		 */
-		if ((expires - basem) > TICK_NSEC)
-			base->is_idle = true;
-	}
+	/* Base is idle if the next event is more than a tick away. */
+	base->is_idle = time_after(nextevt, basej + 1);
 	spin_unlock(&base->lock);
 
+	if (!is_empty) {
+		/* If we missed a tick already, force 0 delta */
+		if (time_before_eq(nextevt, basej))
+			nextevt = basej;
+		expires = basem + (nextevt - basej) * TICK_NSEC;
+	}
+
 	return cmp_next_hrtimer_event(basem, expires);
 }
 
@@ -1534,7 +1536,10 @@ static int collect_expired_timers(struct
 	 * the next expiring timer.
 	 */
 	if ((long)(jiffies - base->clk) > 2) {
-		unsigned long next = __next_timer_interrupt(base);
+		unsigned long next;
+
+		__next_timer_interrupt(base);
+		next = base->next_expiry;
 
 		/*
 		 * If the next timer is ahead of time forward to current
