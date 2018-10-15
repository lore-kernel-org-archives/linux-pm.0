From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] cpuidle: menu: Drop redundant comparison
Date: Mon, 15 Oct 2018 13:51:45 +0200
Message-ID: <2211415.LkLqNA7itZ@aspire.rjw.lan>
References: <9077862.OKK49htnqA@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9077862.OKK49htnqA@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since the correction factor cannot be greater than RESOLUTION * DECAY,
the result of the predicted_us computation in menu_select() cannot be
greater than data->next_timer_us, so it is not necessary to compare
the "typical interval" value coming from get_typical_interval() with
data->next_timer_us separately.

It is sufficient to copmare predicted_us with the return value of
get_typical_interval() directly, so do that and drop the now
redundant expected_interval variable.

No intentional changes of behavior.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -287,7 +287,6 @@ static int menu_select(struct cpuidle_dr
 	int i;
 	int idx;
 	unsigned int interactivity_req;
-	unsigned int expected_interval;
 	unsigned int predicted_us;
 	unsigned long nr_iowaiters, cpu_load;
 	ktime_t delta_next;
@@ -323,14 +322,10 @@ static int menu_select(struct cpuidle_dr
 	predicted_us = DIV_ROUND_CLOSEST_ULL((uint64_t)data->next_timer_us *
 					 data->correction_factor[data->bucket],
 					 RESOLUTION * DECAY);
-
-	expected_interval = get_typical_interval(data);
-	expected_interval = min(expected_interval, data->next_timer_us);
-
 	/*
 	 * Use the lowest expected idle interval to pick the idle state.
 	 */
-	predicted_us = min(predicted_us, expected_interval);
+	predicted_us = min(predicted_us, get_typical_interval(data));
 
 	if (tick_nohz_tick_stopped()) {
 		/*
