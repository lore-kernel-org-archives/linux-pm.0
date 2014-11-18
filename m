From: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Subject: [PATCH v5] cpufreq: Add SFI based cpufreq driver support
Date: Tue, 18 Nov 2014 11:15:45 +0530
Message-ID: <20141118054537.GA28516@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8623 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbaKRFou (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 18 Nov 2014 00:44:50 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, vishwesh.m.rudramuni@intel.com, srinidhi.kasagar@intel.com, lenb@kernel.org

This adds the SFI based cpu freq driver for some of the Intel's
Silvermont based Atom architectures like Z34xx and Z35xx.

Signed-off-by: Rudramuni, Vishwesh M <vishwesh.m.rudramuni@intel.com>
Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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

 arch/x86/include/uapi/asm/msr-index.h |    1 +
 drivers/cpufreq/Kconfig.x86           |   10 ++
 drivers/cpufreq/Makefile              |    1 +
 drivers/cpufreq/sfi-cpufreq.c         |  238 +++++++++++++++++++++++++++++++++
 4 files changed, 250 insertions(+)
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
index 000000000000..83f865f7b1e0
--- /dev/null
+++ b/drivers/cpufreq/sfi-cpufreq.c
@@ -0,0 +1,238 @@
+/*
+ *  SFI Processor P-States Driver
+ *  Based on ACPI Processor P-States Driver
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
+#include <linux/cpuidle.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sfi.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+
+#include <asm/msr.h>
+#include <asm/processor.h>
+
+#define SFI_FREQ_MASK		0xff00
+
+static DEFINE_PER_CPU(struct sfi_cpufreq_data *, drv_data);
+static DEFINE_MUTEX(performance_mutex);
+
+static struct sfi_freq_table_entry *f_entry;
+/* sfi_perf_data is a pointer to percpu data. */
+static struct sfi_cpufreq_performance *sfi_perf_data;
+
+static int sfi_cpufreq_num;
+
+struct sfi_cpufreq_performance {
+	unsigned int state;
+	unsigned int state_count;
+	struct sfi_freq_table_entry *states;
+};
+
+struct sfi_cpufreq_data {
+	struct sfi_cpufreq_performance *sfi_data;
+	struct cpufreq_frequency_table *freq_table;
+};
+
+static int parse_freq(struct sfi_table_header *table)
+{
+	struct sfi_table_simple *sb;
+
+	sb = (struct sfi_table_simple *)table;
+
+	sfi_cpufreq_num = SFI_GET_NUM_ENTRIES(sb, struct sfi_freq_table_entry);
+	f_entry = (struct sfi_freq_table_entry *)sb->pentry;
+
+	return 0;
+}
+
+static int sfi_cpufreq_register_performance(struct sfi_cpufreq_performance *pr)
+{
+	mutex_lock(&performance_mutex);
+
+	/* parse the freq table from SFI */
+	sfi_table_parse(SFI_SIG_FREQ, NULL, NULL, parse_freq);
+
+	pr->state_count = sfi_cpufreq_num;
+	if (pr->state_count <= 1) {
+		pr_err("No p-states discovered\n");
+		return -ENODEV;
+	}
+
+	pr->states = f_entry;
+
+	mutex_unlock(&performance_mutex);
+
+	return 0;
+}
+
+static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
+{
+	u32 lo, hi, sfi_ctrl;
+	struct sfi_cpufreq_performance *perf;
+	struct cpufreq_frequency_table *pos;
+	struct sfi_cpufreq_data *data = per_cpu(drv_data, cpu);
+
+	rdmsr_on_cpu(cpu, MSR_IA32_PERF_CTL, &lo, &hi);
+	lo &= SFI_FREQ_MASK;
+
+	perf = data->sfi_data;
+
+	cpufreq_for_each_entry(pos, data->freq_table) {
+		sfi_ctrl = perf->states[pos->driver_data].ctrl_val
+			& SFI_FREQ_MASK;
+		if (sfi_ctrl == lo)
+			return pos->frequency;
+	}
+	return data->freq_table[0].frequency;
+}
+
+static int sfi_cpufreq_target(struct cpufreq_policy *policy,
+				unsigned int index)
+{
+	struct sfi_cpufreq_data *data = per_cpu(drv_data, policy->cpu);
+	struct sfi_cpufreq_performance *perf;
+	unsigned int next_perf_state = 0; /* Index into perf table */
+	u32 lo, hi;
+
+	perf = data->sfi_data;
+	next_perf_state = data->freq_table[index].driver_data;
+
+	rdmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, &lo, &hi);
+	lo = (lo & ~INTEL_PERF_CTL_MASK) |
+		((u32) perf->states[next_perf_state].ctrl_val &
+			INTEL_PERF_CTL_MASK);
+	wrmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, lo, hi);
+
+	perf->state = next_perf_state;
+
+	return 0;
+}
+
+static int sfi_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	unsigned int i, result = 0, valid_states = 0;
+	unsigned int cpu = policy->cpu;
+	struct sfi_cpufreq_data *data;
+	struct sfi_cpufreq_performance *perf;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->sfi_data = per_cpu_ptr(sfi_perf_data, cpu);
+	per_cpu(drv_data, cpu) = data;
+
+	result = sfi_cpufreq_register_performance(data->sfi_data);
+	if (result)
+		goto err_free;
+
+	perf = data->sfi_data;
+	policy->shared_type = CPUFREQ_SHARED_TYPE_HW;
+
+	data->freq_table = kzalloc(sizeof(*data->freq_table) *
+				(perf->state_count+1), GFP_KERNEL);
+	if (!data->freq_table) {
+		result = -ENOMEM;
+		goto err_free;
+	}
+
+	policy->cpuinfo.transition_latency = 0;
+	for (i = 0; i < perf->state_count; i++) {
+		/* detect transition latency */
+		if ((perf->states[i].latency * 1000) >
+		    policy->cpuinfo.transition_latency)
+			policy->cpuinfo.transition_latency =
+				perf->states[i].latency * 1000;
+
+		/* initialize the freq table */
+		data->freq_table[valid_states].driver_data = i;
+		data->freq_table[valid_states].frequency =
+				perf->states[i].freq_mhz * 1000;
+		valid_states++;
+
+		pr_debug("     %cP%d: %d MHz, %d uS\n",
+			(i == perf->state ? '*' : ' '), i,
+			(u32) perf->states[i].freq_mhz,
+			(u32) perf->states[i].latency);
+	}
+
+	data->freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
+	perf->state = 0;
+
+	result = cpufreq_table_validate_and_show(policy, data->freq_table);
+	if (result)
+		goto err_freqfree;
+
+	pr_debug("CPU%u - SFI performance management activated.\n", cpu);
+
+	return result;
+
+err_freqfree:
+	kfree(data->freq_table);
+err_free:
+	kfree(data);
+	per_cpu(drv_data, cpu) = NULL;
+
+	return result;
+}
+
+static int sfi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	struct sfi_cpufreq_data *data = per_cpu(drv_data, policy->cpu);
+
+	per_cpu(drv_data, policy->cpu) = NULL;
+	kfree(data->freq_table);
+	kfree(data);
+
+	return 0;
+}
+
+static struct cpufreq_driver sfi_cpufreq_driver = {
+	.flags		= CPUFREQ_CONST_LOOPS,
+	.get		= get_cur_freq_on_cpu,
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
+	sfi_perf_data = alloc_percpu(struct sfi_cpufreq_performance);
+	if (!sfi_perf_data) {
+		pr_err("Memory allocation error for sfi_perf_data.\n");
+		return -ENOMEM;
+	}
+
+	return cpufreq_register_driver(&sfi_cpufreq_driver);
+}
+late_initcall(sfi_cpufreq_init);
+
+static void __exit sfi_cpufreq_exit(void)
+{
+	cpufreq_unregister_driver(&sfi_cpufreq_driver);
+	free_percpu(sfi_perf_data);
+}
+module_exit(sfi_cpufreq_exit);
+
+MODULE_AUTHOR("Vishwesh M Rudramuni <vishwesh.m.rudramuni@intel.com>");
+MODULE_DESCRIPTION("SFI P-States Driver");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5


-- 
