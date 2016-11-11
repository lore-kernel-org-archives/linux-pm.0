From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [Update] [PATCH] tools/power turbostat: Display HWP OOB status
Date: Fri, 11 Nov 2016 14:29:48 -0800
Message-ID: <1478903388-52038-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57840 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938638AbcKKWaE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Nov 2016 17:30:04 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Display if the HWP is enabled in OOB (Out of band) mode.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
Update:
	Subject edited.

 tools/power/x86/turbostat/turbostat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 3e199b5..27fb0f0 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3174,10 +3174,11 @@ void decode_misc_pwr_mgmt_msr(void)
 		return;
 
 	if (!get_msr(base_cpu, MSR_MISC_PWR_MGMT, &msr))
-		fprintf(outf, "cpu%d: MSR_MISC_PWR_MGMT: 0x%08llx (%sable-EIST_Coordination %sable-EPB)\n",
+		fprintf(outf, "cpu%d: MSR_MISC_PWR_MGMT: 0x%08llx (%sable-EIST_Coordination %sable-EPB %sable-OOB)\n",
 			base_cpu, msr,
 			msr & (1 << 0) ? "DIS" : "EN",
-			msr & (1 << 1) ? "EN" : "DIS");
+			msr & (1 << 1) ? "EN" : "DIS",
+			msr & (1 << 8) ? "EN" : "DIS");
 }
 
 void process_cpuid()
-- 
2.7.4

