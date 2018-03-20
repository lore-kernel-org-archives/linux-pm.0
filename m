From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFT][PATCH v7 8/8] cpuidle: menu: Avoid selecting shallow states with stopped tick
Date: Tue, 20 Mar 2018 16:47:09 +0100
Message-ID: <2317533.DCFkBeZAbT@aspire.rjw.lan>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2390019.oHdSGtR3EE@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the scheduler tick has been stopped already and the governor
selects a shallow idle state, the CPU can spend a long time in that
state if the selection is based on an inaccurate prediction of idle
time.  That effect turns out to be relevant, so it needs to be
mitigated.

To that end, modify the menu governor to discard the result of the
idle time prediction if the tick is stopped and the predicted idle
time is less than the tick period length, unless the tick timer is
going to expire soon.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v5 -> v7:
  * Rebase on top of the new [5-7/8].

Note that the problem tackled here may be addressed in a couple of other
ways in principle.

---
 drivers/cpuidle/governors/menu.c |   29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -352,13 +352,28 @@ static int menu_select(struct cpuidle_dr
 	 */
 	data->predicted_us = min(data->predicted_us, expected_interval);
 
-	/*
-	 * Use the performance multiplier and the user-configurable
-	 * latency_req to determine the maximum exit latency.
-	 */
-	interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
-	if (latency_req > interactivity_req)
-		latency_req = interactivity_req;
+	if (tick_nohz_tick_stopped()) {
+		/*
+		 * If the tick is already stopped, the cost of possible short
+		 * idle duration misprediction is much higher, because the CPU
+		 * may be stuck in a shallow idle state for a long time as a
+		 * result of it.  In that case say we might mispredict and try
+		 * to force the CPU into a state for which we would have stopped
+		 * the tick, unless the tick timer is going to expire really
+		 * soon anyway.
+		 */
+		if (data->predicted_us < TICK_USEC)
+			data->predicted_us = min_t(unsigned int, TICK_USEC,
+						   ktime_to_us(delta_next));
+	} else {
+		/*
+		 * Use the performance multiplier and the user-configurable
+		 * latency_req to determine the maximum exit latency.
+		 */
+		interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
+		if (latency_req > interactivity_req)
+			latency_req = interactivity_req;
+	}
 
 	expected_interval = data->predicted_us;
 	/*
