From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] cpufreq: Allow accessing freq_table for offline CPUs
Date: Wed,  8 Jul 2015 14:38:41 +0530
Message-ID: <5b275fbf85738095a6045ddd7d470cc99a795664.1436346340.git.viresh.kumar@linaro.org>
References: <20150708090144.GB2647@e104805>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36708 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933962AbbGHJIx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 05:08:53 -0400
Received: by pddu5 with SMTP id u5so54899299pdd.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2015 02:08:52 -0700 (PDT)
In-Reply-To: <20150708090144.GB2647@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, javi.merino@arm.com, pi-cheng.chen@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

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

Reported-and-tested-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2: Get rid of cpufreq_cpu_data()'s declaration as well.. Thanks Javi.

 drivers/cpufreq/cpufreq.c    | 9 +++++++++
 drivers/cpufreq/freq_table.c | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

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
index df14766a8e06..dfbbf981ed56 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -297,15 +297,6 @@ int cpufreq_table_validate_and_show(struct cpufreq_policy *policy,
 }
 EXPORT_SYMBOL_GPL(cpufreq_table_validate_and_show);
 
-struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu);
-
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

