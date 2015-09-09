From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v9 2/5] CPPC: Add a CPUFreq driver for use with CPPC
Date: Wed,  9 Sep 2015 16:27:05 -0400
Message-ID: <6d24b51b0387f4ef6cc4a2517ace2e5e9731d7be.1441830300.git.ashwin.chaugule@linaro.org>
References: <cover.1441830300.git.ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36360 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbbIIU1W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 16:27:22 -0400
Received: by padhk3 with SMTP id hk3so19832951pad.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2015 13:27:21 -0700 (PDT)
In-Reply-To: <cover.1441830300.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1441830300.git.ashwin.chaugule@linaro.org>
References: <cover.1441830300.git.ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, rwells@codeaurora.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

This driver utilizes the methods introduced in the previous
patch - "ACPI: Introduce CPU performance controls using CPPC"
and enables usage with existing CPUFreq governors.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Reviewed-by: Al Stone <al.stone@linaro.org>
---
 drivers/cpufreq/Kconfig.arm    |  17 +++++
 drivers/cpufreq/Makefile       |   2 +
 drivers/cpufreq/cppc_cpufreq.c | 169 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+)
 create mode 100644 drivers/cpufreq/cppc_cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index cc8a71c..e8bb41b 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -261,3 +261,20 @@ config ARM_PXA2xx_CPUFREQ
 	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
 
 	  If in doubt, say N.
+
+config ACPI_CPPC_CPUFREQ
+	tristate "CPUFreq driver based on the ACPI CPPC spec"
+	depends on ACPI
+	select ACPI_CPPC_LIB
+	default n
+	help
+	  This adds a CPUFreq driver which uses CPPC methods
+	  as described in the ACPIv5.1 spec. CPPC stands for
+	  Collaborative Processor Performance Controls. It
+	  is based on an abstract continuous scale of CPU
+	  performance values which allows the remote power
+	  processor to flexibly optimize for power and
+	  performance. CPPC relies on power management firmware
+	  support for its operation.
+
+	  If in doubt, say N.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 2169bf7..676660e 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -78,6 +78,8 @@ obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA_CPUFREQ)		+= tegra-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
+obj-$(CONFIG_ACPI_CPPC_CPUFREQ) += cppc_cpufreq.o
+
 
 ##################################################################################
 # PowerPC platform drivers
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
new file mode 100644
index 0000000..2f6ed0b
--- /dev/null
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -0,0 +1,169 @@
+/*
+ * CPPC (Collaborative Processor Performance Control) driver for
+ * interfacing with the CPUfreq layer and governors. See
+ * cppc_acpi.c for CPPC specific methods.
+ *
+ * (C) Copyright 2014, 2015 Linaro Ltd.
+ * Author: Ashwin Chaugule <ashwin.chaugule@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+
+#define pr_fmt(fmt)	"CPPC Cpufreq:"	fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/vmalloc.h>
+
+#include <acpi/cppc_acpi.h>
+
+/*
+ * These structs contain information parsed from per CPU
+ * ACPI _CPC structures.
+ * e.g. For each CPU the highest, lowest supported
+ * performance capabilities, desired performance level
+ * requested etc.
+ */
+static struct cpudata **all_cpu_data;
+
+static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
+		unsigned int target_freq,
+		unsigned int relation)
+{
+	struct cpudata *cpu;
+	struct cpufreq_freqs freqs;
+	int ret = 0;
+
+	cpu = all_cpu_data[policy->cpu];
+
+	cpu->perf_ctrls.desired_perf = target_freq;
+	freqs.old = policy->cur;
+	freqs.new = target_freq;
+
+	cpufreq_freq_transition_begin(policy, &freqs);
+	ret = cppc_set_perf(cpu->cpu, &cpu->perf_ctrls);
+	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
+
+	if (ret) {
+		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
+				cpu->cpu, ret);
+		return -EFAULT;
+	}
+
+	return ret;
+}
+
+static int cppc_verify_policy(struct cpufreq_policy *policy)
+{
+	cpufreq_verify_within_cpu_limits(policy);
+	return 0;
+}
+
+static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy)
+{
+	int cpu_num = policy->cpu;
+	struct cpudata *cpu = all_cpu_data[cpu_num];
+	int ret;
+
+	pr_info("CPU %d exiting\n", cpu_num);
+
+	cpu->perf_ctrls.desired_perf = cpu->perf_caps.lowest_perf;
+
+	ret = cppc_set_perf(cpu_num, &cpu->perf_ctrls);
+	if (ret)
+		pr_err("Err setting perf value:%d on CPU:%d. ret:%d\n",
+				cpu->perf_caps.lowest_perf, cpu_num, ret);
+}
+
+static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	struct cpudata *cpu;
+	int ret = 0;
+
+	cpu = all_cpu_data[policy->cpu];
+
+	cpu->cpu = policy->cpu;
+	ret = cppc_get_perf_caps(policy->cpu, &cpu->perf_caps);
+
+	if (ret) {
+		pr_err("Err reading CPU%d perf capabilities. ret:%d\n",
+				cpu->cpu, ret);
+		return -FAULT;
+	}
+
+	policy->min = cpu->perf_caps.lowest_perf;
+	policy->max = cpu->perf_caps.highest_perf;
+	policy->cpuinfo.min_freq = policy->min;
+	policy->cpuinfo.max_freq = policy->max;
+
+	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL ||
+	    policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
+		cpumask_copy(policy->cpus, cpu->shared_cpu_map);
+
+	cpumask_set_cpu(policy->cpu, policy->cpus);
+	cpu->cur_policy = policy;
+
+	pr_debug("Initialized on cpu:%d\n", cpu->cpu);
+	return ret;
+}
+
+static struct cpufreq_driver cppc_cpufreq_driver = {
+	.flags = CPUFREQ_CONST_LOOPS,
+	.verify = cppc_verify_policy,
+	.target = cppc_cpufreq_set_target,
+	.init = cppc_cpufreq_cpu_init,
+	.stop_cpu = cppc_cpufreq_stop_cpu,
+	.name = "cppc_cpufreq",
+};
+
+static int __init cppc_cpufreq_init(void)
+{
+	int i, ret = 0;
+	struct cpudata *cpu;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	all_cpu_data = vzalloc(sizeof(void *) * num_possible_cpus());
+	if (!all_cpu_data)
+		return -ENOMEM;
+
+	for_each_possible_cpu(i) {
+		all_cpu_data[i] = kzalloc(sizeof(struct cpudata), GFP_KERNEL);
+		if (!all_cpu_data[i])
+			goto out;
+
+		cpu = all_cpu_data[i];
+		if (!zalloc_cpumask_var(&cpu->shared_cpu_map, GFP_KERNEL))
+			goto out;
+	}
+
+	ret = acpi_get_psd_map(all_cpu_data);
+	if (ret) {
+		pr_debug("Error parsing PSD data. Aborting cpufreq registration.\n");
+		goto out;
+	}
+
+	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
+	if (ret)
+		goto out;
+
+	pr_info("Registration completed.\n");
+	return ret;
+
+out:
+	for_each_possible_cpu(i)
+		if (all_cpu_data[i])
+			kfree(all_cpu_data[i]);
+
+	vfree(all_cpu_data);
+	return -ENODEV;
+}
+
+late_initcall(cppc_cpufreq_init);
-- 
1.9.1

