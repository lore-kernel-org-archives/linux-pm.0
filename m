From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 6/9] arm, arm64: factorize common cpu capacity default code
Date: Thu,  9 Feb 2017 09:25:22 +0000
Message-ID: <20170209092525.6654-7-juri.lelli@arm.com>
References: <20170209092525.6654-1-juri.lelli@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170209092525.6654-1-juri.lelli-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, juri.lelli-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

arm and arm64 share lot of code relative to parsing CPU capacity
information from DT, using that information for appropriate scaling and
exposing a sysfs interface for chaging such values at runtime.

Factorize such code in a common place (driver/base/arch_topology.c) in
preparation for further additions.

Suggested-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Suggested-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Suggested-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Signed-off-by: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
---

Changes from v1:
 - keep the original GPLv2 header
---
 arch/arm/Kconfig             |   1 +
 arch/arm/kernel/topology.c   | 213 ++------------------------------------
 arch/arm64/Kconfig           |   1 +
 arch/arm64/kernel/topology.c | 219 +--------------------------------------
 drivers/base/Kconfig         |   8 ++
 drivers/base/Makefile        |   1 +
 drivers/base/arch_topology.c | 237 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 257 insertions(+), 423 deletions(-)
 create mode 100644 drivers/base/arch_topology.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 186c4c214e0a..6dd5736c1e3c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -19,6 +19,7 @@ config ARM
 	select EDAC_SUPPORT
 	select EDAC_ATOMIC_SCRUB
 	select GENERIC_ALLOCATOR
+	select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
 	select GENERIC_ATOMIC64 if (CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI)
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_EARLY_IOREMAP
diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index c760a321935b..51e9ed6439f1 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -43,75 +43,10 @@
  * to run the rebalance_domains for all idle cores and the cpu_capacity can be
  * updated during this sequence.
  */
-static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
-static DEFINE_MUTEX(cpu_scale_mutex);
 
-unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
-{
-	return per_cpu(cpu_scale, cpu);
-}
-
-static void set_capacity_scale(unsigned int cpu, unsigned long capacity)
-{
-	per_cpu(cpu_scale, cpu) = capacity;
-}
-
-static ssize_t cpu_capacity_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct cpu *cpu = container_of(dev, struct cpu, dev);
-
-	return sprintf(buf, "%lu\n",
-			arch_scale_cpu_capacity(NULL, cpu->dev.id));
-}
-
-static ssize_t cpu_capacity_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf,
-				  size_t count)
-{
-	struct cpu *cpu = container_of(dev, struct cpu, dev);
-	int this_cpu = cpu->dev.id, i;
-	unsigned long new_capacity;
-	ssize_t ret;
-
-	if (count) {
-		ret = kstrtoul(buf, 0, &new_capacity);
-		if (ret)
-			return ret;
-		if (new_capacity > SCHED_CAPACITY_SCALE)
-			return -EINVAL;
-
-		mutex_lock(&cpu_scale_mutex);
-		for_each_cpu(i, &cpu_topology[this_cpu].core_sibling)
-			set_capacity_scale(i, new_capacity);
-		mutex_unlock(&cpu_scale_mutex);
-	}
-
-	return count;
-}
-
-static DEVICE_ATTR_RW(cpu_capacity);
-
-static int register_cpu_capacity_sysctl(void)
-{
-	int i;
-	struct device *cpu;
-
-	for_each_possible_cpu(i) {
-		cpu = get_cpu_device(i);
-		if (!cpu) {
-			pr_err("%s: too early to get CPU%d device!\n",
-			       __func__, i);
-			continue;
-		}
-		device_create_file(cpu, &dev_attr_cpu_capacity);
-	}
-
-	return 0;
-}
-subsys_initcall(register_cpu_capacity_sysctl);
+extern unsigned long
+arch_scale_cpu_capacity(struct sched_domain *sd, int cpu);
+extern void set_capacity_scale(unsigned int cpu, unsigned long capacity);
 
 #ifdef CONFIG_OF
 struct cpu_efficiency {
@@ -140,145 +75,9 @@ static unsigned long *__cpu_capacity;
 
 static unsigned long middle_capacity = 1;
 static bool cap_from_dt = true;
-static u32 *raw_capacity;
-static bool cap_parsing_failed;
-static u32 capacity_scale;
-
-static int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
-{
-	int ret = 1;
-	u32 cpu_capacity;
-
-	if (cap_parsing_failed)
-		return !ret;
-
-	ret = of_property_read_u32(cpu_node,
-				   "capacity-dmips-mhz",
-				   &cpu_capacity);
-	if (!ret) {
-		if (!raw_capacity) {
-			raw_capacity = kcalloc(num_possible_cpus(),
-					       sizeof(*raw_capacity),
-					       GFP_KERNEL);
-			if (!raw_capacity) {
-				pr_err("cpu_capacity: failed to allocate memory for raw capacities\n");
-				cap_parsing_failed = true;
-				return ret;
-			}
-		}
-		capacity_scale = max(cpu_capacity, capacity_scale);
-		raw_capacity[cpu] = cpu_capacity;
-		pr_debug("cpu_capacity: %s cpu_capacity=%u (raw)\n",
-			cpu_node->full_name, raw_capacity[cpu]);
-	} else {
-		if (raw_capacity) {
-			pr_err("cpu_capacity: missing %s raw capacity\n",
-				cpu_node->full_name);
-			pr_err("cpu_capacity: partial information: fallback to 1024 for all CPUs\n");
-		}
-		cap_parsing_failed = true;
-		kfree(raw_capacity);
-	}
-
-	return !ret;
-}
-
-static void normalize_cpu_capacity(void)
-{
-	u64 capacity;
-	int cpu;
-
-	if (!raw_capacity || cap_parsing_failed)
-		return;
-
-	pr_debug("cpu_capacity: capacity_scale=%u\n", capacity_scale);
-	mutex_lock(&cpu_scale_mutex);
-	for_each_possible_cpu(cpu) {
-		capacity = (raw_capacity[cpu] << SCHED_CAPACITY_SHIFT)
-			/ capacity_scale;
-		set_capacity_scale(cpu, capacity);
-		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
-			cpu, arch_scale_cpu_capacity(NULL, cpu));
-	}
-	mutex_unlock(&cpu_scale_mutex);
-}
-
-#ifdef CONFIG_CPU_FREQ
-static cpumask_var_t cpus_to_visit;
-static bool cap_parsing_done;
-static void parsing_done_workfn(struct work_struct *work);
-static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
-
-static int
-init_cpu_capacity_callback(struct notifier_block *nb,
-			   unsigned long val,
-			   void *data)
-{
-	struct cpufreq_policy *policy = data;
-	int cpu;
-
-	if (cap_parsing_failed || cap_parsing_done)
-		return 0;
-
-	switch (val) {
-	case CPUFREQ_NOTIFY:
-		pr_debug("cpu_capacity: init cpu capacity for CPUs [%*pbl] (to_visit=%*pbl)\n",
-				cpumask_pr_args(policy->related_cpus),
-				cpumask_pr_args(cpus_to_visit));
-		cpumask_andnot(cpus_to_visit,
-			       cpus_to_visit,
-			       policy->related_cpus);
-		for_each_cpu(cpu, policy->related_cpus) {
-			raw_capacity[cpu] = arch_scale_cpu_capacity(NULL, cpu) *
-					    policy->cpuinfo.max_freq / 1000UL;
-			capacity_scale = max(raw_capacity[cpu], capacity_scale);
-		}
-		if (cpumask_empty(cpus_to_visit)) {
-			normalize_cpu_capacity();
-			kfree(raw_capacity);
-			pr_debug("cpu_capacity: parsing done\n");
-			cap_parsing_done = true;
-			schedule_work(&parsing_done_work);
-		}
-	}
-	return 0;
-}
-
-static struct notifier_block init_cpu_capacity_notifier = {
-	.notifier_call = init_cpu_capacity_callback,
-};
-
-static int __init register_cpufreq_notifier(void)
-{
-	if (cap_parsing_failed)
-		return -EINVAL;
-
-	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
-		pr_err("cpu_capacity: failed to allocate memory for cpus_to_visit\n");
-		return -ENOMEM;
-	}
-	cpumask_copy(cpus_to_visit, cpu_possible_mask);
-
-	return cpufreq_register_notifier(&init_cpu_capacity_notifier,
-					 CPUFREQ_POLICY_NOTIFIER);
-}
-core_initcall(register_cpufreq_notifier);
-
-static void parsing_done_workfn(struct work_struct *work)
-{
-	cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
-					 CPUFREQ_POLICY_NOTIFIER);
-}
-
-#else
-static int __init free_raw_capacity(void)
-{
-	kfree(raw_capacity);
-
-	return 0;
-}
-core_initcall(free_raw_capacity);
-#endif
+extern bool cap_parsing_failed;
+extern void normalize_cpu_capacity(void);
+extern int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
 /*
  * Iterate all CPUs' descriptor in DT and compute the efficiency
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 111742126897..7534bb41ee09 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -36,6 +36,7 @@ config ARM64
 	select EDAC_SUPPORT
 	select FRAME_POINTER
 	select GENERIC_ALLOCATOR
+	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_CPU_AUTOPROBE
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 565dd69888cc..f629f7524d65 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -11,7 +11,6 @@
  * for more details.
  */
 
