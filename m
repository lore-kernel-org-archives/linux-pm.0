From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH 3/7] sched: idle: Do not stop the tick before cpuidle_idle_call()
Date: Sun, 04 Mar 2018 23:24:59 +0100
Message-ID: <2758947.CLJWixMePE@aspire.rjw.lan>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make cpuidle_idle_call() decide whether or not to stop the tick.

First, there are code paths in cpuidle_idle_call() that don't need
the tick to be stopped.  In particular, the cpuidle_enter_s2idle()
path deals with the tick (and with the entire timekeeping for that
matter) by itself and it doesn't need the tick to be stopped
beforehand.

Second, to address the issue with short idle duration predictions
by the idle governor after the tick has been stopped, it will be
necessary to change the ordering of some governor code with respect
to some code in tick_nohz_idle_go_idle().  For this purpose, call
tick_nohz_idle_go_idle() in the same branch as cpuidle_select().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/idle.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -146,13 +146,14 @@ static void cpuidle_idle_call(void)
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
+		tick_nohz_idle_go_idle(false);
+		rcu_idle_enter();
 		default_idle_call();
 		goto exit_idle;
 	}
@@ -169,6 +170,9 @@ static void cpuidle_idle_call(void)
 
 	if (idle_should_enter_s2idle() || dev->use_deepest_state) {
 		if (idle_should_enter_s2idle()) {
+			tick_nohz_idle_go_idle(false);
+			rcu_idle_enter();
+
 			entered_state = cpuidle_enter_s2idle(drv, dev);
 			if (entered_state > 0) {
 				local_irq_enable();
@@ -176,9 +180,15 @@ static void cpuidle_idle_call(void)
 			}
 		}
 
+		tick_nohz_idle_go_idle(true);
+		rcu_idle_enter();
+
 		next_state = cpuidle_find_deepest_state(drv, dev);
 		call_cpuidle(drv, dev, next_state);
 	} else {
+		tick_nohz_idle_go_idle(true);
+		rcu_idle_enter();
+
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
 		 */
@@ -248,7 +258,6 @@ static void do_idle(void)
 			tick_nohz_idle_go_idle(false);
 			cpu_idle_poll();
 		} else {
-			tick_nohz_idle_go_idle(true);
 			cpuidle_idle_call();
 		}
 		arch_cpu_idle_exit();
