From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/5] cpufreq: governor: Kill declare_show_sampling_rate_min()
Date: Tue,  2 Feb 2016 16:27:21 +0530
Message-ID: <bcbdea3dce1ae5e24a40b10239deb6262576cb70.1454410226.git.viresh.kumar@linaro.org>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454410226.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454410226.git.viresh.kumar@linaro.org>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This extra macro is required because the variable min_sampling_rate is
made part of 'struct dbs_data' instead of governor specific tunables.

For further optimization, its better that we kill
declare_show_sampling_rate_min() by moving min_sampling_rate to governor
specific tunables.

Lets do it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 14 ++++++-------
 drivers/cpufreq/cpufreq_governor.c     | 36 ++++++++++++++++++++--------------
 drivers/cpufreq/cpufreq_governor.h     | 18 ++---------------
 drivers/cpufreq/cpufreq_ondemand.c     | 14 ++++++-------
 4 files changed, 37 insertions(+), 45 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 606ad74abe6e..57750367bd26 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -185,7 +185,7 @@ static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
 	if (ret != 1)
 		return -EINVAL;
 
-	cs_tuners->sampling_rate = max(input, dbs_data->min_sampling_rate);
+	cs_tuners->sampling_rate = max(input, cs_tuners->min_sampling_rate);
 	return count;
 }
 
@@ -281,7 +281,7 @@ show_store_one(cs, up_threshold);
 show_store_one(cs, down_threshold);
 show_store_one(cs, ignore_nice_load);
 show_store_one(cs, freq_step);
-declare_show_sampling_rate_min(cs);
+show_one(cs, min_sampling_rate);
 
 gov_sys_pol_attr_rw(sampling_rate);
 gov_sys_pol_attr_rw(sampling_down_factor);
@@ -289,10 +289,10 @@ gov_sys_pol_attr_rw(up_threshold);
 gov_sys_pol_attr_rw(down_threshold);
 gov_sys_pol_attr_rw(ignore_nice_load);
 gov_sys_pol_attr_rw(freq_step);