-#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/init.h>
@@ -22,226 +21,14 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/cpufreq.h>
 
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/topology.h>
 
-static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
-static DEFINE_MUTEX(cpu_scale_mutex);
-
-unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
-{
-	return per_cpu(cpu_scale, cpu);
-}
-
-static void set_capacity_scale(unsigned int cpu, unsigned long capacity)
-{
-	per_cpu(cpu_scale, cpu) = capacity;
-}
-
-static ssize_t cpu_capacity_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct cpu *cpu = container_of(dev, struct cpu, dev);
-
-	return sprintf(buf, "%lu\n",
-			arch_scale_cpu_capacity(NULL, cpu->dev.id));
-}
-
-static ssize_t cpu_capacity_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf,
-				  size_t count)
-{
-	struct cpu *cpu = container_of(dev, struct cpu, dev);
-	int this_cpu = cpu->dev.id, i;
-	unsigned long new_capacity;
-	ssize_t ret;
-
-	if (count) {
-		ret = kstrtoul(buf, 0, &new_capacity);
-		if (ret)
-			return ret;
-		if (new_capacity > SCHED_CAPACITY_SCALE)
-			return -EINVAL;
-
-		mutex_lock(&cpu_scale_mutex);
-		for_each_cpu(i, &cpu_topology[this_cpu].core_sibling)
-			set_capacity_scale(i, new_capacity);
-		mutex_unlock(&cpu_scale_mutex);
-	}
-
-	return count;
-}
-
-static DEVICE_ATTR_RW(cpu_capacity);
-
-static int register_cpu_capacity_sysctl(void)
-{
-	int i;
-	struct device *cpu;
-
-	for_each_possible_cpu(i) {
-		cpu = get_cpu_device(i);
-		if (!cpu) {
-			pr_err("%s: too early to get CPU%d device!\n",
-			       __func__, i);
-			continue;
-		}
-		device_create_file(cpu, &dev_attr_cpu_capacity);
-	}
-
-	return 0;
-}
-subsys_initcall(register_cpu_capacity_sysctl);
-
-static u32 capacity_scale;
-static u32 *raw_capacity;
-static bool cap_parsing_failed;
-
-static void __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
-{
-	int ret;
-	u32 cpu_capacity;
-
-	if (cap_parsing_failed)
-		return;
-
-	ret = of_property_read_u32(cpu_node,
-				   "capacity-dmips-mhz",
-				   &cpu_capacity);
-	if (!ret) {
-		if (!raw_capacity) {
-			raw_capacity = kcalloc(num_possible_cpus(),
-					       sizeof(*raw_capacity),
-					       GFP_KERNEL);
-			if (!raw_capacity) {
-				pr_err("cpu_capacity: failed to allocate memory for raw capacities\n");
-				cap_parsing_failed = true;
-				return;
-			}
-		}
-		capacity_scale = max(cpu_capacity, capacity_scale);
-		raw_capacity[cpu] = cpu_capacity;
-		pr_debug("cpu_capacity: %s cpu_capacity=%u (raw)\n",
-			cpu_node->full_name, raw_capacity[cpu]);
-	} else {
-		if (raw_capacity) {
-			pr_err("cpu_capacity: missing %s raw capacity\n",
-				cpu_node->full_name);
-			pr_err("cpu_capacity: partial information: fallback to 1024 for all CPUs\n");
-		}
-		cap_parsing_failed = true;
-		kfree(raw_capacity);
-	}
-}
-
-static void normalize_cpu_capacity(void)
-{
-	u64 capacity;
-	int cpu;
-
-	if (!raw_capacity || cap_parsing_failed)
-		return;
-
-	pr_debug("cpu_capacity: capacity_scale=%u\n", capacity_scale);
-	mutex_lock(&cpu_scale_mutex);
-	for_each_possible_cpu(cpu) {
-		pr_debug("cpu_capacity: cpu=%d raw_capacity=%u\n",
-			 cpu, raw_capacity[cpu]);
-		capacity = (raw_capacity[cpu] << SCHED_CAPACITY_SHIFT)
-			/ capacity_scale;
-		set_capacity_scale(cpu, capacity);
-		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
-			cpu, arch_scale_cpu_capacity(NULL, cpu));
-	}
-	mutex_unlock(&cpu_scale_mutex);
-}
-
-#ifdef CONFIG_CPU_FREQ
-static cpumask_var_t cpus_to_visit;
-static bool cap_parsing_done;
-static void parsing_done_workfn(struct work_struct *work);
-static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
-
-static int
-init_cpu_capacity_callback(struct notifier_block *nb,
-			   unsigned long val,
-			   void *data)
-{
-	struct cpufreq_policy *policy = data;
-	int cpu;
-
-	if (cap_parsing_failed || cap_parsing_done)
-		return 0;
-
-	switch (val) {
-	case CPUFREQ_NOTIFY:
-		pr_debug("cpu_capacity: init cpu capacity for CPUs [%*pbl] (to_visit=%*pbl)\n",
-				cpumask_pr_args(policy->related_cpus),
-				cpumask_pr_args(cpus_to_visit));
-		cpumask_andnot(cpus_to_visit,
-			       cpus_to_visit,
-			       policy->related_cpus);
-		for_each_cpu(cpu, policy->related_cpus) {
-			raw_capacity[cpu] = arch_scale_cpu_capacity(NULL, cpu) *
-					    policy->cpuinfo.max_freq / 1000UL;
-			capacity_scale = max(raw_capacity[cpu], capacity_scale);
-		}
-		if (cpumask_empty(cpus_to_visit)) {
-			normalize_cpu_capacity();
-			kfree(raw_capacity);
-			pr_debug("cpu_capacity: parsing done\n");
-			cap_parsing_done = true;
-			schedule_work(&parsing_done_work);
-		}
-	}
-	return 0;
-}
-
-static struct notifier_block init_cpu_capacity_notifier = {
-	.notifier_call = init_cpu_capacity_callback,
-};
-
-static int __init register_cpufreq_notifier(void)
-{
-	/*
-	 * on ACPI-based systems we need to use the default cpu capacity
-	 * until we have the necessary code to parse the cpu capacity, so
-	 * skip registering cpufreq notifier.
-	 */
-	if (!acpi_disabled || cap_parsing_failed)
-		return -EINVAL;
-
-	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
-		pr_err("cpu_capacity: failed to allocate memory for cpus_to_visit\n");
-		return -ENOMEM;
-	}
-	cpumask_copy(cpus_to_visit, cpu_possible_mask);
-
-	return cpufreq_register_notifier(&init_cpu_capacity_notifier,
-					 CPUFREQ_POLICY_NOTIFIER);
-}
-core_initcall(register_cpufreq_notifier);
-
-static void parsing_done_workfn(struct work_struct *work)
-{
-	cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
-					 CPUFREQ_POLICY_NOTIFIER);
-}
-
-#else
-static int __init free_raw_capacity(void)
-{
-	kfree(raw_capacity);
-
-	return 0;
-}
-core_initcall(free_raw_capacity);
-#endif
+extern bool cap_parsing_failed;
+extern void normalize_cpu_capacity(void);
+extern int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu);
 
 static int __init get_cpu_for_node(struct device_node *node)
 {
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index d718ae4b907a..307ea31187dd 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -339,4 +339,12 @@ config CMA_ALIGNMENT
 
 endif
 
+config GENERIC_ARCH_TOPOLOGY
+	bool
+	help
+	  Enable support for architectures common topology code: e.g., parsing
+	  CPU capacity information from DT, usage of such information for
+	  appropriate scaling, sysfs interface for changing capacity values at
+          runtime.
+
 endmenu
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index f2816f6ff76a..397e5c344e6a 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_SOC_BUS) += soc.o
 obj-$(CONFIG_PINCTRL) += pinctrl.o
 obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
 obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
+obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
 
 obj-y			+= test/
 
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
new file mode 100644
index 000000000000..c1dd430adad2
--- /dev/null
+++ b/drivers/base/arch_topology.c
@@ -0,0 +1,237 @@
+/*
+ * driver/base/arch_topology.c - Arch specific cpu topology information
+ *
+ * Copyright (C) 2016, ARM Ltd.
+ * Written by: Juri Lelli, ARM Ltd.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/acpi.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/topology.h>
+
+static DEFINE_MUTEX(cpu_scale_mutex);
+static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
+
+unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
+{
+	return per_cpu(cpu_scale, cpu);
+}
+
+void set_capacity_scale(unsigned int cpu, unsigned long capacity)
+{
+	per_cpu(cpu_scale, cpu) = capacity;
+}
+
+static ssize_t cpu_capacity_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, dev);
+
+	return sprintf(buf, "%lu\n",
+			arch_scale_cpu_capacity(NULL, cpu->dev.id));
+}
+
+static ssize_t cpu_capacity_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t count)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, dev);
+	int this_cpu = cpu->dev.id, i;
+	unsigned long new_capacity;
+	ssize_t ret;
+
+	if (count) {
+		ret = kstrtoul(buf, 0, &new_capacity);
+		if (ret)
+			return ret;
+		if (new_capacity > SCHED_CAPACITY_SCALE)
+			return -EINVAL;
+
+		mutex_lock(&cpu_scale_mutex);
+		for_each_cpu(i, &cpu_topology[this_cpu].core_sibling)
+			set_capacity_scale(i, new_capacity);
+		mutex_unlock(&cpu_scale_mutex);
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(cpu_capacity);
+
+static int register_cpu_capacity_sysctl(void)
+{
+	int i;
+	struct device *cpu;
+
+	for_each_possible_cpu(i) {
+		cpu = get_cpu_device(i);
+		if (!cpu) {
+			pr_err("%s: too early to get CPU%d device!\n",
+			       __func__, i);
+			continue;
+		}
+		device_create_file(cpu, &dev_attr_cpu_capacity);
+	}
+
+	return 0;
+}
+subsys_initcall(register_cpu_capacity_sysctl);
+
+u32 capacity_scale;
+u32 *raw_capacity;
+bool cap_parsing_failed;
+
+void normalize_cpu_capacity(void)
+{
+	u64 capacity;
+	int cpu;
+
+	if (!raw_capacity || cap_parsing_failed)
+		return;
+
+	pr_debug("cpu_capacity: capacity_scale=%u\n", capacity_scale);
+	mutex_lock(&cpu_scale_mutex);
+	for_each_possible_cpu(cpu) {
+		pr_debug("cpu_capacity: cpu=%d raw_capacity=%u\n",
+			 cpu, raw_capacity[cpu]);
+		capacity = (raw_capacity[cpu] << SCHED_CAPACITY_SHIFT)
+			/ capacity_scale;
+		set_capacity_scale(cpu, capacity);
+		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
+			cpu, arch_scale_cpu_capacity(NULL, cpu));
+	}
+	mutex_unlock(&cpu_scale_mutex);
+}
+
+int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
+{
+	int ret = 1;
+	u32 cpu_capacity;
+
+	if (cap_parsing_failed)
+		return !ret;
+
+	ret = of_property_read_u32(cpu_node,
+				   "capacity-dmips-mhz",
+				   &cpu_capacity);
+	if (!ret) {
+		if (!raw_capacity) {
+			raw_capacity = kcalloc(num_possible_cpus(),
+					       sizeof(*raw_capacity),
+					       GFP_KERNEL);
+			if (!raw_capacity) {
+				pr_err("cpu_capacity: failed to allocate memory for raw capacities\n");
+				cap_parsing_failed = true;
+				return ret;
+			}
+		}
+		capacity_scale = max(cpu_capacity, capacity_scale);
+		raw_capacity[cpu] = cpu_capacity;
+		pr_debug("cpu_capacity: %s cpu_capacity=%u (raw)\n",
+			cpu_node->full_name, raw_capacity[cpu]);
+	} else {
+		if (raw_capacity) {
+			pr_err("cpu_capacity: missing %s raw capacity\n",
+				cpu_node->full_name);
+			pr_err("cpu_capacity: partial information: fallback to 1024 for all CPUs\n");
+		}
+		cap_parsing_failed = true;
+		kfree(raw_capacity);
+	}
+
+	return !ret;
+}
+
+#ifdef CONFIG_CPU_FREQ
+static cpumask_var_t cpus_to_visit;
+static bool cap_parsing_done;
+static void parsing_done_workfn(struct work_struct *work);
+static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
+
+static int
+init_cpu_capacity_callback(struct notifier_block *nb,
+			   unsigned long val,
+			   void *data)
+{
+	struct cpufreq_policy *policy = data;
+	int cpu;
+
+	if (cap_parsing_failed || cap_parsing_done)
+		return 0;
+
+	switch (val) {
+	case CPUFREQ_NOTIFY:
+		pr_debug("cpu_capacity: init cpu capacity for CPUs [%*pbl] (to_visit=%*pbl)\n",
+				cpumask_pr_args(policy->related_cpus),
+				cpumask_pr_args(cpus_to_visit));
+		cpumask_andnot(cpus_to_visit,
+			       cpus_to_visit,
+			       policy->related_cpus);
+		for_each_cpu(cpu, policy->related_cpus) {
+			raw_capacity[cpu] = arch_scale_cpu_capacity(NULL, cpu) *
+					    policy->cpuinfo.max_freq / 1000UL;
+			capacity_scale = max(raw_capacity[cpu], capacity_scale);
+		}
+		if (cpumask_empty(cpus_to_visit)) {
+			normalize_cpu_capacity();
+			kfree(raw_capacity);
+			pr_debug("cpu_capacity: parsing done\n");
+			cap_parsing_done = true;
+			schedule_work(&parsing_done_work);
+		}
+	}
+	return 0;
+}
+
+static struct notifier_block init_cpu_capacity_notifier = {
+	.notifier_call = init_cpu_capacity_callback,
+};
+
+static int __init register_cpufreq_notifier(void)
+{
+	/*
+	 * on ACPI-based systems we need to use the default cpu capacity
+	 * until we have the necessary code to parse the cpu capacity, so
+	 * skip registering cpufreq notifier.
+	 */
+	if (!acpi_disabled || cap_parsing_failed)
+		return -EINVAL;
+
+	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
+		pr_err("cpu_capacity: failed to allocate memory for cpus_to_visit\n");
+		return -ENOMEM;
+	}
+
+	cpumask_copy(cpus_to_visit, cpu_possible_mask);
+
+	return cpufreq_register_notifier(&init_cpu_capacity_notifier,
+					 CPUFREQ_POLICY_NOTIFIER);
+}
+core_initcall(register_cpufreq_notifier);
+
+static void parsing_done_workfn(struct work_struct *work)
+{
+	cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
+					 CPUFREQ_POLICY_NOTIFIER);
+}
+
+#else
+static int __init free_raw_capacity(void)
+{
+	kfree(raw_capacity);
+
+	return 0;
+}
+core_initcall(free_raw_capacity);
+#endif
-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
