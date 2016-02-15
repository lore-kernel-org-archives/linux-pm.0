From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 9/9] cpufreq: governor: Use microseconds in sample delay computations
Date: Mon, 15 Feb 2016 02:22:13 +0100
Message-ID: <9344385.GMvgsk6ndT@vostro.rjw.lan>
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

Do not convert microseconds to jiffies and the other way around
in governor computations related to the sampling rate and sample
delay and drop delay_for_sampling_rate() which isn't of any use
then.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_conservative.c |    2 +-
 drivers/cpufreq/cpufreq_governor.c     |    4 +---
 drivers/cpufreq/cpufreq_governor.h     |   15 ++-------------
 drivers/cpufreq/cpufreq_ondemand.c     |   28 +++++++++++++---------------
 4 files changed, 17 insertions(+), 32 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -163,8 +163,8 @@ struct od_cpu_dbs_info_s {
 	struct cpu_dbs_info cdbs;
 	struct cpufreq_frequency_table *freq_table;
 	unsigned int freq_lo;
-	unsigned int freq_lo_jiffies;
-	unsigned int freq_hi_jiffies;
+	unsigned int freq_lo_delay_us;
+	unsigned int freq_hi_delay_us;
 	unsigned int sample_type:1;
 };
 
@@ -223,17 +223,6 @@ struct od_ops {
 	void (*freq_increase)(struct cpufreq_policy *policy, unsigned int freq);
 };
 
-static inline int delay_for_sampling_rate(unsigned int sampling_rate)
-{
-	int delay = usecs_to_jiffies(sampling_rate);
-
-	/* We want all CPUs to do sampling nearly on same jiffy */
-	if (num_online_cpus() > 1)
-		delay -= jiffies % delay;
-
-	return delay;
-}
-
 extern struct mutex dbs_data_mutex;
 unsigned int dbs_update(struct cpufreq_policy *policy);
 int cpufreq_governor_dbs(struct cpufreq_policy *policy, unsigned int event);
Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -102,7 +102,7 @@ static unsigned int cs_dbs_timer(struct
 	}
 
  out:
-	return delay_for_sampling_rate(dbs_data->sampling_rate);
+	return dbs_data->sampling_rate;
 }
 
 static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -66,8 +66,8 @@ static int should_io_be_busy(void)
 
 /*
  * Find right freq to be set now with powersave_bias on.
- * Returns the freq_hi to be used right now and will set freq_hi_jiffies,
- * freq_lo, and freq_lo_jiffies in percpu area for averaging freqs.
+ * Returns the freq_hi to be used right now and will set freq_hi_delay_us,
+ * freq_lo, and freq_lo_delay_us in percpu area for averaging freqs.
  */
 static unsigned int generic_powersave_bias_target(struct cpufreq_policy *policy,
 		unsigned int freq_next, unsigned int relation)
@@ -75,7 +75,7 @@ static unsigned int generic_powersave_bi
 	unsigned int freq_req, freq_reduc, freq_avg;
 	unsigned int freq_hi, freq_lo;
 	unsigned int index = 0;
-	unsigned int jiffies_total, jiffies_hi, jiffies_lo;
+	unsigned int delay_hi_us;
 	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info,
 						   policy->cpu);
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
@@ -84,7 +84,7 @@ static unsigned int generic_powersave_bi
 
 	if (!dbs_info->freq_table) {
 		dbs_info->freq_lo = 0;
-		dbs_info->freq_lo_jiffies = 0;
+		dbs_info->freq_lo_delay_us = 0;
 		return freq_next;
 	}
 
@@ -107,17 +107,15 @@ static unsigned int generic_powersave_bi
 	/* Find out how long we have to be in hi and lo freqs */
 	if (freq_hi == freq_lo) {
 		dbs_info->freq_lo = 0;
-		dbs_info->freq_lo_jiffies = 0;
+		dbs_info->freq_lo_delay_us = 0;
 		return freq_lo;
 	}
-	jiffies_total = usecs_to_jiffies(dbs_data->sampling_rate);
-	jiffies_hi = (freq_avg - freq_lo) * jiffies_total;
-	jiffies_hi += ((freq_hi - freq_lo) / 2);
-	jiffies_hi /= (freq_hi - freq_lo);
-	jiffies_lo = jiffies_total - jiffies_hi;
+	delay_hi_us = (freq_avg - freq_lo) * dbs_data->sampling_rate;
+	delay_hi_us += (freq_hi - freq_lo) / 2;
+	delay_hi_us /= freq_hi - freq_lo;
+	dbs_info->freq_hi_delay_us = delay_hi_us;
 	dbs_info->freq_lo = freq_lo;
-	dbs_info->freq_lo_jiffies = jiffies_lo;
-	dbs_info->freq_hi_jiffies = jiffies_hi;
+	dbs_info->freq_lo_delay_us = dbs_data->sampling_rate - delay_hi_us;
 	return freq_hi;
 }
 
@@ -205,7 +203,7 @@ static unsigned int od_dbs_timer(struct
 	if (sample_type == OD_SUB_SAMPLE && policy_dbs->sample_delay_ns > 0) {
 		__cpufreq_driver_target(policy, dbs_info->freq_lo,
 					CPUFREQ_RELATION_H);
-		return dbs_info->freq_lo_jiffies;
+		return dbs_info->freq_lo_delay_us;
 	}
 
 	od_update(policy);
@@ -213,10 +211,10 @@ static unsigned int od_dbs_timer(struct
 	if (dbs_info->freq_lo) {
 		/* Setup timer for SUB_SAMPLE */
 		dbs_info->sample_type = OD_SUB_SAMPLE;
-		return dbs_info->freq_hi_jiffies;
+		return dbs_info->freq_hi_delay_us;
 	}
 
-	return delay_for_sampling_rate(dbs_data->sampling_rate * policy_dbs->rate_mult);
+	return dbs_data->sampling_rate * policy_dbs->rate_mult;
 }
 
 /************************** sysfs interface ************************/
Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -282,7 +282,6 @@ static void dbs_work_handler(struct work
 	struct policy_dbs_info *policy_dbs;
 	struct cpufreq_policy *policy;
 	struct dbs_governor *gov;
-	unsigned int delay;
 
 	policy_dbs = container_of(work, struct policy_dbs_info, work);
 	policy = policy_dbs->policy;
@@ -293,8 +292,7 @@ static void dbs_work_handler(struct work
 	 * ondemand governor isn't updating the sampling rate in parallel.
 	 */
 	mutex_lock(&policy_dbs->timer_mutex);
-	delay = gov->gov_dbs_timer(policy);
-	policy_dbs->sample_delay_ns = jiffies_to_nsecs(delay);
+	gov_update_sample_delay(policy_dbs, gov->gov_dbs_timer(policy));
 	mutex_unlock(&policy_dbs->timer_mutex);
 
 	/* Allow the utilization update handler to queue up more work. */
