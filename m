From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/12] tools/power turbostat: correct DRAM RAPL units on recent Xeon processors
Date: Sat, 18 Apr 2015 20:40:25 -0400
Message-ID: <40ee8e3b9dc8917e6077dde6a49c7a71d63b0231.1429402554.git.len.brown@intel.com>
References: <1429404027-23203-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:34861 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbbDSAk6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Apr 2015 20:40:58 -0400
Received: by qcbii10 with SMTP id ii10so42194068qcb.2
        for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2015 17:40:58 -0700 (PDT)
In-Reply-To: <1429404027-23203-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
References: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Andrey Semin <andrey.semin@intel.com>, Len Brown <len.brown@intel.com>

From: Andrey Semin <andrey.semin@intel.com>

While not yet documented in the Software Developer's Manual,
the data-sheet for modern Xeon states that DRAM RAPL ENERGY units
are fixed at 15.3 uJ, rather than being discovered via MSR.

Before this patch, DRAM energy on these products is over-stated by turbostat
because the RAPL units are 4x larger.

ref: "Xeon E5-2600 v3/E5-1600 v3 Datasheet Volume 2"
http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e5-v3-datasheet-vol-2.pdf

Signed-off-by: Andrey Semin <andrey.semin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ad56889..064749d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -83,7 +83,8 @@ unsigned int do_dts;
 unsigned int do_ptm;
 unsigned int tcc_activation_temp;
 unsigned int tcc_activation_temp_override;
-double rapl_power_units, rapl_energy_units, rapl_time_units;
+double rapl_power_units, rapl_time_units;
+double rapl_dram_energy_units, rapl_energy_units;
 double rapl_joule_counter_range;
 unsigned int do_core_perf_limit_reasons;
 unsigned int do_gfx_perf_limit_reasons;
@@ -600,7 +601,7 @@ int format_counters(struct thread_data *t, struct core_data *c,
 		if (do_rapl & RAPL_GFX)
 			outp += sprintf(outp, fmt8, p->energy_gfx * rapl_energy_units / interval_float);
 		if (do_rapl & RAPL_DRAM)
-			outp += sprintf(outp, fmt8, p->energy_dram * rapl_energy_units / interval_float);
+			outp += sprintf(outp, fmt8, p->energy_dram * rapl_dram_energy_units / interval_float);
 		if (do_rapl & RAPL_PKG_PERF_STATUS)
 			outp += sprintf(outp, fmt8, 100.0 * p->rapl_pkg_perf_status * rapl_time_units / interval_float);
 		if (do_rapl & RAPL_DRAM_PERF_STATUS)
@@ -617,7 +618,7 @@ int format_counters(struct thread_data *t, struct core_data *c,
 					p->energy_gfx * rapl_energy_units);
 		if (do_rapl & RAPL_DRAM)
 			outp += sprintf(outp, fmt8,
-					p->energy_dram * rapl_energy_units);
+					p->energy_dram * rapl_dram_energy_units);
 		if (do_rapl & RAPL_PKG_PERF_STATUS)
 			outp += sprintf(outp, fmt8, 100.0 * p->rapl_pkg_perf_status * rapl_time_units / interval_float);
 		if (do_rapl & RAPL_DRAM_PERF_STATUS)
@@ -1935,6 +1936,25 @@ double get_tdp(model)
 	}
 }
 
+/*
+ * rapl_dram_energy_units_probe()
+ * Energy units are either hard-coded, or come from RAPL Energy Unit MSR.
+ */
+static double
+rapl_dram_energy_units_probe(int  model, double rapl_energy_units)
+{
+	/* only called for genuine_intel, family 6 */
+
+	switch (model) {
+	case 0x3F:	/* HSX */
+	case 0x4F:	/* BDX */
+	case 0x56:	/* BDX-DE */
+		return (rapl_dram_energy_units = 15.3 / 1000000);
+	default:
+		return (rapl_energy_units);
+	}
+}
+
 
 /*
  * rapl_probe()
@@ -1994,6 +2014,8 @@ void rapl_probe(unsigned int family, unsigned int model)
 	else
 		rapl_energy_units = 1.0 / (1 << (msr >> 8 & 0x1F));
 
+	rapl_dram_energy_units = rapl_dram_energy_units_probe(model, rapl_energy_units);
+
 	time_unit = msr >> 16 & 0xF;
 	if (time_unit == 0)
 		time_unit = 0xA;
-- 
2.4.0.rc1

