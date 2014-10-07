From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: [PATCH] cpufreq: Add sfi based cpufreq driver support
Date: Tue, 7 Oct 2014 19:37:34 +0530
Message-ID: <20141007140734.GB24200@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58061 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbaJGGH7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Oct 2014 02:07:59 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, vishwesh.m.rudramuni@intel.com, srinidhi.kasagar@intel.com

>From b3037348db47f0629316dd0027c7f1a1b28be959 Mon Sep 17 00:00:00 2001
From: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Date: Fri, 12 Sep 2014 22:52:37 +0530
Subject: [PATCH] cpufreq: Add sfi based cpufreq driver support

This adds the sfi based cpu freq driver for some of the
Intel's Silver Mont based atom architectures like
Merrifield and Moorfield (intel-mid)

Signed-off-by: Rudramuni, Vishwesh M <vishwesh.m.rudramuni@intel.com>
Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
---
 drivers/cpufreq/Kconfig.x86   |   10 +
 drivers/cpufreq/Makefile      |    1 +
 drivers/cpufreq/sfi-cpufreq.c |  426 +++++++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/sfi-cpufreq.h |   53 +++++
 4 files changed, 490 insertions(+)
 create mode 100644 drivers/cpufreq/sfi-cpufreq.c
 create mode 100644 drivers/cpufreq/sfi-cpufreq.h

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 89ae88f91895..3d6886b558fa 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -57,6 +57,16 @@ config X86_ACPI_CPUFREQ_CPB
 	  By enabling this option the acpi_cpufreq driver provides the old
 	  entry in addition to the new boost ones, for compatibility reasons.
 