-gov_sys_pol_attr_ro(sampling_rate_min);
+gov_sys_pol_attr_ro(min_sampling_rate);
 
 static struct attribute *dbs_attributes_gov_sys[] = {
-	&sampling_rate_min_gov_sys.attr,
+	&min_sampling_rate_gov_sys.attr,
 	&sampling_rate_gov_sys.attr,
 	&sampling_down_factor_gov_sys.attr,
 	&up_threshold_gov_sys.attr,
@@ -308,7 +308,7 @@ static struct attribute_group cs_attr_group_gov_sys = {
 };
 
 static struct attribute *dbs_attributes_gov_pol[] = {
-	&sampling_rate_min_gov_pol.attr,
+	&min_sampling_rate_gov_pol.attr,
 	&sampling_rate_gov_pol.attr,
 	&sampling_down_factor_gov_pol.attr,
 	&up_threshold_gov_pol.attr,
@@ -340,10 +340,10 @@ static int cs_init(struct dbs_data *dbs_data, bool notify)
 	tuners->sampling_down_factor = DEF_SAMPLING_DOWN_FACTOR;
 	tuners->ignore_nice_load = 0;
 	tuners->freq_step = DEF_FREQUENCY_STEP;
+	tuners->min_sampling_rate = MIN_SAMPLING_RATE_RATIO *
+		jiffies_to_usecs(10);
 
 	dbs_data->tuners = tuners;
-	dbs_data->min_sampling_rate = MIN_SAMPLING_RATE_RATIO *
-		jiffies_to_usecs(10);
 
 	if (notify)
 		cpufreq_register_notifier(&cs_cpufreq_notifier_block,
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index e0d111024d48..9a7edc91ad57 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -286,16 +286,32 @@ static void dbs_timer_handler(unsigned long data)
 		queue_work(system_wq, &shared->work);
 }
 
-static void set_sampling_rate(struct dbs_data *dbs_data,
-		unsigned int sampling_rate)
+static void set_sampling_rate(struct cpufreq_policy *policy,
+			      struct dbs_data *dbs_data)
 {
+	unsigned int *sampling_rate;
+	unsigned int *min_sampling_rate;
+	unsigned int latency;
+
+	/* policy latency is in ns. Convert it to us first */
+	latency = policy->cpuinfo.transition_latency / 1000;
+	if (latency == 0)
+		latency = 1;
+
 	if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
 		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
-		cs_tuners->sampling_rate = sampling_rate;
+		sampling_rate = &cs_tuners->sampling_rate;
+		min_sampling_rate = &cs_tuners->min_sampling_rate;
 	} else {
 		struct od_dbs_tuners *od_tuners = dbs_data->tuners;
-		od_tuners->sampling_rate = sampling_rate;
+		sampling_rate = &od_tuners->sampling_rate;
+		min_sampling_rate = &od_tuners->min_sampling_rate;
 	}
+
+	/* Bring kernel and HW constraints together */
+	*min_sampling_rate = max(*min_sampling_rate,
+				 MIN_LATENCY_MULTIPLIER * latency);
+	*sampling_rate = max(*min_sampling_rate, latency * LATENCY_MULTIPLIER);
 }
 
 static int alloc_common_dbs_info(struct cpufreq_policy *policy,
@@ -338,7 +354,6 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
 				 struct dbs_data *dbs_data,
 				 struct common_dbs_data *cdata)
 {
-	unsigned int latency;
 	int ret;
 
 	/* State should be equivalent to EXIT */
@@ -373,16 +388,7 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
 	if (ret)
 		goto free_common_dbs_info;
 
-	/* policy latency is in ns. Convert it to us first */
-	latency = policy->cpuinfo.transition_latency / 1000;
-	if (latency == 0)
-		latency = 1;
-
-	/* Bring kernel and HW constraints together */
-	dbs_data->min_sampling_rate = max(dbs_data->min_sampling_rate,
-					  MIN_LATENCY_MULTIPLIER * latency);
-	set_sampling_rate(dbs_data, max(dbs_data->min_sampling_rate,
-					latency * LATENCY_MULTIPLIER));
+	set_sampling_rate(policy, dbs_data);
 
 	if (!have_governor_per_policy())
 		cdata->gdbs_data = dbs_data;
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 91e767a058a7..ad44a8546a3a 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -183,6 +183,7 @@ struct od_dbs_tuners {
 	unsigned int up_threshold;
 	unsigned int powersave_bias;
 	unsigned int io_is_busy;
+	unsigned int min_sampling_rate;
 };
 
 struct cs_dbs_tuners {
@@ -192,6 +193,7 @@ struct cs_dbs_tuners {
 	unsigned int up_threshold;
 	unsigned int down_threshold;
 	unsigned int freq_step;
+	unsigned int min_sampling_rate;
 };
 
 /* Common Governor data across policies */
@@ -230,7 +232,6 @@ struct common_dbs_data {
 /* Governor Per policy data */
 struct dbs_data {
 	struct common_dbs_data *cdata;
-	unsigned int min_sampling_rate;
 	int usage_count;
 	void *tuners;
 };
@@ -254,21 +255,6 @@ static inline int delay_for_sampling_rate(unsigned int sampling_rate)
 	return delay;
 }
 
-#define declare_show_sampling_rate_min(_gov)				\
-static ssize_t show_sampling_rate_min_gov_sys				\
-(struct kobject *kobj, struct attribute *attr, char *buf)		\
-{									\
-	struct dbs_data *dbs_data = _gov##_dbs_cdata.gdbs_data;		\
-	return sprintf(buf, "%u\n", dbs_data->min_sampling_rate);	\
-}									\
-									\
-static ssize_t show_sampling_rate_min_gov_pol				\
-(struct cpufreq_policy *policy, char *buf)				\
-{									\
-	struct dbs_data *dbs_data = policy->governor_data;		\
-	return sprintf(buf, "%u\n", dbs_data->min_sampling_rate);	\
-}
-
 extern struct mutex cpufreq_governor_lock;
 
 void gov_add_timers(struct cpufreq_policy *policy, unsigned int delay);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index eae51070c034..b31f64745232 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -250,7 +250,7 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 	int cpu;
 
 	od_tuners->sampling_rate = new_rate = max(new_rate,
-			dbs_data->min_sampling_rate);
+			od_tuners->min_sampling_rate);
 
 	/*
 	 * Lock governor so that governor start/stop can't execute in parallel.
@@ -442,7 +442,7 @@ show_store_one(od, up_threshold);
 show_store_one(od, sampling_down_factor);
 show_store_one(od, ignore_nice_load);
 show_store_one(od, powersave_bias);
-declare_show_sampling_rate_min(od);
+show_one(od, min_sampling_rate);
 
 gov_sys_pol_attr_rw(sampling_rate);
 gov_sys_pol_attr_rw(io_is_busy);
@@ -450,10 +450,10 @@ gov_sys_pol_attr_rw(up_threshold);
 gov_sys_pol_attr_rw(sampling_down_factor);
 gov_sys_pol_attr_rw(ignore_nice_load);
 gov_sys_pol_attr_rw(powersave_bias);
-gov_sys_pol_attr_ro(sampling_rate_min);
+gov_sys_pol_attr_ro(min_sampling_rate);
 
 static struct attribute *dbs_attributes_gov_sys[] = {
-	&sampling_rate_min_gov_sys.attr,
+	&min_sampling_rate_gov_sys.attr,
 	&sampling_rate_gov_sys.attr,
 	&up_threshold_gov_sys.attr,
 	&sampling_down_factor_gov_sys.attr,
@@ -469,7 +469,7 @@ static struct attribute_group od_attr_group_gov_sys = {
 };
 
 static struct attribute *dbs_attributes_gov_pol[] = {
-	&sampling_rate_min_gov_pol.attr,
+	&min_sampling_rate_gov_pol.attr,
 	&sampling_rate_gov_pol.attr,
 	&up_threshold_gov_pol.attr,
 	&sampling_down_factor_gov_pol.attr,
@@ -509,12 +509,12 @@ static int od_init(struct dbs_data *dbs_data, bool notify)
 		 * not depending on HZ, but fixed (very low). The deferred
 		 * timer might skip some samples if idle/sleeping as needed.
 		*/
-		dbs_data->min_sampling_rate = MICRO_FREQUENCY_MIN_SAMPLE_RATE;
+		tuners->min_sampling_rate = MICRO_FREQUENCY_MIN_SAMPLE_RATE;
 	} else {
 		tuners->up_threshold = DEF_FREQUENCY_UP_THRESHOLD;
 
 		/* For correct statistics, we need 10 ticks for each measure */
-		dbs_data->min_sampling_rate = MIN_SAMPLING_RATE_RATIO *
+		tuners->min_sampling_rate = MIN_SAMPLING_RATE_RATIO *
 			jiffies_to_usecs(10);
 	}
 
-- 
2.7.0.79.gdc08a19
