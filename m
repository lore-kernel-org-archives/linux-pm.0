From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/5] tools/power turbostat: correctly decode of ENERGY_PERFORMANCE_BIAS
Date: Wed, 27 May 2015 18:08:04 -0400
Message-ID: <e9be7dd62899194ebdd90d417fc6c07d5d157912.1432764245.git.len.brown@intel.com>
References: <1432764486-3517-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35318 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbbE0WIV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2015 18:08:21 -0400
Received: by qkdn188 with SMTP id n188so14417401qkd.2
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2015 15:08:20 -0700 (PDT)
In-Reply-To: <1432764486-3517-1-git-send-email-lenb@kernel.org>
In-Reply-To: <e275b3885dffd31095984ed2476ed0447fa7309a.1432764245.git.len.brown@intel.com>
References: <e275b3885dffd31095984ed2476ed0447fa7309a.1432764245.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

When EPB is 0xF, turbosat was incorrectly describing it as "custom"
instead of calling it "powersave":

< cpu0: MSR_IA32_ENERGY_PERF_BIAS: 0x0000000f (custom)
> cpu0: MSR_IA32_ENERGY_PERF_BIAS: 0x0000000f (powersave)

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 256a5e1..f92211e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1919,7 +1919,7 @@ int print_epb(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 	if (get_msr(cpu, MSR_IA32_ENERGY_PERF_BIAS, &msr))
 		return 0;
 
-	switch (msr & 0x7) {
+	switch (msr & 0xF) {
 	case ENERGY_PERF_BIAS_PERFORMANCE:
 		epb_string = "performance";
 		break;
-- 
2.4.1.314.g9532ead

