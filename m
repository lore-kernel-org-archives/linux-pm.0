From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/2] cpufreq: Implement cpufreq_find_target_index() to traverse sorted list
Date: Tue, 31 May 2016 17:06:03 +0530
Message-ID: <dbb027770709f856b61db270a6f045fe74da8612.1464694144.git.viresh.kumar@linaro.org>
References: <cover.1464694144.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35539 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcEaLgO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 07:36:14 -0400
Received: by mail-pf0-f179.google.com with SMTP id g64so74096581pfb.2
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2016 04:36:14 -0700 (PDT)
In-Reply-To: <cover.1464694144.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464694144.git.viresh.kumar@linaro.org>
References: <cover.1464694144.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, smuckle@linaro.org

cpufreq core keeps another table of sorted frequencies and that can be
used to find a match quickly, instead of relying on
cpufreq_frequency_table_target() which will be very inefficient
comparatively.

The new routine(s) traverse the table of sorted frequencies and return
an index into the policy->freq_table which is used everywhere else in
the code.

Few important users of cpufreq_frequency_table_target() are also
migrated to use it.

Tested on Exynos board with both ondemand schedutil governor and
confirmed with help of various print messages that we are eventually
switching to the desired frequency based on a target frequency.

Note that migrating all other users of cpufreq_frequency_table_target()
will require some cleanups first and so that will be done separately.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c |  18 +++---
 drivers/cpufreq/cpufreq.c      |  25 +++------
 drivers/cpufreq/freq_table.c   | 124 +++++++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h        |   4 ++
 4 files changed, 145 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 32a15052f363..0b47a4ed7130 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -468,20 +468,18 @@ unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	struct acpi_cpufreq_data *data = policy->driver_data;
 	struct acpi_processor_performance *perf;
 	struct cpufreq_frequency_table *entry;
-	unsigned int next_perf_state, next_freq, freq;
+	unsigned int next_perf_state, next_freq, index;
+	int ret;
 
 	/*
 	 * Find the closest frequency above target_freq.
-	 *
-	 * The table is sorted in the reverse order with respect to the
-	 * frequency and all of the entries are valid (see the initialization).
 	 */
-	entry = policy->freq_table;
-	do {
-		entry++;
-		freq = entry->frequency;
-	} while (freq >= target_freq && freq != CPUFREQ_TABLE_END);
-	entry--;
+	ret = cpufreq_find_target_index(policy, target_freq, CPUFREQ_RELATION_L,
+					&index);
+	if (WARN_ON(ret))
+		return 0;
+
+	entry = &policy->freq_table[index];
 	next_freq = entry->frequency;
 	next_perf_state = entry->driver_data;
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a6bdb55350f4..712a4564c59b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1870,14 +1870,17 @@ static int __target_intermediate(struct cpufreq_policy *policy,
 	return ret;
 }
 
