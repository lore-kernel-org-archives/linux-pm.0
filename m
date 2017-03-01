From: Len Brown <lenb@kernel.org>
Subject: [PATCH 34/44] tools/power turbostat: Add --list option to show available header names
Date: Wed,  1 Mar 2017 00:27:38 -0500
Message-ID: <c8ade3616a1a5cf7767c0338d2b02007796f5d88.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34348 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbdCAFkR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 00:40:17 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

It is handy to know the list of column header names,
so that they can be used with --add and --skip

The new --list option shows them:

sudo ./turbostat --list --hide sysfs
,Core,CPU,Avg_MHz,Busy%,Bzy_MHz,TSC_MHz,IRQ,SMI,CPU%c1,CPU%c3,CPU%c6,CPU%c7,CoreTmp,PkgTmp,GFX%rc6,GFXMHz,PkgWatt,CorWatt,GFXWatt

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 118 +++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 52 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 48b540a2fe81..7b02fbb65893 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -52,6 +52,7 @@ unsigned int debug;
 unsigned int quiet;
 unsigned int rapl_joules;
 unsigned int summary_only;
+unsigned int list_header_only;
 unsigned int dump_only;
 unsigned int do_snb_cstates;
 unsigned int do_knl_cstates;
@@ -469,133 +470,133 @@ unsigned long long bic_lookup(char *name_list)
 	return retval;
 }
 
-void print_header(void)
+void print_header(char *delim)
 {
 	struct msr_counter *mp;
 
 	if (DO_BIC(BIC_Package))
-		outp += sprintf(outp, "\tPackage");
+		outp += sprintf(outp, "%sPackage", delim);
 	if (DO_BIC(BIC_Core))
-		outp += sprintf(outp, "\tCore");
+		outp += sprintf(outp, "%sCore", delim);
 	if (DO_BIC(BIC_CPU))
-		outp += sprintf(outp, "\tCPU");
+		outp += sprintf(outp, "%sCPU", delim);
 	if (DO_BIC(BIC_Avg_MHz))
-		outp += sprintf(outp, "\tAvg_MHz");
+		outp += sprintf(outp, "%sAvg_MHz", delim);
 	if (DO_BIC(BIC_Busy))
-		outp += sprintf(outp, "\tBusy%%");
+		outp += sprintf(outp, "%sBusy%%", delim);
 	if (DO_BIC(BIC_Bzy_MHz))
-		outp += sprintf(outp, "\tBzy_MHz");
+		outp += sprintf(outp, "%sBzy_MHz", delim);
 	if (DO_BIC(BIC_TSC_MHz))
-		outp += sprintf(outp, "\tTSC_MHz");
+		outp += sprintf(outp, "%sTSC_MHz", delim);
 
 	if (DO_BIC(BIC_IRQ))
-		outp += sprintf(outp, "\tIRQ");
+		outp += sprintf(outp, "%sIRQ", delim);
 	if (DO_BIC(BIC_SMI))
-		outp += sprintf(outp, "\tSMI");
+		outp += sprintf(outp, "%sSMI", delim);
 
 	for (mp = sys.tp; mp; mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 64)
-				outp += sprintf(outp, "\t%18.18s", mp->name);
+				outp += sprintf(outp, "%s%18.18s", delim, mp->name);
 			else
-				outp += sprintf(outp, "\t%10.10s", mp->name);
+				outp += sprintf(outp, "%s%10.10s", delim, mp->name);
 		} else {
-			outp += sprintf(outp, "\t%s", mp->name);
+			outp += sprintf(outp, "%s%s", delim, mp->name);
 		}
 	}
 
 	if (DO_BIC(BIC_CPU_c1))
-		outp += sprintf(outp, "\tCPU%%c1");
+		outp += sprintf(outp, "%sCPU%%c1", delim);
 	if (DO_BIC(BIC_CPU_c3) && !do_slm_cstates && !do_knl_cstates)
-		outp += sprintf(outp, "\tCPU%%c3");
+		outp += sprintf(outp, "%sCPU%%c3", delim);
 	if (DO_BIC(BIC_CPU_c6))
-		outp += sprintf(outp, "\tCPU%%c6");
+		outp += sprintf(outp, "%sCPU%%c6", delim);
 	if (DO_BIC(BIC_CPU_c7))
