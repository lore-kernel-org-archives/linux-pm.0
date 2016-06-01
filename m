From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/2] cpufreq: Optimize cpufreq_frequency_table_target()
Date: Wed,  1 Jun 2016 16:09:55 +0530
Message-ID: <120ed8a873b6df2ccc9406eeec8f8f74e5f9b0d5.1464777376.git.viresh.kumar@linaro.org>
References: <cover.1464777376.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464777376.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464777376.git.viresh.kumar@linaro.org>
References: <cover.1464777376.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, smuckle@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

cpufreq core keeps another table of sorted frequencies now and that can
be used to find a match quickly, instead of traversing the unsorted list
in an inefficient way.

Create helper routines for separate relation types to optimize it
further.

Ideally the new routine cpufreq_find_target_index() is required to be
exported, but s3c24xx was abusing the earlier API and have to be
supported for now. Added a FIXME for it.

Tested on Exynos board with both ondemand and schedutil governor and
confirmed with help of various print messages that we are eventually
switching to the desired frequency based on a target frequency.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c    |  15 ++--
 drivers/cpufreq/freq_table.c      | 180 ++++++++++++++++++++++----------------
 drivers/cpufreq/s3c24xx-cpufreq.c |  13 ++-
 include/linux/cpufreq.h           |  20 ++++-
 4 files changed, 134 insertions(+), 94 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 32a15052f363..4f9f7504a17c 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -468,20 +468,15 @@ unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	struct acpi_cpufreq_data *data = policy->driver_data;
 	struct acpi_processor_performance *perf;
 	struct cpufreq_frequency_table *entry;
-	unsigned int next_perf_state, next_freq, freq;
+	unsigned int next_perf_state, next_freq, index;
 
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
+	index = cpufreq_frequency_table_target(policy, target_freq,
+					       CPUFREQ_RELATION_L);
+
+	entry = &policy->freq_table[index];
 	next_freq = entry->frequency;
 	next_perf_state = entry->driver_data;
 
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index d536136c8e1f..15c4a2462c68 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -114,99 +114,131 @@ int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
 
