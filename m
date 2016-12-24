From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/17] tools/power/turbostat: split core MSR support into status + limit
Date: Sat, 24 Dec 2016 15:53:34 -0500
Message-ID: <9148494c59f53bb6c9233df07447777dc533db33.1482612381.git.len.brown@intel.com>
References: <20161224205345.29129-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35915 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbcLXU4I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Dec 2016 15:56:08 -0500
Received: by mail-qk0-f195.google.com with SMTP id h201so21014839qke.3
        for <linux-pm@vger.kernel.org>; Sat, 24 Dec 2016 12:56:07 -0800 (PST)
In-Reply-To: <20161224205345.29129-1-lenb@kernel.org>
In-Reply-To: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
References: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

Some CPUs may not have PP0/Core domain power limit MSRs. We
should still allow its domain energy status to be used. This
patch splits PP0/Core RAPL into two separate flags for power
limit and energy status such that energy status can continue
to be reported without power limit.

Without this patch, turbostat will not be able to use the
remaining RAPL features if some PL MSRs are not present.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 12a6eea2d6ae..3a80f949e5ba 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -129,9 +129,8 @@ unsigned int has_hwp_pkg;		/* IA32_HWP_REQUEST_PKG */
 #define RAPL_DRAM_POWER_INFO	(1 << 5)
 					/* 0x61c MSR_DRAM_POWER_INFO */
 
-#define RAPL_CORES		(1 << 6)
+#define RAPL_CORES_POWER_LIMIT	(1 << 6)
 					/* 0x638 MSR_PP0_POWER_LIMIT */
-					/* 0x639 MSR_PP0_ENERGY_STATUS */
 #define RAPL_CORE_POLICY	(1 << 7)
 					/* 0x63a MSR_PP0_POLICY */
 
@@ -139,6 +138,10 @@ unsigned int has_hwp_pkg;		/* IA32_HWP_REQUEST_PKG */
 					/* 0x640 MSR_PP1_POWER_LIMIT */
 					/* 0x641 MSR_PP1_ENERGY_STATUS */
 					/* 0x642 MSR_PP1_POLICY */
+
+#define RAPL_CORES_ENERGY_STATUS	(1 << 9)
+					/* 0x639 MSR_PP0_ENERGY_STATUS */
+#define RAPL_CORES (RAPL_CORES_ENERGY_STATUS | RAPL_CORES_POWER_LIMIT)
 #define	TJMAX_DEFAULT	100
 
 #define MAX(a, b) ((a) > (b) ? (a) : (b))
@@ -397,7 +400,7 @@ void print_header(void)
 	if (do_rapl && !rapl_joules) {
 		if (do_rapl & RAPL_PKG)
 			outp += sprintf(outp, "\tPkgWatt");
-		if (do_rapl & RAPL_CORES)
+		if (do_rapl & RAPL_CORES_ENERGY_STATUS)
 			outp += sprintf(outp, "\tCorWatt");
 		if (do_rapl & RAPL_GFX)
 			outp += sprintf(outp, "\tGFXWatt");
@@ -410,7 +413,7 @@ void print_header(void)
 	} else if (do_rapl && rapl_joules) {
 		if (do_rapl & RAPL_PKG)
 			outp += sprintf(outp, "\tPkg_J");
-		if (do_rapl & RAPL_CORES)
+		if (do_rapl & RAPL_CORES_ENERGY_STATUS)
 			outp += sprintf(outp, "\tCor_J");
 		if (do_rapl & RAPL_GFX)
 			outp += sprintf(outp, "\tGFX_J");
@@ -657,7 +660,7 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	if (do_rapl && !rapl_joules) {
 		if (do_rapl & RAPL_PKG)
 			outp += sprintf(outp, fmt8, p->energy_pkg * rapl_energy_units / interval_float);
-		if (do_rapl & RAPL_CORES)
+		if (do_rapl & RAPL_CORES_ENERGY_STATUS)
 			outp += sprintf(outp, fmt8, p->energy_cores * rapl_energy_units / interval_float);
 		if (do_rapl & RAPL_GFX)
 			outp += sprintf(outp, fmt8, p->energy_gfx * rapl_energy_units / interval_float);
@@ -1217,7 +1220,7 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 			return -13;
 		p->energy_pkg = msr & 0xFFFFFFFF;
 	}
-	if (do_rapl & RAPL_CORES) {
+	if (do_rapl & RAPL_CORES_ENERGY_STATUS) {
 		if (get_msr(cpu, MSR_PP0_ENERGY_STATUS, &msr))
 			return -14;
 		p->energy_cores = msr & 0xFFFFFFFF;
@@ -2657,7 +2660,7 @@ void rapl_probe(unsigned int family, unsigned int model)
 		break;
 	case 0x37:	/* BYT */
 	case 0x4D:	/* AVN */
-		do_rapl = RAPL_PKG | RAPL_CORES ;
+		do_rapl = RAPL_PKG | RAPL_CORES;
 		break;
 	default:
 		return;
@@ -2872,9 +2875,8 @@ int print_rapl(struct thread_data *t, struct core_data *c, struct pkg_data *p)
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
2.11.0.161.g6610af872

