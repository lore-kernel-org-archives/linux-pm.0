From: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Subject: [PATCH v7] cpufreq: Add SFI based cpufreq driver support
Date: Thu, 11 Dec 2014 13:44:44 +0530
Message-ID: <20141211081438.GA2885@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11674 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964919AbaLKINP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Dec 2014 03:13:15 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, vishwesh.m.rudramuni@intel.com, srinidhi.kasagar@intel.com

This adds the SFI based cpu freq driver for some of the Intel's
Silvermont based Atom architectures like Z34xx and Z35xx.

Signed-off-by: Rudramuni, Vishwesh M <vishwesh.m.rudramuni@intel.com>
Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
---
v2:
(v2-v3: comments from Viresh)
* rephrase the Kconfig text
* merge the header file as its not being shared with anyone
* remove the unnecessary checks in sfi_cpufreq_target
* style changes in kzalloc
* fix the potential memory leak sfi_cpufreq_cpu_init
* move the cpufreq driver flag to the structure definition
* remove the redundant init of policy->cpu and policy->cur
* remove the unnecessary check while init the freq table
* merge the for loops in cpu_init
* use cpufreq_generic_attr rather than the custom one

v3:
* Add this change log
* remove the left over not used cached_freq var
* merge yet another for loop in cpu_init

v4:
* remove unnecessary pr_debug
* rephrase Kconfig text
* remove unused macro SFI_CPU_MAX
* Add Viresh's Acked-by

v5:
(comments from Len Brown)
* rename few private functions with sfi_cpufreq_ prefix
* move the PERF_CTL_MASK to msr-index.h
* make the driver.get current freq to refer PERF_CTRL
* remove sfi_processor_px, rather reuse sfi_freq_table_entry
* remove unnecessary memcpy, rather just point to the freq table
* consolidate get_performance_states with parse_freq
* remove extract_freq and make get_cur_freq to read from MSR directly
* move the state_count check while registering the perf states

v6:
* release the mutex in case of error in register_performance
(comments from Viresh)
* drop local perf pointer in ->target and ->init
* fix the order of freeing memories in the error path of ->init
* remove alloc_percpu, rather allocate it at runtime in ->init

v7:
(comments from Len Brown)
* drop the unnecessary mutex
* move sfi_table_parse to __init as it is global to the system
* drop ->get callback
* consolidate few global data structures

 arch/x86/include/uapi/asm/msr-index.h |    1 +
 drivers/cpufreq/Kconfig.x86           |   10 ++
 drivers/cpufreq/Makefile              |    1 +
 drivers/cpufreq/sfi-cpufreq.c         |  165 +++++++++++++++++++++++++++++++++
 4 files changed, 177 insertions(+)
 create mode 100644 drivers/cpufreq/sfi-cpufreq.c

diff --git a/arch/x86/include/uapi/asm/msr-index.h b/arch/x86/include/uapi/asm/msr-index.h
index e21331ce368f..4f6dae67dd10 100644
--- a/arch/x86/include/uapi/asm/msr-index.h
+++ b/arch/x86/include/uapi/asm/msr-index.h
@@ -318,6 +318,7 @@
 
 #define MSR_IA32_PERF_STATUS		0x00000198
 #define MSR_IA32_PERF_CTL		0x00000199
+#define INTEL_PERF_CTL_MASK		0xffff
 #define MSR_AMD_PSTATE_DEF_BASE		0xc0010064
 #define MSR_AMD_PERF_STATUS		0xc0010063
 #define MSR_AMD_PERF_CTL		0xc0010062
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 89ae88f91895..dd2b6f541f33 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -57,6 +57,16 @@ config X86_ACPI_CPUFREQ_CPB
 	  By enabling this option the acpi_cpufreq driver provides the old
 	  entry in addition to the new boost ones, for compatibility reasons.
 
+config X86_SFI_CPUFREQ
+	tristate "SFI P-States driver"
+	depends on X86_INTEL_MID && SFI
+	help
+	  This adds a CPUFreq driver for some Silvermont based Intel Atom
+	  architectures like Z34xx and Z35xx which enumerate processor
+	  performance states through SFI.
+
+	  If in doubt, say N.
+
 config ELAN_CPUFREQ
 	tristate "AMD Elan SC400 and SC410"
 	depends on MELAN
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index db6d9a2fea4d..c3b51efd4a85 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_X86_P4_CLOCKMOD)		+= p4-clockmod.o
 obj-$(CONFIG_X86_CPUFREQ_NFORCE2)	+= cpufreq-nforce2.o
 obj-$(CONFIG_X86_INTEL_PSTATE)		+= intel_pstate.o
 obj-$(CONFIG_X86_AMD_FREQ_SENSITIVITY)	+= amd_freq_sensitivity.o
+obj-$(CONFIG_X86_SFI_CPUFREQ)		+= sfi-cpufreq.o
 
 ##################################################################################
 # ARM SoC drivers
