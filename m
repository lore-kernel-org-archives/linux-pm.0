From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3] cpuidle: menu: Handle stopped tick more aggressively
Date: Fri, 10 Aug 2018 13:15:58 +0200
Message-ID: <1754612.IcCR94pSYR@aspire.rjw.lan>
References: <1951009.1jlQfyrxio@aspire.rjw.lan> <3174357.2tBMdxG3bF@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3174357.2tBMdxG3bF@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Leo Yan <leo.yan@linaro.org>, Frederic Weisbecker <frederic@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states
with stopped tick) missed the case when the target residencies of
deep idle states of CPUs are above the tick boundary which may cause
the CPU to get stuck in a shallow idle state for a long time.

Say there are two CPU idle states available: one shallow, with the
target residency much below the tick boundary and one deep, with
the target residency significantly above the tick boundary.  In
that case, if the tick has been stopped already and the expected
next timer event is relatively far in the future, the governor will
assume the idle duration to be equal to TICK_USEC and it will select
the idle state for the CPU accordingly.  However, that will cause the
shallow state to be selected even though it would have been more
energy-efficient to select the deep one.

To address this issue, modify the governor to always assume idle
duration to be equal to the time till the closest timer event if
the tick is not running which will cause the selected idle states
to always match the known CPU wakeup time.

Also make it always indicate that the tick should be stopped in
that case for consistency.

Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
Reported-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: Initialize first_idx properly in the stopped tick case.

-> v3: Compute data->bucket before checking whether or not the tick has been
       stopped already to prevent it from becoming stale.

---
 drivers/cpuidle/governors/menu.c |   55 +++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -285,9 +285,8 @@ static int menu_select(struct cpuidle_dr
 {
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
 	int latency_req = cpuidle_governor_latency_req(dev->cpu);
-	int i;
-	int first_idx;
-	int idx;
+	int first_idx = 0;
+	int idx, i;
 	unsigned int interactivity_req;
 	unsigned int expected_interval;
 	unsigned long nr_iowaiters, cpu_load;
@@ -311,6 +310,18 @@ static int menu_select(struct cpuidle_dr
 	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
 
 	/*
+	 * If the tick is already stopped, the cost of possible short idle
+	 * duration misprediction is much higher, because the CPU may be stuck
+	 * in a shallow idle state for a long time as a result of it.  In that
+	 * case say we might mispredict and use the known time till the closest
+	 * timer event for the idle state selection.
+	 */
+	if (tick_nohz_tick_stopped()) {
+		data->predicted_us = ktime_to_us(delta_next);
+		goto select;
+	}
+
+	/*
 	 * Force the result of multiplication to be 64 bits even if both
 	 * operands are 32 bits.
 	 * Make sure to round up for half microseconds.
@@ -322,7 +333,6 @@ static int menu_select(struct cpuidle_dr
 	expected_interval = get_typical_interval(data);
 	expected_interval = min(expected_interval, data->next_timer_us);
 
-	first_idx = 0;
 	if (drv->states[0].flags & CPUIDLE_FLAG_POLLING) {
 		struct cpuidle_state *s = &drv->states[1];
 		unsigned int polling_threshold;
@@ -344,29 +354,15 @@ static int menu_select(struct cpuidle_dr
 	 */
 	data->predicted_us = min(data->predicted_us, expected_interval);
 
-	if (tick_nohz_tick_stopped()) {
-		/*
-		 * If the tick is already stopped, the cost of possible short
-		 * idle duration misprediction is much higher, because the CPU
-		 * may be stuck in a shallow idle state for a long time as a
-		 * result of it.  In that case say we might mispredict and try
-		 * to force the CPU into a state for which we would have stopped
-		 * the tick, unless a timer is going to expire really soon
-		 * anyway.
-		 */
-		if (data->predicted_us < TICK_USEC)
-			data->predicted_us = min_t(unsigned int, TICK_USEC,
-						   ktime_to_us(delta_next));
-	} else {
-		/*
-		 * Use the performance multiplier and the user-configurable
-		 * latency_req to determine the maximum exit latency.
-		 */
-		interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
-		if (latency_req > interactivity_req)
-			latency_req = interactivity_req;
-	}
+	/*
+	 * Use the performance multiplier and the user-configurable latency_req
+	 * to determine the maximum exit latency.
+	 */
+	interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
+	if (latency_req > interactivity_req)
+		latency_req = interactivity_req;
 
+select:
 	expected_interval = data->predicted_us;
 	/*
 	 * Find the idle state with the lowest power while satisfying
@@ -403,14 +399,13 @@ static int menu_select(struct cpuidle_dr
 	 * Don't stop the tick if the selected state is a polling one or if the
 	 * expected idle duration is shorter than the tick period length.
 	 */
-	if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
-	    expected_interval < TICK_USEC) {
+	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
+	    expected_interval < TICK_USEC) && !tick_nohz_tick_stopped()) {
 		unsigned int delta_next_us = ktime_to_us(delta_next);
 
 		*stop_tick = false;
 
-		if (!tick_nohz_tick_stopped() && idx > 0 &&
-		    drv->states[idx].target_residency > delta_next_us) {
+		if (idx > 0 && drv->states[idx].target_residency > delta_next_us) {
 			/*
 			 * The tick is not going to be stopped and the target
 			 * residency of the state to be returned is not within
