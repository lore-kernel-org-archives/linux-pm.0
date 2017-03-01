From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/44] tools/power turbostat: add precision to --debug frequency output
Date: Wed,  1 Mar 2017 00:27:16 -0500
Message-ID: <710f273ba96182fd93ee8540ae06583c7d889d7c.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34056 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdCAF5T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 00:57:19 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Add a digit of precision to the --debug output for frequency range.
This is useful when BCLK is not an integer.

old:
6 * 83 = 500 MHz max efficiency frequency
26 * 83 = 2166 MHz base frequency

new:
6 * 83.3 = 499.8 MHz max efficiency frequency
26 * 83.3 = 2165.8 MHz base frequency

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 42 +++++++++++++++++------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 19802be6dc02..762b81497c3b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1581,11 +1581,11 @@ dump_nhm_platform_info(void)
 	fprintf(outf, "cpu%d: MSR_PLATFORM_INFO: 0x%08llx\n", base_cpu, msr);
 
 	ratio = (msr >> 40) & 0xFF;
-	fprintf(outf, "%d * %.0f = %.0f MHz max efficiency frequency\n",
+	fprintf(outf, "%d * %.1f = %.1f MHz max efficiency frequency\n",
 		ratio, bclk, ratio * bclk);
 
 	ratio = (msr >> 8) & 0xFF;
-	fprintf(outf, "%d * %.0f = %.0f MHz base frequency\n",
+	fprintf(outf, "%d * %.1f = %.1f MHz base frequency\n",
 		ratio, bclk, ratio * bclk);
 
 	get_msr(base_cpu, MSR_IA32_POWER_CTL, &msr);
@@ -1607,12 +1607,12 @@ dump_hsw_turbo_ratio_limits(void)
 
 	ratio = (msr >> 8) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 18 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 18 active cores\n",
 			ratio, bclk, ratio * bclk);
 
 	ratio = (msr >> 0) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 17 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 17 active cores\n",
 			ratio, bclk, ratio * bclk);
 	return;
 }
@@ -1629,42 +1629,42 @@ dump_ivt_turbo_ratio_limits(void)
 
 	ratio = (msr >> 56) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 16 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 16 active cores\n",
 			ratio, bclk, ratio * bclk);
 
 	ratio = (msr >> 48) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 15 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 15 active cores\n",
 			ratio, bclk, ratio * bclk);
 
 	ratio = (msr >> 40) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 14 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 14 active cores\n",
 			ratio, bclk, ratio * bclk);
 
 	ratio = (msr >> 32) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 13 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 13 active cores\n",
 			ratio, bclk, ratio * bclk);
 
 	ratio = (msr >> 24) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 12 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 12 active cores\n",
 			ratio, bclk, ratio * bclk);
 
 	ratio = (msr >> 16) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 11 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 11 active cores\n",
 			ratio, bclk, ratio * bclk);
 
 	ratio = (msr >> 8) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 10 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 10 active cores\n",
 			ratio, bclk, ratio * bclk);
 
 	ratio = (msr >> 0) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 9 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 9 active cores\n",
 			ratio, bclk, ratio * bclk);
 	return;
 }
@@ -1681,42 +1681,42 @@ dump_nhm_turbo_ratio_limits(void)
 
 	ratio = (msr >> 56) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 8 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 8 active cores\n",
 			ratio, bclk, ratio * bclk);
 
 	ratio = (msr >> 48) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 7 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 7 active cores\n",
 			ratio, bclk, ratio * bclk);
 
 	ratio = (msr >> 40) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 6 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 6 active cores\n",
 			ratio, bclk, ratio * bclk);
 
 	ratio = (msr >> 32) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 5 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 5 active cores\n",
 			ratio, bclk, ratio * bclk);
 
 	ratio = (msr >> 24) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 4 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 4 active cores\n",
 			ratio, bclk, ratio * bclk);
 
 	ratio = (msr >> 16) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 3 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 3 active cores\n",
 			ratio, bclk, ratio * bclk);
 
 	ratio = (msr >> 8) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 2 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 2 active cores\n",
 			ratio, bclk, ratio * bclk);
 
 	ratio = (msr >> 0) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.0f = %.0f MHz max turbo 1 active cores\n",
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 1 active cores\n",
 			ratio, bclk, ratio * bclk);
 	return;
 }
@@ -1776,7 +1776,7 @@ dump_knl_turbo_ratio_limits(void)
 	for (i = buckets_no - 1; i >= 0; i--)
 		if (i > 0 ? ratio[i] != ratio[i - 1] : 1)
 			fprintf(outf,
-				"%d * %.0f = %.0f MHz max turbo %d active cores\n",
+				"%d * %.1f = %.1f MHz max turbo %d active cores\n",
 				ratio[i], bclk, ratio[i] * bclk, cores[i]);
 }
 
-- 
2.11.0.161.g6610af872
