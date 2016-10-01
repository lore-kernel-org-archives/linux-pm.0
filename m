From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v5 6/9] x86/sched: Add SD_ASYM_PACKING flags to x86 ITMT CPU
Date: Sat,  1 Oct 2016 04:45:23 -0700
Message-ID: <1475322326-160112-7-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1475322326-160112-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1475322326-160112-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, tim.c.chen@linux.intel.com, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

Some Intel cores in a package can be boosted to a higher turbo frequency
with ITMT 3.0 technology. The scheduler can use the asymmetric packing
feature to move tasks to the more capable cores.

If ITMT is enabled, add SD_ASYM_PACKING flag to the thread and core
sched domains to enable asymmetric packing.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/kernel/smpboot.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 38901b3..607cbe6 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -487,22 +487,42 @@ static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	return false;
 }
 
+#if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_MC)
+static inline int x86_sched_itmt_flags(void)
+{
+	return sysctl_sched_itmt_enabled ? SD_ASYM_PACKING : 0;
+}
+
+#ifdef CONFIG_SCHED_MC
+static int x86_core_flags(void)
+{
+	return cpu_core_flags() | x86_sched_itmt_flags();
+}
+#endif
+#ifdef CONFIG_SCHED_SMT
+static int x86_smt_flags(void)
+{
+	return cpu_smt_flags() | x86_sched_itmt_flags();
+}
+#endif
+#endif
+
 static struct sched_domain_topology_level x86_numa_in_package_topology[] = {
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
 
 static struct sched_domain_topology_level x86_topology[] = {
 #ifdef CONFIG_SCHED_SMT
-	{ cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
+	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
 #endif
 #ifdef CONFIG_SCHED_MC
-	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
+	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
 #endif
 	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
 	{ NULL, },
-- 
2.7.4

