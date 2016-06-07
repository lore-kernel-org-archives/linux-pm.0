From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 1/2] cpufreq: Handle sorted frequency tables more efficiently
Date: Tue,  7 Jun 2016 15:55:14 +0530
Message-ID: <c80f4bf69bd4eb739038cb0f91392fad9cfde59f.1465295033.git.viresh.kumar@linaro.org>
References: <cover.1465295033.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1465295033.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1465295033.git.viresh.kumar@linaro.org>
References: <cover.1465295033.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org
List-Id: linux-pm@vger.kernel.org

cpufreq drivers aren't required to provide a sorted frequency table
today, and even the ones which provide a sorted table aren't handled
efficiently by cpufreq core.

This patch adds infrastructure to verify if the freq-table provided by
the drivers is sorted or not, and use efficient helpers if they are
sorted.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/freq_table.c |  67 +++++++++-
 include/linux/cpufreq.h      | 284 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 343 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index eac8bcbdaad1..0c1139a5f33a 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -113,9 +113,9 @@ int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
 
-int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
-				    unsigned int target_freq,
-				    unsigned int relation)
+int cpufreq_table_find_index_unsorted(struct cpufreq_policy *policy,
+				      unsigned int target_freq,
+				      unsigned int relation)
 {
 	struct cpufreq_frequency_table optimal = {
 		.driver_data = ~0,
@@ -205,7 +205,7 @@ int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 		 table[index].frequency);
 	return index;
 }
-EXPORT_SYMBOL_GPL(cpufreq_frequency_table_target);
+EXPORT_SYMBOL_GPL(cpufreq_table_find_index_unsorted);
 
 int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
 		unsigned int freq)
@@ -297,13 +297,70 @@ struct freq_attr *cpufreq_generic_attr[] = {
 };
 EXPORT_SYMBOL_GPL(cpufreq_generic_attr);
 
+static void set_freq_table_sorted(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
+	struct cpufreq_frequency_table *prev = NULL;
+	int ascending = 0;
+
+	cpufreq_for_each_valid_entry(pos, table) {
+		if (!prev) {
+			prev = pos;
+			continue;
+		}
+
+		if (pos->frequency == prev->frequency) {
+			pr_warn("Duplicate freq-table entries: %u\n",
+				pos->frequency);
+			continue;
+		}
+
+		/* Frequency increased from prev to pos */
+		if (pos->frequency > prev->frequency) {
+			/* But frequency was decreasing earlier */
+			if (ascending < 0) {
+				policy->freq_table_sorted = false;
+				pr_debug("Freq table is unsorted\n");
+				return;
+			}
+
+			ascending++;
+		} else {
+			/* Frequency decreased from prev to pos */
+
+			/* But frequency was increasing earlier */
+			if (ascending > 0) {
+				policy->freq_table_sorted = false;
+				pr_debug("Freq table is unsorted\n");
+				return;
+			}
+
+			ascending--;
+		}
+
+		prev = pos;
+	}
+
+	policy->freq_table_sorted = true;
+
+	if (ascending > 0)
+		policy->freq_table_sorted_ascending = true;
+	else
+		policy->freq_table_sorted_ascending = false;
+
+	pr_debug("Freq table is sorted in %s order\n",
+		 ascending > 0 ? "ascending" : "descending");
+}
+
 int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
 				      struct cpufreq_frequency_table *table)
 {
 	int ret = cpufreq_frequency_table_cpuinfo(policy, table);
 
-	if (!ret)
+	if (!ret) {
 		policy->freq_table = table;
+		set_freq_table_sorted(policy);
+	}
 
 	return ret;
 }
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c378776628b4..5133570e86f2 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -86,7 +86,11 @@ struct cpufreq_policy {
 					 * called, but you're in IRQ context */
 
 	struct cpufreq_user_policy user_policy;
+
+	/* Freq-table and its flags */
 	struct cpufreq_frequency_table	*freq_table;
+	bool			freq_table_sorted;
+	bool			freq_table_sorted_ascending;
 
 	struct list_head        policy_list;
 	struct kobject		kobj;
@@ -597,9 +601,9 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table);
 int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy);
 
