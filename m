From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] cpufreq: Store sorted frequency table
Date: Tue, 31 May 2016 17:06:02 +0530
Message-ID: <d2137fb768df7893be94d3c8c7495e93645b7b9c.1464694144.git.viresh.kumar@linaro.org>
References: <cover.1464694144.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35530 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcEaLgL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 07:36:11 -0400
Received: by mail-pf0-f182.google.com with SMTP id g64so74096170pfb.2
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2016 04:36:10 -0700 (PDT)
In-Reply-To: <cover.1464694144.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464694144.git.viresh.kumar@linaro.org>
References: <cover.1464694144.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, smuckle@linaro.org

The drivers aren't required to provide a sorted frequency table today,
and its not optimal to work on an unsorted freq table.

To simplify and improve code performance, create a frequency table
within core and keep it sorted in ascending order.

Note that this should eventually replace policy->freq_table itself,
which isn't done currently as few drivers will break due to that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c    | 23 ++++++++++-----
 drivers/cpufreq/freq_table.c | 67 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h      |  3 ++
 3 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c6a14ba239a2..a6bdb55350f4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1146,6 +1146,16 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy, bool notify)
 	kfree(policy);
 }
 
+static void cpufreq_policy_exit(struct cpufreq_policy *policy)
+{
+	if (!cpufreq_driver->exit)
+		return;
+
+	cpufreq_driver->exit(policy);
+	free_sorted_freq_table(policy);
+	policy->freq_table = NULL;
+}
+
 static int cpufreq_online(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
@@ -1187,6 +1197,10 @@ static int cpufreq_online(unsigned int cpu)
 		goto out_free_policy;
 	}
 
+	ret = create_sorted_freq_table(policy);
+	if (ret)
+		goto out_exit_policy;
+
 	down_write(&policy->rwsem);
 
 	if (new_policy) {
@@ -1300,9 +1314,7 @@ static int cpufreq_online(unsigned int cpu)
 
 out_exit_policy:
 	up_write(&policy->rwsem);
-
-	if (cpufreq_driver->exit)
-		cpufreq_driver->exit(policy);
+	cpufreq_policy_exit(policy);
 out_free_policy:
 	cpufreq_policy_free(policy, !new_policy);
 	return ret;
@@ -1387,10 +1399,7 @@ static void cpufreq_offline(unsigned int cpu)
 	 * since this is a core component, and is essential for the
 	 * subsequent light-weight ->init() to succeed.
 	 */
-	if (cpufreq_driver->exit) {
-		cpufreq_driver->exit(policy);
-		policy->freq_table = NULL;
-	}
+	cpufreq_policy_exit(policy);
 
 unlock:
 	up_write(&policy->rwsem);
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 4e5c5dbfed7a..ba97912973c4 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -13,6 +13,7 @@
 
 #include <linux/cpufreq.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 
 /*********************************************************************
  *                     FREQUENCY TABLE HELPERS                       *
@@ -298,6 +299,72 @@ struct freq_attr *cpufreq_generic_attr[] = {
 };
 EXPORT_SYMBOL_GPL(cpufreq_generic_attr);
 
+static int next_larger(struct cpufreq_policy *policy, unsigned int freq,
+		       struct cpufreq_frequency_table *table)
+{
+	struct cpufreq_frequency_table *pos;
+	unsigned int next_freq = ~0;
+	int index = -EINVAL;
+
+	cpufreq_for_each_valid_entry(pos, table) {
+		if (pos->frequency <= freq)
+			continue;
+
+		if (next_freq > pos->frequency) {
+			next_freq = pos->frequency;
+			index = pos - table;
+		}
+	}
+
+	return index;
+}
+
+void free_sorted_freq_table(struct cpufreq_policy *policy)
+{
+	kfree(policy->sorted_freq_table);
+	policy->sorted_freq_table = NULL;
+}
+
+int create_sorted_freq_table(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *pos, *new_table;
+	unsigned int freq, index, i, count = 0;
+	struct cpufreq_frequency_table *table = policy->freq_table;
+
+	if (!table)
+		return 0;
+
+	cpufreq_for_each_valid_entry(pos, table)
+		count++;
+
+	/* Extra entry for CPUFREQ_TABLE_END */
+	count++;
+
+	new_table = kmalloc_array(count, sizeof(*new_table), GFP_KERNEL);
+	if (!new_table)
+		return -ENOMEM;
+
+	for (i = 0, freq = 0; i < count - 1; i++) {
+		index = next_larger(policy, freq, table);
+		if (index == -EINVAL)
+			break;
+
+		/*
+		 * driver_data of the sorted table points to the index of the
+		 * unsorted table.
+		 */
+		new_table[i].driver_data = index;
+		new_table[i].frequency = table[index].frequency;
+
+		freq = table[index].frequency;
+	}
+
+	new_table[i].frequency = CPUFREQ_TABLE_END;
+	policy->sorted_freq_table = new_table;
+
+	return 0;
+}
+
 int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
 				      struct cpufreq_frequency_table *table)
 {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 7ed93c310c08..08cf508948dd 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -87,6 +87,7 @@ struct cpufreq_policy {
 
 	struct cpufreq_user_policy user_policy;
 	struct cpufreq_frequency_table	*freq_table;
+	struct cpufreq_frequency_table	*sorted_freq_table;
 
 	struct list_head        policy_list;
 	struct kobject		kobj;
@@ -592,6 +593,8 @@ static inline void dev_pm_opp_free_cpufreq_table(struct device *dev,
 
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 				    struct cpufreq_frequency_table *table);
+int create_sorted_freq_table(struct cpufreq_policy *policy);
+void free_sorted_freq_table(struct cpufreq_policy *policy);
 
 int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table);
-- 
2.7.1.410.g6faf27b

