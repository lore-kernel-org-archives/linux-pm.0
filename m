From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH v3 3/6] sched: idle: Do not stop the tick before cpuidle_idle_call()
Date: Fri, 09 Mar 2018 10:39:27 +0100
Message-ID: <1731836.ePJh9sqWU9@aspire.rjw.lan>
References: <2450532.XN8DODrtDf@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2450532.XN8DODrtDf@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make cpuidle_idle_call() decide whether or not to stop the tick.

First, the cpuidle_enter_s2idle() path deals with the tick (and with
the entire timekeeping for that matter) by itself and it doesn't need
the tick to be stopped beforehand.

Second, to address the issue with short idle duration predictions
by the idle governor after the tick has been stopped, it will be
necessary to change the ordering of cpuidle_select() with respect
to tick_nohz_idle_stop_tick().  To prepare for that, put a
tick_nohz_idle_stop_tick() call in the same branch in which
cpuidle_select() is called.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/idle.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -146,13 +146,15 @@ static void cpuidle_idle_call(void)
 	}
 
 	/*
-	 * Tell the RCU framework we are entering an idle section,
-	 * so no more rcu read side critical sections and one more
+	 * The RCU framework needs to be told that we are entering an idle
+	 * section, so no more rcu read side critical sections and one more
 	 * step to the grace period
 	 */
-	rcu_idle_enter();
 
 	if (cpuidle_not_available(drv, dev)) {
+		tick_nohz_idle_stop_tick();
+		rcu_idle_enter();
+
 		default_idle_call();
 		goto exit_idle;
 	}
@@ -169,16 +171,26 @@ static void cpuidle_idle_call(void)
 
 	if (idle_should_enter_s2idle() || dev->use_deepest_state) {
 		if (idle_should_enter_s2idle()) {
+			rcu_idle_enter();
+
 			entered_state = cpuidle_enter_s2idle(drv, dev);
 			if (entered_state > 0) {
 				local_irq_enable();
 				goto exit_idle;
 			}
+
+			rcu_idle_exit();
 		}
 
+		tick_nohz_idle_stop_tick();
+		rcu_idle_enter();
+
 		next_state = cpuidle_find_deepest_state(drv, dev);
 		call_cpuidle(drv, dev, next_state);
 	} else {
+		tick_nohz_idle_stop_tick();
+		rcu_idle_enter();
+
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
 		 */
@@ -241,12 +253,11 @@ static void do_idle(void)
 		 * broadcast device expired for us, we don't want to go deep
 		 * idle as we know that the IPI is going to arrive right away.
 		 */
-		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
+		if (cpu_idle_force_poll || tick_check_broadcast_expired())
 			cpu_idle_poll();
-		} else {
-			tick_nohz_idle_stop_tick();
+		else
 			cpuidle_idle_call();
-		}
+
 		arch_cpu_idle_exit();
 	}
 
