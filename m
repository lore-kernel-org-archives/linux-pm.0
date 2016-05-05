From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: governor: Fix handling of special cases in dbs_update()
Date: Fri, 06 May 2016 01:30:37 +0200
Message-ID: <4149261.sebfWj8seH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45684 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752786AbcEEX1Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2016 19:27:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen Yu <yu.c.chen@intel.com>, Timo Valtoaho <timo.valtoaho@gmail.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

As reported in KBZ 69821:

"With CONFIG_HZ_PERIODIC=y cpu stays at the lowest frequcency 800MHz
 even if usage goes to 100%, frequency does not scale up, the governor
 in use is ondemand. Neither works conservative. Performance and
 userspace governors work as expected.

 With CONFIG_NO_HZ_IDLE or CONFIG_NO_HZ_FULL cpu scales up with ondemand
 as expected."

Analysis carried out by Chen Yu leads to the conclusion that the
observed issue is due to idle_time in dbs_update() representing a
negative number in which case the function will return 0 as the load
(unless load is greater than 0 for another CPU sharing the policy),
although that need not be the right choice.

Indeed, idle_time representing a negative number means that during
the last sampling interval the CPU was almost 100% busy on the rough
average, so 100 should be returned as the load in that case.

Modify the code accordingly and rearrange it to clarify the handling
of all of the special cases in it.  While at it, also avoid returning
zero as the load if time_elapsed is 0 (it doesn't really make sense
to return 0 then).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=69821
Tested-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Timo Valtoaho <timo.valtoaho@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |   87 +++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 36 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -156,47 +156,62 @@ unsigned int dbs_update(struct cpufreq_p
 			j_cdbs->prev_cpu_nice = cur_nice;
 		}
 
-		if (unlikely(!time_elapsed || time_elapsed < idle_time))
-			continue;
-
-		/*
-		 * If the CPU had gone completely idle, and a task just woke up
-		 * on this CPU now, it would be unfair to calculate 'load' the
-		 * usual way for this elapsed time-window, because it will show
-		 * near-zero load, irrespective of how CPU intensive that task
-		 * actually is. This is undesirable for latency-sensitive bursty
-		 * workloads.
-		 *
-		 * To avoid this, we reuse the 'load' from the previous
-		 * time-window and give this task a chance to start with a
-		 * reasonably high CPU frequency. (However, we shouldn't over-do
-		 * this copy, lest we get stuck at a high load (high frequency)
-		 * for too long, even when the current system load has actually
-		 * dropped down. So we perform the copy only once, upon the
-		 * first wake-up from idle.)
-		 *
-		 * Detecting this situation is easy: the governor's utilization
-		 * update handler would not have run during CPU-idle periods.
-		 * Hence, an unusually large 'time_elapsed' (as compared to the
-		 * sampling rate) indicates this scenario.
-		 *
-		 * prev_load can be zero in two cases and we must recalculate it
-		 * for both cases:
-		 * - during long idle intervals
-		 * - explicitly set to zero
-		 */
-		if (unlikely(time_elapsed > 2 * sampling_rate &&
-			     j_cdbs->prev_load)) {
+		if (unlikely(!time_elapsed)) {
+			/*
+			 * That can only happen when this function is called
+			 * twice in a row with a very short interval between the
+			 * calls, so the previous load value can be used then.
+			 */
 			load = j_cdbs->prev_load;
-
+		} else if (unlikely(time_elapsed > 2 * sampling_rate &&
+				    j_cdbs->prev_load)) {
 			/*
-			 * Perform a destructive copy, to ensure that we copy
-			 * the previous load only once, upon the first wake-up
-			 * from idle.
+			 * If the CPU had gone completely idle and a task has
+			 * just woken up on this CPU now, it would be unfair to
+			 * calculate 'load' the usual way for this elapsed
+			 * time-window, because it would show near-zero load,
+			 * irrespective of how CPU intensive that task actually
+			 * was. This is undesirable for latency-sensitive bursty
+			 * workloads.
+			 *
+			 * To avoid this, reuse the 'load' from the previous
+			 * time-window and give this task a chance to start with
+			 * a reasonably high CPU frequency. However, that
+			 * shouldn't be over-done, lest we get stuck at a high
+			 * load (high frequency) for too long, even when the
+			 * current system load has actually dropped down, so
+			 * clear prev_load to guarantee that the load will be
+			 * computed again next time.
+			 *
+			 * Detecting this situation is easy: the governor's
+			 * utilization update handler would not have run during
+			 * CPU-idle periods.  Hence, an unusually large
+			 * 'time_elapsed' (as compared to the sampling rate)
+			 * indicates this scenario.
 			 */
+			load = j_cdbs->prev_load;
 			j_cdbs->prev_load = 0;
 		} else {
-			load = 100 * (time_elapsed - idle_time) / time_elapsed;
+			if (time_elapsed >= idle_time) {
+				load = 100 * (time_elapsed - idle_time) / time_elapsed;
+			} else {
+				/*
+				 * That can happen if idle_time is returned by
+				 * get_cpu_idle_time_jiffy().  In that case
+				 * idle_time is roughly equal to the difference
+				 * between time_elapsed and "busy time" obtained
+				 * from CPU statistics.  Then, the "busy time"
+				 * can end up being greater than time_elapsed
+				 * (for example, if jiffies_64 and the CPU
+				 * statistics are updated by different CPUs),
+				 * so idle_time may in fact be negative.  That
+				 * means, though, that the CPU was busy all
+				 * the time (on the rough average) during the
+				 * last sampling interval and 100 can be
+				 * returned as the load.
+				 */
+				load = (int)idle_time < 0 ? 100 : 0;
+			}
 			j_cdbs->prev_load = load;
 		}
 

