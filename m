From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/44] tools/power turbostat: decode CPUID(6).TURBO
Date: Wed,  1 Mar 2017 00:27:21 -0500
Message-ID: <b3a34e9382a4aacfa7c0b24f9548737bbb20338e.1488345270.git.len.brown@intel.com>
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

show the CPUID feature for turbo to clarify the case
when it may not be shown in MISC_ENABLE

CPUID(6): APERF, TURBO, DTS, PTM, No-HWP, No-HWPnotify, No-HWPwindow, No-HWPepp, No-HWPpkg, EPB
cpu4: MSR_IA32_MISC_ENABLE: 0x00850089 (TCC EIST MWAIT TURBO)

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index da6ec640caf7..1011b5f7f21f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3626,6 +3626,7 @@ void process_cpuid()
 {
 	unsigned int eax, ebx, ecx, edx, max_level, max_extended_level;
 	unsigned int fms, family, model, stepping;
+	unsigned int has_turbo;
 
 	eax = ebx = ecx = edx = 0;
 
@@ -3696,6 +3697,7 @@ void process_cpuid()
 	do_dts = eax & (1 << 0);
 	if (do_dts)
 		BIC_PRESENT(BIC_CoreTmp);
+	has_turbo = eax & (1 << 1);
 	do_ptm = eax & (1 << 6);
 	if (do_ptm)
 		BIC_PRESENT(BIC_PkgTmp);
@@ -3707,9 +3709,10 @@ void process_cpuid()
 	has_epb = ecx & (1 << 3);
 
 	if (debug)
-		fprintf(outf, "CPUID(6): %sAPERF, %sDTS, %sPTM, %sHWP, "
+		fprintf(outf, "CPUID(6): %sAPERF, %sTURBO, %sDTS, %sPTM, %sHWP, "
 			"%sHWPnotify, %sHWPwindow, %sHWPepp, %sHWPpkg, %sEPB\n",
 			has_aperf ? "" : "No-",
+			has_turbo ? "" : "No-",
 			do_dts ? "" : "No-",
 			do_ptm ? "" : "No-",
 			has_hwp ? "" : "No-",
-- 
2.11.0.161.g6610af872
