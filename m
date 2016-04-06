From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/13] intel_idle: add BXT support
Date: Wed,  6 Apr 2016 17:00:47 -0400
Message-ID: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
References: <1459976459-2532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459976459-2532-1-git-send-email-lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Broxton has all the HSW C-states, except C3.
BXT C-state timing is slightly different.

Here we trust the IRTL MSRs as authority
on maximum C-state latency, and override the driver's tables
with the values found in the associated IRTL MSRs.
Further we set the target_residency to 1x maximum latency,
trusting the hardware demotion logic.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/msr-index.h |   8 +++
 drivers/idle/intel_idle.c        | 137 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 2da46ac..1e81927 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -167,6 +167,14 @@
 #define MSR_PKG_C9_RESIDENCY		0x00000631
 #define MSR_PKG_C10_RESIDENCY		0x00000632
 
+/* Interrupt Response Limit */
+#define MSR_PKGC3_IRTL			0x0000060a
+#define MSR_PKGC6_IRTL			0x0000060b
+#define MSR_PKGC7_IRTL			0x0000060c
+#define MSR_PKGC8_IRTL			0x00000633
+#define MSR_PKGC9_IRTL			0x00000634
+#define MSR_PKGC10_IRTL			0x00000635
+
 /* Run Time Average Power Limiting (RAPL) Interface */
 
 #define MSR_RAPL_POWER_UNIT		0x00000606
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ba947df..012980a 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -737,6 +737,67 @@ static struct cpuidle_state knl_cstates[] = {
 		.enter = NULL }
 };
 
+static struct cpuidle_state bxt_cstates[] = {
+	{
+		.name = "C1-BXT",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00),
+		.exit_latency = 2,
+		.target_residency = 2,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C1E-BXT",
+		.desc = "MWAIT 0x01",
+		.flags = MWAIT2flg(0x01),
+		.exit_latency = 10,
+		.target_residency = 20,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C6-BXT",
+		.desc = "MWAIT 0x20",
+		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 133,
+		.target_residency = 133,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C7s-BXT",
+		.desc = "MWAIT 0x31",
+		.flags = MWAIT2flg(0x31) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 155,
+		.target_residency = 155,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C8-BXT",
+		.desc = "MWAIT 0x40",
+		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 1000,
+		.target_residency = 1000,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C9-BXT",
+		.desc = "MWAIT 0x50",
+		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 2000,
+		.target_residency = 2000,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.name = "C10-BXT",
+		.desc = "MWAIT 0x60",
+		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 10000,
+		.target_residency = 10000,
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
+	{
+		.enter = NULL }
+};
+
 /**
  * intel_idle
  * @dev: cpuidle_device
@@ -914,6 +975,11 @@ static const struct idle_cpu idle_cpu_knl = {
 	.state_table = knl_cstates,
 };
 
+static const struct idle_cpu idle_cpu_bxt = {
+	.state_table = bxt_cstates,
+	.disable_promotion_to_c1e = true,
+};
+
 #define ICPU(model, cpu) \
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, (unsigned long)&cpu }
 
@@ -946,6 +1012,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(0x4e, idle_cpu_skl),
 	ICPU(0x5e, idle_cpu_skl),
 	ICPU(0x57, idle_cpu_knl),
+	ICPU(0x5c, idle_cpu_bxt),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_idle_ids);
@@ -1046,6 +1113,73 @@ static void ivt_idle_state_table_update(void)
 
 	/* else, 1 and 2 socket systems use default ivt_cstates */
 }
+
+/*
+ * Translate IRTL (Interrupt Response Time Limit) MSR to usec
+ */
+
+static unsigned int irtl_ns_units[] = {
+	1, 32, 1024, 32768, 1048576, 33554432, 0, 0 };
+
+static unsigned long long irtl_2_usec(unsigned long long irtl)
+{
+	unsigned long long ns;
+
+	ns = irtl_ns_units[(irtl >> 10) & 0x3];
+
+	return div64_u64((irtl & 0x3FF) * ns, 1000);
+}
+/*
+ * bxt_idle_state_table_update(void)
+ *
+ * On BXT, we trust the IRTL to show the definitive maximum latency
+ * We use the same value for target_residency.
+ */
+static void bxt_idle_state_table_update(void)
+{
+	unsigned long long msr;
+
+	rdmsrl(MSR_PKGC6_IRTL, msr);
+	if (msr) {
+		unsigned int usec = irtl_2_usec(msr);
+
+		bxt_cstates[2].exit_latency = usec;
+		bxt_cstates[2].target_residency = usec;
+	}
+
+	rdmsrl(MSR_PKGC7_IRTL, msr);
+	if (msr) {
+		unsigned int usec = irtl_2_usec(msr);
+
+		bxt_cstates[3].exit_latency = usec;
+		bxt_cstates[3].target_residency = usec;
+	}
+
+	rdmsrl(MSR_PKGC8_IRTL, msr);
+	if (msr) {
+		unsigned int usec = irtl_2_usec(msr);
+
+		bxt_cstates[4].exit_latency = usec;
+		bxt_cstates[4].target_residency = usec;
+	}
+
+	rdmsrl(MSR_PKGC9_IRTL, msr);
+	if (msr) {
+		unsigned int usec = irtl_2_usec(msr);
+
+		bxt_cstates[5].exit_latency = usec;
+		bxt_cstates[5].target_residency = usec;
+	}
+
+	rdmsrl(MSR_PKGC10_IRTL, msr);
+	if (msr) {
+		unsigned int usec = irtl_2_usec(msr);
+
+		bxt_cstates[6].exit_latency = usec;
+		bxt_cstates[6].target_residency = usec;
+	}
+
+}
 /*
  * sklh_idle_state_table_update(void)
  *
@@ -1101,6 +1235,9 @@ static void intel_idle_state_table_update(void)
 	case 0x3e: /* IVT */
 		ivt_idle_state_table_update();
 		break;
+	case 0x5c: /* BXT */
+		bxt_idle_state_table_update();
+		break;
 	case 0x5e: /* SKL-H */
 		sklh_idle_state_table_update();
 		break;
-- 
2.8.0.rc4.16.g56331f8
