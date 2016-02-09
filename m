From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 4/7] cpufreq: governor: Move common sysfs tunables to cpufreq_governor.c
Date: Tue,  9 Feb 2016 09:16:16 +0530
Message-ID: <18cf5aab3f90b9d9db2d269057a309b624ea7924.1454988792.git.viresh.kumar@linaro.org>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34769 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834AbcBIDrn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 22:47:43 -0500
Received: by mail-pf0-f178.google.com with SMTP id x65so1051705pfb.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 19:47:43 -0800 (PST)
In-Reply-To: <cover.1454988792.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454988792.git.viresh.kumar@linaro.org>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

We have got five common sysfs tunables between ondemand and conservative
governors, move their callbacks to cpufreq_governor.c to get rid of
redundant code.

Because of minor differences in the implementation of the callbacks,
some more per-governor callbacks are introduced in order to not
introduce any more "governor == ONDEMAND/CONSERVATIVE" like checks.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Juri Lelli <juri.lelli@arm.com>
Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/cpufreq_conservative.c |  80 +++++---------------------
 drivers/cpufreq/cpufreq_governor.c     | 100 ++++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq_governor.h     |  16 +++++-
 drivers/cpufreq/cpufreq_ondemand.c     | 102 ++++++++-------------------------
 4 files changed, 151 insertions(+), 147 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index ed081dbce00c..5c54041015d4 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -122,47 +122,17 @@ static struct notifier_block cs_cpufreq_notifier_block = {
 /************************** sysfs interface ************************/
 static struct dbs_governor cs_dbs_gov;
 
-static ssize_t store_sampling_down_factor(struct dbs_data *dbs_data,
-		const char *buf, size_t count)
+static bool invalid_up_threshold(struct dbs_data *dbs_data,
+				 unsigned int threshold)
 {
-	unsigned int input;
-	int ret;
-	ret = sscanf(buf, "%u", &input);
-
-	if (ret != 1 || input > MAX_SAMPLING_DOWN_FACTOR || input < 1)
-		return -EINVAL;
+	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
-	dbs_data->sampling_down_factor = input;
-	return count;
+	return threshold > 100 || threshold <= cs_tuners->down_threshold;
 }
 
-static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
-		size_t count)
+static bool invalid_sampling_down_factor(unsigned int factor)
 {
-	unsigned int input;
-	int ret;
-	ret = sscanf(buf, "%u", &input);
-
-	if (ret != 1)
-		return -EINVAL;
-
-	dbs_data->sampling_rate = max(input, dbs_data->min_sampling_rate);
-	return count;
-}
-
-static ssize_t store_up_threshold(struct dbs_data *dbs_data, const char *buf,
-		size_t count)
-{
-	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
-	unsigned int input;
-	int ret;
-	ret = sscanf(buf, "%u", &input);
-
-	if (ret != 1 || input > 100 || input <= cs_tuners->down_threshold)
-		return -EINVAL;
-
-	dbs_data->up_threshold = input;
-	return count;
+	return factor > MAX_SAMPLING_DOWN_FACTOR;
 }
 
 static ssize_t store_down_threshold(struct dbs_data *dbs_data, const char *buf,
@@ -182,27 +152,13 @@ static ssize_t store_down_threshold(struct dbs_data *dbs_data, const char *buf,
 	return count;
 }
 
-static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
-		const char *buf, size_t count)
+static void update_ignore_nice_load(struct dbs_data *dbs_data)
 {
-	unsigned int input, j;
-	int ret;
-
-	ret = sscanf(buf, "%u", &input);
-	if (ret != 1)
-		return -EINVAL;
-
-	if (input > 1)
-		input = 1;
-
-	if (input == dbs_data->ignore_nice_load) /* nothing to do */
-		return count;
-
-	dbs_data->ignore_nice_load = input;
+	struct cs_cpu_dbs_info_s *dbs_info;
+	unsigned int j;
 
 	/* we need to re-evaluate prev_cpu_idle */
 	for_each_online_cpu(j) {
-		struct cs_cpu_dbs_info_s *dbs_info;
 		dbs_info = &per_cpu(cs_cpu_dbs_info, j);
 		dbs_info->cdbs.prev_cpu_idle = get_cpu_idle_time(j,
 					&dbs_info->cdbs.prev_cpu_wall, 0);
@@ -210,7 +166,6 @@ static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
 			dbs_info->cdbs.prev_cpu_nice =
 				kcpustat_cpu(j).cpustat[CPUTIME_NICE];
 	}
-	return count;
 }
 
 static ssize_t store_freq_step(struct dbs_data *dbs_data, const char *buf,
@@ -235,21 +190,11 @@ static ssize_t store_freq_step(struct dbs_data *dbs_data, const char *buf,
 	return count;
 }
 
-gov_show_one_common(sampling_rate);
-gov_show_one_common(sampling_down_factor);
-gov_show_one_common(up_threshold);
-gov_show_one_common(ignore_nice_load);
-gov_show_one_common(min_sampling_rate);
 gov_show_one(cs, down_threshold);
 gov_show_one(cs, freq_step);
 
-gov_attr_rw(sampling_rate);
-gov_attr_rw(sampling_down_factor);
-gov_attr_rw(up_threshold);
-gov_attr_rw(ignore_nice_load);
-gov_attr_ro(min_sampling_rate);
-gov_attr_rw(down_threshold);
-gov_attr_rw(freq_step);
+static gov_attr_rw(down_threshold);
+static gov_attr_rw(freq_step);
 
 static struct attribute *cs_attributes[] = {
 	&min_sampling_rate.attr,
@@ -315,6 +260,9 @@ static struct dbs_governor cs_dbs_gov = {
 	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
 	.gov_dbs_timer = cs_dbs_timer,
 	.gov_check_cpu = cs_check_cpu,
+	.invalid_up_threshold = invalid_up_threshold,
+	.invalid_sampling_down_factor = invalid_sampling_down_factor,
+	.update_ignore_nice_load = update_ignore_nice_load,
 	.init = cs_init,
 	.exit = cs_exit,
 };
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 8e53f804a5af..7038ada3915d 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -25,6 +25,105 @@
 DEFINE_MUTEX(dbs_data_mutex);
 EXPORT_SYMBOL_GPL(dbs_data_mutex);
 
+/* Common sysfs tunables */
+static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
+				   size_t count)
+{
+	struct dbs_governor *gov = dbs_data->gov;
+	unsigned int rate;
+	int ret;
+	ret = sscanf(buf, "%u", &rate);
+	if (ret != 1)
+		return -EINVAL;
+
+	dbs_data->sampling_rate = max(rate, dbs_data->min_sampling_rate);
+
+	if (gov->update_sampling_rate)
+		gov->update_sampling_rate(dbs_data);
+
+	return count;
+}
+
+static ssize_t store_up_threshold(struct dbs_data *dbs_data, const char *buf,
+				  size_t count)
+{
+	struct dbs_governor *gov = dbs_data->gov;
+	unsigned int input;
+	int ret;
+	ret = sscanf(buf, "%u", &input);
+
+	if (ret != 1 || gov->invalid_up_threshold(dbs_data, input))
+		return -EINVAL;
+
+	dbs_data->up_threshold = input;
+	return count;
+}
+
+static ssize_t store_sampling_down_factor(struct dbs_data *dbs_data,
+					  const char *buf, size_t count)
+{
+	struct dbs_governor *gov = dbs_data->gov;
+	unsigned int input;
+	int ret;
+	ret = sscanf(buf, "%u", &input);
+
+	if (ret != 1 || gov->invalid_sampling_down_factor(input) || input < 1)
+		return -EINVAL;
+
+	dbs_data->sampling_down_factor = input;
+
+	if (gov->update_sampling_down_factor)
+		gov->update_sampling_down_factor(dbs_data);
+
+	return count;
+}
+
+static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
+				      const char *buf, size_t count)
+{
+	struct dbs_governor *gov = dbs_data->gov;
+	unsigned int input;
+	int ret;
+
+	ret = sscanf(buf, "%u", &input);
+	if (ret != 1)
+		return -EINVAL;
+
+	if (input > 1)
+		input = 1;
+
+	if (input == dbs_data->ignore_nice_load) { /* nothing to do */
+		return count;
+	}
+
+	dbs_data->ignore_nice_load = input;
+
+	gov->update_ignore_nice_load(dbs_data);
+	return count;
+}
+
+gov_show_one_common(sampling_rate);
+gov_show_one_common(up_threshold);
+gov_show_one_common(sampling_down_factor);
+gov_show_one_common(ignore_nice_load);
+gov_show_one_common(min_sampling_rate);
+
+gov_attr_rw(sampling_rate);
+EXPORT_SYMBOL_GPL(sampling_rate);
+
+gov_attr_rw(up_threshold);
+EXPORT_SYMBOL_GPL(up_threshold);
+
+gov_attr_rw(sampling_down_factor);
+EXPORT_SYMBOL_GPL(sampling_down_factor);
+
+gov_attr_rw(ignore_nice_load);
+EXPORT_SYMBOL_GPL(ignore_nice_load);
+
+gov_attr_ro(min_sampling_rate);
+EXPORT_SYMBOL_GPL(min_sampling_rate);
+
+/* Governor routines */
 static inline struct dbs_data *to_dbs_data(struct kobject *kobj)
 {
 	return container_of(kobj, struct dbs_data, kobj);
@@ -401,6 +500,7 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy)
 		goto free_policy_dbs_info;
 	}
 