-static int __target_index(struct cpufreq_policy *policy,
-			  struct cpufreq_frequency_table *freq_table, int index)
+static int __target_index(struct cpufreq_policy *policy, int index)
 {
 	struct cpufreq_freqs freqs = {.old = policy->cur, .flags = 0};
+	unsigned int new_freq = policy->freq_table[index].frequency;
 	unsigned int intermediate_freq = 0;
 	int retval = -EINVAL;
 	bool notify;
 
+	if (new_freq == policy->cur)
+		return 0;
+
 	notify = !(cpufreq_driver->flags & CPUFREQ_ASYNC_NOTIFICATION);
 	if (notify) {
 		/* Handle switching to intermediate frequency */
@@ -1892,7 +1895,7 @@ static int __target_index(struct cpufreq_policy *policy,
 				freqs.old = freqs.new;
 		}
 
-		freqs.new = freq_table[index].frequency;
+		freqs.new = new_freq;
 		pr_debug("%s: cpu: %d, oldfreq: %u, new freq: %u\n",
 			 __func__, policy->cpu, freqs.old, freqs.new);
 
@@ -1929,7 +1932,6 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int relation)
 {
 	unsigned int old_target_freq = target_freq;
-	struct cpufreq_frequency_table *freq_table;
 	int index, retval;
 
 	if (cpufreq_disabled())
@@ -1959,23 +1961,14 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
 
-	freq_table = cpufreq_frequency_get_table(policy->cpu);
-	if (unlikely(!freq_table)) {
-		pr_err("%s: Unable to find freq_table\n", __func__);
-		return -EINVAL;
-	}
-
-	retval = cpufreq_frequency_table_target(policy, freq_table, target_freq,
-						relation, &index);
+	retval = cpufreq_find_target_index(policy, target_freq, relation,
+					   &index);
 	if (unlikely(retval)) {
 		pr_err("%s: Unable to find matching freq\n", __func__);
 		return retval;
 	}
 
-	if (freq_table[index].frequency == policy->cur)
-		return 0;
-
-	return __target_index(policy, freq_table, index);
+	return __target_index(policy, index);
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index ba97912973c4..5217d93f1ab8 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -116,6 +116,130 @@ int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
 
+static int cpufreq_find_target_index_l(struct cpufreq_policy *policy,
+				       unsigned int target_freq)
+{
+	struct cpufreq_frequency_table *pos, *best = NULL;
+	unsigned int freq;
+
+	cpufreq_for_each_valid_entry(pos, policy->sorted_freq_table) {
+		freq = pos->frequency;
+
+		if ((freq < policy->min) || (freq > policy->max))
+			continue;
+
+		if (freq >= target_freq)
+			return pos->driver_data;
+
+		best = pos;
+	}
+
+	if (best)
+		return best->driver_data;
+
+	return -EINVAL;
+}
+
+static int cpufreq_find_target_index_h(struct cpufreq_policy *policy,
+				       unsigned int target_freq)
+{
+	struct cpufreq_frequency_table *pos, *best = NULL;
+	unsigned int freq;
+
+	cpufreq_for_each_valid_entry(pos, policy->sorted_freq_table) {
+		freq = pos->frequency;
+
+		if ((freq < policy->min) || (freq > policy->max))
+			continue;
+
+		if (freq == target_freq)
+			return pos->driver_data;
+
+		if (freq < target_freq) {
+			best = pos;
+			continue;
+		}
+
+		/* No freq found below target_freq */
+		if (!best)
+			best = pos;
+		break;
+	}
+
+	if (best)
+		return best->driver_data;
+
+	return -EINVAL;
+}
+
+static int cpufreq_find_target_index_c(struct cpufreq_policy *policy,
+				       unsigned int target_freq)
+{
+	struct cpufreq_frequency_table *pos, *best = NULL;
+	unsigned int freq;
+
+	cpufreq_for_each_valid_entry(pos, policy->sorted_freq_table) {
+		freq = pos->frequency;
+
+		if ((freq < policy->min) || (freq > policy->max))
+			continue;
+
+		if (freq == target_freq)
+			return pos->driver_data;
+
+		if (freq < target_freq) {
+			best = pos;
+			continue;
+		}
+
+		/* No freq found below target_freq */
+		if (!best) {
+			best = pos;
+			break;
+		}
+
+		/* Choose the closest freq */
+		if (target_freq - best->frequency > freq - target_freq)
+			best = pos;
+
+		break;
+	}
+
+	if (best)
+		return best->driver_data;
+
+	return -EINVAL;
+}
+
+int cpufreq_find_target_index(struct cpufreq_policy *policy,
+			      unsigned int target_freq, unsigned int relation,
+			      unsigned int *index)
+{
+	int new_index;
+
+	switch (relation) {
+	case CPUFREQ_RELATION_L:
+		new_index = cpufreq_find_target_index_l(policy, target_freq);
+		break;
+	case CPUFREQ_RELATION_H:
+		new_index = cpufreq_find_target_index_h(policy, target_freq);
+		break;
+	case CPUFREQ_RELATION_C:
+		new_index = cpufreq_find_target_index_c(policy, target_freq);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (new_index == -EINVAL)
+		return new_index;
+
+	*index = new_index;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_find_target_index);
+
+/* Deprecated */
 int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table,
 				   unsigned int target_freq,
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 08cf508948dd..03e88fb3d2c0 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -600,6 +600,10 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table);
 int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy);
 
+int cpufreq_find_target_index(struct cpufreq_policy *policy,
+			      unsigned int target_freq, unsigned int relation,
+			      unsigned int *index);
+/* Deprecated */
 int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table,
 				   unsigned int target_freq,
-- 
2.7.1.410.g6faf27b

