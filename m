From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 2/2] CPUFreq: Add new sysfs attribute freqdomain_cpus for acpi-freq driver
Date: Tue, 25 Jun 2013 10:06:46 +0800
Message-ID: <1372126006-4950-2-git-send-email-tianyu.lan@intel.com>
References: <1372126006-4950-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1372126006-4950-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org, viresh.kumar@linaro.org, jean-philippe.halimi@exascale-computing.eu
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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
 Documentation/cpu-freq/user-guide.txt |    4 ++++
 drivers/cpufreq/acpi-cpufreq.c        |   11 +++++++++++
 drivers/cpufreq/cpufreq.c             |    7 ++++---
 include/linux/cpufreq.h               |    3 +++
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/cpu-freq/user-guide.txt b/Documentation/cpu-freq/user-guide.txt
index ff2f283..0cc72f7 100644
--- a/Documentation/cpu-freq/user-guide.txt
+++ b/Documentation/cpu-freq/user-guide.txt
@@ -196,6 +196,10 @@ affected_cpus :			List of Online CPUs that require software
 related_cpus :			List of Online + Offline CPUs that need software
 				coordination of frequency.
 
+freqdomain_cpus :		List of Online + Offline CPUs in same CPU dependency
+				domain. (This is only available for acpi-cpufreq
+				driver)
+
 scaling_driver :		Hardware driver for cpufreq.
 
 scaling_cur_freq :		Current frequency of the CPU as determined by
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 17e3496..b859997 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -176,6 +176,16 @@ static struct global_attr global_boost = __ATTR(boost, 0644,
 						show_global_boost,
 						store_global_boost);
 
+static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
+{
+	struct acpi_cpufreq_data *data = per_cpu(acfreq_data, policy->cpu);
+	struct acpi_processor_performance *perf = data->acpi_data;
+
+	return cpufreq_show_cpus(perf->shared_cpu_map, buf);
+}
+
+cpufreq_freq_attr_ro(freqdomain_cpus);
+
 #ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
 static ssize_t store_cpb(struct cpufreq_policy *policy, const char *buf,
 			 size_t count)
@@ -906,6 +916,7 @@ static int acpi_cpufreq_resume(struct cpufreq_policy *policy)
 
 static struct freq_attr *acpi_cpufreq_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
+	&freqdomain_cpus,
 	NULL,	/* this is a placeholder for cpb, do not remove */
 	NULL,
 };
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f8c2860..d31feab 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -574,7 +574,7 @@ out:
 	return i;
 }
 
-static ssize_t show_cpus(const struct cpumask *mask, char *buf)
+ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf)
 {
 	ssize_t i = 0;
 	unsigned int cpu;
@@ -589,6 +589,7 @@ static ssize_t show_cpus(const struct cpumask *mask, char *buf)
 	i += sprintf(&buf[i], "\n");
 	return i;
 }
+EXPORT_SYMBOL_GPL(cpufreq_show_cpus);
 
 /**
  * show_related_cpus - show the CPUs affected by each transition even if
@@ -596,7 +597,7 @@ static ssize_t show_cpus(const struct cpumask *mask, char *buf)
  */
 static ssize_t show_related_cpus(struct cpufreq_policy *policy, char *buf)
 {
-	return show_cpus(policy->related_cpus, buf);
+	return cpufreq_show_cpus(policy->related_cpus, buf);
 }
 
 /**
@@ -604,7 +605,7 @@ static ssize_t show_related_cpus(struct cpufreq_policy *policy, char *buf)
  */
 static ssize_t show_affected_cpus(struct cpufreq_policy *policy, char *buf)
 {
-	return show_cpus(policy->cpus, buf);
+	return cpufreq_show_cpus(policy->cpus, buf);
 }
 
 static ssize_t store_scaling_setspeed(struct cpufreq_policy *policy,
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d939056..70021f1 100644
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

