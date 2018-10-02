From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 6/6] cpuidle: menu: Move the latency_req == 0 special case check
Date: Tue, 02 Oct 2018 23:47:43 +0200
Message-ID: <9002841.GWJsep0FYb@aspire.rjw.lan>
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

It is better to always update data->bucket before returning from
menu_select() so as to prevent disturbing the wakeup statistics
collected by the governor, so combine the latency_req == 0 special
check with the more general check below.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -297,19 +297,13 @@ static int menu_select(struct cpuidle_dr
 		data->needs_update = 0;
 	}
 
-	/* Special case when user has set very strict latency requirement */
-	if (unlikely(latency_req == 0)) {
-		*stop_tick = false;
-		return 0;
-	}
-
 	/* determine the expected residency time, round up */
 	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
 
 	get_iowait_load(&nr_iowaiters, &cpu_load);
 	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
 
-	if (unlikely(drv->state_count <= 1) ||
+	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
 	    ((data->next_timer_us < drv->states[1].target_residency ||
 	      latency_req < drv->states[1].exit_latency) &&
 	     !drv->states[0].disabled && !dev->states_usage[0].disable)) {
