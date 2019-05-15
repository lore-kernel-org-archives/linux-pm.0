From: Parth Shah <parth@linux.ibm.com>
Subject: [RFCv2 4/6] sched/fair: Define core capacity to limit task packing
Date: Wed, 15 May 2019 19:23:20 +0530
Message-ID: <20190515135322.19393-5-parth@linux.ibm.com>
References: <20190515135322.19393-1-parth@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515135322.19393-1-parth@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com, dsmythies@telus.net
List-Id: linux-pm@vger.kernel.org

The task packing on a core needs to be bounded based on its capacity. This
patch defines a new method which acts as a tipping point for task packing.

The Core capacity is the method which limits task packing above certain
point. In general, the capacity of a core is defined to be the aggregated
sum of all the CPUs in the Core.

Some architectures does not have core capacity linearly increasing with the
number of threads( or CPUs) in the core. For such cases, architecture
specific calculations needs to be done to find core capacity.

The `arch_scale_core_capacity` is currently tuned for `powerpc` arch by
scaling capacity w.r.t to the number of online SMT in the core.

The patch provides default handler for other architecture by scaling core
capacity w.r.t. to the capacity of all the threads in the core.

ToDo: SMT mode is calculated each time a jitter task wakes up leading to
redundant decision time which can be eliminated by keeping track of online
CPUs during hotplug task.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 arch/powerpc/include/asm/topology.h |  4 ++++
 arch/powerpc/kernel/smp.c           | 32 +++++++++++++++++++++++++++++
 kernel/sched/fair.c                 | 19 +++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index f85e2b01c3df..1c777ee67180 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -132,6 +132,10 @@ static inline void shared_proc_topology_init(void) {}
 #define topology_sibling_cpumask(cpu)	(per_cpu(cpu_sibling_map, cpu))
 #define topology_core_cpumask(cpu)	(per_cpu(cpu_core_map, cpu))
 #define topology_core_id(cpu)		(cpu_to_core_id(cpu))
+#define arch_scale_core_capacity	powerpc_scale_core_capacity
+
+unsigned long powerpc_scale_core_capacity(int first_smt,
+					  unsigned long smt_cap);
 
 int dlpar_cpu_readd(int cpu);
 #endif
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e784342bdaa1..256ab2a50f6e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1173,6 +1173,38 @@ static void remove_cpu_from_masks(int cpu)
 }
 #endif
 
+#ifdef CONFIG_SCHED_SMT
+/*
+ * Calculate capacity of a core based on the active threads in the core
+ * Scale the capacity of first SM-thread based on total number of
+ * active threads in the respective smt_mask.
+ *
+ * The scaling is done such that for
+ * SMT-4, core_capacity = 1.5x first_cpu_capacity
+ * and for SMT-8, core_capacity multiplication factor is 2x
+ *
+ * So, core_capacity multiplication factor = (1 + smt_mode*0.125)
+ *
+ * @first_cpu: First/any CPU id in the core
+ * @cap: Capacity of the first_cpu
+ */
+inline unsigned long powerpc_scale_core_capacity(int first_cpu,
+		unsigned long cap) {
+	struct cpumask select_idles;
+	struct cpumask *cpus = &select_idles;
+	int cpu, smt_mode = 0;
+
+	cpumask_and(cpus, cpu_smt_mask(first_cpu), cpu_online_mask);
+
+	/* Find SMT mode from active SM-threads */
+	for_each_cpu(cpu, cpus)
+		smt_mode++;
+
+	/* Scale core capacity based on smt mode */
+	return smt_mode == 1 ? cap : ((cap * smt_mode) >> 3) + cap;
+}
+#endif
+
 static inline void add_cpu_to_smallcore_masks(int cpu)
 {
 	struct cpumask *this_l1_cache_map = per_cpu(cpu_l1_cache_map, cpu);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b7eea9dc4644..2578e6bdf85b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6231,6 +6231,25 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	return cpu;
 }
 
+#ifdef CONFIG_SCHED_SMT
+
+#ifndef arch_scale_core_capacity
+static inline unsigned long arch_scale_core_capacity(int first_thread,
+						     unsigned long smt_cap)
+{
+	/* Default capacity of core is sum of cap of all the threads */
+	unsigned long ret = 0;
+	int sibling;
+
+	for_each_cpu(sibling, cpu_smt_mask(first_thread))
+		ret += cpu_rq(sibling)->cpu_capacity;
+
+	return ret;
+}
+#endif
+
+#endif
+
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
-- 
2.17.1
