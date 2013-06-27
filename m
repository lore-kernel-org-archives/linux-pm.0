From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 2/2 V3] CPUFreq: Add new sysfs attribute freqdomain_cpus for acpi-freq driver
Date: Thu, 27 Jun 2013 15:08:54 +0800
Message-ID: <1372316934-27225-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47873 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286Ab3F0HQ5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Jun 2013 03:16:57 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org, viresh.kumar@linaro.org, jean-philippe.halimi@exascale-computing.eu
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org

Commit aa77a52 and fcf8058 changes the content of "related_cpus" and user
space can't get cpus which are in the same hardware coordination cpu domain
(These info are provided by ACPI AML method _PSD) via "related_cpus". This
change affects some users of original "related_cpus".

This patch is to add a new sysfs attribute "freqdomian_cpus" for acpi-cpufreq
driver which exposes all cpus in the same domain regardless of hardware or
software coordination to make up the info loss of previous change.

Reference:https://bugzilla.kernel.org/show_bug.cgi?id=58761
Reported-by: Jean-Philippe Halimi <jean-philippe.halimi@exascale-computing.eu>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
Change since v1:
     Create new file acpi-cpufreq.txt under Documentation/cpu-freq and
move new attribute descriptor to it.
     Add new field freqdomain_cpus in struct acpi_cpufreq_data and record
cpu domain info in it. For AMD case, use sibling cpus info to overwrite
cpu domain info from ACPI.

Change since v2:
     Move new attribute descriptor to Documentation/ABI/testing/
sysfs-devices-system-cpu and update descriptor content according Viresh's
comment.
    http://www.spinics.net/lists/cpufreq/msg06119.html

 Documentation/ABI/testing/sysfs-devices-system-cpu |   15 +++++++++++++
 drivers/cpufreq/acpi-cpufreq.c                     |   23 +++++++++++++++++++-
 drivers/cpufreq/cpufreq.c                          |    7 +++---
 include/linux/cpufreq.h                            |    3 +++
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 2447698..c72fccc 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -144,6 +144,21 @@ Description:	Discover and change clock speed of CPUs
 		to learn how to control the knobs.
 
 
+What:		/sys/devices/system/cpu/cpu#/cpufreq/freqdomain_cpus
+Date:		June 2013
+Contact:	cpufreq@vger.kernel.org
+Description:	Discover CPUs in the same CPU frequency dependency domain
+
+		"freqdomain_cpus" are the list of cpus (online+offline) that share
+		same clock/freq domain at hardware level. This information might
+		be hidden from cpufreq core and so related_cpus can have different
+		value compared to this. This is not used by kernel but userspace
+		DVFS controllers to get better power/performance values for platforms
+		using acpi-cpufreq.c driver.
+
+		This file is only present if the acpi-cpufreq driver is in use.
+
+
 What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
 Date:		August 2008
 KernelVersion:	2.6.27
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index f4fef0a..3926402 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -70,6 +70,7 @@ struct acpi_cpufreq_data {
 	struct cpufreq_frequency_table *freq_table;
 	unsigned int resume;
 	unsigned int cpu_feature;
+	cpumask_var_t freqdomain_cpus;
 };
 
 static DEFINE_PER_CPU(struct acpi_cpufreq_data *, acfreq_data);
@@ -176,6 +177,15 @@ static struct global_attr global_boost = __ATTR(boost, 0644,
 						show_global_boost,
 						store_global_boost);
 
+static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
+{
+	struct acpi_cpufreq_data *data = per_cpu(acfreq_data, policy->cpu);
+
+	return cpufreq_show_cpus(data->freqdomain_cpus, buf);
+}
+
+cpufreq_freq_attr_ro(freqdomain_cpus);
+
 #ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
 static ssize_t store_cpb(struct cpufreq_policy *policy, const char *buf,
 			 size_t count)
@@ -704,6 +714,11 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (!data)
 		return -ENOMEM;
 
+	if (!zalloc_cpumask_var(&data->freqdomain_cpus, GFP_KERNEL)) {
+		result = -ENOMEM;
+		goto err_free;
+	}
+
 	data->acpi_data = per_cpu_ptr(acpi_perf_data, cpu);
 	per_cpu(acfreq_data, cpu) = data;
 
