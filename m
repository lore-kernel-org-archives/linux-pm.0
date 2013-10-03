From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 01/92] cpufreq: define generic .attr, .exit() and .verify() routines
Date: Thu,  3 Oct 2013 20:27:55 +0530
Message-ID: <9c000366618681c70ca6780530b82bfb4a10c73c.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:63089 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710Ab3JCO7m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 10:59:42 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so2739402pab.15
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 07:59:42 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch introduces generic .attr, .exit() and .verify() cpufreq drivers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/freq_table.c | 20 ++++++++++++++++++++
 include/linux/cpufreq.h      |  8 ++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 11f6fa9..b198458 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -87,6 +87,20 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
 }
 EXPORT_SYMBOL_GPL(cpufreq_frequency_table_verify);
 
+/*
+ * Generic routine to verify policy & frequency table, requires driver to call
+ * cpufreq_frequency_table_get_attr() prior to it.
+ */
+int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *table =
+		cpufreq_frequency_get_table(policy->cpu);
+	if (!table)
+		return -ENODEV;
+
+	return cpufreq_frequency_table_verify(policy, table);
+}
+EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
 
 int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table,
@@ -200,6 +214,12 @@ struct freq_attr cpufreq_freq_attr_scaling_available_freqs = {
 };
 EXPORT_SYMBOL_GPL(cpufreq_freq_attr_scaling_available_freqs);
 
+struct freq_attr *cpufreq_generic_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+EXPORT_SYMBOL_GPL(cpufreq_generic_attr);
+
 /*
  * if you use these, you must assure that the frequency table is valid
  * all the time between get_attr and put_attr!
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 6b199ed..c808809 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -392,6 +392,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 
 int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table);
+int cpufreq_generic_frequency_table_verify(struct cpufreq_policy *policy);
 
 int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 				   struct cpufreq_frequency_table *table,
@@ -407,10 +408,17 @@ struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu);
 
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
+extern struct freq_attr *cpufreq_generic_attr[];
 void cpufreq_frequency_table_get_attr(struct cpufreq_frequency_table *table,
 				      unsigned int cpu);
 void cpufreq_frequency_table_put_attr(unsigned int cpu);
 int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
 				      struct cpufreq_frequency_table *table);
 
+static inline int cpufreq_generic_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+	return 0;
+}
+
 #endif /* _LINUX_CPUFREQ_H */
-- 
1.7.12.rc2.18.g61b472e

