From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/44] tools/power turbostat: further decode MSR_IA32_MISC_ENABLE
Date: Wed,  1 Mar 2017 00:27:17 -0500
Message-ID: <e651262477c6d8cba79dffc1a6039da43d9c96b0.1488345270.git.len.brown@intel.com>
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

Decode MISC_ENABLE.NO_TURBO,
also use the #defines in msr-index.h for decoding this register

cpu0: MSR_IA32_MISC_ENABLE: 0x00850089 (TCC EIST MWAIT TURBO)

Although it is not architectural, decode also
MSR_IA32_MISC_ENABLE.prefetch-disable (bit-9).
documented to be present on: Core, P4, Intel-Xeon
reserved on: Atom, Silvermont, Nehalem, SNB, PHI ec.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 762b81497c3b..a1ec9d816dfa 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3509,11 +3509,13 @@ void decode_misc_enable_msr(void)
 	unsigned long long msr;
 
 	if (!get_msr(base_cpu, MSR_IA32_MISC_ENABLE, &msr))
-		fprintf(outf, "cpu%d: MSR_IA32_MISC_ENABLE: 0x%08llx (%s %s %s)\n",
+		fprintf(outf, "cpu%d: MSR_IA32_MISC_ENABLE: 0x%08llx (%sTCC %sEIST %sMWAIT %sPREFETCH %sTURBO)\n",
 			base_cpu, msr,
-			msr & (1 << 3) ? "TCC" : "",
-			msr & (1 << 16) ? "EIST" : "",
-			msr & (1 << 18) ? "MONITOR" : "");
+			msr & MSR_IA32_MISC_ENABLE_TM1 ? "" : "No-",
+			msr & MSR_IA32_MISC_ENABLE_ENHANCED_SPEEDSTEP ? "" : "No-",
+			msr & MSR_IA32_MISC_ENABLE_MWAIT ? "No-" : "",
+			msr & MSR_IA32_MISC_ENABLE_PREFETCH_DISABLE ? "No-" : "",
+			msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE ? "No-" : "");
 }
 
 /*
-- 
2.11.0.161.g6610af872
