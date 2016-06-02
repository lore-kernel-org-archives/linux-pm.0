From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/11] cpufreq: Keep a single (sorted) freq_table
Date: Thu,  2 Jun 2016 19:49:10 +0530
Message-ID: <468e26b3f145e251299711acdd74172107740b7b.1464876460.git.viresh.kumar@linaro.org>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464876460.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464876460.git.viresh.kumar@linaro.org>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Shawn Guo <shawn.guo@freescale.com>, Steven Miao <realmz6@gmail.com>
List-Id: linux-pm@vger.kernel.org

Now that all drivers providing ->target_index() callback are updated to
use 'index' only for indexing into policy->freq_table, we can safely
avoid keeping two separate freq-tables.

Which also means that cpufreq core doesn't use the freq_table passed to
cpufreq_table_validate_and_show(), once that routine has returned.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c    |  6 +-----
 drivers/cpufreq/freq_table.c | 36 ++++++++++++++----------------------
 include/linux/cpufreq.h      |  9 ++-------
 3 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 10c5f7abc205..47983cb0601d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1143,7 +1143,7 @@ static void cpufreq_policy_exit(struct cpufreq_policy *policy)
 		return;
 
 	cpufreq_driver->exit(policy);
-	free_sorted_freq_table(policy);
+	kfree(policy->freq_table);
 	policy->freq_table = NULL;
 }
 
@@ -1188,10 +1188,6 @@ static int cpufreq_online(unsigned int cpu)
 		goto out_free_policy;
 	}
 
-	ret = create_sorted_freq_table(policy);
-	if (ret)
-		goto out_exit_policy;
-
 	down_write(&policy->rwsem);
 
 	if (new_policy) {
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 15c4a2462c68..7afe2c017267 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -350,20 +350,11 @@ static int next_larger(struct cpufreq_policy *policy, unsigned int freq,
 	return index;
 }
 
-void free_sorted_freq_table(struct cpufreq_policy *policy)
-{
-	kfree(policy->sorted_freq_table);
-	policy->sorted_freq_table = NULL;
-}
-
-int create_sorted_freq_table(struct cpufreq_policy *policy)
+static int create_sorted_freq_table(struct cpufreq_policy *policy,
+				    struct cpufreq_frequency_table *table)
 {
 	struct cpufreq_frequency_table *pos, *new_table;
 	unsigned int freq, index, i, count = 0;
-	struct cpufreq_frequency_table *table = policy->freq_table;
-
-	if (!table)
-		return 0;
 
 	cpufreq_for_each_valid_entry(pos, table)
 		count++;
@@ -380,31 +371,32 @@ int create_sorted_freq_table(struct cpufreq_policy *policy)
 		if (index == -EINVAL)
 			break;
 
-		/*
-		 * driver_data of the sorted table points to the index of the
-		 * unsorted table.
-		 */
-		new_table[i].driver_data = index;
 		new_table[i].frequency = table[index].frequency;
+		new_table[i].driver_data = table[index].driver_data;
+		new_table[i].flags = table[index].flags;
 
 		freq = table[index].frequency;
 	}
 
 	new_table[i].frequency = CPUFREQ_TABLE_END;
-	policy->sorted_freq_table = new_table;
+	policy->freq_table = new_table;
 
 	return 0;
 }
 
 int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
-				      struct cpufreq_frequency_table *table)
+				    struct cpufreq_frequency_table *table)
 {
-	int ret = cpufreq_frequency_table_cpuinfo(policy, table);
+	int ret;
+
+	if (!table)
+		return -EINVAL;
 
-	if (!ret)
-		policy->freq_table = table;
+	ret = cpufreq_frequency_table_cpuinfo(policy, table);
+	if (ret)
+		return ret;
 
-	return ret;
+	return create_sorted_freq_table(policy, table);
 }
 EXPORT_SYMBOL_GPL(cpufreq_table_validate_and_show);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 5aabec611e87..9df7c569cfbb 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -87,7 +87,6 @@ struct cpufreq_policy {
 
 	struct cpufreq_user_policy user_policy;
 	struct cpufreq_frequency_table	*freq_table;
-	struct cpufreq_frequency_table	*sorted_freq_table;
 
 	struct list_head        policy_list;
 	struct kobject		kobj;
@@ -593,8 +592,6 @@ static inline void dev_pm_opp_free_cpufreq_table(struct device *dev,
 
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 				    struct cpufreq_frequency_table *table);
-int create_sorted_freq_table(struct cpufreq_policy *policy);
-void free_sorted_freq_table(struct cpufreq_policy *policy);
 
 int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table);
@@ -616,10 +613,8 @@ static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 						 unsigned int target_freq,
 						 unsigned int relation)
 {
-	int index = cpufreq_find_target_index(policy, policy->sorted_freq_table,
-					      target_freq, relation);
-
-	return policy->sorted_freq_table[index].driver_data;
+	return cpufreq_find_target_index(policy, policy->freq_table,
+					 target_freq, relation);
 }
 
 #ifdef CONFIG_CPU_FREQ
-- 
2.7.1.410.g6faf27b
