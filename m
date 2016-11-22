From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v8 5/8] x86/sched: Add SD_ASYM_PACKING flags to x86 ITMT CPU
Date: Tue, 22 Nov 2016 12:23:57 -0800
Message-ID: <9bbb885bedbef4eb50e197305eb16b160cff0831.1479844244.git.tim.c.chen@linux.intel.com>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:28060 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932967AbcKVUZR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Nov 2016 15:25:17 -0500
In-Reply-To: <cover.1479844244.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1479844244.git.tim.c.chen@linux.intel.com>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

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

