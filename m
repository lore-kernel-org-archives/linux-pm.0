From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/6] cpuidle: menu: Compute first_idx when latency_req is known
Date: Tue, 02 Oct 2018 23:42:56 +0200
Message-ID: <2172591.2D0LTaJpaX@aspire.rjw.lan>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3510260.hvypppS8Bs@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since menu_select() can only set first_idx to 1 if the exit latency
of the second state is not greater than the latency limit, it should
first determine that limit.  Thus first_idx should be computed after
the "interactivity" factor has been taken into account.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -322,22 +322,6 @@ static int menu_select(struct cpuidle_dr
 	expected_interval = get_typical_interval(data);
 	expected_interval = min(expected_interval, data->next_timer_us);
 
-	first_idx = 0;
-	if (drv->states[0].flags & CPUIDLE_FLAG_POLLING) {
-		struct cpuidle_state *s = &drv->states[1];
-		unsigned int polling_threshold;
-
-		/*
-		 * Default to a physical idle state, not to busy polling, unless
-		 * a timer is going to trigger really really soon.
-		 */
-		polling_threshold = max_t(unsigned int, 20, s->target_residency);
-		if (data->next_timer_us > polling_threshold &&
-		    latency_req > s->exit_latency && !s->disabled &&
-		    !dev->states_usage[1].disable)
-			first_idx = 1;
-	}
-
 	/*
 	 * Use the lowest expected idle interval to pick the idle state.
 	 */
@@ -364,6 +348,22 @@ static int menu_select(struct cpuidle_dr
 			latency_req = interactivity_req;
 	}
 
+	first_idx = 0;
+	if (drv->states[0].flags & CPUIDLE_FLAG_POLLING) {
+		struct cpuidle_state *s = &drv->states[1];
+		unsigned int polling_threshold;
+
+		/*
+		 * Default to a physical idle state, not to busy polling, unless
+		 * a timer is going to trigger really really soon.
+		 */
+		polling_threshold = max_t(unsigned int, 20, s->target_residency);
+		if (data->next_timer_us > polling_threshold &&
+		    latency_req > s->exit_latency && !s->disabled &&
+		    !dev->states_usage[1].disable)
+			first_idx = 1;
+	}
+
 	/*
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