diff --git a/drivers/cpufreq/sfi-cpufreq.c b/drivers/cpufreq/sfi-cpufreq.c
new file mode 100644
index 000000000000..118aa5eba628
--- /dev/null
+++ b/drivers/cpufreq/sfi-cpufreq.c
@@ -0,0 +1,165 @@
+/*
+ *  SFI Processor P-States Driver
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  Author: Vishwesh M Rudramuni <vishwesh.m.rudramuni@intel.com>
+ *  Author: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
+ */
+
+#include <linux/cpufreq.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sfi.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+
+#include <asm/msr.h>
+
+#define SFI_FREQ_MAX		32
+#define SFI_FREQ_MASK		0xff00
+
+static DEFINE_PER_CPU(struct cpufreq_frequency_table *, drv_data);
+static struct sfi_freq_table_entry sfi_cpufreq_array[SFI_FREQ_MAX];
+static int num_freq_table_entries;
+
+static int sfi_parse_freq(struct sfi_table_header *table)
+{
+	struct sfi_table_simple *sb;
+	struct sfi_freq_table_entry *pentry;
+	int totallen;
+
+	sb = (struct sfi_table_simple *)table;
+	num_freq_table_entries = SFI_GET_NUM_ENTRIES(sb,
+			struct sfi_freq_table_entry);
+	if (num_freq_table_entries <= 1) {
+		pr_err("No p-states discovered\n");
+		return -ENODEV;
+	}
+
+	pentry = (struct sfi_freq_table_entry *)sb->pentry;
+	totallen = num_freq_table_entries * sizeof(*pentry);
+	memcpy(sfi_cpufreq_array, pentry, totallen);
+
+	return 0;
+}
+
+static int sfi_cpufreq_target(struct cpufreq_policy *policy,
+				unsigned int index)
+{
+	struct cpufreq_frequency_table *freq_table =
+			per_cpu(drv_data, policy->cpu);
+	unsigned int next_perf_state = 0; /* Index into perf table */
+	u32 lo, hi;
+
+	next_perf_state = freq_table[index].driver_data;
+
+	rdmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, &lo, &hi);
+	lo = (lo & ~INTEL_PERF_CTL_MASK) |
+		((u32) sfi_cpufreq_array[next_perf_state].ctrl_val &
+		INTEL_PERF_CTL_MASK);
+	wrmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, lo, hi);
+
+	return 0;
+}
+
+static int sfi_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *freq_table;
+	unsigned int i, result, valid_states = 0;
+	unsigned int cpu = policy->cpu;
+
+	freq_table = kzalloc(sizeof(*freq_table) *
+			(num_freq_table_entries + 1), GFP_KERNEL);
+	if (!freq_table)
+		return -ENOMEM;
+
+	per_cpu(drv_data, cpu) = freq_table;
+
+	policy->shared_type = CPUFREQ_SHARED_TYPE_HW;
+
+	policy->cpuinfo.transition_latency = 0;
+	for (i = 0; i < num_freq_table_entries; i++) {
+		/* detect transition latency */
+		if ((sfi_cpufreq_array[i].latency * 1000) >
+		    policy->cpuinfo.transition_latency)
+			policy->cpuinfo.transition_latency =
+				sfi_cpufreq_array[i].latency * 1000;
+
+		/* initialize the freq table */
+		freq_table[valid_states].driver_data = i;
+		freq_table[valid_states].frequency =
+				sfi_cpufreq_array[i].freq_mhz * 1000;
+		valid_states++;
+
+		pr_debug("     P%d: %d MHz, %d uS\n",
+			i,
+			(u32) sfi_cpufreq_array[i].freq_mhz,
+			(u32) sfi_cpufreq_array[i].latency);
+	}
+	freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
+
+	result = cpufreq_table_validate_and_show(policy, freq_table);
+	if (result)
+		goto err_free;
+
+	pr_debug("CPU%u - SFI performance management activated.\n", cpu);
+
+	return result;
+
+err_free:
+	per_cpu(drv_data, cpu) = NULL;
+	kfree(freq_table);
+
+	return result;
+}
+
+static int sfi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *freq_table =
+			per_cpu(drv_data, policy->cpu);
+
+	kfree(freq_table);
+	return 0;
+}
+
+static struct cpufreq_driver sfi_cpufreq_driver = {
+	.flags		= CPUFREQ_CONST_LOOPS,
+	.verify		= cpufreq_generic_frequency_table_verify,
+	.target_index	= sfi_cpufreq_target,
+	.init		= sfi_cpufreq_cpu_init,
+	.exit		= sfi_cpufreq_cpu_exit,
+	.name		= "sfi-cpufreq",
+	.attr		= cpufreq_generic_attr,
+};
+
+static int __init sfi_cpufreq_init(void)
+{
+	int ret;
+
+	/* parse the freq table from SFI */
+	ret = sfi_table_parse(SFI_SIG_FREQ, NULL, NULL, sfi_parse_freq);
+	if (ret)
+		return ret;
+
+	return cpufreq_register_driver(&sfi_cpufreq_driver);
+}
+late_initcall(sfi_cpufreq_init);
+
+static void __exit sfi_cpufreq_exit(void)
+{
+	cpufreq_unregister_driver(&sfi_cpufreq_driver);
+}
+module_exit(sfi_cpufreq_exit);
+
+MODULE_AUTHOR("Vishwesh M Rudramuni <vishwesh.m.rudramuni@intel.com>");
+MODULE_DESCRIPTION("SFI P-States Driver");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5


-- 
