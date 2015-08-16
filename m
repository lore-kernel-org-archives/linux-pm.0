From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/7] tools/power turbostat: dump CONFIG_TDP
Date: Sat, 15 Aug 2015 23:25:44 -0400
Message-ID: <6fb3143b561c4a7865e5513eeb02d42ef38e8173.1439695194.git.len.brown@intel.com>
References: <1439695548-21174-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439695548-21174-1-git-send-email-lenb@kernel.org>
In-Reply-To: <75fd7ffa7fab91c2c3234bd3e465ba4f366733f4.1439695194.git.len.brown@intel.com>
References: <75fd7ffa7fab91c2c3234bd3e465ba4f366733f4.1439695194.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Config TDP is a feature that allows parts to be configured
for different thermal limits after they have left the factory.

This can have an effect on the operation of the part,
particularly in determiniing...

Max Non-turbo Ratio
Turbo Activation Ratio

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/uapi/asm/msr-index.h |  6 +++
 tools/power/x86/turbostat/turbostat.c | 78 ++++++++++++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/msr-index.h b/arch/x86/include/uapi/asm/msr-index.h
index 3c6bb34..872b592 100644
--- a/arch/x86/include/uapi/asm/msr-index.h
+++ b/arch/x86/include/uapi/asm/msr-index.h
@@ -169,6 +169,12 @@
 #define MSR_PP1_ENERGY_STATUS		0x00000641
 #define MSR_PP1_POLICY			0x00000642
 
+#define MSR_CONFIG_TDP_NOMINAL		0x00000648
+#define MSR_CONFIG_TDP_LEVEL_1		0x00000649
+#define MSR_CONFIG_TDP_LEVEL_2		0x0000064A
+#define MSR_CONFIG_TDP_CONTROL		0x0000064B
+#define MSR_TURBO_ACTIVATION_RATIO	0x0000064C
+
 #define MSR_PKG_WEIGHTED_CORE_C0_RES	0x00000658
 #define MSR_PKG_ANY_CORE_C0_RES		0x00000659
 #define MSR_PKG_ANY_GFXE_C0_RES		0x0000065A
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 67162ec..5a793be 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1384,6 +1384,49 @@ dump_nhm_cst_cfg(void)
 	return;
 }
 
+static void
+dump_config_tdp(void)
+{
+	unsigned long long msr;
+
+	get_msr(base_cpu, MSR_CONFIG_TDP_NOMINAL, &msr);
+	fprintf(stderr, "cpu%d: MSR_CONFIG_TDP_NOMINAL: 0x%08llx", base_cpu, msr);
+	fprintf(stderr, " (base_ratio=%d)\n", (unsigned int)msr & 0xEF);
+
+	get_msr(base_cpu, MSR_CONFIG_TDP_LEVEL_1, &msr);
+	fprintf(stderr, "cpu%d: MSR_CONFIG_TDP_LEVEL_1: 0x%08llx (", base_cpu, msr);
+	if (msr) {
+		fprintf(stderr, "PKG_MIN_PWR_LVL1=%d ", (unsigned int)(msr >> 48) & 0xEFFF);
+		fprintf(stderr, "PKG_MAX_PWR_LVL1=%d ", (unsigned int)(msr >> 32) & 0xEFFF);
+		fprintf(stderr, "LVL1_RATIO=%d ", (unsigned int)(msr >> 16) & 0xEF);
+		fprintf(stderr, "PKG_TDP_LVL1=%d", (unsigned int)(msr) & 0xEFFF);
+	}
+	fprintf(stderr, ")\n");
+
+	get_msr(base_cpu, MSR_CONFIG_TDP_LEVEL_2, &msr);
+	fprintf(stderr, "cpu%d: MSR_CONFIG_TDP_LEVEL_2: 0x%08llx (", base_cpu, msr);
+	if (msr) {
+		fprintf(stderr, "PKG_MIN_PWR_LVL2=%d ", (unsigned int)(msr >> 48) & 0xEFFF);
+		fprintf(stderr, "PKG_MAX_PWR_LVL2=%d ", (unsigned int)(msr >> 32) & 0xEFFF);
+		fprintf(stderr, "LVL2_RATIO=%d ", (unsigned int)(msr >> 16) & 0xEF);
+		fprintf(stderr, "PKG_TDP_LVL2=%d", (unsigned int)(msr) & 0xEFFF);
+	}
+	fprintf(stderr, ")\n");
+
+	get_msr(base_cpu, MSR_CONFIG_TDP_CONTROL, &msr);
+	fprintf(stderr, "cpu%d: MSR_CONFIG_TDP_CONTROL: 0x%08llx (", base_cpu, msr);
+	if ((msr) & 0x3)
+		fprintf(stderr, "TDP_LEVEL=%d ", (unsigned int)(msr) & 0x3);
+	fprintf(stderr, " lock=%d", (unsigned int)(msr >> 31) & 1);
+	fprintf(stderr, ")\n");
+	
+	get_msr(base_cpu, MSR_TURBO_ACTIVATION_RATIO, &msr);
+	fprintf(stderr, "cpu%d: MSR_TURBO_ACTIVATION_RATIO: 0x%08llx (", base_cpu, msr);
+	fprintf(stderr, "MAX_NON_TURBO_RATIO=%d", (unsigned int)(msr) & 0xEF);
+	fprintf(stderr, " lock=%d", (unsigned int)(msr >> 31) & 1);
+	fprintf(stderr, ")\n");
+}
+
 void free_all_buffers(void)
 {
 	CPU_FREE(cpu_present_set);
@@ -1873,6 +1916,36 @@ int has_knl_turbo_ratio_limit(unsigned int family, unsigned int model)
 		return 0;
 	}
 }
+int has_config_tdp(unsigned int family, unsigned int model)
+{
+	if (!genuine_intel)
+		return 0;
+
+	if (family != 6)
+		return 0;
+
+	switch (model) {
+	case 0x3A:	/* IVB */
+	case 0x3E:	/* IVB Xeon */
+
+	case 0x3C:	/* HSW */
+	case 0x3F:	/* HSX */
+	case 0x45:	/* HSW */
+	case 0x46:	/* HSW */
+	case 0x3D:	/* BDW */
+	case 0x47:	/* BDW */
+	case 0x4F:	/* BDX */
+	case 0x56:	/* BDX-DE */
+	case 0x4E:	/* SKL */
+	case 0x5E:	/* SKL */
+
+	case 0x57:	/* Knights Landing */
+		return 1;
+	default:
+		return 0;
+	}
+}
+
 static void
 dump_cstate_pstate_config_info(family, model)
 {
@@ -1893,6 +1966,9 @@ dump_cstate_pstate_config_info(family, model)
 	if (has_knl_turbo_ratio_limit(family, model))
 		dump_knl_turbo_ratio_limits();
 
+	if (has_config_tdp(family, model))
+		dump_config_tdp();
+
 	dump_nhm_cst_cfg();
 }
 
@@ -3014,7 +3090,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(stderr, "turbostat version 4.7 27-May, 2015"
+	fprintf(stderr, "turbostat version 4.7 17-June, 2015"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.5.0.330.g130be8e