-int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
-				   unsigned int target_freq,
-				   unsigned int relation);
+int cpufreq_table_find_index_unsorted(struct cpufreq_policy *policy,
+				      unsigned int target_freq,
+				      unsigned int relation);
 int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
 		unsigned int freq);
 
@@ -610,6 +614,280 @@ int cpufreq_boost_trigger_state(int state);
 int cpufreq_boost_enabled(void);
 int cpufreq_enable_boost_support(void);
 bool policy_has_boost_freq(struct cpufreq_policy *policy);
+
+static inline bool freq_is_invalid(struct cpufreq_policy *policy, unsigned int frequency)
+{
+	if (unlikely(frequency == CPUFREQ_ENTRY_INVALID))
+		return true;
+
+	if (unlikely((frequency < policy->min) || (frequency > policy->max)))
+		return true;
+
+	return false;
+}
+
+/* Find lowest freq at or above target in a table in ascending order */
+static inline int cpufreq_table_find_index_al(struct cpufreq_policy *policy,
+					      unsigned int target_freq)
+{
+	struct cpufreq_frequency_table *table = policy->freq_table;
+	unsigned int freq;
+	int i, best = -1;
+
+	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
+		freq = table[i].frequency;
+
+		if (freq_is_invalid(policy, freq))
+			continue;
+
+		if (freq >= target_freq)
+			return i;
+
+		best = i;
+	}
+
+	if (best == -1) {
+		WARN(1, "Invalid frequency table: %d\n", policy->cpu);
+		return -EINVAL;
+	}
+
+	return best;
+}
+
+/* Find lowest freq at or above target in a table in descending order */
+static inline int cpufreq_table_find_index_dl(struct cpufreq_policy *policy,
+					      unsigned int target_freq)
+{
+	struct cpufreq_frequency_table *table = policy->freq_table;
+	unsigned int freq;
+	int i, best = -1;
+
+	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
+		freq = table[i].frequency;
+
+		if (freq_is_invalid(policy, freq))
+			continue;
+
+		if (freq == target_freq)
+			return i;
+
+		if (freq > target_freq) {
+			best = i;
+			continue;
+		}
+
+		/* No freq found below target_freq */
+		if (best == -1)
+			return i;
+
+		return best;
+	}
+
+	if (best == -1) {
+		WARN(1, "Invalid frequency table: %d\n", policy->cpu);
+		return -EINVAL;
+	}
+
+	return best;
+}
+
+/* Works only on sorted freq-tables */
+static inline int cpufreq_table_find_index_l(struct cpufreq_policy *policy,
+					     unsigned int target_freq)
+{
+	if (policy->freq_table_sorted_ascending)
+		return cpufreq_table_find_index_al(policy, target_freq);
+	else
+		return cpufreq_table_find_index_dl(policy, target_freq);
+}
+
+/* Find highest freq at or below target in a table in ascending order */
+static inline int cpufreq_table_find_index_ah(struct cpufreq_policy *policy,
+					      unsigned int target_freq)
+{
+	struct cpufreq_frequency_table *table = policy->freq_table;
+	unsigned int freq;
+	int i, best = -1;
+
+	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
+		freq = table[i].frequency;
+
+		if (freq_is_invalid(policy, freq))
+			continue;
+
+		if (freq == target_freq)
+			return i;
+
+		if (freq < target_freq) {
+			best = i;
+			continue;
+		}
+
+		/* No freq found below target_freq */
+		if (best == -1)
+			return i;
+
+		return best;
+	}
+
+	if (best == -1) {
+		WARN(1, "Invalid frequency table: %d\n", policy->cpu);
+		return -EINVAL;
+	}
+
+	return best;
+}
+
+/* Find highest freq at or below target in a table in descending order */
+static inline int cpufreq_table_find_index_dh(struct cpufreq_policy *policy,
+					      unsigned int target_freq)
+{
+	struct cpufreq_frequency_table *table = policy->freq_table;
+	unsigned int freq;
+	int i, best = -1;
+
+	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
+		freq = table[i].frequency;
+
+		if (freq_is_invalid(policy, freq))
+			continue;
+
+		if (freq <= target_freq)
+			return i;
+
+		best = i;
+	}
+
+	if (best == -1) {
+		WARN(1, "Invalid frequency table: %d\n", policy->cpu);
+		return -EINVAL;
+	}
+
+	return best;
+}
+
+/* Works only on sorted freq-tables */
+static inline int cpufreq_table_find_index_h(struct cpufreq_policy *policy,
+					     unsigned int target_freq)
+{
+	if (policy->freq_table_sorted_ascending)
+		return cpufreq_table_find_index_ah(policy, target_freq);
+	else
+		return cpufreq_table_find_index_dh(policy, target_freq);
+}
+
+/* Find closest freq to target in a table in ascending order */
+static inline int cpufreq_table_find_index_ac(struct cpufreq_policy *policy,
+					      unsigned int target_freq)
+{
+	struct cpufreq_frequency_table *table = policy->freq_table;
+	unsigned int freq;
+	int i, best = -1;
+
+	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
+		freq = table[i].frequency;
+
+		if (freq_is_invalid(policy, freq))
+			continue;
+
+		if (freq == target_freq)
+			return i;
+
+		if (freq < target_freq) {
+			best = i;
+			continue;
+		}
+
+		/* No freq found below target_freq */
+		if (best == -1)
+			return i;
+
+		/* Choose the closest freq */
+		if (target_freq - table[best].frequency > freq - target_freq)
+			return i;
+
+		return best;
+	}
+
+	if (best == -1) {
+		WARN(1, "Invalid frequency table: %d\n", policy->cpu);
+		return -EINVAL;
+	}
+
+	return best;
+}
+
+/* Find closest freq to target in a table in descending order */
+static inline int cpufreq_table_find_index_dc(struct cpufreq_policy *policy,
+					      unsigned int target_freq)
+{
+	struct cpufreq_frequency_table *table = policy->freq_table;
+	unsigned int freq;
+	int i, best = -1;
+
+	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
+		freq = table[i].frequency;
+
+		if (freq_is_invalid(policy, freq))
+			continue;
+
+		if (freq == target_freq)
+			return i;
+
+		if (freq > target_freq) {
+			best = i;
+			continue;
+		}
+
+		/* No freq found below target_freq */
+		if (best == -1)
+			return i;
+
+		/* Choose the closest freq */
+		if (target_freq - table[best].frequency > freq - target_freq)
+			return i;
+
+		return best;
+	}
+
+	if (best == -1) {
+		WARN(1, "Invalid frequency table: %d\n", policy->cpu);
+		return -EINVAL;
+	}
+
+	return best;
+}
+
+/* Works only on sorted freq-tables */
+static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
+					     unsigned int target_freq)
+{
+	if (policy->freq_table_sorted_ascending)
+		return cpufreq_table_find_index_ac(policy, target_freq);
+	else
+		return cpufreq_table_find_index_dc(policy, target_freq);
+}
+
+static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
+						 unsigned int target_freq,
+						 unsigned int relation)
+{
+	if (unlikely(!policy->freq_table_sorted))
+		return cpufreq_table_find_index_unsorted(policy, target_freq,
+							 relation);
+
+	switch (relation) {
+	case CPUFREQ_RELATION_L:
+		return cpufreq_table_find_index_l(policy, target_freq);
+	case CPUFREQ_RELATION_H:
+		return cpufreq_table_find_index_h(policy, target_freq);
+	case CPUFREQ_RELATION_C:
+		return cpufreq_table_find_index_c(policy, target_freq);
+	default:
+		pr_err("%s: Invalid relation: %d\n", __func__, relation);
+		return -EINVAL;
+	}
+}
 #else
 static inline int cpufreq_boost_trigger_state(int state)
 {
-- 
2.7.1.410.g6faf27b