+	dbs_data->gov = gov;
 	INIT_LIST_HEAD(&dbs_data->policy_dbs_list);
 	mutex_init(&dbs_data->mutex);
 
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 02885e353dfc..8aff218f73a4 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -64,6 +64,7 @@ static void *get_cpu_dbs_info_s(int cpu)				\
 
 /* Governor demand based switching data (per-policy or global). */
 struct dbs_data {
+	struct dbs_governor *gov;
 	int usage_count;
 	void *tuners;
 	unsigned int min_sampling_rate;
@@ -106,13 +107,19 @@ static ssize_t show_##file_name						\
 }
 
 #define gov_attr_ro(_name)						\
-static struct governor_attr _name =					\
+struct governor_attr _name =						\
 __ATTR(_name, 0444, show_##_name, NULL)
 
 #define gov_attr_rw(_name)						\
-static struct governor_attr _name =					\
+struct governor_attr _name =						\
 __ATTR(_name, 0644, show_##_name, store_##_name)
 
+extern struct governor_attr sampling_rate;
+extern struct governor_attr up_threshold;
+extern struct governor_attr sampling_down_factor;
+extern struct governor_attr ignore_nice_load;
+extern struct governor_attr min_sampling_rate;
+
 /* Common to all CPUs of a policy */
 struct policy_dbs_info {
 	struct cpufreq_policy *policy;
@@ -202,6 +209,11 @@ struct dbs_governor {
 	void (*gov_check_cpu)(int cpu, unsigned int load);
 	int (*init)(struct dbs_data *dbs_data, bool notify);
 	void (*exit)(struct dbs_data *dbs_data, bool notify);
+	bool (*invalid_up_threshold)(struct dbs_data *dbs_data, unsigned int threshold);
+	bool (*invalid_sampling_down_factor)(unsigned int factor);
+	void (*update_sampling_rate)(struct dbs_data *dbs_data);
+	void (*update_sampling_down_factor)(struct dbs_data *dbs_data);
+	void (*update_ignore_nice_load)(struct dbs_data *dbs_data);
 
 	/* Governor specific ops, see below */
 	void *gov_ops;
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 38301c6b31c7..caef7c9f631d 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -223,7 +223,6 @@ static struct dbs_governor od_dbs_gov;
 
 /**
  * update_sampling_rate - update sampling rate effective immediately if needed.
- * @new_rate: new sampling rate
  *
  * If new rate is smaller than the old, simply updating
  * dbs.sampling_rate might not be appropriate. For example, if the
@@ -241,14 +240,10 @@ static struct dbs_governor od_dbs_gov;
  * This must be called with dbs_data->mutex held, otherwise traversing
  * policy_dbs_list isn't safe.
  */
-static void update_sampling_rate(struct dbs_data *dbs_data,
-		unsigned int new_rate)
+static void update_sampling_rate(struct dbs_data *dbs_data)
 {
 	struct policy_dbs_info *policy_dbs;
 
-	dbs_data->sampling_rate = new_rate = max(new_rate,
-			dbs_data->min_sampling_rate);
-
 	/*
 	 * We are operating under dbs_data->mutex and so the list and its
 	 * entries can't be freed concurrently.
@@ -272,22 +267,21 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 		 * be corrected next time a sample is taken, so it shouldn't be
 		 * significant.
 		 */
-		gov_update_sample_delay(policy_dbs, new_rate);
+		gov_update_sample_delay(policy_dbs, dbs_data->sampling_rate);
 		mutex_unlock(&policy_dbs->timer_mutex);
 	}
 }
 
-static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
-		size_t count)
+static bool invalid_up_threshold(struct dbs_data *dbs_data,
+				 unsigned int threshold)
 {
-	unsigned int input;
-	int ret;
-	ret = sscanf(buf, "%u", &input);
-	if (ret != 1)
-		return -EINVAL;
+	return threshold > MAX_FREQUENCY_UP_THRESHOLD ||
+	       threshold < MIN_FREQUENCY_UP_THRESHOLD;
+}
 
-	update_sampling_rate(dbs_data, input);
-	return count;
+static bool invalid_sampling_down_factor(unsigned int factor)
+{
+	return factor > MAX_SAMPLING_DOWN_FACTOR;
 }
 
 static ssize_t store_io_is_busy(struct dbs_data *dbs_data, const char *buf,
@@ -313,66 +307,22 @@ static ssize_t store_io_is_busy(struct dbs_data *dbs_data, const char *buf,
 	return count;
 }
 
-static ssize_t store_up_threshold(struct dbs_data *dbs_data, const char *buf,
-		size_t count)
-{
-	unsigned int input;
-	int ret;
-	ret = sscanf(buf, "%u", &input);
-
-	if (ret != 1 || input > MAX_FREQUENCY_UP_THRESHOLD ||
-			input < MIN_FREQUENCY_UP_THRESHOLD) {
-		return -EINVAL;
-	}
-
-	dbs_data->up_threshold = input;
-	return count;
-}
-
-static ssize_t store_sampling_down_factor(struct dbs_data *dbs_data,
-		const char *buf, size_t count)
+static void update_sampling_down_factor(struct dbs_data *dbs_data)
 {
-	unsigned int input, j;
-	int ret;
-	ret = sscanf(buf, "%u", &input);
-
-	if (ret != 1 || input > MAX_SAMPLING_DOWN_FACTOR || input < 1)
-		return -EINVAL;
-	dbs_data->sampling_down_factor = input;
+	unsigned int j;
 
 	/* Reset down sampling multiplier in case it was active */
-	for_each_online_cpu(j) {
-		struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info,
-				j);
-		dbs_info->rate_mult = 1;
-	}
-	return count;
+	for_each_online_cpu(j)
+		per_cpu(od_cpu_dbs_info, j).rate_mult = 1;
 }
 
-static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
-		const char *buf, size_t count)
+static void update_ignore_nice_load(struct dbs_data *dbs_data)
 {
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
-	unsigned int input;
-	int ret;
-
+	struct od_cpu_dbs_info_s *dbs_info;
 	unsigned int j;
 
-	ret = sscanf(buf, "%u", &input);
-	if (ret != 1)
-		return -EINVAL;
-
-	if (input > 1)
-		input = 1;
-
-	if (input == dbs_data->ignore_nice_load) { /* nothing to do */
-		return count;
-	}
-	dbs_data->ignore_nice_load = input;
-
-	/* we need to re-evaluate prev_cpu_idle */
 	for_each_online_cpu(j) {
-		struct od_cpu_dbs_info_s *dbs_info;
 		dbs_info = &per_cpu(od_cpu_dbs_info, j);
 		dbs_info->cdbs.prev_cpu_idle = get_cpu_idle_time(j,
 			&dbs_info->cdbs.prev_cpu_wall, od_tuners->io_is_busy);
@@ -381,7 +331,6 @@ static ssize_t store_ignore_nice_load(struct dbs_data *dbs_data,
 				kcpustat_cpu(j).cpustat[CPUTIME_NICE];
 
 	}
-	return count;
 }
 
 static ssize_t store_powersave_bias(struct dbs_data *dbs_data, const char *buf,
@@ -403,21 +352,11 @@ static ssize_t store_powersave_bias(struct dbs_data *dbs_data, const char *buf,
 	return count;
 }
 
-gov_show_one_common(sampling_rate);
-gov_show_one_common(up_threshold);
-gov_show_one_common(sampling_down_factor);
-gov_show_one_common(ignore_nice_load);
-gov_show_one_common(min_sampling_rate);
 gov_show_one(od, io_is_busy);
 gov_show_one(od, powersave_bias);
 
-gov_attr_rw(sampling_rate);
-gov_attr_rw(io_is_busy);
-gov_attr_rw(up_threshold);
-gov_attr_rw(sampling_down_factor);
-gov_attr_rw(ignore_nice_load);
-gov_attr_rw(powersave_bias);
-gov_attr_ro(min_sampling_rate);
+static gov_attr_rw(io_is_busy);
+static gov_attr_rw(powersave_bias);
 
 static struct attribute *od_attributes[] = {
 	&min_sampling_rate.attr,
@@ -499,6 +438,11 @@ static struct dbs_governor od_dbs_gov = {
 	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
 	.gov_dbs_timer = od_dbs_timer,
 	.gov_check_cpu = od_check_cpu,
+	.update_sampling_rate = update_sampling_rate,
+	.invalid_up_threshold = invalid_up_threshold,
+	.invalid_sampling_down_factor = invalid_sampling_down_factor,
+	.update_sampling_down_factor = update_sampling_down_factor,
+	.update_ignore_nice_load = update_ignore_nice_load,
 	.gov_ops = &od_ops,
 	.init = od_init,
 	.exit = od_exit,
-- 
2.7.1.370.gb2aa7f8

