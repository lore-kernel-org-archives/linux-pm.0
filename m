From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/3] tools/power/turbostat: handle missing rapl msrs
Date: Thu, 16 Jun 2016 09:48:20 -0700
Message-ID: <1466095702-5537-2-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1466095702-5537-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466095702-5537-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Some CPUs may not have PP0/Core domain power limit MSRs. We
should still allow its domain energy status to be used. This
patch splits PP0/Core RAPL into two separate flags for power
limit and energy status such that energy status can continue
to be reported without power limit.

Without this patch, turbostat will not be able to use the
remaining RAPL features if some PL MSRs are not present.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index acbf7ff..26566e6 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -131,9 +131,8 @@ unsigned int has_hwp_pkg;		/* IA32_HWP_REQUEST_PKG */
 #define RAPL_DRAM_POWER_INFO	(1 << 5)
 					/* 0x61c MSR_DRAM_POWER_INFO */
 
-#define RAPL_CORES		(1 << 6)
+#define RAPL_CORES_POWER_LIMIT	(1 << 6)
 					/* 0x638 MSR_PP0_POWER_LIMIT */
-					/* 0x639 MSR_PP0_ENERGY_STATUS */
 #define RAPL_CORE_POLICY	(1 << 7)
 					/* 0x63a MSR_PP0_POLICY */
 
@@ -141,6 +140,10 @@ unsigned int has_hwp_pkg;		/* IA32_HWP_REQUEST_PKG */
 					/* 0x640 MSR_PP1_POWER_LIMIT */
 					/* 0x641 MSR_PP1_ENERGY_STATUS */
 					/* 0x642 MSR_PP1_POLICY */
+
+#define RAPL_CORES_ENERGY_STATUS	(1 << 9)
+					/* 0x639 MSR_PP0_ENERGY_STATUS */
+#define RAPL_CORES (RAPL_CORES_ENERGY_STATUS | RAPL_CORES_POWER_LIMIT)
 #define	TJMAX_DEFAULT	100
 
 #define MAX(a, b) ((a) > (b) ? (a) : (b))
@@ -400,7 +403,7 @@ void print_header(void)
 	if (do_rapl && !rapl_joules) {
 		if (do_rapl & RAPL_PKG)
 			outp += sprintf(outp, " PkgWatt");
-		if (do_rapl & RAPL_CORES)
+		if (do_rapl & RAPL_CORES_ENERGY_STATUS)
 			outp += sprintf(outp, " CorWatt");
 		if (do_rapl & RAPL_GFX)
 			outp += sprintf(outp, " GFXWatt");
@@ -413,7 +416,7 @@ void print_header(void)
 	} else if (do_rapl && rapl_joules) {
 		if (do_rapl & RAPL_PKG)
 			outp += sprintf(outp, "   Pkg_J");
-		if (do_rapl & RAPL_CORES)
+		if (do_rapl & RAPL_CORES_ENERGY_STATUS)
 			outp += sprintf(outp, "   Cor_J");
 		if (do_rapl & RAPL_GFX)
 			outp += sprintf(outp, "   GFX_J");
@@ -670,7 +673,7 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	if (do_rapl && !rapl_joules) {
 		if (do_rapl & RAPL_PKG)
 			outp += sprintf(outp, fmt8, p->energy_pkg * rapl_energy_units / interval_float);
-		if (do_rapl & RAPL_CORES)
+		if (do_rapl & RAPL_CORES_ENERGY_STATUS)
 			outp += sprintf(outp, fmt8, p->energy_cores * rapl_energy_units / interval_float);
 		if (do_rapl & RAPL_GFX)
 			outp += sprintf(outp, fmt8, p->energy_gfx * rapl_energy_units / interval_float);
@@ -1237,7 +1240,7 @@ retry:
 			return -13;
 		p->energy_pkg = msr & 0xFFFFFFFF;
 	}
-	if (do_rapl & RAPL_CORES) {
+	if (do_rapl & RAPL_CORES_ENERGY_STATUS) {
 		if (get_msr(cpu, MSR_PP0_ENERGY_STATUS, &msr))
 			return -14;
 		p->energy_cores = msr & 0xFFFFFFFF;
@@ -2671,7 +2674,7 @@ void rapl_probe(unsigned int family, unsigned int model)
 		break;
 	case 0x37:	/* BYT */
 	case 0x4D:	/* AVN */
-		do_rapl = RAPL_PKG | RAPL_CORES ;
+		do_rapl = RAPL_PKG | RAPL_CORES;
 		break;
 	default:
 		return;
@@ -2886,9 +2889,8 @@ int print_rapl(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 			fprintf(outf, "cpu%d: MSR_PP0_POLICY: %lld\n", cpu, msr & 0xF);
 		}
 	}
-	if (do_rapl & RAPL_CORES) {
+	if (do_rapl & RAPL_CORES_POWER_LIMIT) {
 		if (debug) {
-
 			if (get_msr(cpu, MSR_PP0_POWER_LIMIT, &msr))
 				return -9;
 			fprintf(outf, "cpu%d: MSR_PP0_POWER_LIMIT: 0x%08llx (%slocked)\n",
-- 
1.9.1
