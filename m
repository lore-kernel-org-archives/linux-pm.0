From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/44] tools/power turbostat: BYT does not have MSR_MISC_PWR_MGMT
Date: Wed,  1 Mar 2017 00:27:07 -0500
Message-ID: <cf4cbe5314884c3123fe4ca137e9d750b6e2b8c9.1488345270.git.len.brown@intel.com>
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

and so --debug fails with:

turbostat: msr 1 offset 0x1aa read failed: Input/output error

It seems that baytrail, and airmont do not have this MSR.
It is included in subsequent Goldmont Atom.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index fff280b50af0..fdf0273465fa 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -70,6 +70,7 @@ unsigned int units = 1000000;	/* MHz etc */
 unsigned int genuine_intel;
 unsigned int has_invariant_tsc;
 unsigned int do_nhm_platform_info;
+unsigned int no_MSR_MISC_PWR_MGMT;
 unsigned int aperf_mperf_multiplier = 1;
 double bclk;
 double base_hz;
@@ -330,7 +331,7 @@ int get_msr(int cpu, off_t offset, unsigned long long *msr)
 	retval = pread(get_msr_fd(cpu), msr, sizeof(*msr), offset);
 
 	if (retval != sizeof *msr)
-		err(-1, "msr %d offset 0x%llx read failed", cpu, (unsigned long long)offset);
+		err(-1, "cpu%d: msr offset 0x%llx read failed", cpu, (unsigned long long)offset);
 
 	return 0;
 }
@@ -2384,6 +2385,8 @@ void check_permissions()
  * MSR_PLATFORM_INFO               0x000000ce
  * MSR_NHM_SNB_PKG_CST_CFG_CTL     0x000000e2
  *
+ * MSR_MISC_PWR_MGMT               0x000001aa
+ *
  * MSR_PKG_C3_RESIDENCY            0x000003f8
  * MSR_PKG_C6_RESIDENCY            0x000003f9
  * MSR_CORE_C3_RESIDENCY           0x000003fc
@@ -2440,11 +2443,13 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		pkg_cstate_limits = skx_pkg_cstate_limits;
 		break;
 	case INTEL_FAM6_ATOM_SILVERMONT1:	/* BYT */
+		no_MSR_MISC_PWR_MGMT = 1;
 	case INTEL_FAM6_ATOM_SILVERMONT2:	/* AVN */
 		pkg_cstate_limits = slv_pkg_cstate_limits;
 		break;
 	case INTEL_FAM6_ATOM_AIRMONT:	/* AMT */
 		pkg_cstate_limits = amt_pkg_cstate_limits;
+		no_MSR_MISC_PWR_MGMT = 1;
 		break;
 	case INTEL_FAM6_XEON_PHI_KNL:	/* PHI */
 	case INTEL_FAM6_XEON_PHI_KNM:
@@ -3481,6 +3486,9 @@ void decode_misc_pwr_mgmt_msr(void)
 	if (!do_nhm_platform_info)
 		return;
 
+	if (no_MSR_MISC_PWR_MGMT)
+		return;
+
 	if (!get_msr(base_cpu, MSR_MISC_PWR_MGMT, &msr))
 		fprintf(outf, "cpu%d: MSR_MISC_PWR_MGMT: 0x%08llx (%sable-EIST_Coordination %sable-EPB %sable-OOB)\n",
 			base_cpu, msr,
@@ -4061,7 +4069,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(outf, "turbostat version 4.16 24 Dec 2016"
+	fprintf(outf, "turbostat version 4.17 1 Jan 2017"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.11.0.161.g6610af872
