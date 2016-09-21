From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 01/10] x86/topology: Fix numa in package topology bug
Date: Wed, 21 Sep 2016 12:19:03 -0700
Message-ID: <1474485552-141429-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1474485552-141429-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1474485552-141429-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, tim.c.chen@linux.intel.com, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

Current code can call set_cpu_sibling_map and invoke sched_set_topology
more than once (e.g. on hot plug).  When this happens after
sched_init_smp has been called,  we lose the numa topology extension to
sched_domain_topology in sched_init_numa.  This results in incorrect
topology when the sched domain is rebuilt.

This patch fixes the bug and issues warning if we call sched_set_topology
after sched_init_smp.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/kernel/smpboot.c | 46 ++++++++++++++++++++++++++++++----------------
 kernel/sched/core.c       |  3 +++
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 4296beb..7137ec4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -471,7 +471,7 @@ static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	return false;
 }
 
-static struct sched_domain_topology_level numa_inside_package_topology[] = {
+static struct sched_domain_topology_level x86_numa_in_package_topology[] = {
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
 #endif
@@ -480,22 +480,23 @@ static struct sched_domain_topology_level numa_inside_package_topology[] = {
 #endif
 	{ NULL, },
 };
+
+static struct sched_domain_topology_level x86_topology[] = {
+#ifdef CONFIG_SCHED_SMT
+	{ cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
+#endif
+#ifdef CONFIG_SCHED_MC
+	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
+#endif
+	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ NULL, },
+};
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
@@ -558,7 +559,7 @@ void set_cpu_sibling_map(int cpu)
 				c->booted_cores = cpu_data(i).booted_cores;
 		}
 		if (match_die(c, o) && !topology_same_node(c, o))
-			primarily_use_numa_for_topology();
+			x86_has_numa_in_package = true;
 	}
 
 	threads = cpumask_weight(topology_sibling_cpumask(cpu));
@@ -1304,6 +1305,16 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
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
@@ -1370,6 +1381,9 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
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

