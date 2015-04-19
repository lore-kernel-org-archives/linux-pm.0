From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/12] tools/power turbostat: calculate TSC frequency from CPUID(0x15) on SKL
Date: Sat, 18 Apr 2015 20:40:26 -0400
Message-ID: <8a5bdf41d2c027c1e4ad62bc4f96f3fdf82070ba.1429402554.git.len.brown@intel.com>
References: <1429404027-23203-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36675 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbbDSAlA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Apr 2015 20:41:00 -0400
Received: by qcpm10 with SMTP id m10so42168734qcp.3
        for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2015 17:40:59 -0700 (PDT)
In-Reply-To: <1429404027-23203-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
References: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

turbostat --debug
...
CPUID(0x15): eax_crystal: 2 ebx_tsc: 100 ecx_crystal_hz: 0
TSC: 1200 MHz (24000000 Hz * 100 / 2 / 1000000)

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 39 ++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 064749d..203d45d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -89,6 +89,8 @@ double rapl_joule_counter_range;
 unsigned int do_core_perf_limit_reasons;
 unsigned int do_gfx_perf_limit_reasons;
 unsigned int do_ring_perf_limit_reasons;
+unsigned int crystal_hz;
+unsigned long long tsc_hz;
 
 #define RAPL_PKG		(1 << 0)
 					/* 0x610 MSR_PKG_POWER_LIMIT */
@@ -2496,6 +2498,41 @@ void process_cpuid()
 			do_ptm ? "" : "No ",
 			has_epb ? "" : "No ");
 
+	if (max_level > 0x15) {
+		unsigned int eax_crystal;
+		unsigned int ebx_tsc;
+
+		/*
+		 * CPUID 15H TSC/Crystal ratio, possibly Crystal Hz
+		 */
+		eax_crystal = ebx_tsc = crystal_hz = edx = 0;
+		__get_cpuid(0x15, &eax_crystal, &ebx_tsc, &crystal_hz, &edx);
+
+		if (ebx_tsc != 0) {
+
+			if (debug && (ebx != 0))
+				fprintf(stderr, "CPUID(0x15): eax_crystal: %d ebx_tsc: %d ecx_crystal_hz: %d\n",
+					eax_crystal, ebx_tsc, crystal_hz);
+
+			if (crystal_hz == 0)
+				switch(model) {
+				case 0x4E:	/* SKL */
+				case 0x5E:	/* SKL */
+					crystal_hz = 24000000;	/* 24 MHz */
+					break;
+				default:
+					crystal_hz = 0;
+			}
+
+			if (crystal_hz) {
+				tsc_hz =  (unsigned long long) crystal_hz * ebx_tsc / eax_crystal;
+				if (debug)
+					fprintf(stderr, "TSC: %lld MHz (%d Hz * %d / %d / 1000000)\n",
+						tsc_hz / 1000000, crystal_hz, ebx_tsc,  eax_crystal);
+			}
+		}
+	}
+
 	do_nhm_platform_info = do_nhm_cstates = do_smi = probe_nhm_msrs(family, model);
 	do_snb_cstates = has_snb_msrs(family, model);
 	do_pc2 = do_snb_cstates && (pkg_cstate_limit >= PCL__2);
@@ -2834,7 +2871,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(stderr, "turbostat version 4.3 24 Mar, 2015"
+	fprintf(stderr, "turbostat version 4.4 2 Apr, 2015"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.4.0.rc1