-		outp += sprintf(outp, "\tCPU%%c7");
+		outp += sprintf(outp, "%sCPU%%c7", delim);
 
 	if (DO_BIC(BIC_Mod_c6))
-		outp += sprintf(outp, "\tMod%%c6");
+		outp += sprintf(outp, "%sMod%%c6", delim);
 
 	if (DO_BIC(BIC_CoreTmp))
-		outp += sprintf(outp, "\tCoreTmp");
+		outp += sprintf(outp, "%sCoreTmp", delim);
 
 	for (mp = sys.cp; mp; mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 64)
-				outp += sprintf(outp, "\t%18.18s", mp->name);
+				outp += sprintf(outp, "%s%18.18s", delim, mp->name);
 			else
-				outp += sprintf(outp, "\t%10.10s", mp->name);
+				outp += sprintf(outp, "%s%10.10s", delim, mp->name);
 		} else {
-			outp += sprintf(outp, "\t%s", mp->name);
+			outp += sprintf(outp, "%s%s", delim, mp->name);
 		}
 	}
 
 	if (DO_BIC(BIC_PkgTmp))
-		outp += sprintf(outp, "\tPkgTmp");
+		outp += sprintf(outp, "%sPkgTmp", delim);
 
 	if (DO_BIC(BIC_GFX_rc6))
-		outp += sprintf(outp, "\tGFX%%rc6");
+		outp += sprintf(outp, "%sGFX%%rc6", delim);
 
 	if (DO_BIC(BIC_GFXMHz))
-		outp += sprintf(outp, "\tGFXMHz");
+		outp += sprintf(outp, "%sGFXMHz", delim);
 
 	if (do_skl_residency) {
-		outp += sprintf(outp, "\tTotl%%C0");
-		outp += sprintf(outp, "\tAny%%C0");
-		outp += sprintf(outp, "\tGFX%%C0");
-		outp += sprintf(outp, "\tCPUGFX%%");
+		outp += sprintf(outp, "%sTotl%%C0", delim);
+		outp += sprintf(outp, "%sAny%%C0", delim);
+		outp += sprintf(outp, "%sGFX%%C0", delim);
+		outp += sprintf(outp, "%sCPUGFX%%", delim);
 	}
 
 	if (DO_BIC(BIC_Pkgpc2))
-		outp += sprintf(outp, "\tPkg%%pc2");
+		outp += sprintf(outp, "%sPkg%%pc2", delim);
 	if (DO_BIC(BIC_Pkgpc3))
-		outp += sprintf(outp, "\tPkg%%pc3");
+		outp += sprintf(outp, "%sPkg%%pc3", delim);
 	if (DO_BIC(BIC_Pkgpc6))
-		outp += sprintf(outp, "\tPkg%%pc6");
+		outp += sprintf(outp, "%sPkg%%pc6", delim);
 	if (DO_BIC(BIC_Pkgpc7))
-		outp += sprintf(outp, "\tPkg%%pc7");
+		outp += sprintf(outp, "%sPkg%%pc7", delim);
 	if (DO_BIC(BIC_Pkgpc8))
-		outp += sprintf(outp, "\tPkg%%pc8");
+		outp += sprintf(outp, "%sPkg%%pc8", delim);
 	if (DO_BIC(BIC_Pkgpc9))
-		outp += sprintf(outp, "\tPkg%%pc9");
+		outp += sprintf(outp, "%sPkg%%pc9", delim);
 	if (DO_BIC(BIC_Pkgpc10))
