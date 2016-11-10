From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v7 5/8] x86/sched: Add SD_ASYM_PACKING flags to x86 ITMT CPU
Date: Thu, 10 Nov 2016 14:36:37 -0800
Message-ID: <df2de5941530e644816139dd5f49bf48e1e2ed0d.1478805832.git.tim.c.chen@linux.intel.com>
References: <cover.1478805832.git.tim.c.chen@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1478805832.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1478805832.git.tim.c.chen@linux.intel.com>
References: <cover.1478805832.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Some Intel cores in a package can be boosted to a higher turbo frequency
with ITMT 3.0 technology. The scheduler can use the asymmetric packing
feature to move tasks to the more capable cores.

If ITMT is enabled, add SD_ASYM_PACKING flag to the thread and core
sched domains to enable asymmetric packing.

Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/kernel/smpboot.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ac61ee7..4f13062 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -482,22 +482,42 @@ static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
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
2.5.5
