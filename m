From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH 1/3] cpufreq: Add new attribute "base_frequency"
Date: Fri,  4 Sep 2015 10:19:17 -0700
Message-ID: <1441387159-19860-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51149 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932864AbbIDRTh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Sep 2015 13:19:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Currently scaling_available_frequencies displays list of available
frequencies which can be used to set max/min or current scaling
frequency. But because of configurable thermal design power implementation
in several Intel CPUs, this is not a guaranteed frequency or a P state,
which user can request. After a limit all frequencies (P states) may be
purely in opportunistic performance range. For example

>cat scaling_available_frequencies
2301000 2300000 2200000 2000000 1900000 1800000 1700000 1500000 1400000
1300000 1100000 1000000 900000 800000 600000 500000

Here traditionally it is assumed that only 2301000 is a turbo frequency,
anything else user can request. But that is not true. Based on the
config TDP level, this turbo (boost) start can be much below. For
example it can be 2300000 or any other value.

This change adds an optional new attribute called "base_frequency",
which displays the max non-turbo frequency (base frequency). For example:
>cat base_frequency
2200000

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/cpufreq.c | 26 ++++++++++++++++++++++++++
 include/linux/cpufreq.h   |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7a3c30c..f4ff667 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -812,6 +812,25 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
 	return sprintf(buf, "%u\n", policy->cpuinfo.max_freq);
 }
 
+/*
+ * show_base_frequency - show the current cpufreq boost start freq
+ */
+static ssize_t show_base_frequency(struct cpufreq_policy *policy, char *buf)
+{
+	unsigned int freq;
+	int ret;
+
+	if (cpufreq_driver->base_frequency) {
+		ret = cpufreq_driver->base_frequency(policy->cpu, &freq);
+		if (!ret)
+			return sprintf(buf, "%u\n", freq);
+		else
+			return ret;
+	}
+
+	return -EIO;
+}
+
 cpufreq_freq_attr_ro_perm(cpuinfo_cur_freq, 0400);
 cpufreq_freq_attr_ro(cpuinfo_min_freq);
 cpufreq_freq_attr_ro(cpuinfo_max_freq);
@@ -820,6 +839,7 @@ cpufreq_freq_attr_ro(scaling_available_governors);
 cpufreq_freq_attr_ro(scaling_driver);
 cpufreq_freq_attr_ro(scaling_cur_freq);
 cpufreq_freq_attr_ro(bios_limit);
+cpufreq_freq_attr_ro(base_frequency);
 cpufreq_freq_attr_ro(related_cpus);
 cpufreq_freq_attr_ro(affected_cpus);
 cpufreq_freq_attr_rw(scaling_min_freq);
@@ -1057,6 +1077,12 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
 			return ret;
 	}
 
+	if (cpufreq_driver->base_frequency) {
+		ret = sysfs_create_file(&policy->kobj, &base_frequency.attr);
+		if (ret)
+			return ret;
+	}
+
 	return cpufreq_add_dev_symlink(policy);
 }
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index bde1e56..f95a61e 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -267,6 +267,8 @@ struct cpufreq_driver {
 
 	/* optional */
 	int		(*bios_limit)(int cpu, unsigned int *limit);
+	/* optional base_frequency */
+	int		(*base_frequency)(int cpu, unsigned int *freq);
 
 	int		(*exit)(struct cpufreq_policy *policy);
 	void		(*stop_cpu)(struct cpufreq_policy *policy);
-- 
2.4.3