+config X86_SFI_CPUFREQ
+	tristate "SFI Processor P-States driver"
+	depends on X86_INTEL_MID && SFI
+	help
+	  This driver adds a CPUFreq driver which utilizes the SFI
+	  Processor Performance States enumeration on some Silver Mont
+	  based Intel Atom architecture (like intel-mid)
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
index 000000000000..1400e0387528
--- /dev/null
+++ b/drivers/cpufreq/sfi-cpufreq.c
@@ -0,0 +1,426 @@
+/*
+ *  sfi_cpufreq.c - sfi Processor P-States Driver
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
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/cpufreq.h>
+#include <linux/slab.h>
+#include <linux/sfi.h>
+
+#include <asm/msr.h>
+#include <asm/processor.h>
+
+#include "sfi-cpufreq.h"
+
+#define SFI_FREQ_MAX		32
+#define INTEL_MSR_RANGE		0xffff
+#define INTEL_MSR_BUSRATIO_MASK	0xff00
+#define SFI_CPU_MAX		8
+
+DEFINE_PER_CPU(struct sfi_processor *, sfi_processors);
+
+static DEFINE_MUTEX(performance_mutex);
+static DEFINE_PER_CPU(struct sfi_cpufreq_data *, drv_data);
+struct sfi_freq_table_entry sfi_cpufreq_array[SFI_FREQ_MAX];
+static int sfi_cpufreq_num;
+
+/* sfi_perf_data is a pointer to percpu data. */
+static struct sfi_processor_performance *sfi_perf_data;
+static struct cpufreq_driver sfi_cpufreq_driver;
+
+struct sfi_cpufreq_data {
+	struct sfi_processor_performance *sfi_data;
+	struct cpufreq_frequency_table *freq_table;
+	unsigned int resume;
+};
+
+static int parse_freq(struct sfi_table_header *table)
+{
+	struct sfi_table_simple *sb;
+	struct sfi_freq_table_entry *pentry;
+	int total_len;
+
+	sb = (struct sfi_table_simple *)table;
+	if (!sb) {
+		printk(KERN_WARNING "SFI: Unable to map FREQ\n");
+		return -ENODEV;
+	}
+
+	if (!sfi_cpufreq_num) {
+		sfi_cpufreq_num = SFI_GET_NUM_ENTRIES(sb,
+			 struct sfi_freq_table_entry);
+		pentry = (struct sfi_freq_table_entry *)sb->pentry;
+		total_len = sfi_cpufreq_num * sizeof(*pentry);
+		memcpy(sfi_cpufreq_array, pentry, total_len);
+	}
+
+	return 0;
+}
+
+static int sfi_processor_get_performance_states(struct sfi_processor *pr)
+{
+	int result = 0;
+	int i;
+
+	pr->performance->state_count = sfi_cpufreq_num;
+	pr->performance->states =
+	    kmalloc(sizeof(struct sfi_processor_px) * sfi_cpufreq_num,
+		    GFP_KERNEL);
+	if (!pr->performance->states)
+		result = -ENOMEM;
+
+	printk(KERN_INFO "Num p-states %d\n", sfi_cpufreq_num);
+
+	/* Populate the P-states info from the SFI table here */
+	for (i = 0; i < sfi_cpufreq_num; i++) {
+		pr->performance->states[i].core_frequency =
+			sfi_cpufreq_array[i].freq_mhz;
+		pr->performance->states[i].transition_latency =
+			sfi_cpufreq_array[i].latency;
+		pr->performance->states[i].control =
+			sfi_cpufreq_array[i].ctrl_val;
+		printk(KERN_INFO "State [%d]: core_frequency[%d] transition_latency[%d] control[0x%x]\n",
+			i,
+			(u32) pr->performance->states[i].core_frequency,
+			(u32) pr->performance->states[i].transition_latency,
+			(u32) pr->performance->states[i].control);
+	}
+
+	return result;
+}
+
+static int sfi_processor_register_performance(struct sfi_processor_performance
+				    *performance, unsigned int cpu)
+{
+	struct sfi_processor *pr;
+
+	mutex_lock(&performance_mutex);
+
+	pr = per_cpu(sfi_processors, cpu);
+	if (!pr) {
+		mutex_unlock(&performance_mutex);
+		return -ENODEV;
+	}
+
+	if (pr->performance) {
+		mutex_unlock(&performance_mutex);
+		return -EBUSY;
+	}
+
+	WARN_ON(!performance);
+
+	pr->performance = performance;
+
+	/* parse the freq table from sfi */
+	sfi_cpufreq_num = 0;
+	sfi_table_parse(SFI_SIG_FREQ, NULL, NULL, parse_freq);
+
+	sfi_processor_get_performance_states(pr);
+
+	mutex_unlock(&performance_mutex);
+	return 0;
+}
+
+void sfi_processor_unregister_performance(struct sfi_processor_performance
+				      *performance, unsigned int cpu)
+{
+	struct sfi_processor *pr;
+
+	mutex_lock(&performance_mutex);
+
+	pr = per_cpu(sfi_processors, cpu);
+	if (!pr) {
+		mutex_unlock(&performance_mutex);
+		return;
+	}
+
+	if (pr->performance)
+		kfree(pr->performance->states);
+	pr->performance = NULL;
+
+	mutex_unlock(&performance_mutex);
+}
+
+static unsigned extract_freq(u32 msr, struct sfi_cpufreq_data *data)
+{
+	struct cpufreq_frequency_table *pos;
+	struct sfi_processor_performance *perf;
+	u32 sfi_ctrl;
+
+	msr &= INTEL_MSR_BUSRATIO_MASK;
+	perf = data->sfi_data;
+
+	cpufreq_for_each_entry(pos, data->freq_table) {
+		sfi_ctrl = perf->states[pos->driver_data].control
+			& INTEL_MSR_BUSRATIO_MASK;
+		if (sfi_ctrl == msr)
+			return pos->frequency;
+	}
+	return data->freq_table[0].frequency;
+}
+
+static u32 get_cur_val(const struct cpumask *mask)
+{
+	u32 val, dummy;
+
+	if (unlikely(cpumask_empty(mask)))
+		return 0;
+
+	rdmsr_on_cpu(cpumask_any(mask), MSR_IA32_PERF_STATUS, &val, &dummy);
+
+	return val;
+}
+
+static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
+{
+	struct sfi_cpufreq_data *data = per_cpu(drv_data, cpu);
+	unsigned int freq;
+	unsigned int cached_freq;
+
+	pr_debug("get_cur_freq_on_cpu (%d)\n", cpu);
+
+	if (unlikely(data == NULL ||
+		data->sfi_data == NULL || data->freq_table == NULL)) {
+		return 0;
+	}
+
+	cached_freq = data->freq_table[data->sfi_data->state].frequency;
+	freq = extract_freq(get_cur_val(cpumask_of(cpu)), data);
+	if (freq != cached_freq)
+		 /* Force the frequency on next target call */
+		data->resume = 1;
+
+	pr_debug("cur freq = %u\n", freq);
+
+	return freq;
+}
+
+static int sfi_cpufreq_target(struct cpufreq_policy *policy,
+				unsigned int index)
+{
+	struct sfi_cpufreq_data *data = per_cpu(drv_data, policy->cpu);
+	struct sfi_processor_performance *perf;
+	unsigned int next_perf_state = 0; /* Index into perf table */
+	u32 lo, hi;
+
+	if (unlikely(data == NULL ||
+	     data->sfi_data == NULL || data->freq_table == NULL)) {
+		return -ENODEV;
+	}
+
+	perf = data->sfi_data;
+	next_perf_state = data->freq_table[index].driver_data;
+	if (perf->state == next_perf_state) {
+		if (unlikely(data->resume)) {
+			pr_debug("Called after resume, resetting to P%d\n",
+				next_perf_state);
+			data->resume = 0;
+		} else {
+			pr_debug("Already at target state (P%d)\n",
+				next_perf_state);
+			return 0;
+		}
+	}
+
+	rdmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, &lo, &hi);
+	lo = (lo & ~INTEL_MSR_RANGE) |
+		((u32) perf->states[next_perf_state].control & INTEL_MSR_RANGE);
+	wrmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, lo, hi);
+
+	perf->state = next_perf_state;
+
+	return 0;
+}
+
+static int sfi_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	unsigned int i;
+	unsigned int valid_states = 0;
+	unsigned int cpu = policy->cpu;
+	struct sfi_cpufreq_data *data;
+	unsigned int result = 0;
+	struct sfi_processor_performance *perf;
+	struct sfi_processor *pr;
+
+	pr = kzalloc(sizeof(struct sfi_processor), GFP_KERNEL);
+	if (!pr)
+		return -ENOMEM;
+
+	per_cpu(sfi_processors, cpu) = pr;
+
+	pr_debug("sfi_cpufreq_cpu_init CPU:%d\n", policy->cpu);
+
+	data = kzalloc(sizeof(struct sfi_cpufreq_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->sfi_data = per_cpu_ptr(sfi_perf_data, cpu);
+	per_cpu(drv_data, cpu) = data;
+
+	sfi_cpufreq_driver.flags |= CPUFREQ_CONST_LOOPS;
+
+	result = sfi_processor_register_performance(data->sfi_data, cpu);
+	if (result)
+		goto err_free;
+
+	perf = data->sfi_data;
+	policy->shared_type = CPUFREQ_SHARED_TYPE_HW;
+
+	cpumask_set_cpu(policy->cpu, policy->cpus);
+	cpumask_set_cpu(policy->cpu, policy->related_cpus);
+
+	/* capability check */
+	if (perf->state_count <= 1) {
+		pr_debug("No P-States\n");
+		result = -ENODEV;
+		goto err_unreg;
+	}
+
+	data->freq_table = kzalloc(sizeof(struct cpufreq_frequency_table) *
+		    (perf->state_count+1), GFP_KERNEL);
+	if (!data->freq_table) {
+		result = -ENOMEM;
+		goto err_unreg;
+	}
+
+	/* detect transition latency */
+	policy->cpuinfo.transition_latency = 0;
+	for (i = 0; i < perf->state_count; i++) {
+		if ((perf->states[i].transition_latency * 1000) >
+		    policy->cpuinfo.transition_latency)
+			policy->cpuinfo.transition_latency =
+			    perf->states[i].transition_latency * 1000;
+	}
+
+	/* initialize the freq table */
+	for (i = 0; i < perf->state_count; i++) {
+		if (i > 0 && perf->states[i].core_frequency >=
+		    data->freq_table[valid_states-1].frequency / 1000)
+			continue;
+
+		data->freq_table[valid_states].driver_data = i;
+		data->freq_table[valid_states].frequency =
+		    perf->states[i].core_frequency * 1000;
+		valid_states++;
+	}
+	data->freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
+	perf->state = 0;
+
+	result = cpufreq_table_validate_and_show(policy, data->freq_table);
+	if (result)
+		goto err_freqfree;
+
+	policy->cur = get_cur_freq_on_cpu(cpu);
+
+	pr_debug("CPU%u - SFI performance management activated.\n", cpu);
+	for (i = 0; i < perf->state_count; i++)
+		pr_debug("     %cP%d: %d MHz, %d uS\n",
+			(i == perf->state ? '*' : ' '), i,
+			(u32) perf->states[i].core_frequency,
+			(u32) perf->states[i].transition_latency);
+
+	data->resume = 1;
+
+	return result;
+
+err_freqfree:
+	kfree(data->freq_table);
+err_unreg:
+	sfi_processor_unregister_performance(perf, cpu);
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
+	struct sfi_processor *pr = per_cpu(sfi_processors, policy->cpu);
+
+	pr_debug("sfi_cpufreq_cpu_exit\n");
+
+	if (data) {
+		per_cpu(drv_data, policy->cpu) = NULL;
+		sfi_processor_unregister_performance(data->sfi_data,
+						policy->cpu);
+		kfree(data->freq_table);
+		kfree(data);
+		kfree(pr);
+	}
+
+	return 0;
+}
+
+static int sfi_cpufreq_resume(struct cpufreq_policy *policy)
+{
+	struct sfi_cpufreq_data *data = per_cpu(drv_data, policy->cpu);
+
+	pr_debug("sfi_cpufreq_resume\n");
+
+	data->resume = 1;
+
+	return 0;
+}
+
+static struct freq_attr *sfi_cpufreq_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+
+static struct cpufreq_driver sfi_cpufreq_driver = {
+	.get = get_cur_freq_on_cpu,
+	.verify = cpufreq_generic_frequency_table_verify,
+	.target_index = sfi_cpufreq_target,
+	.init = sfi_cpufreq_cpu_init,
+	.exit = sfi_cpufreq_cpu_exit,
+	.resume = sfi_cpufreq_resume,
+	.name = "sfi-cpufreq",
+	.attr = sfi_cpufreq_attr,
+};
+
+static int __init sfi_cpufreq_init(void)
+{
+	sfi_perf_data = alloc_percpu(struct sfi_processor_performance);
+	if (!sfi_perf_data) {
+		pr_debug("Memory allocation error for sfi_perf_data.\n");
+		return -ENOMEM;
+	}
+
+	return cpufreq_register_driver(&sfi_cpufreq_driver);
+}
+
+static void __exit sfi_cpufreq_exit(void)
+{
+	struct sfi_processor *pr;
+
+	pr = per_cpu(sfi_processors, 0);
+	kfree(pr);
+
+	cpufreq_unregister_driver(&sfi_cpufreq_driver);
+
+	free_percpu(sfi_perf_data);
+}
+late_initcall(sfi_cpufreq_init);
+module_exit(sfi_cpufreq_exit);
+
+MODULE_ALIAS("sfi");
+MODULE_AUTHOR("Vishwesh Rudramuni");
+MODULE_DESCRIPTION("SFI Processor P-States Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/cpufreq/sfi-cpufreq.h b/drivers/cpufreq/sfi-cpufreq.h
new file mode 100644
index 000000000000..b24f958cdaa8
--- /dev/null
+++ b/drivers/cpufreq/sfi-cpufreq.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright (c) 2010, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef __SFI_PROCESSOR_H__
+#define __SFI_PROCESSOR_H__
+
+#include <linux/sfi.h>
+#include <linux/cpuidle.h>
+
+struct sfi_processor_power {
+	struct cpuidle_device dev;
+	u32 default_state;
+	int count;
+	struct cpuidle_state *states;
+	struct sfi_cstate_table_entry *sfi_cstates;
+};
+
+struct sfi_processor_flags {
+	u8 valid;
+	u8 power;
+};
+
+struct sfi_processor {
+	u32 id;
+	struct sfi_processor_flags flags;
+	struct sfi_processor_power power;
+	struct sfi_processor_performance *performance;
+};
+
+/* Performance management */
+struct sfi_processor_px {
+	u32 core_frequency;	/* megahertz */
+	u32 transition_latency;	/* microseconds */
+	u32 control;	/* control value */
+};
+
+struct sfi_processor_performance {
+	unsigned int state;
+	unsigned int state_count;
+	struct sfi_processor_px *states;
+};
+
+#endif /*__SFI_PROCESSOR_H__*/
-- 
1.7.9.5