@@ -712,7 +727,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	result = acpi_processor_register_performance(data->acpi_data, cpu);
 	if (result)
-		goto err_free;
+		goto err_free_mask;
 
 	perf = data->acpi_data;
 	policy->shared_type = perf->shared_type;
@@ -725,6 +740,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	    policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
 		cpumask_copy(policy->cpus, perf->shared_cpu_map);
 	}
+	cpumask_copy(data->freqdomain_cpus, perf->shared_cpu_map);
 
 #ifdef CONFIG_SMP
 	dmi_check_system(sw_any_bug_dmi_table);
@@ -736,6 +752,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (check_amd_hwpstate_cpu(cpu) && !acpi_pstate_strict) {
 		cpumask_clear(policy->cpus);
 		cpumask_set_cpu(cpu, policy->cpus);
+		cpumask_copy(data->freqdomain_cpus, cpu_sibling_mask(cpu));
 		policy->shared_type = CPUFREQ_SHARED_TYPE_HW;
 		pr_info_once(PFX "overriding BIOS provided _PSD data\n");
 	}
@@ -870,6 +887,8 @@ err_freqfree:
 	kfree(data->freq_table);
 err_unreg:
 	acpi_processor_unregister_performance(perf, cpu);
+err_free_mask:
+	free_cpumask_var(data->freqdomain_cpus);
 err_free:
 	kfree(data);
 	per_cpu(acfreq_data, cpu) = NULL;
@@ -888,6 +907,7 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 		per_cpu(acfreq_data, policy->cpu) = NULL;
 		acpi_processor_unregister_performance(data->acpi_data,
 						      policy->cpu);
+		free_cpumask_var(data->freqdomain_cpus);
 		kfree(data->freq_table);
 		kfree(data);
 	}
@@ -908,6 +928,7 @@ static int acpi_cpufreq_resume(struct cpufreq_policy *policy)
 
 static struct freq_attr *acpi_cpufreq_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
+	&freqdomain_cpus,
 	NULL,	/* this is a placeholder for cpb, do not remove */
 	NULL,
 };
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d976e22..adf12a9f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -573,7 +573,7 @@ out:
 	return i;
 }
 
-static ssize_t show_cpus(const struct cpumask *mask, char *buf)
+ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf)
 {
 	ssize_t i = 0;
 	unsigned int cpu;
@@ -588,6 +588,7 @@ static ssize_t show_cpus(const struct cpumask *mask, char *buf)
 	i += sprintf(&buf[i], "\n");
 	return i;
 }
+EXPORT_SYMBOL_GPL(cpufreq_show_cpus);
 
 /**
  * show_related_cpus - show the CPUs affected by each transition even if
@@ -595,7 +596,7 @@ static ssize_t show_cpus(const struct cpumask *mask, char *buf)
  */
 static ssize_t show_related_cpus(struct cpufreq_policy *policy, char *buf)
 {
-	return show_cpus(policy->related_cpus, buf);
+	return cpufreq_show_cpus(policy->related_cpus, buf);
 }
 
 /**
@@ -603,7 +604,7 @@ static ssize_t show_related_cpus(struct cpufreq_policy *policy, char *buf)
  */
 static ssize_t show_affected_cpus(struct cpufreq_policy *policy, char *buf)
 {
-	return show_cpus(policy->cpus, buf);
+	return cpufreq_show_cpus(policy->cpus, buf);
 }
 
 static ssize_t store_scaling_setspeed(struct cpufreq_policy *policy,
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 3c7ee2f..5fedb6c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -438,4 +438,7 @@ void cpufreq_frequency_table_get_attr(struct cpufreq_frequency_table *table,
 void cpufreq_frequency_table_update_policy_cpu(struct cpufreq_policy *policy);
 
 void cpufreq_frequency_table_put_attr(unsigned int cpu);
+
+ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf);
+
 #endif /* _LINUX_CPUFREQ_H */
-- 
1.7.10.4

