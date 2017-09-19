From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 4/6] Topology: Add cluster on die macros and arm64 decoding
Date: Tue, 19 Sep 2017 13:47:49 -0500
Message-ID: <20170919184751.25110-5-jeremy.linton@arm.com>
References: <20170919184751.25110-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170919184751.25110-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@codeaurora.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jeremy Linton <jeremy.linton@arm.com>
List-Id: linux-pm@vger.kernel.org

Many modern machines have cluster on die (COD) non-uniformity
as well as the traditional multi-socket architectures. Reusing
the multi-socket or NUMA on die concepts for these (as arm64 does)
breaks down when presented with actual multi-socket/COD machines.
Similar, problems are also visible on some x86 machines so it
seems appropriate to start abstracting and making these topologies
visible.

To start, a topology_cod_id() macro is added which defaults to returning
the same information as topology_physical_package_id(). Moving forward
we can start to spit out the differences.

For arm64, an additional package_id is added to the cpu_topology array.
Initially this will be equal to the cluster_id as well.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/topology.h | 4 +++-
 arch/arm64/kernel/topology.c      | 8 ++++++--
 include/linux/topology.h          | 3 +++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 8b57339823e9..bd7517960d39 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -7,13 +7,15 @@ struct cpu_topology {
 	int thread_id;
 	int core_id;
 	int cluster_id;
+	int package_id;
 	cpumask_t thread_sibling;
 	cpumask_t core_sibling;
 };
 
 extern struct cpu_topology cpu_topology[NR_CPUS];
 
-#define topology_physical_package_id(cpu)	(cpu_topology[cpu].cluster_id)
+#define topology_physical_package_id(cpu)	(cpu_topology[cpu].package_id)
+#define topology_cod_id(cpu)		(cpu_topology[cpu].cluster_id)
 #define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
 #define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
 #define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 8d48b233e6ce..9147e5b6326d 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -67,6 +67,8 @@ static int __init parse_core(struct device_node *core, int cluster_id,
 			leaf = false;
 			cpu = get_cpu_for_node(t);
 			if (cpu >= 0) {
+				/* maintain DT cluster == package behavior */
+				cpu_topology[cpu].package_id = cluster_id;
 				cpu_topology[cpu].cluster_id = cluster_id;
 				cpu_topology[cpu].core_id = core_id;
 				cpu_topology[cpu].thread_id = i;
@@ -88,7 +90,7 @@ static int __init parse_core(struct device_node *core, int cluster_id,
 			       core);
 			return -EINVAL;
 		}
-
+		cpu_topology[cpu].package_id = cluster_id;
 		cpu_topology[cpu].cluster_id = cluster_id;
 		cpu_topology[cpu].core_id = core_id;
 	} else if (leaf) {
@@ -228,7 +230,7 @@ static void update_siblings_masks(unsigned int cpuid)
 	for_each_possible_cpu(cpu) {
 		cpu_topo = &cpu_topology[cpu];
 
-		if (cpuid_topo->cluster_id != cpu_topo->cluster_id)
+		if (cpuid_topo->package_id != cpu_topo->package_id)
 			continue;
 
 		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
@@ -273,6 +275,7 @@ void store_cpu_topology(unsigned int cpuid)
 					 MPIDR_AFFINITY_LEVEL(mpidr, 2) << 8 |
 					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 16;
 	}
+	cpuid_topo->package_id = cpuid_topo->cluster_id;
 
 	pr_debug("CPU%u: cluster %d core %d thread %d mpidr %#016llx\n",
 		 cpuid, cpuid_topo->cluster_id, cpuid_topo->core_id,
@@ -292,6 +295,7 @@ static void __init reset_cpu_topology(void)
 		cpu_topo->thread_id = -1;
 		cpu_topo->core_id = 0;
 		cpu_topo->cluster_id = -1;
+		cpu_topo->package_id = -1;
 
 		cpumask_clear(&cpu_topo->core_sibling);
 		cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
diff --git a/include/linux/topology.h b/include/linux/topology.h
index cb0775e1ee4b..4660749a7303 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -184,6 +184,9 @@ static inline int cpu_to_mem(int cpu)
 #ifndef topology_physical_package_id
 #define topology_physical_package_id(cpu)	((void)(cpu), -1)
 #endif
+#ifndef topology_cod_id				/* cluster on die */
+#define topology_cod_id(cpu)			topology_physical_package_id(cpu)
+#endif
 #ifndef topology_core_id
 #define topology_core_id(cpu)			((void)(cpu), 0)
 #endif
-- 
2.13.5
