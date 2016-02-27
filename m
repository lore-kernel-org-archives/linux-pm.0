From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/16] tools/power turbostat: show GFXMHz
Date: Sat, 27 Feb 2016 04:01:08 -0500
Message-ID: <a0fc0674fdad432096cb83f8b71f4a120e4c9891.1456563103.git.len.brown@intel.com>
References: <1456563670-23282-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36000 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243AbcB0JCI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 04:02:08 -0500
Received: by mail-yw0-f196.google.com with SMTP id h80so5308529ywc.3
        for <linux-pm@vger.kernel.org>; Sat, 27 Feb 2016 01:02:08 -0800 (PST)
In-Reply-To: <1456563670-23282-1-git-send-email-lenb@kernel.org>
In-Reply-To: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
References: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Under the column "GFXMHz", show a snapshot of this attribute:
/sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz

This is an instantaneous snapshot of what sysfs presents
at the end of the measurement interval.  turbostat does
not average or otherwise perform any math on this value.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 50 ++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c679326..d599f91 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -90,6 +90,8 @@ char *output_buffer, *outp;
 unsigned int do_rapl;
 unsigned int do_dts;
 unsigned int do_ptm;
+unsigned int do_gfx_mhz;
+unsigned int gfx_cur_mhz;
 unsigned int tcc_activation_temp;
 unsigned int tcc_activation_temp_override;
 double rapl_power_units, rapl_time_units;
@@ -183,6 +185,7 @@ struct pkg_data {
 	unsigned long long pkg_any_core_c0;
 	unsigned long long pkg_any_gfxe_c0;
 	unsigned long long pkg_both_core_gfxe_c0;
+	unsigned int gfx_mhz;
 	unsigned int package_id;
 	unsigned int energy_pkg;	/* MSR_PKG_ENERGY_STATUS */
 	unsigned int energy_dram;	/* MSR_DRAM_ENERGY_STATUS */
@@ -311,7 +314,7 @@ int get_msr(int cpu, off_t offset, unsigned long long *msr)
 /*
  * Example Format w/ field column widths:
  *
- *  Package    Core     CPU Avg_MHz Bzy_MHz TSC_MHz     IRQ   SMI   Busy% CPU_%c1 CPU_%c3 CPU_%c6 CPU_%c7 CoreTmp  PkgTmp Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 PkgWatt CorWatt GFXWatt
+ *  Package    Core     CPU Avg_MHz Bzy_MHz TSC_MHz     IRQ   SMI   Busy% CPU_%c1 CPU_%c3 CPU_%c6 CPU_%c7 CoreTmp  PkgTmp  GFXMHz Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 PkgWatt CorWatt GFXWatt
  * 12345678123456781234567812345678123456781234567812345678123456781234567812345678123456781234567812345678123456781234567812345678123456781234567812345678123456781234567812345678
  */
 
@@ -362,6 +365,9 @@ void print_header(void)
 	if (do_ptm)
 		outp += sprintf(outp, "  PkgTmp");
 
+	if (do_gfx_mhz)
+		outp += sprintf(outp, "  GFXMHz");
+
 	if (do_skl_residency) {
 		outp += sprintf(outp, " Totl%%C0");
 		outp += sprintf(outp, "  Any%%C0");
@@ -608,6 +614,10 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	if (do_ptm)
 		outp += sprintf(outp, "%8d", p->pkg_temp_c);
 
+	/* GFXMHz */
+	if (do_gfx_mhz)
+		outp += sprintf(outp, "%8d", p->gfx_mhz);
+
 	/* Totl%C0, Any%C0 GFX%C0 CPUGFX% */
 	if (do_skl_residency) {
 		outp += sprintf(outp, "%8.2f", 100.0 * p->pkg_wtd_core_c0/t->tsc);
@@ -746,6 +756,8 @@ delta_package(struct pkg_data *new, struct pkg_data *old)
 	old->pc10 = new->pc10 - old->pc10;
 	old->pkg_temp_c = new->pkg_temp_c;
 
+	old->gfx_mhz = new->gfx_mhz;
+
 	DELTA_WRAP32(new->energy_pkg, old->energy_pkg);
 	DELTA_WRAP32(new->energy_cores, old->energy_cores);
 	DELTA_WRAP32(new->energy_gfx, old->energy_gfx);
@@ -909,6 +921,8 @@ void clear_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	p->rapl_pkg_perf_status = 0;
 	p->rapl_dram_perf_status = 0;
 	p->pkg_temp_c = 0;
+
+	p->gfx_mhz = 0;
 }
 int sum_counters(struct thread_data *t, struct core_data *c,
 	struct pkg_data *p)
@@ -961,6 +975,8 @@ int sum_counters(struct thread_data *t, struct core_data *c,
 	average.packages.energy_cores += p->energy_cores;
 	average.packages.energy_gfx += p->energy_gfx;
 
+	average.packages.gfx_mhz = p->gfx_mhz;
+
 	average.packages.pkg_temp_c = MAX(average.packages.pkg_temp_c, p->pkg_temp_c);
 
 	average.packages.rapl_pkg_perf_status += p->rapl_pkg_perf_status;
@@ -1176,6 +1192,9 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 			return -17;
 		p->pkg_temp_c = tcc_activation_temp - ((msr >> 16) & 0x7F);
 	}
+	if (do_gfx_mhz)
+		p->gfx_mhz = gfx_cur_mhz;
+
 	return 0;
 }
 
@@ -1825,6 +1844,30 @@ int snapshot_proc_interrupts(void)
 	}
 	return 0;
 }
+/*
+ * snapshot_gfx_mhz()
+ *
+ * record snapshot of
+ * /sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz
+ *
+ * return 1 if config change requires a restart, else return 0
+ */
+int snapshot_gfx_mhz(void)
+{
+	static FILE *fp;
+	int retval;
+
+	if (fp == NULL)
+		fp = fopen_or_die("/sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz", "r");
+	else
+		rewind(fp);
+
+	retval = fscanf(fp, "%d", &gfx_cur_mhz);
+	if (retval != 1)
+		err(1, "GFX MHz");
+
+	return 0;
+}
 
 /*
  * snapshot /proc and /sys files
@@ -1836,6 +1879,9 @@ int snapshot_proc_sysfs_files(void)
 	if (snapshot_proc_interrupts())
 		return 1;
 
+	if (do_gfx_mhz)
+		snapshot_gfx_mhz();
+
 	return 0;
 }
 
@@ -3111,6 +3157,8 @@ void process_cpuid()
 	if (has_skl_msrs(family, model))
 		calculate_tsc_tweak();
 
+	do_gfx_mhz = !access("/sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz", R_OK);
+
 	return;
 }
 
-- 
2.7.1.339.g0233b80

