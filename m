From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2] intel_idle: prevent SKL-H boot failure when C8+C9+C10 enabled
Date: Thu, 24 Mar 2016 01:16:01 -0400
Message-ID: <d70e28f57e14a481977436695b0c9ba165472431.1458796304.git.len.brown@intel.com>
References: <1458796562-19744-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35572 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756720AbcCXFQi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 01:16:38 -0400
In-Reply-To: <1458796562-19744-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, stable@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Some SKL-H configurations require "intel_idle.max_cstate=7" to boot.
While that is an effective workaround, it disables C10.

This patch detects the problematic configuration,
and disables C8 and C9, keeping C10 enabled.

Note that enabling SGX in BIOS SETUP can also prevent this issue,
if the system BIOS provides that option.

https://bugzilla.kernel.org/show_bug.cgi?id=109081
"Freezes with Intel i7 6700HQ (Skylake), unless intel_idle.max_cstate=7"

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/idle/intel_idle.c | 108 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 86 insertions(+), 22 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index cd4510a..146eed70b 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -65,7 +65,7 @@
 #include <asm/mwait.h>
 #include <asm/msr.h>
 
-#define INTEL_IDLE_VERSION "0.4"
+#define INTEL_IDLE_VERSION "0.4.1"
 #define PREFIX "intel_idle: "
 
 static struct cpuidle_driver intel_idle_driver = {
@@ -994,36 +994,92 @@ static void intel_idle_cpuidle_devices_uninit(void)
 }
 
 /*
- * intel_idle_state_table_update()
- *
- * Update the default state_table for this CPU-id
+ * ivt_idle_state_table_update(void)
  *
- * Currently used to access tuned IVT multi-socket targets
+ * Tune IVT multi-socket targets
  * Assumption: num_sockets == (max_package_num + 1)
  */
-void intel_idle_state_table_update(void)
+static void ivt_idle_state_table_update(void)
 {
 	/* IVT uses a different table for 1-2, 3-4, and > 4 sockets */
-	if (boot_cpu_data.x86_model == 0x3e) { /* IVT */
-		int cpu, package_num, num_sockets = 1;
-
-		for_each_online_cpu(cpu) {
-			package_num = topology_physical_package_id(cpu);
-			if (package_num + 1 > num_sockets) {
-				num_sockets = package_num + 1;
-
-				if (num_sockets > 4) {
-					cpuidle_state_table = ivt_cstates_8s;
-					return;
-				}
+	int cpu, package_num, num_sockets = 1;
+
+	for_each_online_cpu(cpu) {
+		package_num = topology_physical_package_id(cpu);
+		if (package_num + 1 > num_sockets) {
+			num_sockets = package_num + 1;
+
+			if (num_sockets > 4) {
+				cpuidle_state_table = ivt_cstates_8s;
+				return;
 			}
 		}
+	}
+
+	if (num_sockets > 2)
+		cpuidle_state_table = ivt_cstates_4s;
+
+	/* else, 1 and 2 socket systems use default ivt_cstates */
+}
+/*
+ * sklh_idle_state_table_update(void)
+ *
+ * On SKL-H (model 0x5e) disable C8 and C9 if:
+ * C10 is enabled and SGX disabled
+ */
+static void sklh_idle_state_table_update(void)
+{
+	unsigned long long msr;
+	unsigned int eax, ebx, ecx, edx;
+
+
+	/* if PC10 disabled via cmdline intel_idle.max_cstate=7 or shallower */
+	if (max_cstate <= 7)
+		return;
+
+	/* if PC10 not present in CPUID.MWAIT.EDX */
+	if ((mwait_substates & (0xF << 28)) == 0)
+		return;
+
+	rdmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr);
+
+	/* PC10 is not enabled in PKG C-state limit */
+	if ((msr & 0xF) != 8)
+		return;
+
+	ecx = 0;
+	cpuid(7, &eax, &ebx, &ecx, &edx);
+
+	/* if SGX is present */
+	if (ebx & (1 << 2)) {
 
-		if (num_sockets > 2)
-			cpuidle_state_table = ivt_cstates_4s;
-		/* else, 1 and 2 socket systems use default ivt_cstates */
+		rdmsrl(MSR_IA32_FEATURE_CONTROL, msr);
+
+		/* if SGX is enabled */
+		if (msr & (1 << 18))
+			return;
+	}
+
+	skl_cstates[5].disabled = 1;	/* C8-SKL */
+	skl_cstates[6].disabled = 1;	/* C9-SKL */
+}
+/*
+ * intel_idle_state_table_update()
+ *
+ * Update the default state_table for this CPU-id
+ */
+
+static void intel_idle_state_table_update(void)
+{
+	switch (boot_cpu_data.x86_model) {
+
+	case 0x3e: /* IVT */
+		ivt_idle_state_table_update();
+		break;
+	case 0x5e: /* SKL-H */
+		sklh_idle_state_table_update();
+		break;
 	}
-	return;
 }
 
 /*
@@ -1063,6 +1119,14 @@ static int __init intel_idle_cpuidle_driver_init(void)
 		if (num_substates == 0)
 			continue;
 
+		/* if state marked as disabled, skip it */
+		if (cpuidle_state_table[cstate].disabled != 0) {
+			pr_debug(PREFIX "state %s is disabled",
+				cpuidle_state_table[cstate].name);
+			continue;
+		}
+
+
 		if (((mwait_cstate + 1) > 2) &&
 			!boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
 			mark_tsc_unstable("TSC halts in idle"
-- 
2.7.1.339.g0233b80

