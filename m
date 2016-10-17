From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH v7 REPOST 2/9] arm: parse cpu capacity-dmips-mhz from DT
Date: Mon, 17 Oct 2016 16:46:43 +0100
Message-ID: <20161017154650.18779-3-juri.lelli@arm.com>
References: <20161017154650.18779-1-juri.lelli@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36754 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935265AbcJQPrt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Oct 2016 11:47:49 -0400
In-Reply-To: <20161017154650.18779-1-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com, broonie@kernel.org

With the introduction of cpu capacity-dmips-mhz bindings, CPU capacities
can now be calculated from values extracted from DT and information
coming from cpufreq. Add parsing of DT information at boot time, and
complement it with cpufreq information. We keep code that can produce
same information, based on different DT properties and hard-coded
values, as fall-back for backward compatibility.

Caveat: the information provided by this patch will start to be used in
the future. We need to #define arch_scale_cpu_capacity to something
provided in arch, so that scheduler's default implementation (which gets
used if arch_scale_cpu_capacity is not defined) is overwritten.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---

Changes from v1:
  - normalize w.r.t. highest capacity found in DT
  - bailout conditions (all-or-nothing)

Changes from v4:
  - parsing modified to reflect change in binding (capacity-dmips-mhz)

Changes from v5:
  - allocate raw_capacity array with kcalloc()
  - pr_err() only for partial capacity information

Changes from v6:
  - use cpuinfo.max_freq instead of policy->max
  - add delayed work to unregister cpufreq notifier
---
 arch/arm/kernel/topology.c | 156 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ec279d161b32..18bb0474f7ec 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/cpufreq.h>
 
 #include <asm/cputype.h>
 #include <asm/topology.h>
@@ -78,6 +79,144 @@ static unsigned long *__cpu_capacity;
 #define cpu_capacity(cpu)	__cpu_capacity[cpu]
 
 static unsigned long middle_capacity = 1;
+static bool cap_from_dt = true;
+static u32 *raw_capacity;
+static bool cap_parsing_failed;
+static u32 capacity_scale;
+
+static int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
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
+				return !ret;
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
+static void normalize_cpu_capacity(void)
+{
+	u64 capacity;
+	int cpu;
+
+	if (!raw_capacity || cap_parsing_failed)
+		return;
+
+	pr_debug("cpu_capacity: capacity_scale=%u\n", capacity_scale);
+	for_each_possible_cpu(cpu) {
+		capacity = (raw_capacity[cpu] << SCHED_CAPACITY_SHIFT)
+			/ capacity_scale;
+		set_capacity_scale(cpu, capacity);
+		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
+			cpu, arch_scale_cpu_capacity(NULL, cpu));
+	}
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
+	if (cap_parsing_failed)
+		return -EINVAL;
+
+	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
+		pr_err("cpu_capacity: failed to allocate memory for cpus_to_visit\n");
+		return -ENOMEM;
+	}
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
 
 /*
  * Iterate all CPUs' descriptor in DT and compute the efficiency
@@ -99,6 +238,12 @@ static void __init parse_dt_topology(void)
 	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
 				 GFP_NOWAIT);
 
+	cn = of_find_node_by_path("/cpus");
+	if (!cn) {
+		pr_err("No CPU information found in DT\n");
+		return;
+	}
+
 	for_each_possible_cpu(cpu) {
 		const u32 *rate;
 		int len;
@@ -110,6 +255,13 @@ static void __init parse_dt_topology(void)
 			continue;
 		}
 
+		if (parse_cpu_capacity(cn, cpu)) {
+			of_node_put(cn);
+			continue;
+		}
+
+		cap_from_dt = false;
+
 		for (cpu_eff = table_efficiency; cpu_eff->compatible; cpu_eff++)
 			if (of_device_is_compatible(cn, cpu_eff->compatible))
 				break;
@@ -151,6 +303,8 @@ static void __init parse_dt_topology(void)
 		middle_capacity = ((max_capacity / 3)
 				>> (SCHED_CAPACITY_SHIFT-1)) + 1;
 
+	if (cap_from_dt && !cap_parsing_failed)
+		normalize_cpu_capacity();
 }
 
 /*
@@ -160,7 +314,7 @@ static void __init parse_dt_topology(void)
  */
 static void update_cpu_capacity(unsigned int cpu)
 {
-	if (!cpu_capacity(cpu))
+	if (!cpu_capacity(cpu) || cap_from_dt)
 		return;
 
 	set_capacity_scale(cpu, cpu_capacity(cpu) / middle_capacity);
-- 
2.10.0

