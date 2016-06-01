From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] cpufreq: Don't use cpufreq_frequency_get_table() if 'policy' is available
Date: Wed,  1 Jun 2016 07:23:19 +0530
Message-ID: <1983189261737014b1f83e5b455d9d76e3288748.1464745869.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34077 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbcFABxY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 21:53:24 -0400
Received: by mail-pf0-f181.google.com with SMTP id 62so4080647pfd.1
        for <linux-pm@vger.kernel.org>; Tue, 31 May 2016 18:53:23 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

Most of the callers of cpufreq_frequency_get_table() already have the
pointer to a valid 'policy' structure and they don't really need to go
through the per-cpu variable first and then a check to validate the
frequency, in order to find the freq-table for the policy.

Directly use the policy->freq_table field instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2: Instead of adding a new routine, use policy->freq_table directly as
there already are a lot of users who are doing it directly anyway.

 drivers/cpufreq/cpufreq.c             | 27 +++++++++++++--------------
 drivers/cpufreq/cpufreq_ondemand.c    |  2 +-
 drivers/cpufreq/cpufreq_stats.c       |  3 +--
 drivers/cpufreq/freq_table.c          |  9 +++------
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c |  3 +--
 5 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c6a14ba239a2..5d359b94779d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2345,26 +2345,25 @@ static struct notifier_block __refdata cpufreq_cpu_notifier = {
  *********************************************************************/
 static int cpufreq_boost_set_sw(int state)
 {
-	struct cpufreq_frequency_table *freq_table;
 	struct cpufreq_policy *policy;
 	int ret = -EINVAL;
 
 	for_each_active_policy(policy) {
-		freq_table = cpufreq_frequency_get_table(policy->cpu);
-		if (freq_table) {
-			ret = cpufreq_frequency_table_cpuinfo(policy,
-							freq_table);
-			if (ret) {
-				pr_err("%s: Policy frequency update failed\n",
-				       __func__);
-				break;
-			}
+		if (!policy->freq_table)
+			continue;
 
-			down_write(&policy->rwsem);
-			policy->user_policy.max = policy->max;
-			cpufreq_governor_limits(policy);
-			up_write(&policy->rwsem);
+		ret = cpufreq_frequency_table_cpuinfo(policy,
+						      policy->freq_table);
+		if (ret) {
+			pr_err("%s: Policy frequency update failed\n",
+			       __func__);
+			break;
 		}
+
+		down_write(&policy->rwsem);
+		policy->user_policy.max = policy->max;
+		cpufreq_governor_limits(policy);
+		up_write(&policy->rwsem);
 	}
 
 	return ret;
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index c84fc2240d49..4d2fe2710c5d 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -113,7 +113,7 @@ static void ondemand_powersave_bias_init(struct cpufreq_policy *policy)
 {
 	struct od_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
 
-	dbs_info->freq_table = cpufreq_frequency_get_table(policy->cpu);
+	dbs_info->freq_table = policy->freq_table;
 	dbs_info->freq_lo = 0;
 }
 
diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index c6e7f81a0397..06d3abdffd3a 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -157,11 +157,10 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	unsigned int i = 0, count = 0, ret = -ENOMEM;
 	struct cpufreq_stats *stats;
 	unsigned int alloc_size;
-	unsigned int cpu = policy->cpu;
 	struct cpufreq_frequency_table *pos, *table;
 
 	/* We need cpufreq table for creating stats table */
-	table = cpufreq_frequency_get_table(cpu);
+	table = policy->freq_table;
 	if (unlikely(!table))
 		return;
 
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 4e5c5dbfed7a..f52b5473b1f4 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -106,12 +106,10 @@ EXPORT_SYMBOL_GPL(cpufreq_frequency_table_verify);
  */
 int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy)
 {
-	struct cpufreq_frequency_table *table =
-		cpufreq_frequency_get_table(policy->cpu);
-	if (!table)
+	if (!policy->freq_table)
 		return -ENODEV;
 
-	return cpufreq_frequency_table_verify(policy, table);
+	return cpufreq_frequency_table_verify(policy, policy->freq_table);
 }
 EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
 
@@ -210,9 +208,8 @@ EXPORT_SYMBOL_GPL(cpufreq_frequency_table_target);
 int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
 		unsigned int freq)
 {
-	struct cpufreq_frequency_table *pos, *table;
+	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
 
-	table = cpufreq_frequency_get_table(policy->cpu);
 	if (unlikely(!table)) {
 		pr_debug("%s: Unable to find frequency table\n", __func__);
 		return -ENOENT;
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
index 7c4cd5c634f2..dc112481a408 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
@@ -94,7 +94,7 @@ static int pmi_notifier(struct notifier_block *nb,
 				       unsigned long event, void *data)
 {
 	struct cpufreq_policy *policy = data;
-	struct cpufreq_frequency_table *cbe_freqs;
+	struct cpufreq_frequency_table *cbe_freqs = policy->freq_table;
 	u8 node;
 
 	/* Should this really be called for CPUFREQ_ADJUST and CPUFREQ_NOTIFY
@@ -103,7 +103,6 @@ static int pmi_notifier(struct notifier_block *nb,
 	if (event == CPUFREQ_START)
 		return 0;
 
-	cbe_freqs = cpufreq_frequency_get_table(policy->cpu);
 	node = cbe_cpu_to_node(policy->cpu);
 
 	pr_debug("got notified, event=%lu, node=%u\n", event, node);
-- 
2.7.1.410.g6faf27b

