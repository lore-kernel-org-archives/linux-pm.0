From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/4] sched / idle: Eliminate the "reflect" check from cpuidle_idle_call()
Date: Mon, 04 May 2015 15:57:53 +0200
Message-ID: <1728148.BeERL39LLY@vostro.rjw.lan>
References: <3084951.QaIkFrZ3VU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52746 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752417AbbEDNeI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 09:34:08 -0400
In-Reply-To: <3084951.QaIkFrZ3VU@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since cpuidle_reflect() should only be called if the idle state
to enter was selected by cpuidle_select(), there is the "reflect"
variable in cpuidle_idle_call() whose value is used to determine
whether or not that is the case.

However, if the entire code run between the conditional setting
"reflect" and the call to cpuidle_reflect() is moved to a separate
function, it will be possible to call that new function in both
branches of the conditional, in which case cpuidle_reflect() will
only need to be called from one of them too and the "reflect"
variable won't be necessary any more.

This eliminates one check made by cpuidle_idle_call() on the majority
of its invocations, so change the code as described.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/idle.c |   90 ++++++++++++++++++++++++++--------------------------
 1 file changed, 46 insertions(+), 44 deletions(-)

Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -78,6 +78,46 @@ static void default_idle_call(void) {
 		arch_cpu_idle();
 }
 
+static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+		      int next_state)
+{
+	int entered_state;
+
+	/* Fall back to the default arch idle method on errors. */
+	if (next_state < 0) {
+		default_idle_call();
+		return next_state;
+	}
+
+	/*
+	 * The idle task must be scheduled, it is pointless to go to idle, just
+	 * update no idle residency and return.
+	 */
+	if (current_clr_polling_and_test()) {
+		dev->last_residency = 0;
+		local_irq_enable();
+		return -EBUSY;
+	}
+
+	/* Take note of the planned idle state. */
+	idle_set_state(this_rq(), &drv->states[next_state]);
+
+	/*
+	 * Enter the idle state previously returned by the governor decision.
+	 * This function will block until an interrupt occurs and will take
+	 * care of re-enabling the local interrupts
+	 */
+	entered_state = cpuidle_enter(drv, dev, next_state);
+
+	/* The cpu is no longer idle or about to enter idle. */
+	idle_set_state(this_rq(), NULL);
+
+	if (entered_state == -EBUSY)
+		default_idle_call();
+
+	return entered_state;
+}
+
 /**
  * cpuidle_idle_call - the main idle function
  *
@@ -92,7 +132,6 @@ static void cpuidle_idle_call(void)
 	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
 	int next_state, entered_state;
-	bool reflect;
 
 	/*
 	 * Check if the idle task must be rescheduled. If it is the
@@ -137,56 +176,19 @@ static void cpuidle_idle_call(void)
 			goto exit_idle;
 		}
 
-		reflect = false;
 		next_state = cpuidle_find_deepest_state(drv, dev);
+		call_cpuidle(drv, dev, next_state);
 	} else {
-		reflect = true;
 		/*
 		 * Ask the cpuidle framework to choose a convenient idle state.
 		 */
 		next_state = cpuidle_select(drv, dev);
-	}
-	/* Fall back to the default arch idle method on errors. */
-	if (next_state < 0) {
-		default_idle_call();
-		goto exit_idle;
-	}
-
-	/*
-	 * The idle task must be scheduled, it is pointless to
-	 * go to idle, just update no idle residency and get
-	 * out of this function
-	 */
-	if (current_clr_polling_and_test()) {
-		dev->last_residency = 0;
-		entered_state = next_state;
-		local_irq_enable();
-		goto exit_idle;
-	}
-
-	/* Take note of the planned idle state. */
-	idle_set_state(this_rq(), &drv->states[next_state]);
-
-	/*
-	 * Enter the idle state previously returned by the governor decision.
-	 * This function will block until an interrupt occurs and will take
-	 * care of re-enabling the local interrupts
-	 */
-	entered_state = cpuidle_enter(drv, dev, next_state);
-
-	/* The cpu is no longer idle or about to enter idle. */
-	idle_set_state(this_rq(), NULL);
-
-	if (entered_state == -EBUSY) {
-		default_idle_call();
-		goto exit_idle;
-	}
-
-	/*
-	 * Give the governor an opportunity to reflect on the outcome
-	 */
-	if (reflect)
+		entered_state = call_cpuidle(drv, dev, next_state);
+		/*
+		 * Give the governor an opportunity to reflect on the outcome
+		 */
 		cpuidle_reflect(dev, entered_state);
+	}
 
 exit_idle:
 	__current_set_polling();

