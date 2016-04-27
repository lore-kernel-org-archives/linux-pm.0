From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: governor: Change confusing struct field and variable names
Date: Thu, 28 Apr 2016 01:19:03 +0200
Message-ID: <2024653.a0XKPA0FXA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:57030 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752830AbcD0XQD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 19:16:03 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen Yu <yu.c.chen@intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The name of the prev_cpu_wall field in struct cpu_dbs_info is
confusing, because it doesn't represent wall time, but the previous
update time as returned by get_cpu_idle_time() (that may be the
current value of jiffies_64 in some cases, for example).

Moreover, the names of some related variables in dbs_update() take
that confusion further.

Rename all of those things to make their names reflect the purpose
more accurately.  While at it, drop unnecessary parens from one of
the updated expressions.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |   22 +++++++++++-----------
 drivers/cpufreq/cpufreq_governor.h |    2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -111,7 +111,7 @@ static inline void gov_update_sample_del
 /* Per cpu structures */
 struct cpu_dbs_info {
 	u64 prev_cpu_idle;
-	u64 prev_cpu_wall;
+	u64 prev_update_time;
 	u64 prev_cpu_nice;
 	/*
 	 * Used to keep track of load in the previous interval. However, when
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -103,7 +103,7 @@ void gov_update_cpu_data(struct dbs_data
 		for_each_cpu(j, policy_dbs->policy->cpus) {
 			struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
 
-			j_cdbs->prev_cpu_idle = get_cpu_idle_time(j, &j_cdbs->prev_cpu_wall,
+			j_cdbs->prev_cpu_idle = get_cpu_idle_time(j, &j_cdbs->prev_update_time,
 								  dbs_data->io_is_busy);
 			if (dbs_data->ignore_nice_load)
 				j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
@@ -137,14 +137,14 @@ unsigned int dbs_update(struct cpufreq_p
 	/* Get Absolute Load */
 	for_each_cpu(j, policy->cpus) {
 		struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
-		u64 cur_wall_time, cur_idle_time;
-		unsigned int idle_time, wall_time;
+		u64 update_time, cur_idle_time;
+		unsigned int idle_time, time_elapsed;
 		unsigned int load;
 
-		cur_idle_time = get_cpu_idle_time(j, &cur_wall_time, io_busy);
+		cur_idle_time = get_cpu_idle_time(j, &update_time, io_busy);
 
-		wall_time = cur_wall_time - j_cdbs->prev_cpu_wall;
-		j_cdbs->prev_cpu_wall = cur_wall_time;
+		time_elapsed = update_time - j_cdbs->prev_update_time;
+		j_cdbs->prev_update_time = update_time;
 
 		idle_time = cur_idle_time - j_cdbs->prev_cpu_idle;
 		j_cdbs->prev_cpu_idle = cur_idle_time;
@@ -156,7 +156,7 @@ unsigned int dbs_update(struct cpufreq_p
 			j_cdbs->prev_cpu_nice = cur_nice;
 		}
 
-		if (unlikely(!wall_time || wall_time < idle_time))
+		if (unlikely(!time_elapsed || time_elapsed < idle_time))
 			continue;
 
 		/*
@@ -177,7 +177,7 @@ unsigned int dbs_update(struct cpufreq_p
 		 *
 		 * Detecting this situation is easy: the governor's utilization
 		 * update handler would not have run during CPU-idle periods.
-		 * Hence, an unusually large 'wall_time' (as compared to the
+		 * Hence, an unusually large 'time_elapsed' (as compared to the
 		 * sampling rate) indicates this scenario.
 		 *
 		 * prev_load can be zero in two cases and we must recalculate it
@@ -185,7 +185,7 @@ unsigned int dbs_update(struct cpufreq_p
 		 * - during long idle intervals
 		 * - explicitly set to zero
 		 */
-		if (unlikely(wall_time > (2 * sampling_rate) &&
+		if (unlikely(time_elapsed > 2 * sampling_rate &&
 			     j_cdbs->prev_load)) {
 			load = j_cdbs->prev_load;
 
@@ -196,7 +196,7 @@ unsigned int dbs_update(struct cpufreq_p
 			 */
 			j_cdbs->prev_load = 0;
 		} else {
-			load = 100 * (wall_time - idle_time) / wall_time;
+			load = 100 * (time_elapsed - idle_time) / time_elapsed;
 			j_cdbs->prev_load = load;
 		}
 
@@ -509,7 +509,7 @@ static int cpufreq_governor_start(struct
 	for_each_cpu(j, policy->cpus) {
 		struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
 
-		j_cdbs->prev_cpu_idle = get_cpu_idle_time(j, &j_cdbs->prev_cpu_wall, io_busy);
+		j_cdbs->prev_cpu_idle = get_cpu_idle_time(j, &j_cdbs->prev_update_time, io_busy);
 		/*
 		 * Make the first invocation of dbs_update() compute the load.
 		 */

