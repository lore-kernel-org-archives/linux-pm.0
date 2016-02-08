From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 02/13] cpufreq: governor: Move common tunables to 'struct dbs_data'
Date: Mon,  8 Feb 2016 17:09:16 +0530
Message-ID: <a1c17889853f5dcaf10b1e81c284be9190ff1ab3.1454931188.git.viresh.kumar@linaro.org>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454931188.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454931188.git.viresh.kumar@linaro.org>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

There are few more common tunables shared across ondemand and
conservative governors. Move them to 'struct dbs_data' to simplify code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 38 ++++++++++++++-----------------
 drivers/cpufreq/cpufreq_governor.c     | 37 ++++++------------------------
 drivers/cpufreq/cpufreq_governor.h     | 14 +++++-------
 drivers/cpufreq/cpufreq_ondemand.c     | 41 +++++++++++++++-------------------
 4 files changed, 47 insertions(+), 83 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 8aaa8a4c2fca..ee4937ab6a8b 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -60,7 +60,7 @@ static void cs_check_cpu(int cpu, unsigned int load)
 		return;
 
 	/* Check for frequency increase */
-	if (load > cs_tuners->up_threshold) {
+	if (load > dbs_data->up_threshold) {
 		dbs_info->down_skip = 0;
 
 		/* if we are already at full speed then break out early */
@@ -78,7 +78,7 @@ static void cs_check_cpu(int cpu, unsigned int load)
 	}
 
 	/* if sampling_down_factor is active break out early */
-	if (++dbs_info->down_skip < cs_tuners->sampling_down_factor)
+	if (++dbs_info->down_skip < dbs_data->sampling_down_factor)
 		return;
 	dbs_info->down_skip = 0;
 
@@ -107,10 +107,9 @@ static unsigned int cs_dbs_timer(struct cpufreq_policy *policy)
 {
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
-	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
 	dbs_check_cpu(policy);
-	return delay_for_sampling_rate(cs_tuners->sampling_rate);
+	return delay_for_sampling_rate(dbs_data->sampling_rate);
 }
 
 static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
@@ -126,7 +125,6 @@ static struct dbs_governor cs_dbs_gov;
 static ssize_t store_sampling_down_factor(struct dbs_data *dbs_data,
 		const char *buf, size_t count)
 {
-	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	unsigned int input;
 	int ret;
 	ret = sscanf(buf, "%u", &input);
@@ -134,14 +132,13 @@ static ssize_t store_sampling_down_factor(struct dbs_data *dbs_data,
 	if (ret != 1 || input > MAX_SAMPLING_DOWN_FACTOR || input < 1)
 		return -EINVAL;
 
-	cs_tuners->sampling_down_factor = input;
+	dbs_data->sampling_down_factor = input;
 	return count;
 }
 
 static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
 		size_t count)
 {
-	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	unsigned int input;
 	int ret;
 	ret = sscanf(buf, "%u", &input);
@@ -149,7 +146,7 @@ static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
 	if (ret != 1)
 		return -EINVAL;
 
-	cs_tuners->sampling_rate = max(input, dbs_data->min_sampling_rate);
+	dbs_data->sampling_rate = max(input, dbs_data->min_sampling_rate);
 	return count;
 }
 
@@ -164,7 +161,7 @@ static ssize_t store_up_threshold(struct dbs_data *dbs_data, const char *buf,
 	if (ret != 1 || input > 100 || input <= cs_tuners->down_threshold)
 		return -EINVAL;
 
-	cs_tuners->up_threshold = input;
+	dbs_data->up_threshold = input;
 	return count;
 }
 
@@ -178,7 +175,7 @@ static ssize_t store_down_threshold(struct dbs_data *dbs_data, const char *buf,
 
 	/* cannot be lower than 11 otherwise freq will not fall */
 	if (ret != 1 || input < 11 || input > 100 ||
-			input >= cs_tuners->up_threshold)
+			input >= dbs_data->up_threshold)
 		return -EINVAL;
 
 	cs_tuners->down_threshold = input;
@@ -188,7 +185,6 @@ static ssize_t store_down_threshold(struct dbs_data *dbs_data, const char *buf,
 static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
 		const char *buf, size_t count)
 {
-	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	unsigned int input, j;
 	int ret;
 
@@ -199,10 +195,10 @@ static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
 	if (input > 1)
 		input = 1;
 
-	if (input == cs_tuners->ignore_nice_load) /* nothing to do */
+	if (input == dbs_data->ignore_nice_load) /* nothing to do */
 		return count;
 
-	cs_tuners->ignore_nice_load = input;
+	dbs_data->ignore_nice_load = input;
 
 	/* we need to re-evaluate prev_cpu_idle */
 	for_each_online_cpu(j) {
@@ -210,7 +206,7 @@ static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
 		dbs_info = &per_cpu(cs_cpu_dbs_info, j);
 		dbs_info->cdbs.prev_cpu_idle = get_cpu_idle_time(j,
 					&dbs_info->cdbs.prev_cpu_wall, 0);
-		if (cs_tuners->ignore_nice_load)
+		if (dbs_data->ignore_nice_load)
 			dbs_info->cdbs.prev_cpu_nice =
 				kcpustat_cpu(j).cpustat[CPUTIME_NICE];
 	}
@@ -239,12 +235,12 @@ static ssize_t store_freq_step(struct dbs_data *dbs_data, const char *buf,
 	return count;
 }
 
-show_store_one(cs, sampling_rate);
-show_store_one(cs, sampling_down_factor);
-show_store_one(cs, up_threshold);
 show_store_one(cs, down_threshold);
-show_store_one(cs, ignore_nice_load);
 show_store_one(cs, freq_step);
+show_store_one_global(cs, sampling_rate);
+show_store_one_global(cs, sampling_down_factor);
+show_store_one_global(cs, up_threshold);
+show_store_one_global(cs, ignore_nice_load);
 show_one_global(cs, min_sampling_rate);
 
 gov_sys_pol_attr_rw(sampling_rate);
@@ -299,11 +295,11 @@ static int cs_init(struct dbs_data *dbs_data, bool notify)
 		return -ENOMEM;
 	}
 
-	tuners->up_threshold = DEF_FREQUENCY_UP_THRESHOLD;
 	tuners->down_threshold = DEF_FREQUENCY_DOWN_THRESHOLD;
-	tuners->sampling_down_factor = DEF_SAMPLING_DOWN_FACTOR;
-	tuners->ignore_nice_load = 0;
 	tuners->freq_step = DEF_FREQUENCY_STEP;
+	dbs_data->up_threshold = DEF_FREQUENCY_UP_THRESHOLD;
+	dbs_data->sampling_down_factor = DEF_SAMPLING_DOWN_FACTOR;
+	dbs_data->ignore_nice_load = 0;
 
 	dbs_data->tuners = tuners;
 	dbs_data->min_sampling_rate = MIN_SAMPLING_RATE_RATIO *
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 9c1dfcee0d57..b168a32cc8f0 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -38,10 +38,9 @@ void dbs_check_cpu(struct cpufreq_policy *policy)
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
-	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
-	unsigned int sampling_rate;
+	unsigned int sampling_rate = dbs_data->sampling_rate;
+	unsigned int ignore_nice = dbs_data->ignore_nice_load;
 	unsigned int max_load = 0;
-	unsigned int ignore_nice;
 	unsigned int j;
 
 	if (gov->governor == GOV_ONDEMAND) {
@@ -54,13 +53,8 @@ void dbs_check_cpu(struct cpufreq_policy *policy)
 		 * the 'sampling_rate', so as to keep the wake-up-from-idle
 		 * detection logic a bit conservative.
 		 */
-		sampling_rate = od_tuners->sampling_rate;
 		sampling_rate *= od_dbs_info->rate_mult;
 
-		ignore_nice = od_tuners->ignore_nice_load;
-	} else {
-		sampling_rate = cs_tuners->sampling_rate;
-		ignore_nice = cs_tuners->ignore_nice_load;
 	}
 
 	/* Get Absolute Load */
@@ -279,19 +273,6 @@ static void dbs_update_util_handler(struct update_util_data *data, u64 time,
 	atomic_dec(&policy_dbs->skip_work);
 }
 
-static void set_sampling_rate(struct dbs_data *dbs_data,
-			      struct dbs_governor *gov,
-			      unsigned int sampling_rate)
-{
-	if (gov->governor == GOV_CONSERVATIVE) {
-		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
-		cs_tuners->sampling_rate = sampling_rate;
-	} else {
-		struct od_dbs_tuners *od_tuners = dbs_data->tuners;
-		od_tuners->sampling_rate = sampling_rate;
-	}
-}
-
 static struct policy_dbs_info *alloc_policy_dbs_info(struct cpufreq_policy *policy,
 						     struct dbs_governor *gov)
 {
@@ -383,8 +364,8 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy)
 	/* Bring kernel and HW constraints together */
 	dbs_data->min_sampling_rate = max(dbs_data->min_sampling_rate,
 					  MIN_LATENCY_MULTIPLIER * latency);
-	set_sampling_rate(dbs_data, gov, max(dbs_data->min_sampling_rate,
-					latency * LATENCY_MULTIPLIER));
+	dbs_data->sampling_rate = max(dbs_data->min_sampling_rate,
+				      LATENCY_MULTIPLIER * latency);
 
 	if (!have_governor_per_policy())
 		gov->gdbs_data = dbs_data;
@@ -456,16 +437,12 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy)
 	if (policy_dbs->policy)
 		return -EBUSY;
 
