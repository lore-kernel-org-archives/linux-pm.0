From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 02/11] sched, x86: Add SD_ASYM_PACKING flags to x86 cpu topology for cpus supporting Intel Turbo Boost Max Technology
Date: Thu, 18 Aug 2016 15:36:43 -0700
Message-ID: <1471559812-19967-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, peterz@infradead.org
Cc: x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, tim.c.chen@linux.intel.com, srinivas.pandruvada@linux.intel.com, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com
List-Id: linux-pm@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

We uses ASYM_PACKING feature in the scheduler to move tasks to more
capable cpus that can be boosted to higher frequency.  We mark the sched
domain topology level with SD_ASYM_PACKING flag for such systems.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/kernel/smpboot.c | 77 ++++++++++++++++++++++++++++++++++++-----------
 kernel/sched/core.c       |  3 ++
 2 files changed, 62 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 2a6e84a..255f64e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -464,31 +464,59 @@ static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	return false;
 }
 
-static struct sched_domain_topology_level numa_inside_package_topology[] = {
+#ifdef CONFIG_SCHED_ITMT
+extern unsigned int sysctl_sched_itmt_enabled;
+
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
+static bool x86_has_numa_in_package = false;
 
 void set_cpu_sibling_map(int cpu)
 {
@@ -551,7 +579,7 @@ void set_cpu_sibling_map(int cpu)
 				c->booted_cores = cpu_data(i).booted_cores;
 		}
 		if (match_die(c, o) && !topology_same_node(c, o))
-			primarily_use_numa_for_topology();
+			x86_has_numa_in_package = true;
 	}
 
 	threads = cpumask_weight(topology_sibling_cpumask(cpu));
@@ -1297,6 +1325,16 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
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
@@ -1363,6 +1401,9 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
 {
 	pr_debug("Boot done\n");
 
+	if (x86_has_numa_in_package)
+		set_sched_topology(x86_numa_in_package_topology);
+
 	nmi_selftest();
 	impress_friends();
 	setup_ioapic_dest();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ec752da..342eca9 100644
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
