From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/16] tools/power turbostat: Intel Xeon x200: fix turbo-ratio decoding
Date: Sat, 27 Feb 2016 04:01:02 -0500
Message-ID: <5a6de6ec9c492d52fd261e2c584361108e951b0d.1456563103.git.len.brown@intel.com>
References: <1456563670-23282-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f194.google.com ([209.85.160.194]:34219 "EHLO
	mail-yk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756219AbcB0JB6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 04:01:58 -0500
Received: by mail-yk0-f194.google.com with SMTP id z7so2782451yka.1
        for <linux-pm@vger.kernel.org>; Sat, 27 Feb 2016 01:01:57 -0800 (PST)
In-Reply-To: <1456563670-23282-1-git-send-email-lenb@kernel.org>
In-Reply-To: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
References: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>, Len Brown <len.brown@intel.com>

From: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>

Following changes have been made:
- changed MSR_NHM_TURBO_RATIO_LIMIT to MSR_TURBO_RATIO_LIMIT in debug print
  for consistency with Developer Manual
- updated definition of bitfields in MSR_TURBO_RATIO_LIMIT and appropriate
  parsing code
- added x200 to list of architectures that do not support Nahlem compatible
  definition of MSR_TURBO_RATIO_LIMIT register (x200 has the register but
  bits definition is custom)
- fixed typo in code that parses MSR_TURBO_RATIO_LIMIT
  (logical instead of bitwise operator)
- changed MSR_TURBO_RATIO_LIMIT parsing algorithm so the print out had the
  same order as implementations for other platforms

Signed-off-by: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 53 +++++++++++++++++------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 652d08d..4e5386d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1328,21 +1328,23 @@ dump_nhm_turbo_ratio_limits(void)
 static void
 dump_knl_turbo_ratio_limits(void)
 {
-	int cores;
-	unsigned int ratio;
+	const unsigned int buckets_no = 7;
+
 	unsigned long long msr;
-	int delta_cores;
-	int delta_ratio;
-	int i;
+	int delta_cores, delta_ratio;
+	int i, b_nr;
+	unsigned int cores[buckets_no];
+	unsigned int ratio[buckets_no];
 
 	get_msr(base_cpu, MSR_NHM_TURBO_RATIO_LIMIT, &msr);
 
-	fprintf(stderr, "cpu%d: MSR_NHM_TURBO_RATIO_LIMIT: 0x%08llx\n",
+	fprintf(stderr, "cpu%d: MSR_TURBO_RATIO_LIMIT: 0x%08llx\n",
 		base_cpu, msr);
 
 	/**
 	 * Turbo encoding in KNL is as follows:
-	 * [7:0] -- Base value of number of active cores of bucket 1.
+	 * [0] -- Reserved
+	 * [7:1] -- Base value of number of active cores of bucket 1.
 	 * [15:8] -- Base value of freq ratio of bucket 1.
 	 * [20:16] -- +ve delta of number of active cores of bucket 2.
 	 * i.e. active cores of bucket 2 =
@@ -1361,29 +1363,25 @@ dump_knl_turbo_ratio_limits(void)
 	 * [60:56]-- +ve delta of number of active cores of bucket 7.
 	 * [63:61]-- -ve delta of freq ratio of bucket 7.
 	 */
-	cores = msr & 0xFF;
-	ratio = (msr >> 8) && 0xFF;
-	if (ratio > 0)
-		fprintf(stderr,
-			"%d * %.0f = %.0f MHz max turbo %d active cores\n",
-			ratio, bclk, ratio * bclk, cores);
-
-	for (i = 16; i < 64; i = i + 8) {
+
+	b_nr = 0;
+	cores[b_nr] = (msr & 0xFF) >> 1;
+	ratio[b_nr] = (msr >> 8) & 0xFF;
+
+	for (i = 16; i < 64; i += 8) {
 		delta_cores = (msr >> i) & 0x1F;
-		delta_ratio = (msr >> (i + 5)) && 0x7;
-		if (!delta_cores || !delta_ratio)
-			return;
-		cores = cores + delta_cores;
-		ratio = ratio - delta_ratio;
-
-		/** -ve ratios will make successive ratio calculations
-		 * negative. Hence return instead of carrying on.
-		 */
-		if (ratio > 0)
+		delta_ratio = (msr >> (i + 5)) & 0x7;
+
+		cores[b_nr + 1] = cores[b_nr] + delta_cores;
+		ratio[b_nr + 1] = ratio[b_nr] - delta_ratio;
+		b_nr++;
+	}
+
+	for (i = buckets_no - 1; i >= 0; i--)
+		if (i > 0 ? ratio[i] != ratio[i - 1] : 1)
 			fprintf(stderr,
 				"%d * %.0f = %.0f MHz max turbo %d active cores\n",
-				ratio, bclk, ratio * bclk, cores);
-	}
+				ratio[i], bclk, ratio[i] * bclk, cores[i]);
 }
 
 static void
@@ -1896,6 +1894,7 @@ int has_nhm_turbo_ratio_limit(unsigned int family, unsigned int model)
 	/* Nehalem compatible, but do not include turbo-ratio limit support */
 	case 0x2E:	/* Nehalem-EX Xeon - Beckton */
 	case 0x2F:	/* Westmere-EX Xeon - Eagleton */
+	case 0x57:	/* PHI - Knights Landing (different MSR definition) */
 		return 0;
 	default:
 		return 1;
-- 
2.7.1.339.g0233b80

