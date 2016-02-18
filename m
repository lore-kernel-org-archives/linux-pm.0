From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/12] cpufreq: governor: Move io_is_busy to struct dbs_data
Date: Thu, 18 Feb 2016 02:20:13 +0100
Message-ID: <291154692.LHGJ2D0EYz@vostro.rjw.lan>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2938006.67J0esUvOA@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The io_is_busy governor tunable is only used by the ondemand governor
and is located in the ondemand-specific data structure, but it is
looked at by the common governor code that has to do ugly things to
get to that value, so move it to struct dbs_data and modify ondemand
accordingly.

Since the conservative governor never touches that field, it will
be always 0 for that governor and it won't have any effect on the
results of computations in that case.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |   27 +++++++++------------------
 drivers/cpufreq/cpufreq_governor.h |    2 +-
 drivers/cpufreq/cpufreq_ondemand.c |   12 +++++-------
 3 files changed, 15 insertions(+), 26 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -137,10 +137,9 @@ unsigned int dbs_update(struct cpufreq_p
 	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
-	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	unsigned int ignore_nice = dbs_data->ignore_nice_load;
 	unsigned int max_load = 0;
-	unsigned int sampling_rate, j;
+	unsigned int sampling_rate, io_busy, j;
 
 	/*
 	 * Sometimes governors may use an additional multiplier to increase
@@ -149,6 +148,12 @@ unsigned int dbs_update(struct cpufreq_p
 	 * conservative.
 	 */
 	sampling_rate = dbs_data->sampling_rate * policy_dbs->rate_mult;
+	/*
+	 * For the purpose of ondemand, waiting for disk IO is an indication
+	 * that you're performance critical, and not that the system is actually
+	 * idle, so do not add the iowait time to the CPU idle time then.
+	 */
+	io_busy = dbs_data->io_is_busy;
 
 	/* Get Absolute Load */
 	for_each_cpu(j, policy->cpus) {
@@ -156,18 +161,9 @@ unsigned int dbs_update(struct cpufreq_p
 		u64 cur_wall_time, cur_idle_time;
 		unsigned int idle_time, wall_time;
 		unsigned int load;
-		int io_busy = 0;
 
 		j_cdbs = gov->get_cpu_cdbs(j);
 
-		/*
-		 * For the purpose of ondemand, waiting for disk IO is
-		 * an indication that you're performance critical, and
-		 * not that the system is actually idle. So do not add
-		 * the iowait time to the cpu idle time.
-		 */
-		if (gov->governor == GOV_ONDEMAND)
-			io_busy = od_tuners->io_is_busy;
 		cur_idle_time = get_cpu_idle_time(j, &cur_wall_time, io_busy);
 
 		wall_time = cur_wall_time - j_cdbs->prev_cpu_wall;
@@ -522,7 +518,7 @@ static int cpufreq_governor_start(struct
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	unsigned int sampling_rate, ignore_nice, j, cpu = policy->cpu;
-	int io_busy = 0;
+	unsigned int io_busy;
 
 	if (!policy->cur)
 		return -EINVAL;
@@ -532,12 +528,7 @@ static int cpufreq_governor_start(struct
 
 	sampling_rate = dbs_data->sampling_rate;
 	ignore_nice = dbs_data->ignore_nice_load;
-
-	if (gov->governor == GOV_ONDEMAND) {
-		struct od_dbs_tuners *od_tuners = dbs_data->tuners;
-
-		io_busy = od_tuners->io_is_busy;
-	}
+	io_busy = dbs_data->io_is_busy;
 
 	for_each_cpu(j, policy->cpus) {
 		struct cpu_dbs_info *j_cdbs = gov->get_cpu_cdbs(j);
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -71,6 +71,7 @@ struct dbs_data {
 	unsigned int sampling_rate;
 	unsigned int sampling_down_factor;
 	unsigned int up_threshold;
+	unsigned int io_is_busy;
 
 	struct kobject kobj;
 	struct list_head policy_dbs_list;
@@ -177,7 +178,6 @@ struct cs_cpu_dbs_info_s {
 /* Per policy Governors sysfs tunables */
 struct od_dbs_tuners {
 	unsigned int powersave_bias;
-	unsigned int io_is_busy;
 };
 
 struct cs_dbs_tuners {
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -220,7 +220,6 @@ static struct dbs_governor od_dbs_gov;
 static ssize_t store_io_is_busy(struct dbs_data *dbs_data, const char *buf,
 		size_t count)
 {
-	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	unsigned int input;
 	int ret;
 	unsigned int j;
@@ -228,14 +227,14 @@ static ssize_t store_io_is_busy(struct d
 	ret = sscanf(buf, "%u", &input);
 	if (ret != 1)
 		return -EINVAL;
-	od_tuners->io_is_busy = !!input;
+	dbs_data->io_is_busy = !!input;
 
 	/* we need to re-evaluate prev_cpu_idle */
 	for_each_online_cpu(j) {
 		struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info,
 									j);
 		dbs_info->cdbs.prev_cpu_idle = get_cpu_idle_time(j,
-			&dbs_info->cdbs.prev_cpu_wall, od_tuners->io_is_busy);
+			&dbs_info->cdbs.prev_cpu_wall, dbs_data->io_is_busy);
 	}
 	return count;
 }
@@ -286,7 +285,6 @@ static ssize_t store_sampling_down_facto
 static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
 		const char *buf, size_t count)
 {
-	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	unsigned int input;
 	int ret;
 
@@ -309,7 +307,7 @@ static ssize_t store_ignore_nice_load(st
 		struct od_cpu_dbs_info_s *dbs_info;
 		dbs_info = &per_cpu(od_cpu_dbs_info, j);
 		dbs_info->cdbs.prev_cpu_idle = get_cpu_idle_time(j,
-			&dbs_info->cdbs.prev_cpu_wall, od_tuners->io_is_busy);
+			&dbs_info->cdbs.prev_cpu_wall, dbs_data->io_is_busy);
 		if (dbs_data->ignore_nice_load)
 			dbs_info->cdbs.prev_cpu_nice =
 				kcpustat_cpu(j).cpustat[CPUTIME_NICE];
@@ -342,7 +340,7 @@ gov_show_one_common(up_threshold);
 gov_show_one_common(sampling_down_factor);
 gov_show_one_common(ignore_nice_load);
 gov_show_one_common(min_sampling_rate);
-gov_show_one(od, io_is_busy);
+gov_show_one_common(io_is_busy);
 gov_show_one(od, powersave_bias);
 
 gov_attr_rw(sampling_rate);
@@ -401,7 +399,7 @@ static int od_init(struct dbs_data *dbs_
 	dbs_data->sampling_down_factor = DEF_SAMPLING_DOWN_FACTOR;
 	dbs_data->ignore_nice_load = 0;
 	tuners->powersave_bias = default_powersave_bias;
-	tuners->io_is_busy = should_io_be_busy();
+	dbs_data->io_is_busy = should_io_be_busy();
 
 	dbs_data->tuners = tuners;
 	return 0;
