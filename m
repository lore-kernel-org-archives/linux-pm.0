From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC] sched: cpufreq: Fix long idle judgement logic in load calculation
Date: Thu,  7 Jun 2018 11:17:34 +0800
Message-ID: <1528341454-16991-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, Artem S Tashkinov <t.artem@mailcity.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

According to current code implementation, detecting the long
idle period is done by checking if the interval between two
adjacent utilization update handers is long enough. Although
this mechanism can detect if the idle period is long enough
(no utilization hooks invoked during idle period), it might
not contain a corner case: if the task has occupied the cpu
for too long which causes no context switch during that
period, then no utilization handler will be launched until this
high prio task is switched out. As a result, the idle_periods
field might be calculated incorrectly because it regards the
100% load as 0% and makes the conservative governor who uses
this field confusing.

Change the judgement to compare the idle_time with sampling_rate
directly.

Reported-by: Artem S. Tashkinov <t.artem@mailcity.com>
Cc: Artem S Tashkinov <t.artem@mailcity.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 871bf9c..9792c80 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -165,7 +165,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 			 * calls, so the previous load value can be used then.
 			 */
 			load = j_cdbs->prev_load;
-		} else if (unlikely(time_elapsed > 2 * sampling_rate &&
+		} else if (((int)idle_time > 0) && unlikely(idle_time > 2 * sampling_rate &&
 				    j_cdbs->prev_load)) {
 			/*
 			 * If the CPU had gone completely idle and a task has
@@ -185,10 +185,8 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 			 * clear prev_load to guarantee that the load will be
 			 * computed again next time.
 			 *
-			 * Detecting this situation is easy: the governor's
-			 * utilization update handler would not have run during
-			 * CPU-idle periods.  Hence, an unusually large
-			 * 'time_elapsed' (as compared to the sampling rate)
+			 * Detecting this situation is easy: an unusually large
+			 * 'idle_time' (as compared to the sampling rate)
 			 * indicates this scenario.
 			 */
 			load = j_cdbs->prev_load;
@@ -217,8 +215,8 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 			j_cdbs->prev_load = load;
 		}
 
-		if (time_elapsed > 2 * sampling_rate) {
-			unsigned int periods = time_elapsed / sampling_rate;
+		if (((int)idle_time > 0) && (idle_time > 2 * sampling_rate)) {
+			unsigned int periods = idle_time / sampling_rate;
 
 			if (periods < idle_periods)
 				idle_periods = periods;
-- 
2.7.4
