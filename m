From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/44] tools/power turbostat: decode MSR_MISC_FEATURE_CONTROL
Date: Wed,  1 Mar 2017 00:27:23 -0500
Message-ID: <33148d671cc191fceaca5017e1bb060e9f30fbf7.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

useful for observing if the BIOS disabled prefetch
Not architectural, but docuemented as present on NHM, SNB
and is present on others.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1011b5f7f21f..2f033f3d2a21 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -102,6 +102,7 @@ unsigned int has_hwp_notify;		/* IA32_HWP_INTERRUPT */
 unsigned int has_hwp_activity_window;	/* IA32_HWP_REQUEST[bits 41:32] */
 unsigned int has_hwp_epp;		/* IA32_HWP_REQUEST[bits 31:24] */
 unsigned int has_hwp_pkg;		/* IA32_HWP_REQUEST_PKG */
+unsigned int has_misc_feature_control;
 
 #define RAPL_PKG		(1 << 0)
 					/* 0x610 MSR_PKG_POWER_LIMIT */
@@ -2466,6 +2467,7 @@ void check_permissions()
  *
  * Side effect:
  * sets global pkg_cstate_limit to decode MSR_PKG_CST_CONFIG_CONTROL
+ * sets has_misc_feature_control
  */
 int probe_nhm_msrs(unsigned int family, unsigned int model)
 {
@@ -2496,6 +2498,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_IVYBRIDGE:	/* IVB */
 	case INTEL_FAM6_IVYBRIDGE_X:	/* IVB Xeon */
 		pkg_cstate_limits = snb_pkg_cstate_limits;
+		has_misc_feature_control = 1;
 		break;
 	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
@@ -2510,9 +2513,11 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_KABYLAKE_MOBILE:	/* KBL */
 	case INTEL_FAM6_KABYLAKE_DESKTOP:	/* KBL */
 		pkg_cstate_limits = hsw_pkg_cstate_limits;
+		has_misc_feature_control = 1;
 		break;
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 		pkg_cstate_limits = skx_pkg_cstate_limits;
+		has_misc_feature_control = 1;
 		break;
 	case INTEL_FAM6_ATOM_SILVERMONT1:	/* BYT */
 		no_MSR_MISC_PWR_MGMT = 1;
@@ -3579,6 +3584,21 @@ void decode_misc_enable_msr(void)
 			msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE ? "No-" : "");
 }
 
+void decode_misc_feature_control(void)
+{
+	unsigned long long msr;
+
+	if (!has_misc_feature_control)
+		return;
+
+	if (!get_msr(base_cpu, MSR_MISC_FEATURE_CONTROL, &msr))
+		fprintf(outf, "cpu%d: MSR_MISC_FEATURE_CONTROL: 0x%08llx (%sL2-Prefetch %sL2-Prefetch-pair %sL1-Prefetch %sL1-IP-Prefetch)\n",
+			base_cpu, msr,
+			msr & (0 << 0) ? "No-" : "",
+			msr & (1 << 0) ? "No-" : "",
+			msr & (2 << 0) ? "No-" : "",
+			msr & (3 << 0) ? "No-" : "");
+}
 /*
  * Decode MSR_MISC_PWR_MGMT
  *
@@ -3725,6 +3745,7 @@ void process_cpuid()
 	if (debug)
 		decode_misc_enable_msr();
 
+
 	if (max_level >= 0x7 && debug) {
 		int has_sgx;
 
@@ -3852,6 +3873,9 @@ void process_cpuid()
 	if (!access("/sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz", R_OK))
 		BIC_PRESENT(BIC_GFXMHz);
 
+	if (debug)
+		decode_misc_feature_control();
+
 	return;
 }
 
-- 
2.11.0.161.g6610af872
