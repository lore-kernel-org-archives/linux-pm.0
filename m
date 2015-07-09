From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Allow accessing freq_table for offline CPUs
Date: Thu, 9 Jul 2015 10:43:56 +0530
Message-ID: <20150709051356.GK1805@linux>
References: <c07ccbe7f415d20e055c9d1ba025a71b902e6b0f.1436340899.git.viresh.kumar@linaro.org>
 <2953689.ETebrTym45@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33273 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbbGIFOD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 01:14:03 -0400
Received: by pacws9 with SMTP id ws9so145478186pac.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2015 22:14:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2953689.ETebrTym45@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, javi.merino@arm.com, Pi-Cheng Chen <pi-cheng.chen@linaro.org>, open list <linux-kernel@vger.kernel.org>

On 09-07-15, 02:40, Rafael J. Wysocki wrote:
> The above sentence is completely unclear to anyone unfamiliar with the
> code in question.
> 
> The fix is to access the policy data structure for the given CPU directly
> (which also returns a valid policy for offline CPUs), but the policy
> itself has to be active (meaning that at least one CPU using it is online)
> for the frequency table to be returned.
> 
> Right?

Yeah..

-------------------8<--------------------
Message-Id: <9c37b9a711b6dc6e419e256fd62fcc93a29db4e4.1436418686.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 8 Jul 2015 12:53:03 +0530
Subject: [PATCH V3] cpufreq: Allow accessing freq_table for offline CPUs

Users of freq table may want to access it for any CPU from
policy->related_cpus mask. One such user is cpu-cooling layer. It gets a
list of 'clip_cpus' (equivalent to policy->related_cpus) during
registration and tries to get freq_table for the first CPU of this mask.

If the CPU, for which it tries to fetch freq_table, is offline,
cpufreq_frequency_get_table() fails. This happens because it relies on
cpufreq_cpu_get_raw() for its functioning which returns policy only for
online CPUs.

The fix is to access the policy data structure for the given CPU
directly (which also returns a valid policy for offline CPUs), but the
policy itself has to be active (meaning that at least one CPU using it
is online) for the frequency table to be returned.

Because we will be using 'cpufreq_cpu_data' now, which is internal to
cpufreq-core, lets also move cpufreq_frequency_get_table() to cpufreq.c
file.

Reported-and-tested-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3-> Changelog improvement suggested by Rafael.

 drivers/cpufreq/cpufreq.c    | 9 +++++++++
 drivers/cpufreq/freq_table.c | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 36e97a5a7e20..a7b6ac6e048e 100644
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
