From: Parth Shah <parth@linux.ibm.com>
Subject: [RFCv2 6/6] sched/fair: Bound non idle core search by DIE domain
Date: Wed, 15 May 2019 19:23:22 +0530
Message-ID: <20190515135322.19393-7-parth@linux.ibm.com>
References: <20190515135322.19393-1-parth@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515135322.19393-1-parth@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com, dsmythies@telus.net
List-Id: linux-pm@vger.kernel.org

This patch specifies the sched domain to search for a non idle core.

The select_non_idle_core searches for the non idle cores across whole
system. But in the systems with multiple NUMA domains, the Turbo frequency
can be sustained within the NUMA domain without being affected from other
NUMA.

This patch provides an architecture specific implementation for defining
the turbo domain to make searching of the core to be bound within the NUMA.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 arch/powerpc/include/asm/topology.h |  3 +++
 arch/powerpc/kernel/smp.c           |  5 +++++
 kernel/sched/fair.c                 | 10 +++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index 1c777ee67180..410b94c9e1a2 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -133,10 +133,13 @@ static inline void shared_proc_topology_init(void) {}
 #define topology_core_cpumask(cpu)	(per_cpu(cpu_core_map, cpu))
 #define topology_core_id(cpu)		(cpu_to_core_id(cpu))
 #define arch_scale_core_capacity	powerpc_scale_core_capacity
+#define arch_turbo_domain		powerpc_turbo_domain
 
 unsigned long powerpc_scale_core_capacity(int first_smt,
 					  unsigned long smt_cap);
 
+struct cpumask *powerpc_turbo_domain(int cpu);
+
 int dlpar_cpu_readd(int cpu);
 #endif
 #endif
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 256ab2a50f6e..e13ba3981891 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1203,6 +1203,11 @@ inline unsigned long powerpc_scale_core_capacity(int first_cpu,
 	/* Scale core capacity based on smt mode */
 	return smt_mode == 1 ? cap : ((cap * smt_mode) >> 3) + cap;
 }
+
+inline struct cpumask *powerpc_turbo_domain(int cpu)
+{
+	return cpumask_of_node(cpu_to_node(cpu));
+}
 #endif
 
 static inline void add_cpu_to_smallcore_masks(int cpu)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d2d556eb6d0f..bd9985775db4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6260,6 +6260,13 @@ static inline bool core_underutilized(unsigned long core_util,
 	return core_util < (core_capacity >> 3);
 }
 
+#ifndef arch_turbo_domain
+static __always_inline struct cpumask *arch_turbo_domain(int cpu)
+{
+	return sched_domain_span(rcu_dereference(per_cpu(sd_llc, cpu)));
+}
+#endif
+
 /*
  * Try to find a non idle core in the system  with spare capacity
  * available for task packing, thereby keeping minimal cores active.
@@ -6270,7 +6277,8 @@ static int select_non_idle_core(struct task_struct *p, int prev_cpu)
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(turbo_sched_mask);
 	int iter_cpu, sibling;
 
-	cpumask_and(cpus, cpu_online_mask, &p->cpus_allowed);
+	cpumask_and(cpus, cpu_online_mask, arch_turbo_domain(prev_cpu));
+	cpumask_and(cpus, cpus, &p->cpus_allowed);
 
 	for_each_cpu_wrap(iter_cpu, cpus, prev_cpu) {
 		unsigned long core_util = 0;
-- 
2.17.1
