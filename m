From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v7 5/8] CPPC: Add a CPUFreq driver for use with CPPC
Date: Thu,  9 Jul 2015 14:04:21 -0400
Message-ID: <e8464849d98e4a4f64e9b23501d84b1f843aa994.1436464513.git.ashwin.chaugule@linaro.org>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1436464513.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1436464513.git.ashwin.chaugule@linaro.org>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, sudeep.holla@arm.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>
List-Id: linux-pm@vger.kernel.org

This driver utilizes the methods introduced in the previous
patch - "ACPI: Introduce CPU performance controls using CPPC"
and enables usage with existing CPUFreq governors.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Reviewed-by: Al Stone <al.stone@linaro.org>
---
 drivers/cpufreq/Kconfig.arm    |  16 ++++
 drivers/cpufreq/Makefile       |   2 +
 drivers/cpufreq/cppc_cpufreq.c | 197 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 215 insertions(+)
 create mode 100644 drivers/cpufreq/cppc_cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 4f3dbc8..578384d 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -272,3 +272,19 @@ config ARM_PXA2xx_CPUFREQ
 	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
 
 	  If in doubt, say N.
+
+config ACPI_CPPC_CPUFREQ
+	tristate "CPUFreq driver based on the ACPI CPPC spec"
+	depends on ACPI_CPPC_LIB
+	default n
+	help
+	  This adds a CPUFreq driver which uses CPPC methods
+	  as described in the ACPIv5.1 spec. CPPC stands for
+	  Collaborative Processor Performance Controls. It
+	  is based on an abstract continuous scale of CPU
+	  performance values which allows the remote power
+	  processor to flexibly optimize for power and
+	  performance. CPPC relies on power management firmware
+	  for its operation.
+
+	  If in doubt, say N.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index cdce92a..ef3779b 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -79,6 +79,8 @@ obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA_CPUFREQ)		+= tegra-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
+obj-$(CONFIG_ACPI_CPPC_CPUFREQ) += cppc_cpufreq.o
+
 
 ##################################################################################
 # PowerPC platform drivers
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
new file mode 100644
index 0000000..b5af4c8
--- /dev/null
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -0,0 +1,197 @@
+/*
+ * CPPC (Collaborative Processor Performance Control) driver for
+ * interfacing with the CPUfreq layer and governors. See
+ * cppc_acpi.c for CPPC specific methods.
+ *
+ * (C) Copyright 2014 Linaro Ltd.
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
+static struct cpudata **all_cpu_data;
+
+static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
+		unsigned int target_freq,
+		unsigned int relation)
+{
+	struct cpudata *cpu;
+	struct cpufreq_freqs freqs;
+	int ret;
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
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static unsigned int cppc_cpufreq_get_perf(unsigned int cpu_num)
+{
+	struct cpudata *cpu;
+	int32_t delivered_perf = 1;
+	int ret;
+
+	cpu = all_cpu_data[cpu_num];
+	if (!cpu)
+		return 0;
+
+	ret = cppc_get_perf_ctrs(cpu_num, &cpu->perf_fb_ctrs);
+
+	if (ret) {
+		pr_err("Err reading CPU%d, perf counters. ret:%d\n",
+				cpu->cpu, ret);
+		return -ENODEV;
+	}
+	delivered_perf = cpu->perf_caps.reference_perf *
+		cpu->perf_fb_ctrs.delivered;
+	delivered_perf /= cpu->perf_fb_ctrs.reference;
+	pr_debug("delivered_perf: %d\n", delivered_perf);
+	pr_debug("reference_perf: %d\n",
+			cpu->perf_caps.reference_perf);
+	pr_debug("delivered, reference deltas: %lld, %lld\n",
+			cpu->perf_fb_ctrs.delivered,
+			cpu->perf_fb_ctrs.reference);
+
+	return delivered_perf;
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
+	int ret;
+
+	cpu = all_cpu_data[policy->cpu];
+
+	cpu->cpu = policy->cpu;
+	ret = cppc_get_perf_caps(policy->cpu, &cpu->perf_caps);
+
+	if (ret) {
+		pr_err("Err reading CPU%d, perf capabilities. ret:%d\n",
+				cpu->cpu, ret);
+		return -ENODEV;
+	}
+
+	policy->min = cpu->perf_caps.lowest_perf;
+	policy->max = cpu->perf_caps.highest_perf;
+	/* cpuinfo and default policy values */
+	policy->cpuinfo.min_freq = cpu->perf_caps.lowest_perf;
+	policy->cpuinfo.max_freq = cpu->perf_caps.highest_perf;
+
+	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL ||
+	    policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
+		cpumask_copy(policy->cpus, cpu->shared_cpu_map);
+
+	cpumask_set_cpu(policy->cpu, policy->cpus);
+	cpu->cur_policy = policy;
+
+	pr_info("Initialized on cpu:%d\n", cpu->cpu);
+	return 0;
+}
+
+static struct cpufreq_driver cppc_cpufreq_driver = {
+	.flags = CPUFREQ_CONST_LOOPS,
+	.verify = cppc_verify_policy,
+	.target = cppc_cpufreq_set_target,
+	.get = cppc_cpufreq_get_perf,
+	.init = cppc_cpufreq_cpu_init,
+	.stop_cpu = cppc_cpufreq_stop_cpu,
+	.name = "cppc_cpufreq",
+};
+
+static int __init cppc_cpufreq_init(void)
+{
+	int i, rc = 0;
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
+		if (!zalloc_cpumask_var(&cpu->shared_cpu_map,
+					GFP_KERNEL)) {
+			pr_debug("No memory for shared_cpus cpumask\n");
+			goto out;
+		}
+	}
+
+	rc = acpi_get_psd_map(all_cpu_data);
+	if (rc) {
+		pr_err("Error parsing PSD data\n");
+		goto out;
+	}
+
+	rc = cpufreq_register_driver(&cppc_cpufreq_driver);
+	if (rc)
+		goto out;
+
+	pr_info("Registration completed\n");
+	return rc;
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

