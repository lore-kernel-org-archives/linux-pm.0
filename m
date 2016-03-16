From: Rik van Riel <riel@redhat.com>
Subject: [PATCH] cpuidle: use high confidence factors only when considering
 polling
Date: Wed, 16 Mar 2016 12:14:00 -0400
Message-ID: <20160316121400.680a6a46@annuminas.surriel.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<CAJZ5v0jf4g7iZWDGwJ0Kc3MRNPRNFk_hmsZuk-WJRFnuC=c6sQ@mail.gmail.com>
	<1458007395.8898.19.camel@redhat.com>
	<2600831.Qfymhh5Hpv@vostro.rjw.lan>
	<1458089721.8898.25.camel@redhat.com>
	<CAJZ5v0iC2CUKRJokVL5xsbebOPzxNUzXxzo8hxRvm-Y=0v_LQg@mail.gmail.com>
	<CAJZ5v0hDGmReO9KQrofSu3K25xzP08yo+qqgLiEHejKrSXEy4w@mail.gmail.com>
	<20160316100144.75bfef53@annuminas.surriel.com>
	<CAJZ5v0iz87xKYFV_wiJgppfiCWt7uQGXyrQhoxpZ3E7GBhA5_A@mail.gmail.com>
	<1458139600.14723.29.camel@redhat.com>
	<CAJZ5v0h2YDHHt1XL3Y5UiA6dAEDtzNSOGn+Fd-ph70fhvW1AZw@mail.gmail.com>
	<1458140836.14723.30.camel@redhat.com>
	<CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39356 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbcCPQOE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Mar 2016 12:14:04 -0400
In-Reply-To: <CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

The menu governor uses five different factors to pick the
idle state:
- the user configured latency_req
- the time until the next timer (next_timer_us)
- the typical sleep interval, as measured recently
- an estimate of sleep time by dividing next_timer_us by an observed factor
- a load corrected version of the above, divided again by load

Only the first three items are known with enough confidence that
we can use them to consider polling, instead of an actual CPU
idle state, because the cost of being wrong about polling can be
excessive power use.

The latter two are used in the menu governor's main selection
loop, and can result in choosing a shallower idle state when
the system is expected to be busy again soon.

This pushes a busy system in the "performance" direction of
the performance<>power tradeoff, when choosing between idle
states, but stays more strictly on the "power" state when
deciding between polling and C1.

Signed-off-by: Rik van Riel <riel@redhat.com>
---
 drivers/cpuidle/governors/menu.c | 42 +++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 0742b3296673..fba867d917f7 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -196,7 +196,7 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev);
  * of points is below a threshold. If it is... then use the
  * average of these 8 points as the estimated value.
  */
-static void get_typical_interval(struct menu_device *data)
+static unsigned int get_typical_interval(struct menu_device *data)
 {
 	int i, divisor;
 	unsigned int max, thresh;
@@ -254,9 +254,7 @@ static void get_typical_interval(struct menu_device *data)
 		stddev = int_sqrt(stddev);
 		if (((avg > stddev * 6) && (divisor * 4 >= INTERVALS * 3))
 							|| stddev <= 20) {
-			if (data->next_timer_us > avg)
-				data->predicted_us = avg;
-			return;
+			return avg;
 		}
 	}
 
@@ -270,7 +268,7 @@ static void get_typical_interval(struct menu_device *data)
 	 * with sporadic activity with a bunch of short pauses.
 	 */
 	if ((divisor * 4) <= INTERVALS * 3)
-		return;
+		return UINT_MAX;
 
 	thresh = max - 1;
 	goto again;
@@ -287,6 +285,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 	int i;
 	unsigned int interactivity_req;
+	unsigned int expected_interval;
 	unsigned long nr_iowaiters, cpu_load;
 
 	if (data->needs_update) {
@@ -313,32 +312,39 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 					 data->correction_factor[data->bucket],
 					 RESOLUTION * DECAY);
 
-	get_typical_interval(data);
-
-	/*
-	 * Performance multiplier defines a minimum predicted idle
-	 * duration / latency ratio. Adjust the latency limit if
-	 * necessary.
-	 */
-	interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
-	if (latency_req > interactivity_req)
-		latency_req = interactivity_req;
+	expected_interval = get_typical_interval(data);
+	expected_interval = min(expected_interval, data->next_timer_us);
 
 	if (CPUIDLE_DRIVER_STATE_START > 0) {
 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
 		/*
 		 * We want to default to C1 (hlt), not to busy polling
-		 * unless the timer is happening really really soon.
+		 * unless the timer is happening really really soon, or
+		 * C1's exit latency exceeds the user configured limit.
 		 */
-		if (interactivity_req > 20 &&
+		if (expected_interval > drv->states[CPUIDLE_DRIVER_STATE_START].target_residency &&
+		    latency_req > drv->states[CPUIDLE_DRIVER_STATE_START].exit_latency &&
 		    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
-			dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
+		    !dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable)
 			data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
 	} else {
 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
 	}
 
 	/*
+	 * Use the lowest expected idle interval to pick the idle state.
+	 */
+	data->predicted_us = min(data->predicted_us, expected_interval);
+
+	/*
+	 * Use the performance multiplier and the user-configurable
+	 * latency_req to determine the maximum exit latency.
+	 */
+	interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
+	if (latency_req > interactivity_req)
+		latency_req = interactivity_req;
+
+	/*
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
 	 */

