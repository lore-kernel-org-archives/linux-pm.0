From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Thu,  1 Oct 2015 15:25:17 -0700
Message-ID: <1443738317-4224-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:55718 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbbJAWZs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 1 Oct 2015 18:25:48 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Currently scaling_available_frequencies displays list of available
frequencies which can be used to set max/min or current scaling frequency.

>cat scaling_available_frequencies
2301000 2300000 2200000 2000000 1900000 1800000 1700000 1500000 1400000
1300000 1100000 1000000 900000 800000 600000 500000

Here traditionally it is assumed that only 2301000 is a turbo frequency,
which is purely opportunistic, anything else user can request and may
get it.
But because of configurable thermal design power implementation in several
Intel CPUs, the opportunistic frequency start can be any frequency in this
range. For example it can be 2300000 or any lower value.
This change adds an optional new attribute called "base_frequency",
which displays the max non-turbo frequency (base frequency). For example:
>cat base_frequency
2200000
This will allow user to choose a certain frequency which is not
opportunistic.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index cec1ee2..4433f6b 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -70,6 +70,7 @@ struct acpi_cpufreq_data {
 	unsigned int cpu_feature;
 	unsigned int acpi_perf_cpu;
 	cpumask_var_t freqdomain_cpus;
+	bool base_freq_attr_present;
 };
 
 /* acpi_perf_data is a pointer to percpu data. */
@@ -651,6 +652,21 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
 }
 #endif
 
+static ssize_t base_frequency_show(struct cpufreq_policy *policy, char *buf)
+{
+	u64 tar;
+	int err;
+
+	err = rdmsrl_safe(MSR_TURBO_ACTIVATION_RATIO, &tar);
+	if (!err)
+		/* Refer to IA64, IA32 SDM table 35-20, unit = 100 MHz */
+		return sprintf(buf, "%llu\n", tar * 100000);
+
+	return err;
+}
+
+static struct freq_attr cpufreq_attr_base_frequency = __ATTR_RO(base_frequency);
+
 static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int i;
@@ -827,6 +843,21 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		break;
 	}
 
+	if (data->cpu_feature == SYSTEM_INTEL_MSR_CAPABLE) {
+		u64 tar;
+		int err;
+
+		err = rdmsrl_safe(MSR_TURBO_ACTIVATION_RATIO, &tar);
+		if (!err) {
+			result = sysfs_create_file(&policy->kobj,
+					&(cpufreq_attr_base_frequency.attr));
+			if (result)
+				goto err_freqfree;
+
+			data->base_freq_attr_present = true;
+		}
+	}
+
 	/* notify BIOS that we exist */
 	acpi_processor_notify_smm(THIS_MODULE);
 
@@ -866,6 +897,9 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	pr_debug("acpi_cpufreq_cpu_exit\n");
 
 	if (data) {
+		if (data->base_freq_attr_present)
+			sysfs_remove_file(&policy->kobj,
+					  &(cpufreq_attr_base_frequency.attr));
 		policy->driver_data = NULL;
 		acpi_processor_unregister_performance(data->acpi_perf_cpu);
 		free_cpumask_var(data->freqdomain_cpus);
-- 
2.4.3