-int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
-				    unsigned int target_freq,
-				    unsigned int relation)
+static int cpufreq_find_target_index_l(struct cpufreq_policy *policy,
+				       struct cpufreq_frequency_table *table,
+				       unsigned int target_freq)
 {
-	struct cpufreq_frequency_table optimal = {
-		.driver_data = ~0,
-		.frequency = 0,
-	};
-	struct cpufreq_frequency_table suboptimal = {
-		.driver_data = ~0,
-		.frequency = 0,
-	};
-	struct cpufreq_frequency_table *pos;
-	struct cpufreq_frequency_table *table = policy->freq_table;
-	unsigned int freq, diff, i = 0;
-	int index;
+	struct cpufreq_frequency_table *pos, *best = NULL;
+	unsigned int freq;
 
-	pr_debug("request for target %u kHz (relation: %u) for cpu %u\n",
-					target_freq, relation, policy->cpu);
+	cpufreq_for_each_valid_entry(pos, table) {
+		freq = pos->frequency;
 
-	switch (relation) {
-	case CPUFREQ_RELATION_H:
-		suboptimal.frequency = ~0;
-		break;
-	case CPUFREQ_RELATION_L:
-	case CPUFREQ_RELATION_C:
-		optimal.frequency = ~0;
+		if ((freq < policy->min) || (freq > policy->max))
+			continue;
+
+		if (freq >= target_freq)
+			return pos - table;
+
+		best = pos;
+	}
+
+	if (best)
+		return best - table;
+
+	return -EINVAL;
+}
+
+static int cpufreq_find_target_index_h(struct cpufreq_policy *policy,
+				       struct cpufreq_frequency_table *table,
+				       unsigned int target_freq)
+{
+	struct cpufreq_frequency_table *pos, *best = NULL;
+	unsigned int freq;
+
+	cpufreq_for_each_valid_entry(pos, table) {
+		freq = pos->frequency;
+
+		if ((freq < policy->min) || (freq > policy->max))
+			continue;
+
+		if (freq == target_freq)
+			return pos - table;
+
+		if (freq < target_freq) {
+			best = pos;
+			continue;
+		}
+
+		/* No freq found below target_freq */
+		if (!best)
+			best = pos;
 		break;
 	}
 
+	if (best)
+		return best - table;
+
+	return -EINVAL;
+}
+
+static int cpufreq_find_target_index_c(struct cpufreq_policy *policy,
+				       struct cpufreq_frequency_table *table,
+				       unsigned int target_freq)
+{
+	struct cpufreq_frequency_table *pos, *best = NULL;
+	unsigned int freq;
+
 	cpufreq_for_each_valid_entry(pos, table) {
 		freq = pos->frequency;
 
-		i = pos - table;
 		if ((freq < policy->min) || (freq > policy->max))
 			continue;
-		if (freq == target_freq) {
-			optimal.driver_data = i;
-			break;
+
+		if (freq == target_freq)
+			return pos - table;
+
+		if (freq < target_freq) {
+			best = pos;
+			continue;
 		}
-		switch (relation) {
-		case CPUFREQ_RELATION_H:
-			if (freq < target_freq) {
-				if (freq >= optimal.frequency) {
-					optimal.frequency = freq;
-					optimal.driver_data = i;
-				}
-			} else {
-				if (freq <= suboptimal.frequency) {
-					suboptimal.frequency = freq;
-					suboptimal.driver_data = i;
-				}
-			}
-			break;
-		case CPUFREQ_RELATION_L:
-			if (freq > target_freq) {
-				if (freq <= optimal.frequency) {
-					optimal.frequency = freq;
-					optimal.driver_data = i;
-				}
-			} else {
-				if (freq >= suboptimal.frequency) {
-					suboptimal.frequency = freq;
-					suboptimal.driver_data = i;
-				}
-			}
-			break;
-		case CPUFREQ_RELATION_C:
-			diff = abs(freq - target_freq);
-			if (diff < optimal.frequency ||
-			    (diff == optimal.frequency &&
-			     freq > table[optimal.driver_data].frequency)) {
-				optimal.frequency = diff;
-				optimal.driver_data = i;
-			}
+
+		/* No freq found below target_freq */
+		if (!best) {
+			best = pos;
 			break;
 		}
+
+		/* Choose the closest freq */
+		if (target_freq - best->frequency > freq - target_freq)
+			best = pos;
+
+		break;
+	}
+
+	if (best)
+		return best - table;
+
+	return -EINVAL;
+}
+
+int cpufreq_find_target_index(struct cpufreq_policy *policy,
+			      struct cpufreq_frequency_table *table,
+			      unsigned int target_freq, unsigned int relation)
+{
+	int index;
+
+	switch (relation) {
+	case CPUFREQ_RELATION_L:
+		index = cpufreq_find_target_index_l(policy, table, target_freq);
+		break;
+	case CPUFREQ_RELATION_H:
+		index = cpufreq_find_target_index_h(policy, table, target_freq);
+		break;
+	case CPUFREQ_RELATION_C:
+		index = cpufreq_find_target_index_c(policy, table, target_freq);
+		break;
+	default:
+		pr_err("%s: Invalid relation: %d\n", __func__, relation);
+		return -EINVAL;
 	}
-	if (optimal.driver_data > i) {
-		if (suboptimal.driver_data > i) {
-			WARN(1, "Invalid frequency table: %d\n", policy->cpu);
-			return 0;
-		}
 
-		index = suboptimal.driver_data;
-	} else
-		index = optimal.driver_data;
+	if (index == -EINVAL)
+		WARN(1, "Invalid frequency table: %d\n", policy->cpu);
 
-	pr_debug("target index is %u, freq is:%u kHz\n", index,
-		 table[index].frequency);
 	return index;
 }
-EXPORT_SYMBOL_GPL(cpufreq_frequency_table_target);
+EXPORT_SYMBOL_GPL(cpufreq_find_target_index);
 
 int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
 		unsigned int freq)
diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 7b596fa38ad2..c9c2b4151b9f 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -318,14 +318,13 @@ static int s3c_cpufreq_target(struct cpufreq_policy *policy,
 		tmp_policy.min = policy->min * 1000;
 		tmp_policy.max = policy->max * 1000;
 		tmp_policy.cpu = policy->cpu;
-		tmp_policy.freq_table = pll_reg;
 
-		/* cpufreq_frequency_table_target returns the index
-		 * of the table entry, not the value of
-		 * the table entry's index field. */
-
-		index = cpufreq_frequency_table_target(&tmp_policy, target_freq,
-						       relation);
+		/*
+		 * FIXME: We should be providing this freq-table to the cpufreq
+		 * core instead of managing it ourselves here.
+		 */
+		index = cpufreq_find_target_index(&tmp_policy, pll_reg,
+						  target_freq, relation);
 		pll = pll_reg + index;
 
 		s3c_freq_dbg("%s: target %u => %u\n",
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 5e23eed2252c..5aabec611e87 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -600,14 +600,28 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table);
 int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy);
 
-int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
-				   unsigned int target_freq,
-				   unsigned int relation);
+int cpufreq_find_target_index(struct cpufreq_policy *policy,
+			      struct cpufreq_frequency_table *table,
+			      unsigned int target_freq, unsigned int relation);
 int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
 		unsigned int freq);
 
 ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf);
 
+/*
+ * Search in the sorted freq table local to the core and return index of
+ * policy->freq_table.
+ */
+static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
+						 unsigned int target_freq,
+						 unsigned int relation)
+{
+	int index = cpufreq_find_target_index(policy, policy->sorted_freq_table,
+					      target_freq, relation);
+
+	return policy->sorted_freq_table[index].driver_data;
+}
+
 #ifdef CONFIG_CPU_FREQ
 int cpufreq_boost_trigger_state(int state);
 int cpufreq_boost_enabled(void);
-- 
2.7.1.410.g6faf27b
