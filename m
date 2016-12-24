From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/17] tools/power turbostat: Display HWP OOB status
Date: Sat, 24 Dec 2016 15:53:39 -0500
Message-ID: <ddadb8adea76e6168c55850f2066e441880fb3d5.1482612381.git.len.brown@intel.com>
References: <20161224205345.29129-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35660 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbcLXU4L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Dec 2016 15:56:11 -0500
Received: by mail-qk0-f196.google.com with SMTP id u25so21303431qki.2
        for <linux-pm@vger.kernel.org>; Sat, 24 Dec 2016 12:56:11 -0800 (PST)
In-Reply-To: <20161224205345.29129-1-lenb@kernel.org>
In-Reply-To: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
References: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Display if the HWP is enabled in OOB (Out of band) mode.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 89c31e90a85e..83d1fb9750aa 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3168,10 +3168,11 @@ void decode_misc_pwr_mgmt_msr(void)
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
2.11.0.161.g6610af872

