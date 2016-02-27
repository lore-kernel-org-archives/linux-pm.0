From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/16] tools/power turbostat: CPUID(0x16) leaf shows base, max, and bus frequency
Date: Sat, 27 Feb 2016 04:00:56 -0500
Message-ID: <61a87ba7893a256d86c7eea6a7ab10d38ccac9b2.1456563103.git.len.brown@intel.com>
References: <1456563670-23282-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:32804 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbcB0JNO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 04:13:14 -0500
Received: by mail-yw0-f196.google.com with SMTP id c124so5326830ywe.0
        for <linux-pm@vger.kernel.org>; Sat, 27 Feb 2016 01:13:14 -0800 (PST)
In-Reply-To: <1456563670-23282-1-git-send-email-lenb@kernel.org>
In-Reply-To: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
References: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

This CPUID leaf is available on Skylake:

CPUID(0x16): base_mhz: 1500 max_mhz: 2200 bus_mhz: 100

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 7ef8b9f..4c4470f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2688,7 +2688,7 @@ void decode_misc_enable_msr(void)
 
 void process_cpuid()
 {
-	unsigned int eax, ebx, ecx, edx, max_level;
+	unsigned int eax, ebx, ecx, edx, max_level, max_extended_level;
 	unsigned int fms, family, model, stepping;
 
 	eax = ebx = ecx = edx = 0;
@@ -2732,9 +2732,9 @@ void process_cpuid()
 	 * This check is valid for both Intel and AMD.
 	 */
 	ebx = ecx = edx = 0;
-	__get_cpuid(0x80000000, &max_level, &ebx, &ecx, &edx);
+	__get_cpuid(0x80000000, &max_extended_level, &ebx, &ecx, &edx);
 
-	if (max_level >= 0x80000007) {
+	if (max_extended_level >= 0x80000007) {
 
 		/*
 		 * Non-Stop TSC is advertised by CPUID.EAX=0x80000007: EDX.bit8
@@ -2765,7 +2765,7 @@ void process_cpuid()
 	if (debug)
 		decode_misc_enable_msr();
 
-	if (max_level > 0x15) {
+	if (max_level >= 0x15) {
 		unsigned int eax_crystal;
 		unsigned int ebx_tsc;
 
@@ -2799,6 +2799,19 @@ void process_cpuid()
 			}
 		}
 	}
+	if (max_level >= 0x16) {
+		unsigned int base_mhz, max_mhz, bus_mhz, edx;
+
+		/*
+		 * CPUID 16H Base MHz, Max MHz, Bus MHz
+		 */
+		base_mhz = max_mhz = bus_mhz = edx = 0;
+
+		__get_cpuid(0x16, &base_mhz, &max_mhz, &bus_mhz, &edx);
+		if (debug)
+			fprintf(stderr, "CPUID(0x16): base_mhz: %d max_mhz: %d bus_mhz: %d\n",
+				base_mhz, max_mhz, bus_mhz);
+	}
 
 	if (has_aperf)
 		aperf_mperf_multiplier = get_aperf_mperf_multiplier(family, model);
@@ -3151,7 +3164,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(stderr, "turbostat version 4.8 26-Sep, 2015"
+	fprintf(stderr, "turbostat version 4.9 22 Nov, 2015"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.7.1.339.g0233b80

