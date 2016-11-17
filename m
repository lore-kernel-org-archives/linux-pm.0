From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [RFC][PATCH] cpufreq: governor: Change the calculation of load for
 deferred updates
Date: Thu, 17 Nov 2016 21:54:14 +0200
Message-ID: <4f7f7d9e-4b6b-a9f8-bf54-a6d99bd952c6@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.semaphore.gr ([138.201.185.188]:56450 "EHLO
        mail.semaphore.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbcKQTyW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2016 14:54:22 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Commit 18b46abd0009 ("cpufreq: governor: Be friendly towards latency-
sensitive bursty workloads"), introduced a method to copy the calculated
load from the previous sampling period in case of a deferred timer
(update).

This helps on bursty workloads but generally coping the load for the
previous measurement could be arbitrary, because of the possibly different
nature of the new workload.

Instead of coping the load from the previous period we can calculate the
load considering that between the two samples, the busy time is comparable
to one sampling period. Thus:

 busy = time_elapsed - idle_time

and

 load = 100 * busy / sampling_rate;

Also, remove the 'unlikely' hint because it seems that a deferred update
is a very common case on most modern systems.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/cpufreq_governor.c | 37 +++++++++++++++----------------------
 drivers/cpufreq/cpufreq_governor.h |  7 +------
 2 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 0196467..8675180 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -163,25 +163,17 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 			 * calls, so the previous load value can be used then.
 			 */
 			load = j_cdbs->prev_load;
-		} else if (unlikely(time_elapsed > 2 * sampling_rate &&
-				    j_cdbs->prev_load)) {
+		} else if (time_elapsed > 2 * sampling_rate) {
+			unsigned int busy, periods;
+
 			/*
 			 * If the CPU had gone completely idle and a task has
 			 * just woken up on this CPU now, it would be unfair to
 			 * calculate 'load' the usual way for this elapsed
 			 * time-window, because it would show near-zero load,
 			 * irrespective of how CPU intensive that task actually
-			 * was. This is undesirable for latency-sensitive bursty
-			 * workloads.
-			 *
-			 * To avoid this, reuse the 'load' from the previous
-			 * time-window and give this task a chance to start with
-			 * a reasonably high CPU frequency. However, that
-			 * shouldn't be over-done, lest we get stuck at a high
-			 * load (high frequency) for too long, even when the
-			 * current system load has actually dropped down, so
-			 * clear prev_load to guarantee that the load will be
-			 * computed again next time.
+			 * was. This is undesirable, so we can safely consider
+			 * that the CPU is busy only in the last sampling period
 			 *
 			 * Detecting this situation is easy: the governor's
 			 * utilization update handler would not have run during
@@ -189,8 +181,16 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 			 * 'time_elapsed' (as compared to the sampling rate)
 			 * indicates this scenario.
 			 */
-			load = j_cdbs->prev_load;
-			j_cdbs->prev_load = 0;
+			busy = time_elapsed - idle_time;
+			if (busy > sampling_rate)
+				load = 100;
+			else
+				load = 100 * busy / sampling_rate;
+			j_cdbs->prev_load = load;
+
+			periods = time_elapsed / sampling_rate;
+			if (periods < idle_periods)
+				idle_periods = periods;
 		} else {
 			if (time_elapsed >= idle_time) {
 				load = 100 * (time_elapsed - idle_time) / time_elapsed;
@@ -215,13 +215,6 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 			j_cdbs->prev_load = load;
 		}

-		if (time_elapsed > 2 * sampling_rate) {
-			unsigned int periods = time_elapsed / sampling_rate;
-
-			if (periods < idle_periods)
-				idle_periods = periods;
-		}
-
 		if (load > max_load)
 			max_load = load;
 	}
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index f5717ca..e068a31 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -114,12 +114,7 @@ struct cpu_dbs_info {
 	u64 prev_cpu_idle;
 	u64 prev_update_time;
 	u64 prev_cpu_nice;
-	/*
-	 * Used to keep track of load in the previous interval. However, when
-	 * explicitly set to zero, it is used as a flag to ensure that we copy
-	 * the previous load to the current interval only once, upon the first
-	 * wake-up from idle.
-	 */
+	/* Used to keep track of load in the previous interval. */
 	unsigned int prev_load;
 	struct update_util_data update_util;
 	struct policy_dbs_info *policy_dbs;
-- 
2.7.4
