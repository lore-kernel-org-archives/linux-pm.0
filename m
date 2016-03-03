From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v5] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Thu,  3 Mar 2016 11:09:17 -0800
Message-ID: <1457032157-11490-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:61461 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbcCCTMN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 3 Mar 2016 14:12:13 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Currently scaling_available_frequencies displays list of available
frequencies which can be used to set max/min or current scaling frequency.

$ cat scaling_available_frequencies
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

$ cat base_frequency
2200000

This will allow user to choose a certain frequency which is not
opportunistic.

To be fair, other than the concept, the code is essentially copied
from responses from Rafael in mailing list.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---

v5
- Rebased on the top of
"cpufreq: acpi: Allow new dynamics attributes to be added to acpi_cpufreq_attr"
- Remove loop for finding next empty slot in acpi_cpufreq_attr
- Code change suggested by Rafael

v4
- Changes for s/>/$ /
- new lines commmit description after paragraph
- coding style for for "if (ret)" in show_base_frequency

v3
-Merged Documentation and code patch to one patch.
-Created a common function to read tar which is used init and during read
-Documentation and code changed suggested by Viresh
-On unsupported CPUs, user when tries to read base_frequency
"Operation not supported" error will be returned.

v2
sysfs_create_file on policy->kobj is no longer possible on recent kernel
versions. So we can't create selectively create base_frequency attribute
on supported policies.
This version creates a base_frequency attribute, if the boot cpu supports
as part of cpufreq_driver->attributes. If for some CPUs the TAR can't be
read, return error.

v1:
Base version

 Documentation/cpu-freq/acpi-cpufreq.txt | 31 ++++++++++++++++++++++++
 drivers/cpufreq/acpi-cpufreq.c          | 43 +++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/cpu-freq/acpi-cpufreq.txt

diff --git a/Documentation/cpu-freq/acpi-cpufreq.txt b/Documentation/cpu-freq/acpi-cpufreq.txt
new file mode 100644
index 0000000..6b3be2c
--- /dev/null
+++ b/Documentation/cpu-freq/acpi-cpufreq.txt
@@ -0,0 +1,31 @@
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
+				$ cat scaling_available_frequencies
+				2301000 2300000 2200000 2000000 1900000
+				1800000 1700000 1500000 1400000 1300000
+				1100000 1000000 900000 800000 600000
+				500000
+
+				If the base_frequency attribute is present
+				and readable, then any frequency above
+				base_frequency is turbo frequency. For example
+
+				$ cat base_frequency
+				2200000
+
+				Then in the above displayed list of
+				scaling_available_frequencies, 2300000 and
+				2301000 are turbo frequencies. That is, if any
+				of these frequencies is requested, the
+				processor will be allowed to run at a frequency
+				of its choice above the base_frequency that
+				need not be equal to any of them and may be
+				above the maximum listed one.
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 7da172f..801884f 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -646,6 +646,43 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
 }
 #endif
 
+static int x86_get_turbo_activation_ratio(int cpu, u64 *tar)
+{
+	u64 plat_info;
+	int err;
+
+	err = rdmsrl_safe_on_cpu(cpu, MSR_PLATFORM_INFO, &plat_info);
+	if (err)
+		return err;
+
+	if (((plat_info >> 33) & 0x03) > 0)
+		return rdmsrl_safe_on_cpu(cpu, MSR_TURBO_ACTIVATION_RATIO, tar);
+
+	return -ENXIO;
+}
+
+static inline bool boot_cpu_has_turbo_activation_ratio(void)
+{
+	u64 tar;
+
+	return !x86_get_turbo_activation_ratio(0, &tar);
+}
+
+static ssize_t show_base_frequency(struct cpufreq_policy *policy, char *buf)
+{
+	u64 tar;
+	int err;
+
+	err = x86_get_turbo_activation_ratio(policy->cpu, &tar);
+	if (err)
+		return err;
+
+	/* Refer to IA64, IA32 SDM table 35-20, unit = 100 MHz */
+	return sprintf(buf, "%llu\n", tar * 100000);
+}
+
+cpufreq_freq_attr_ro(base_frequency);
+
 static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int i;
@@ -888,6 +925,7 @@ static struct freq_attr *acpi_cpufreq_attr[] = {
 #ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
 	NULL,	/* Extra space for cpb if required */
 #endif
+	NULL, /* Extra space for base_frequency attr, if required */
 	NULL,
 };
 
@@ -970,6 +1008,11 @@ static int __init acpi_cpufreq_init(void)
 		pr_debug("CPB unsupported, do not expose it\n");
 
 #endif
+
+	if (boot_cpu_has(X86_FEATURE_IDA) &&
+	    boot_cpu_has_turbo_activation_ratio())
+		*attr++ = &base_frequency;
+
 	acpi_cpufreq_boost_init();
 
 	ret = cpufreq_register_driver(&acpi_cpufreq_driver);
-- 
2.5.0

