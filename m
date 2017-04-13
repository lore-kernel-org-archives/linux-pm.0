From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/7] tools/power turbostat: update HWP dump to decimal from hex
Date: Wed, 12 Apr 2017 20:08:50 -0400
Message-ID: <6dbd25a24599db07d88a805615bad1f4d48a5749.1492041840.git.len.brown@intel.com>
References: <20170413000853.21648-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35971 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755855AbdDMAJc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2017 20:09:32 -0400
In-Reply-To: <20170413000853.21648-1-lenb@kernel.org>
In-Reply-To: <22048c5485503749754b3b5daf9d99ef89fcacdc.1492041840.git.len.brown@intel.com>
References: <22048c5485503749754b3b5daf9d99ef89fcacdc.1492041840.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Syntax only.

The HWP CAPABILTIES and REQUEST ratios are more easily
viewed in decimal -- just multiply by 100 and you get MHz...

new:
cpu0: MSR_HWP_CAPABILITIES: 0x010c1b23 (high 35 guar 27 eff 12 low 1)
cpu0: MSR_HWP_REQUEST: 0x80002301 (min 1 max 35 des 0 epp 0x80 window 0x0 pkg 0x0)

old:
cpu0: MSR_HWP_CAPABILITIES: 0x010c1b23 (high 0x23 guar 0x1b eff 0xc low 0x1)
cpu0: MSR_HWP_REQUEST: 0x80002301 (min 0x1 max 0x23 des 0x0 epp 0x80 window 0x0 pkg 0x0)

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index e95799966560..b0591d0da801 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3113,7 +3113,7 @@ int print_hwp(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		return 0;
 
 	fprintf(outf, "cpu%d: MSR_HWP_CAPABILITIES: 0x%08llx "
-			"(high 0x%x guar 0x%x eff 0x%x low 0x%x)\n",
+			"(high %d guar %d eff %d low %d)\n",
 			cpu, msr,
 			(unsigned int)HWP_HIGHEST_PERF(msr),
 			(unsigned int)HWP_GUARANTEED_PERF(msr),
@@ -3124,7 +3124,7 @@ int print_hwp(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		return 0;
 
 	fprintf(outf, "cpu%d: MSR_HWP_REQUEST: 0x%08llx "
-			"(min 0x%x max 0x%x des 0x%x epp 0x%x window 0x%x pkg 0x%x)\n",
+			"(min %d max %d des %d epp 0x%x window 0x%x pkg 0x%x)\n",
 			cpu, msr,
 			(unsigned int)(((msr) >> 0) & 0xff),
 			(unsigned int)(((msr) >> 8) & 0xff),
@@ -3138,7 +3138,7 @@ int print_hwp(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 			return 0;
 
 		fprintf(outf, "cpu%d: MSR_HWP_REQUEST_PKG: 0x%08llx "
-			"(min 0x%x max 0x%x des 0x%x epp 0x%x window 0x%x)\n",
+			"(min %d max %d des %d epp 0x%x window 0x%x)\n",
 			cpu, msr,
 			(unsigned int)(((msr) >> 0) & 0xff),
 			(unsigned int)(((msr) >> 8) & 0xff),
-- 
2.11.0.161.g6610af872
