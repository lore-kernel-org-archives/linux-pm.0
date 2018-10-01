From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpuidle: menu: Replace data->predicted_us with local variable
Date: Mon, 01 Oct 2018 11:56:21 +0200
Message-ID: <2889908.NE4FqvqlhV@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The predicted_us field in struct menu_device is only accessed in
menu_select(), so replace it with a local variable in that function.

With that, stop using expected_interval instead of predicted_us to
store the new predicted idle duration value if it is set to the
selected state's target residency which is quite confusing.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -124,7 +124,6 @@ struct menu_device {
 	int             tick_wakeup;
 
 	unsigned int	next_timer_us;
-	unsigned int	predicted_us;
 	unsigned int	bucket;
 	unsigned int	correction_factor[BUCKETS];
 	unsigned int	intervals[INTERVALS];
@@ -290,6 +289,7 @@ static int menu_select(struct cpuidle_dr
 	int idx;
 	unsigned int interactivity_req;
 	unsigned int expected_interval;
+	unsigned int predicted_us;
 	unsigned long nr_iowaiters, cpu_load;
 	ktime_t delta_next;
 
@@ -315,7 +315,7 @@ static int menu_select(struct cpuidle_dr
 	 * operands are 32 bits.
 	 * Make sure to round up for half microseconds.
 	 */
-	data->predicted_us = DIV_ROUND_CLOSEST_ULL((uint64_t)data->next_timer_us *
+	predicted_us = DIV_ROUND_CLOSEST_ULL((uint64_t)data->next_timer_us *
 					 data->correction_factor[data->bucket],
 					 RESOLUTION * DECAY);
 
@@ -341,7 +341,7 @@ static int menu_select(struct cpuidle_dr
 	/*
 	 * Use the lowest expected idle interval to pick the idle state.
 	 */
-	data->predicted_us = min(data->predicted_us, expected_interval);
+	predicted_us = min(predicted_us, expected_interval);
 
 	if (tick_nohz_tick_stopped()) {
 		/*
@@ -352,19 +352,18 @@ static int menu_select(struct cpuidle_dr
 		 * the known time till the closest timer event for the idle
 		 * state selection.
 		 */
-		if (data->predicted_us < TICK_USEC)
-			data->predicted_us = ktime_to_us(delta_next);
+		if (predicted_us < TICK_USEC)
+			predicted_us = ktime_to_us(delta_next);
 	} else {
 		/*
 		 * Use the performance multiplier and the user-configurable
 		 * latency_req to determine the maximum exit latency.
 		 */
-		interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
+		interactivity_req = predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
 		if (latency_req > interactivity_req)
 			latency_req = interactivity_req;
 	}
 
-	expected_interval = data->predicted_us;
 	/*
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
@@ -378,8 +377,8 @@ static int menu_select(struct cpuidle_dr
 			continue;
 		if (idx == -1)
 			idx = i; /* first enabled state */
-		if (s->target_residency > data->predicted_us) {
-			if (data->predicted_us < TICK_USEC)
+		if (s->target_residency > predicted_us) {
+			if (predicted_us < TICK_USEC)
 				break;
 
 			if (!tick_nohz_tick_stopped()) {
@@ -389,7 +388,7 @@ static int menu_select(struct cpuidle_dr
 				 * tick in that case and let the governor run
 				 * again in the next iteration of the loop.
 				 */
-				expected_interval = drv->states[idx].target_residency;
+				predicted_us = drv->states[idx].target_residency;
 				break;
 			}
 
@@ -412,7 +411,7 @@ static int menu_select(struct cpuidle_dr
 			 * expected idle duration so that the tick is retained
 			 * as long as that target residency is low enough.
 			 */
-			expected_interval = drv->states[idx].target_residency;
+			predicted_us = drv->states[idx].target_residency;
 			break;
 		}
 		idx = i;
@@ -426,7 +425,7 @@ static int menu_select(struct cpuidle_dr
 	 * expected idle duration is shorter than the tick period length.
 	 */
 	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
-	     expected_interval < TICK_USEC) && !tick_nohz_tick_stopped()) {
+	     predicted_us < TICK_USEC) && !tick_nohz_tick_stopped()) {
 		unsigned int delta_next_us = ktime_to_us(delta_next);
 
 		*stop_tick = false;
