From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Allow accessing freq_table for offline CPUs
Date: Wed,  8 Jul 2015 13:08:15 +0530
Message-ID: <c07ccbe7f415d20e055c9d1ba025a71b902e6b0f.1436340899.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, Pi-Cheng Chen <pi-cheng.chen@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Users of freq table may want to access it for any CPU from
policy->related_cpus mask. One such user is cpu-cooling layer. It gets a
list of 'clip_cpus' (equivalent to policy->related_cpus) during
registration and tries to get freq_table for the first CPU of this mask.

If the CPU, for which it tries to fetch freq_table, is offline,
cpufreq_frequency_get_table() fails. This happens because it relies on
cpufreq_cpu_get_raw() for its functioning which returns policy only for
online CPUs.

Fix this by considering offline CPUs, but with a restriction that the
policy is active at that time.

Because we will be using 'cpufreq_cpu_data' now, which is internal to
cpufreq-core, lets also move cpufreq_frequency_get_table() to cpufreq.c
file.

Reported-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
This was recently tried by Pi cheng but in a completely different way:
http://marc.info/?l=linux-pm&m=143572367402758&w=2

Its not broken by any stuff in 4.2, but would be good if we can push
this for 4.2 as well.

 drivers/cpufreq/cpufreq.c    | 9 +++++++++
 drivers/cpufreq/freq_table.c | 7 -------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2c22e3902e72..26063afb3eba 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -169,6 +169,15 @@ struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(get_governor_parent_kobj);
 
+struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
+
+	return policy && !policy_is_inactive(policy) ?
+		policy->freq_table : NULL;
+}
+EXPORT_SYMBOL_GPL(cpufreq_frequency_get_table);
+
 static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
 {
 	u64 idle_time;
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index df14766a8e06..7551f01e8536 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -299,13 +299,6 @@ EXPORT_SYMBOL_GPL(cpufreq_table_validate_and_show);
 
 struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu);
 
-struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu)
-{
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	return policy ? policy->freq_table : NULL;
-}
-EXPORT_SYMBOL_GPL(cpufreq_frequency_get_table);
-
 MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION("CPUfreq frequency table helpers");
 MODULE_LICENSE("GPL");
-- 
2.4.0
