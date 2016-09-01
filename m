From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/8] sched, x86: Add SD_ASYM_PACKING flags to x86 cpu topology for ITMT
Date: Thu,  1 Sep 2016 13:33:37 -0700
Message-ID: <1472762024-88771-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, peterz@infradead.org
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

We uses ASYM_PACKING feature in the scheduler to move tasks to more
capable cpus that can be boosted to higher frequency. This is enabled by
Intel Turbo Boost Max Technology 3.0 (ITMT).  We mark the sched domain
topology level with SD_ASYM_PACKING flag for such systems to indicate
scheduler can use the ASYM_PACKING feature to move load to the
more capable cpus.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/include/asm/topology.h |  4 +++
 arch/x86/kernel/smpboot.c       | 77 +++++++++++++++++++++++++++++++----------
 kernel/sched/core.c             |  3 ++
 3 files changed, 66 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index cf75871..98b669d 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -146,4 +146,8 @@ struct pci_bus;
 int x86_pci_root_bus_node(int bus);
 void x86_pci_root_bus_resources(int bus, struct list_head *resources);
 
+#ifdef CONFIG_SCHED_ITMT
+extern unsigned int __read_mostly sysctl_sched_itmt_enabled;
+#endif /* CONFIG_SCHED_ITMT */
+
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 4296beb..3782bd4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -109,6 +109,8 @@ static bool logical_packages_frozen __read_mostly;
 /* Maximum number of SMT threads on any online core */
 int __max_smt_threads __read_mostly;
 
+unsigned int __read_mostly sysctl_sched_itmt_enabled;
+
 static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
 {
 	unsigned long flags;
@@ -471,31 +473,57 @@ static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	return false;
 }
 
-static struct sched_domain_topology_level numa_inside_package_topology[] = {
+#ifdef CONFIG_SCHED_ITMT
+static int x86_core_flags(void)
+{
+	int flags = cpu_core_flags();
+
+	if (sysctl_sched_itmt_enabled)
+		flags |= SD_ASYM_PACKING;
+
+	return flags;
+}
+
+static int x86_smt_flags(void)
+{
+	int flags = cpu_smt_flags();
+
+	if (sysctl_sched_itmt_enabled)
+		flags |= SD_ASYM_PACKING;
+
+	return flags;
+}
+#else
+#define x86_core_flags cpu_core_flags
+#define x86_smt_flags cpu_smt_flags
+#endif
+
+static struct sched_domain_topology_level x86_topology[] = {
+#ifdef CONFIG_SCHED_SMT
+	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
+#endif
+#ifdef CONFIG_SCHED_MC
+	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
+#endif
+	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ NULL, },
+};
+
+static struct sched_domain_topology_level x86_numa_in_package_topology[] = {
 #ifdef CONFIG_SCHED_SMT
-	{ cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
+	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
 #endif
 #ifdef CONFIG_SCHED_MC
-	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
+	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
 #endif
 	{ NULL, },
 };
+
 /*
- * set_sched_topology() sets the topology internal to a CPU.  The
- * NUMA topologies are layered on top of it to build the full
- * system topology.
- *
- * If NUMA nodes are observed to occur within a CPU package, this
- * function should be called.  It forces the sched domain code to
- * only use the SMT level for the CPU portion of the topology.
- * This essentially falls back to relying on NUMA information
- * from the SRAT table to describe the entire system topology
- * (except for hyperthreads).
+ * Set if a package/die has multiple NUMA nodes inside.
+ * AMD Magny-Cours and Intel Cluster-on-Die have this.
  */
-static void primarily_use_numa_for_topology(void)
-{
-	set_sched_topology(numa_inside_package_topology);
-}
+static bool x86_has_numa_in_package;
 
 void set_cpu_sibling_map(int cpu)
 {
@@ -558,7 +586,7 @@ void set_cpu_sibling_map(int cpu)
 				c->booted_cores = cpu_data(i).booted_cores;
 		}
 		if (match_die(c, o) && !topology_same_node(c, o))
-			primarily_use_numa_for_topology();
+			x86_has_numa_in_package = true;
 	}
 
 	threads = cpumask_weight(topology_sibling_cpumask(cpu));
@@ -1304,6 +1332,16 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
 	}
+
+	/*
+	 * Set 'default' x86 topology, this matches default_topology() in that
+	 * it has NUMA nodes as a topology level. See also
+	 * native_smp_cpus_done().
+	 *
+	 * Must be done before set_cpus_sibling_map() is ran.
+	 */
+	set_sched_topology(x86_topology);
+
 	set_cpu_sibling_map(0);
 
 	switch (smp_sanity_check(max_cpus)) {
@@ -1370,6 +1408,9 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
 {
 	pr_debug("Boot done\n");
 
+	if (x86_has_numa_in_package)
+		set_sched_topology(x86_numa_in_package_topology);
+
 	nmi_selftest();
 	impress_friends();
 	setup_ioapic_dest();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2a906f2..e86c4a5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6487,6 +6487,9 @@ static struct sched_domain_topology_level *sched_domain_topology =
 
 void set_sched_topology(struct sched_domain_topology_level *tl)
 {
+	if (WARN_ON_ONCE(sched_smp_initialized))
+		return;
+
 	sched_domain_topology = tl;
 }
 
-- 
2.7.4