-		outp += sprintf(outp, "\tPk%%pc10");
+		outp += sprintf(outp, "%sPk%%pc10", delim);
 
 	if (do_rapl && !rapl_joules) {
 		if (DO_BIC(BIC_PkgWatt))
-			outp += sprintf(outp, "\tPkgWatt");
+			outp += sprintf(outp, "%sPkgWatt", delim);
 		if (DO_BIC(BIC_CorWatt))
-			outp += sprintf(outp, "\tCorWatt");
+			outp += sprintf(outp, "%sCorWatt", delim);
 		if (DO_BIC(BIC_GFXWatt))
-			outp += sprintf(outp, "\tGFXWatt");
+			outp += sprintf(outp, "%sGFXWatt", delim);
 		if (DO_BIC(BIC_RAMWatt))
-			outp += sprintf(outp, "\tRAMWatt");
+			outp += sprintf(outp, "%sRAMWatt", delim);
 		if (DO_BIC(BIC_PKG__))
-			outp += sprintf(outp, "\tPKG_%%");
+			outp += sprintf(outp, "%sPKG_%%", delim);
 		if (DO_BIC(BIC_RAM__))
-			outp += sprintf(outp, "\tRAM_%%");
+			outp += sprintf(outp, "%sRAM_%%", delim);
 	} else if (do_rapl && rapl_joules) {
 		if (DO_BIC(BIC_Pkg_J))
-			outp += sprintf(outp, "\tPkg_J");
+			outp += sprintf(outp, "%sPkg_J", delim);
 		if (DO_BIC(BIC_Cor_J))
-			outp += sprintf(outp, "\tCor_J");
+			outp += sprintf(outp, "%sCor_J", delim);
 		if (DO_BIC(BIC_GFX_J))
-			outp += sprintf(outp, "\tGFX_J");
+			outp += sprintf(outp, "%sGFX_J", delim);
 		if (DO_BIC(BIC_RAM_J))
-			outp += sprintf(outp, "\tRAM_J");
+			outp += sprintf(outp, "%sRAM_J", delim);
 		if (DO_BIC(BIC_PKG__))
-			outp += sprintf(outp, "\tPKG_%%");
+			outp += sprintf(outp, "%sPKG_%%", delim);
 		if (DO_BIC(BIC_RAM__))
-			outp += sprintf(outp, "\tRAM_%%");
+			outp += sprintf(outp, "%sRAM_%%", delim);
 	}
 	for (mp = sys.pp; mp; mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 64)
-				outp += sprintf(outp, "\t%18.18s", mp->name);
+				outp += sprintf(outp, "%s%18.18s", delim, mp->name);
 			else
-				outp += sprintf(outp, "\t%10.10s", mp->name);
+				outp += sprintf(outp, "%s%10.10s", delim, mp->name);
 		} else {
-			outp += sprintf(outp, "\t%s", mp->name);
+			outp += sprintf(outp, "%s%s", delim, mp->name);
 		}
 	}
 
@@ -933,7 +934,7 @@ void format_all_counters(struct thread_data *t, struct core_data *c, struct pkg_
 	static int printed;
 
 	if (!printed || !summary_only)
-		print_header();
+		print_header("\t");
 
 	if (topo.num_cpus > 1)
 		format_counters(&average.threads, &average.cores,
@@ -4107,6 +4108,7 @@ void help()
 	"--quiet	skip decoding system configuration header\n"
 	"--interval sec	Override default 5-second measurement interval\n"
 	"--help		print this help message\n"
+	"--list		list column headers only\n"
 	"--out file	create or truncate \"file\" for all output\n"
 	"--version	print version information\n"
 	"\n"
@@ -4814,6 +4816,7 @@ void cmdline(int argc, char **argv)
 		{"help",	no_argument,		0, 'h'},
 		{"hide",	required_argument,	0, 'H'},	// meh, -h taken by --help
 		{"Joules",	no_argument,		0, 'J'},
+		{"list",	no_argument,		0, 'l'},
 		{"out",		required_argument,	0, 'o'},
 		{"Package",	no_argument,		0, 'p'},
 		{"processor",	no_argument,		0, 'p'},
@@ -4866,6 +4869,10 @@ void cmdline(int argc, char **argv)
 		case 'J':
 			rapl_joules++;
 			break;
+		case 'l':
+			list_header_only++;
+			quiet++;
+			break;
 		case 'o':
 			outf = fopen_or_die(optarg, "w");
 			break;
@@ -4912,6 +4919,13 @@ int main(int argc, char **argv)
 	if (dump_only)
 		return get_and_dump_counters();
 
+	/* list header and exit */
+	if (list_header_only) {
+		print_header(",");
+		flush_output_stdout();
+		return 0;
+	}
+
 	/*
 	 * if any params left, it must be a command to fork
 	 */
-- 
2.11.0.161.g6610af872
