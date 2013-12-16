From: dirk.brandewie@gmail.com
Subject: [PATCH] turbostat: Add option to report joules consumed per sample
Date: Mon, 16 Dec 2013 10:23:41 -0800
Message-ID: <1387218221-11763-2-git-send-email-dirk.j.brandewie@intel.com>
References: <1387218221-11763-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:46474 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928Ab3LPSX7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2013 13:23:59 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so5680147pde.7
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2013 10:23:58 -0800 (PST)
In-Reply-To: <1387218221-11763-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Add "-J" option to report energy consumed in joules per sample.  This option
also adds the sample time to the reported values.

Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 91 +++++++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 25 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 9d77f13..e6f049ff 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -40,6 +40,7 @@ char *proc_stat = "/proc/stat";
 unsigned int interval_sec = 5;	/* set with -i interval_sec */
 unsigned int verbose;		/* set with -v */
 unsigned int rapl_verbose;	/* set with -R */
+unsigned int rapl_joules;	/* set with -J */
 unsigned int thermal_verbose;	/* set with -T */
 unsigned int summary_only;	/* set with -s */
 unsigned int skip_c0;
@@ -296,19 +297,35 @@ void print_header(void)
 		outp += sprintf(outp, "  %%pc10");
 	}
 
-	if (do_rapl & RAPL_PKG)
-		outp += sprintf(outp, "  Pkg_W");
-	if (do_rapl & RAPL_CORES)
-		outp += sprintf(outp, "  Cor_W");
-	if (do_rapl & RAPL_GFX)
-		outp += sprintf(outp, " GFX_W");
-	if (do_rapl & RAPL_DRAM)
-		outp += sprintf(outp, " RAM_W");
-	if (do_rapl & RAPL_PKG_PERF_STATUS)
-		outp += sprintf(outp, " PKG_%%");
-	if (do_rapl & RAPL_DRAM_PERF_STATUS)
-		outp += sprintf(outp, " RAM_%%");
+	if (do_rapl && !rapl_joules) {
+		if (do_rapl & RAPL_PKG)
+			outp += sprintf(outp, "  Pkg_W");
+		if (do_rapl & RAPL_CORES)
+			outp += sprintf(outp, "  Cor_W");
+		if (do_rapl & RAPL_GFX)
+			outp += sprintf(outp, " GFX_W");
+		if (do_rapl & RAPL_DRAM)
+			outp += sprintf(outp, " RAM_W");
+		if (do_rapl & RAPL_PKG_PERF_STATUS)
+			outp += sprintf(outp, " PKG_%%");
+		if (do_rapl & RAPL_DRAM_PERF_STATUS)
+			outp += sprintf(outp, " RAM_%%");
+	} else {
+		if (do_rapl & RAPL_PKG)
+			outp += sprintf(outp, "  Pkg_J");
+		if (do_rapl & RAPL_CORES)
+			outp += sprintf(outp, "  Cor_J");
+		if (do_rapl & RAPL_GFX)
+			outp += sprintf(outp, " GFX_J");
+		if (do_rapl & RAPL_DRAM)
+			outp += sprintf(outp, " RAM_W");
+		if (do_rapl & RAPL_PKG_PERF_STATUS)
+			outp += sprintf(outp, " PKG_%%");
+		if (do_rapl & RAPL_DRAM_PERF_STATUS)
+			outp += sprintf(outp, " RAM_%%");
+		outp += sprintf(outp, " time");
 
+	}
 	outp += sprintf(outp, "\n");
 }
 
@@ -527,19 +544,39 @@ int format_counters(struct thread_data *t, struct core_data *c,
 		fmt6 = " %4.0f**";
 	}
 
-	if (do_rapl & RAPL_PKG)
-		outp += sprintf(outp, fmt6, p->energy_pkg * rapl_energy_units / interval_float);
-	if (do_rapl & RAPL_CORES)
-		outp += sprintf(outp, fmt6, p->energy_cores * rapl_energy_units / interval_float);
-	if (do_rapl & RAPL_GFX)
-		outp += sprintf(outp, fmt5, p->energy_gfx * rapl_energy_units / interval_float); 
-	if (do_rapl & RAPL_DRAM)
-		outp += sprintf(outp, fmt5, p->energy_dram * rapl_energy_units / interval_float);
-	if (do_rapl & RAPL_PKG_PERF_STATUS )
-		outp += sprintf(outp, fmt5, 100.0 * p->rapl_pkg_perf_status * rapl_time_units / interval_float);
-	if (do_rapl & RAPL_DRAM_PERF_STATUS )
-		outp += sprintf(outp, fmt5, 100.0 * p->rapl_dram_perf_status * rapl_time_units / interval_float);
+	if (do_rapl && !rapl_joules) {
+		if (do_rapl & RAPL_PKG)
+			outp += sprintf(outp, fmt6, p->energy_pkg * rapl_energy_units / interval_float);
+		if (do_rapl & RAPL_CORES)
+			outp += sprintf(outp, fmt6, p->energy_cores * rapl_energy_units / interval_float);
+		if (do_rapl & RAPL_GFX)
+			outp += sprintf(outp, fmt5, p->energy_gfx * rapl_energy_units / interval_float); 
+		if (do_rapl & RAPL_DRAM)
+			outp += sprintf(outp, fmt5, p->energy_dram * rapl_energy_units / interval_float);
+		if (do_rapl & RAPL_PKG_PERF_STATUS )
+			outp += sprintf(outp, fmt5, 100.0 * p->rapl_pkg_perf_status * rapl_time_units / interval_float);
+		if (do_rapl & RAPL_DRAM_PERF_STATUS )
+			outp += sprintf(outp, fmt5, 100.0 * p->rapl_dram_perf_status * rapl_time_units / interval_float);
+	} else {
+		if (do_rapl & RAPL_PKG)
+			outp += sprintf(outp, fmt6,
+					p->energy_pkg * rapl_energy_units);
+		if (do_rapl & RAPL_CORES)
+			outp += sprintf(outp, fmt6, 
+					p->energy_cores * rapl_energy_units);
+		if (do_rapl & RAPL_GFX)
+			outp += sprintf(outp, fmt5,
+					p->energy_gfx * rapl_energy_units); 
+		if (do_rapl & RAPL_DRAM)
+			outp += sprintf(outp, fmt5, 
+					p->energy_dram * rapl_energy_units );
+		if (do_rapl & RAPL_PKG_PERF_STATUS )
+			outp += sprintf(outp, fmt5, 100.0 * p->rapl_pkg_perf_status * rapl_time_units / interval_float);
+		if (do_rapl & RAPL_DRAM_PERF_STATUS )
+			outp += sprintf(outp, fmt5, 100.0 * p->rapl_dram_perf_status * rapl_time_units / interval_float);
+	outp += sprintf(outp, fmt5, interval_float);
 
+	}
 done:
 	outp += sprintf(outp, "\n");
 
@@ -2370,7 +2407,7 @@ void cmdline(int argc, char **argv)
 
 	progname = argv[0];
 
-	while ((opt = getopt(argc, argv, "+pPSvi:sc:sC:m:M:RT:")) != -1) {
+	while ((opt = getopt(argc, argv, "+pPSvi:sc:sC:m:M:RJT:")) != -1) {
 		switch (opt) {
 		case 'p':
 			show_core_only++;
@@ -2405,6 +2442,10 @@ void cmdline(int argc, char **argv)
 		case 'T':
 			tcc_activation_temp_override = atoi(optarg);
 			break;
+		case 'J':
+			rapl_joules++;
+			break;
+
 		default:
 			usage();
 		}
-- 
1.8.3.1

