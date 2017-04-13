From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/7] tools/power turbostat: enable package THERM_INTERRUPT dump
Date: Wed, 12 Apr 2017 20:08:49 -0400
Message-ID: <f4896fa502b81c5bce93f375bd17b14725c01826.1492041840.git.len.brown@intel.com>
References: <20170413000853.21648-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170413000853.21648-1-lenb@kernel.org>
In-Reply-To: <22048c5485503749754b3b5daf9d99ef89fcacdc.1492041840.git.len.brown@intel.com>
References: <22048c5485503749754b3b5daf9d99ef89fcacdc.1492041840.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x00641400 (100 C)
cpu0: MSR_IA32_PACKAGE_THERM_STATUS: 0x884b0800 (25 C)
cpu0: MSR_IA32_PACKAGE_THERM_INTERRUPT: 0x00000003 (100 C, 100 C)

Enable the same per-core output, but hide it behind --debug
because it is too verbose on big systems.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 94d7e54b1ec0..e95799966560 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3482,7 +3482,7 @@ void perf_limit_reasons_probe(unsigned int family, unsigned int model)
 int print_thermal(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 {
 	unsigned long long msr;
-	unsigned int dts;
+	unsigned int dts, dts2;
 	int cpu;
 
 	if (!(do_dts || do_ptm))
@@ -3507,7 +3507,6 @@ int print_thermal(struct thread_data *t, struct core_data *c, struct pkg_data *p
 		fprintf(outf, "cpu%d: MSR_IA32_PACKAGE_THERM_STATUS: 0x%08llx (%d C)\n",
 			cpu, msr, tcc_activation_temp - dts);
 
-#ifdef	THERM_DEBUG
 		if (get_msr(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, &msr))
 			return 0;
 
@@ -3515,11 +3514,10 @@ int print_thermal(struct thread_data *t, struct core_data *c, struct pkg_data *p
 		dts2 = (msr >> 8) & 0x7F;
 		fprintf(outf, "cpu%d: MSR_IA32_PACKAGE_THERM_INTERRUPT: 0x%08llx (%d C, %d C)\n",
 			cpu, msr, tcc_activation_temp - dts, tcc_activation_temp - dts2);
-#endif
 	}
 
 
-	if (do_dts) {
+	if (do_dts && debug) {
 		unsigned int resolution;
 
 		if (get_msr(cpu, MSR_IA32_THERM_STATUS, &msr))
@@ -3530,7 +3528,6 @@ int print_thermal(struct thread_data *t, struct core_data *c, struct pkg_data *p
 		fprintf(outf, "cpu%d: MSR_IA32_THERM_STATUS: 0x%08llx (%d C +/- %d)\n",
 			cpu, msr, tcc_activation_temp - dts, resolution);
 
-#ifdef THERM_DEBUG
 		if (get_msr(cpu, MSR_IA32_THERM_INTERRUPT, &msr))
 			return 0;
 
@@ -3538,7 +3535,6 @@ int print_thermal(struct thread_data *t, struct core_data *c, struct pkg_data *p
 		dts2 = (msr >> 8) & 0x7F;
 		fprintf(outf, "cpu%d: MSR_IA32_THERM_INTERRUPT: 0x%08llx (%d C, %d C)\n",
 			cpu, msr, tcc_activation_temp - dts, tcc_activation_temp - dts2);
-#endif
 	}
 
 	return 0;
-- 
2.11.0.161.g6610af872
