From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 7/9] cpufreq: governor: Move rate_mult to struct policy_dbs
Date: Mon, 15 Feb 2016 02:20:51 +0100
Message-ID: <2464597.suxGYOfmRx@vostro.rjw.lan>
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

The rate_mult field in struct od_cpu_dbs_info_s is used by the code
shared with the conservative governor and to access it that code
has to do an ugly governor type check.  However, first of all it
is ever only used for policy->cpu, so it is per-policy rather than
per-CPU and second, it is initialized to 1 by cpufreq_governor_start(),
so if the conservative governor never modifies it, it will have no
effect on the results of any computations.

For these reasons, move rate_mult to struct policy_dbs_info (as a
common field).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |   25 +++++++++----------------
 drivers/cpufreq/cpufreq_governor.h |    3 ++-
 drivers/cpufreq/cpufreq_ondemand.c |   23 +++++++++++++++--------
 3 files changed, 26 insertions(+), 25 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -138,24 +138,17 @@ unsigned int dbs_update(struct cpufreq_p
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
-	unsigned int sampling_rate = dbs_data->sampling_rate;
 	unsigned int ignore_nice = dbs_data->ignore_nice_load;
 	unsigned int max_load = 0;
-	unsigned int j;
+	unsigned int sampling_rate, j;
 
-	if (gov->governor == GOV_ONDEMAND) {
-		struct od_cpu_dbs_info_s *od_dbs_info =
-				gov->get_cpu_dbs_info_s(policy->cpu);
-
-		/*
-		 * Sometimes, the ondemand governor uses an additional
-		 * multiplier to give long delays. So apply this multiplier to
-		 * the 'sampling_rate', so as to keep the wake-up-from-idle
-		 * detection logic a bit conservative.
-		 */
-		sampling_rate *= od_dbs_info->rate_mult;
-
-	}
+	/*
+	 * Sometimes governors may use an additional multiplier to increase
+	 * sample delays temporarily.  Apply that multiplier to sampling_rate
+	 * so as to keep the wake-up-from-idle detection logic a bit
+	 * conservative.
+	 */
+	sampling_rate = dbs_data->sampling_rate * policy_dbs->rate_mult;
 
 	/* Get Absolute Load */
 	for_each_cpu(j, policy->cpus) {
@@ -546,6 +539,7 @@ static int cpufreq_governor_start(struct
 		return -EINVAL;
 
 	policy_dbs->is_shared = policy_is_shared(policy);
+	policy_dbs->rate_mult = 1;
 
 	sampling_rate = dbs_data->sampling_rate;
 	ignore_nice = dbs_data->ignore_nice_load;
@@ -579,7 +573,6 @@ static int cpufreq_governor_start(struct
 		struct od_ops *od_ops = gov->gov_ops;
 		struct od_cpu_dbs_info_s *od_dbs_info = gov->get_cpu_dbs_info_s(cpu);
 
-		od_dbs_info->rate_mult = 1;
 		od_dbs_info->sample_type = OD_NORMAL_SAMPLE;
 		od_ops->powersave_bias_init_cpu(cpu);
 	}
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -130,6 +130,8 @@ struct policy_dbs_info {
 	/* dbs_data may be shared between multiple policy objects */
 	struct dbs_data *dbs_data;
 	struct list_head list;
+	/* Multiplier for increasing sample delay temporarily. */
+	unsigned int rate_mult;
 	/* Status indicators */
 	bool is_shared;		/* This object is used by multiple CPUs */
 	bool work_in_progress;	/* Work is being queued up or in progress */
@@ -163,7 +165,6 @@ struct od_cpu_dbs_info_s {
 	unsigned int freq_lo;
 	unsigned int freq_lo_jiffies;
 	unsigned int freq_hi_jiffies;
-	unsigned int rate_mult;
 	unsigned int sample_type:1;
 };
 
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -164,7 +164,7 @@ static void od_update(struct cpufreq_pol
 	if (load > dbs_data->up_threshold) {
 		/* If switching to max speed, apply sampling_down_factor */
 		if (policy->cur < policy->max)
-			dbs_info->rate_mult = dbs_data->sampling_down_factor;
+			policy_dbs->rate_mult = dbs_data->sampling_down_factor;
 		dbs_freq_increase(policy, policy->max);
 	} else {
 		/* Calculate the next frequency proportional to load */
@@ -175,7 +175,7 @@ static void od_update(struct cpufreq_pol
 		freq_next = min_f + load * (max_f - min_f) / 100;
 
 		/* No longer fully busy, reset rate_mult */
-		dbs_info->rate_mult = 1;
+		policy_dbs->rate_mult = 1;
 
 		if (!od_tuners->powersave_bias) {
 			__cpufreq_driver_target(policy, freq_next,
@@ -214,7 +214,7 @@ static unsigned int od_dbs_timer(struct
 			delay = dbs_info->freq_hi_jiffies;
 		} else {
 			delay = delay_for_sampling_rate(dbs_data->sampling_rate
-							* dbs_info->rate_mult);
+							* policy_dbs->rate_mult);
 		}
 	}
 
@@ -266,20 +266,27 @@ static ssize_t store_up_threshold(struct
 static ssize_t store_sampling_down_factor(struct dbs_data *dbs_data,
 		const char *buf, size_t count)
 {
-	unsigned int input, j;
+	struct policy_dbs_info *policy_dbs;
+	unsigned int input;
 	int ret;
 	ret = sscanf(buf, "%u", &input);
 
 	if (ret != 1 || input > MAX_SAMPLING_DOWN_FACTOR || input < 1)
 		return -EINVAL;
+
 	dbs_data->sampling_down_factor = input;
 
 	/* Reset down sampling multiplier in case it was active */
-	for_each_online_cpu(j) {
-		struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info,
-				j);
-		dbs_info->rate_mult = 1;
+	list_for_each_entry(policy_dbs, &dbs_data->policy_dbs_list, list) {
+		/*
+		 * Doing this without locking might lead to using different
+		 * rate_mult values in od_update() and od_dbs_timer().
+		 */
+		mutex_lock(&policy_dbs->timer_mutex);
+		policy_dbs->rate_mult = 1;
+		mutex_unlock(&policy_dbs->timer_mutex);
 	}
+
 	return count;
 }
 
