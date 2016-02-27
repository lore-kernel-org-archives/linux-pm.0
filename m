From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/16] tools/power turbostat: decode more CPUID fields
Date: Sat, 27 Feb 2016 04:00:55 -0500
Message-ID: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
References: <1456563670-23282-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35484 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbcB0JBr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 04:01:47 -0500
Received: by mail-yw0-f196.google.com with SMTP id u200so5302257ywf.2
        for <linux-pm@vger.kernel.org>; Sat, 27 Feb 2016 01:01:46 -0800 (PST)
In-Reply-To: <1456563670-23282-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

for debugging, dump a few more fields:

CPUID(1): SSE3 MONITOR EIST TM2 TSC MSR ACPI-TM TM

cpu0: MSR_IA32_MISC_ENABLE: 0x00850089 (TCC EIST MONITOR)

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 0dac7e0..7ef8b9f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2673,6 +2673,19 @@ guess:
 
 	return 0;
 }
+
+void decode_misc_enable_msr(void)
+{
+	unsigned long long msr;
+
+	if (!get_msr(base_cpu, MSR_IA32_MISC_ENABLE, &msr))
+		fprintf(stderr, "cpu%d: MSR_IA32_MISC_ENABLE: 0x%08llx (%s %s %s)\n",
+			base_cpu, msr,
+			msr & (1 << 3) ? "TCC" : "",
+			msr & (1 << 16) ? "EIST" : "",
+			msr & (1 << 18) ? "MONITOR" : "");
+}
+
 void process_cpuid()
 {
 	unsigned int eax, ebx, ecx, edx, max_level;
@@ -2696,9 +2709,19 @@ void process_cpuid()
 	if (family == 6 || family == 0xf)
 		model += ((fms >> 16) & 0xf) << 4;
 
-	if (debug)
+	if (debug) {
 		fprintf(stderr, "%d CPUID levels; family:model:stepping 0x%x:%x:%x (%d:%d:%d)\n",
 			max_level, family, model, stepping, family, model, stepping);
+		fprintf(stderr, "CPUID(1): %s %s %s %s %s %s %s %s\n",
+			ecx & (1 << 0) ? "SSE3" : "-",
+			ecx & (1 << 3) ? "MONITOR" : "-",
+			ecx & (1 << 7) ? "EIST" : "-",
+			ecx & (1 << 8) ? "TM2" : "-",
+			edx & (1 << 4) ? "TSC" : "-",
+			edx & (1 << 5) ? "MSR" : "-",
+			edx & (1 << 22) ? "ACPI-TM" : "-",
+			edx & (1 << 29) ? "TM" : "-");
+	}
 
 	if (!(edx & (1 << 5)))
 		errx(1, "CPUID: no MSR");
@@ -2739,6 +2762,9 @@ void process_cpuid()
 			do_ptm ? "" : "No ",
 			has_epb ? "" : "No ");
 
+	if (debug)
+		decode_misc_enable_msr();
+
 	if (max_level > 0x15) {
 		unsigned int eax_crystal;
 		unsigned int ebx_tsc;
-- 
2.7.1.339.g0233b80

