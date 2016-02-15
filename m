From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/9] cpufreq: governor: Clean up load-related computations
Date: Mon, 15 Feb 2016 02:18:48 +0100
Message-ID: <1482979.EeN5cMzyR7@vostro.rjw.lan>
References: <3329748.lhJgppdTt9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3329748.lhJgppdTt9@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Clean up some load-related computations in dbs_check_cpu() and
cpufreq_governor_start() to get rid of unnecessary operations and
type casts and make the code easier to read.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -186,16 +186,15 @@ void dbs_check_cpu(struct cpufreq_policy
 			io_busy = od_tuners->io_is_busy;
 		cur_idle_time = get_cpu_idle_time(j, &cur_wall_time, io_busy);
 
-		wall_time = (unsigned int)
-			(cur_wall_time - j_cdbs->prev_cpu_wall);
+		wall_time = cur_wall_time - j_cdbs->prev_cpu_wall;
 		j_cdbs->prev_cpu_wall = cur_wall_time;
 
-		if (cur_idle_time < j_cdbs->prev_cpu_idle)
-			cur_idle_time = j_cdbs->prev_cpu_idle;
-
-		idle_time = (unsigned int)
-			(cur_idle_time - j_cdbs->prev_cpu_idle);
-		j_cdbs->prev_cpu_idle = cur_idle_time;
+		if (cur_idle_time <= j_cdbs->prev_cpu_idle) {
+			idle_time = 0;
+		} else {
+			idle_time = cur_idle_time - j_cdbs->prev_cpu_idle;
+			j_cdbs->prev_cpu_idle = cur_idle_time;
+		}
 
 		if (ignore_nice) {
 			u64 cur_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
@@ -571,13 +570,10 @@ static int cpufreq_governor_start(struct
 		struct cpu_dbs_info *j_cdbs = gov->get_cpu_cdbs(j);
 		unsigned int prev_load;
 
-		j_cdbs->prev_cpu_idle =
-			get_cpu_idle_time(j, &j_cdbs->prev_cpu_wall, io_busy);
+		j_cdbs->prev_cpu_idle = get_cpu_idle_time(j, &j_cdbs->prev_cpu_wall, io_busy);
 
-		prev_load = (unsigned int)(j_cdbs->prev_cpu_wall -
-					    j_cdbs->prev_cpu_idle);
-		j_cdbs->prev_load = 100 * prev_load /
-				    (unsigned int)j_cdbs->prev_cpu_wall;
+		prev_load = j_cdbs->prev_cpu_wall - j_cdbs->prev_cpu_idle;
+		j_cdbs->prev_load = 100 * prev_load / j_cdbs->prev_cpu_wall;
 
 		if (ignore_nice)
 			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