-	if (gov->governor == GOV_CONSERVATIVE) {
-		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
+	sampling_rate = dbs_data->sampling_rate;
+	ignore_nice = dbs_data->ignore_nice_load;
 
-		sampling_rate = cs_tuners->sampling_rate;
-		ignore_nice = cs_tuners->ignore_nice_load;
-	} else {
+	if (gov->governor == GOV_ONDEMAND) {
 		struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 
-		sampling_rate = od_tuners->sampling_rate;
-		ignore_nice = od_tuners->ignore_nice_load;
 		io_busy = od_tuners->io_is_busy;
 	}
 
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index cc9a373b9736..5c5d7936087c 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -153,9 +153,13 @@ static void *get_cpu_dbs_info_s(int cpu)				\
 
 /* Governor demand based switching data (per-policy or global). */
 struct dbs_data {
-	unsigned int min_sampling_rate;
 	int usage_count;
 	void *tuners;
+	unsigned int min_sampling_rate;
+	unsigned int ignore_nice_load;
+	unsigned int sampling_rate;
+	unsigned int sampling_down_factor;
+	unsigned int up_threshold;
 };
 
 /* Common to all CPUs of a policy */
@@ -216,19 +220,11 @@ struct cs_cpu_dbs_info_s {
 
 /* Per policy Governors sysfs tunables */
 struct od_dbs_tuners {
-	unsigned int ignore_nice_load;
-	unsigned int sampling_rate;
-	unsigned int sampling_down_factor;
-	unsigned int up_threshold;
 	unsigned int powersave_bias;
 	unsigned int io_is_busy;
 };
 
 struct cs_dbs_tuners {
-	unsigned int ignore_nice_load;
-	unsigned int sampling_rate;
-	unsigned int sampling_down_factor;
-	unsigned int up_threshold;
 	unsigned int down_threshold;
 	unsigned int freq_step;
 };
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 2a71a6755998..cb0d6ff1ced5 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -110,7 +110,7 @@ static unsigned int generic_powersave_bias_target(struct cpufreq_policy *policy,
 		dbs_info->freq_lo_jiffies = 0;
 		return freq_lo;
 	}
-	jiffies_total = usecs_to_jiffies(od_tuners->sampling_rate);
+	jiffies_total = usecs_to_jiffies(dbs_data->sampling_rate);
 	jiffies_hi = (freq_avg - freq_lo) * jiffies_total;
 	jiffies_hi += ((freq_hi - freq_lo) / 2);
 	jiffies_hi /= (freq_hi - freq_lo);
@@ -161,11 +161,10 @@ static void od_check_cpu(int cpu, unsigned int load)
 	dbs_info->freq_lo = 0;
 
 	/* Check for frequency increase */
-	if (load > od_tuners->up_threshold) {
+	if (load > dbs_data->up_threshold) {
 		/* If switching to max speed, apply sampling_down_factor */
 		if (policy->cur < policy->max)
-			dbs_info->rate_mult =
-				od_tuners->sampling_down_factor;
+			dbs_info->rate_mult = dbs_data->sampling_down_factor;
 		dbs_freq_increase(policy, policy->max);
 	} else {
 		/* Calculate the next frequency proportional to load */
@@ -195,7 +194,6 @@ static unsigned int od_dbs_timer(struct cpufreq_policy *policy)
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, policy->cpu);
-	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	int delay = 0, sample_type = dbs_info->sample_type;
 
 	/* Common NORMAL_SAMPLE setup */
@@ -214,7 +212,7 @@ static unsigned int od_dbs_timer(struct cpufreq_policy *policy)
 	}
 
 	if (!delay)
-		delay = delay_for_sampling_rate(od_tuners->sampling_rate
+		delay = delay_for_sampling_rate(dbs_data->sampling_rate
 				* dbs_info->rate_mult);
 
 	return delay;
@@ -239,11 +237,10 @@ static struct dbs_governor od_dbs_gov;
 static void update_sampling_rate(struct dbs_data *dbs_data,
 		unsigned int new_rate)
 {
-	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	struct cpumask cpumask;
 	int cpu;
 
-	od_tuners->sampling_rate = new_rate = max(new_rate,
+	dbs_data->sampling_rate = new_rate = max(new_rate,
 			dbs_data->min_sampling_rate);
 
 	/*
@@ -348,7 +345,6 @@ static ssize_t store_io_is_busy(struct dbs_data *dbs_data, const char *buf,
 static ssize_t store_up_threshold(struct dbs_data *dbs_data, const char *buf,
 		size_t count)
 {
-	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	unsigned int input;
 	int ret;
 	ret = sscanf(buf, "%u", &input);
@@ -358,21 +354,20 @@ static ssize_t store_up_threshold(struct dbs_data *dbs_data, const char *buf,
 		return -EINVAL;
 	}
 
-	od_tuners->up_threshold = input;
+	dbs_data->up_threshold = input;
 	return count;
 }
 
 static ssize_t store_sampling_down_factor(struct dbs_data *dbs_data,
 		const char *buf, size_t count)
 {
-	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	unsigned int input, j;
 	int ret;
 	ret = sscanf(buf, "%u", &input);
 
 	if (ret != 1 || input > MAX_SAMPLING_DOWN_FACTOR || input < 1)
 		return -EINVAL;
-	od_tuners->sampling_down_factor = input;
+	dbs_data->sampling_down_factor = input;
 
 	/* Reset down sampling multiplier in case it was active */
 	for_each_online_cpu(j) {
@@ -399,10 +394,10 @@ static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
 	if (input > 1)
 		input = 1;
 
-	if (input == od_tuners->ignore_nice_load) { /* nothing to do */
+	if (input == dbs_data->ignore_nice_load) { /* nothing to do */
 		return count;
 	}
-	od_tuners->ignore_nice_load = input;
+	dbs_data->ignore_nice_load = input;
 
 	/* we need to re-evaluate prev_cpu_idle */
 	for_each_online_cpu(j) {
@@ -410,7 +405,7 @@ static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
 		dbs_info = &per_cpu(od_cpu_dbs_info, j);
 		dbs_info->cdbs.prev_cpu_idle = get_cpu_idle_time(j,
 			&dbs_info->cdbs.prev_cpu_wall, od_tuners->io_is_busy);
-		if (od_tuners->ignore_nice_load)
+		if (dbs_data->ignore_nice_load)
 			dbs_info->cdbs.prev_cpu_nice =
 				kcpustat_cpu(j).cpustat[CPUTIME_NICE];
 
@@ -437,12 +432,12 @@ static ssize_t store_powersave_bias(struct dbs_data *dbs_data, const char *buf,
 	return count;
 }
 
-show_store_one(od, sampling_rate);
 show_store_one(od, io_is_busy);
-show_store_one(od, up_threshold);
-show_store_one(od, sampling_down_factor);
-show_store_one(od, ignore_nice_load);
 show_store_one(od, powersave_bias);
+show_store_one_global(od, sampling_rate);
+show_store_one_global(od, up_threshold);
+show_store_one_global(od, sampling_down_factor);
+show_store_one_global(od, ignore_nice_load);
 show_one_global(od, min_sampling_rate);
 
 gov_sys_pol_attr_rw(sampling_rate);
@@ -504,7 +499,7 @@ static int od_init(struct dbs_data *dbs_data, bool notify)
 	put_cpu();
 	if (idle_time != -1ULL) {
 		/* Idle micro accounting is supported. Use finer thresholds */
-		tuners->up_threshold = MICRO_FREQUENCY_UP_THRESHOLD;
+		dbs_data->up_threshold = MICRO_FREQUENCY_UP_THRESHOLD;
 		/*
 		 * In nohz/micro accounting case we set the minimum frequency
 		 * not depending on HZ, but fixed (very low). The deferred
@@ -512,15 +507,15 @@ static int od_init(struct dbs_data *dbs_data, bool notify)
 		*/
 		dbs_data->min_sampling_rate = MICRO_FREQUENCY_MIN_SAMPLE_RATE;
 	} else {
-		tuners->up_threshold = DEF_FREQUENCY_UP_THRESHOLD;
+		dbs_data->up_threshold = DEF_FREQUENCY_UP_THRESHOLD;
 
 		/* For correct statistics, we need 10 ticks for each measure */
 		dbs_data->min_sampling_rate = MIN_SAMPLING_RATE_RATIO *
 			jiffies_to_usecs(10);
 	}
 
-	tuners->sampling_down_factor = DEF_SAMPLING_DOWN_FACTOR;
-	tuners->ignore_nice_load = 0;
+	dbs_data->sampling_down_factor = DEF_SAMPLING_DOWN_FACTOR;
+	dbs_data->ignore_nice_load = 0;
 	tuners->powersave_bias = default_powersave_bias;
 	tuners->io_is_busy = should_io_be_busy();
 
-- 
2.7.1.370.gb2aa7f8
