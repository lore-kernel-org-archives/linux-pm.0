From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Tue,  1 Mar 2016 14:07:39 -0800
Message-ID: <1456870059-21681-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1456870059-21681-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23438 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbcCAWJ1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Mar 2016 17:09:27 -0500
In-Reply-To: <1456870059-21681-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
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
 Documentation/cpu-freq/acpi-cpufreq.txt | 27 ++++++++++++++++++++
 drivers/cpufreq/acpi-cpufreq.c          | 45 +++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/cpu-freq/acpi-cpufreq.txt

diff --git a/Documentation/cpu-freq/acpi-cpufreq.txt b/Documentation/cpu-freq/acpi-cpufreq.txt
new file mode 100644
index 0000000..e5600c4
--- /dev/null
+++ b/Documentation/cpu-freq/acpi-cpufreq.txt
@@ -0,0 +1,27 @@
+Additional sysfs attributes for acpi-cpufreq
+
+acpi-cpufreq sysfs has following sysfs attributes in addition to standard
+cpufreq attributes:
+
+base_frequency :		Max non-turbo frequency
+				For example:
+				scaling_available_frequencies displays list
+				of available frequencies.
+
+				>cat scaling_available_frequencies
+				2301000 2300000 2200000 2000000 1900000
+				1800000 1700000 1500000 1400000 1300000
+				1100000 1000000 900000 800000 600000
+				500000
+
+				If the base_frequency attribute is present
+				and readable, then any frequency above
+				base_frequency is turbo frequency. For example
+
+				>cat base_frequency
+				2200000
+
+				Then in the above displayed list of
+				scaling_available_frequencies, 2300000 and
+				2301000 are turbo frequencies.
+
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 51eef87..0bdd36d 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -646,6 +646,37 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
 }
 #endif
 
+static int x86_get_turbo_activation_ratio(int cpu, u64 *tar)
+{
+	u64 plat_info;
+	int err;
+
+	err = rdmsrl_safe_on_cpu(cpu, MSR_PLATFORM_INFO, &plat_info);
+	/* Check number of config TDP levels > 0 */
+	if (!err && ((plat_info >> 33) & 0x03) > 0)
+		err = rdmsrl_safe_on_cpu(cpu, MSR_TURBO_ACTIVATION_RATIO,
+					 tar);
+	else
+		err = -EOPNOTSUPP;
+
+	return err;
+}
+
+static ssize_t show_base_frequency(struct cpufreq_policy *policy, char *buf)
+{
+	u64 tar;
+	int err;
+
+	err = x86_get_turbo_activation_ratio(policy->cpu, &tar);
+	if (!err)
+		/* Refer to IA64, IA32 SDM table 35-20, unit = 100 MHz */
+		return sprintf(buf, "%llu\n", tar * 100000);
+
+	return err;
+}
+
+cpufreq_freq_attr_ro(base_frequency);
+
 static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int i;
@@ -888,6 +919,7 @@ static struct freq_attr *acpi_cpufreq_attr[] = {
 #ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
 	&cpb,
 #endif
+	NULL, /* Extra space for base_frequency attr, if required */
 	NULL,
 };
 
@@ -971,6 +1003,19 @@ static int __init acpi_cpufreq_init(void)
 			}
 	}
 #endif
+
+	if (boot_cpu_has(X86_FEATURE_IDA)) {
+		u64 tar;
+
+		if (!x86_get_turbo_activation_ratio(0, &tar)) {
+			struct freq_attr **attr;
+
+			for (attr = acpi_cpufreq_attr; *attr; attr++)
+			;
+			*attr = &base_frequency;
+		}
+	}
+
 	acpi_cpufreq_boost_init();
 
 	ret = cpufreq_register_driver(&acpi_cpufreq_driver);
-- 
2.5.0

