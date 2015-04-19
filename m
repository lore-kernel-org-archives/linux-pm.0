From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/12] tools/power turbostat: update PERF_LIMIT_REASONS decoding
Date: Sat, 18 Apr 2015 20:40:17 -0400
Message-ID: <e33cbe852de48c313a8a52686765c58a711dd9e4.1429402554.git.len.brown@intel.com>
References: <1429404027-23203-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36395 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbbDSAkq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Apr 2015 20:40:46 -0400
Received: by qku63 with SMTP id 63so173261871qku.3
        for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2015 17:40:45 -0700 (PDT)
In-Reply-To: <1429404027-23203-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
References: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

cosmetic only.

order the decoding of MSR_PERF_LIMIT_REASONS bits
from MSB to LSB -- which you notice when more than 1 bit is set
and you are, say, comparing the output to the documentation...

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 52 +++++++++++++++++------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1bc6e6c..50ef857 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1700,35 +1700,35 @@ int print_perf_limit(struct thread_data *t, struct core_data *c, struct pkg_data
 		get_msr(cpu, MSR_CORE_PERF_LIMIT_REASONS, &msr);
 		fprintf(stderr, "cpu%d: MSR_CORE_PERF_LIMIT_REASONS, 0x%08llx", cpu, msr);
 		fprintf(stderr, " (Active: %s%s%s%s%s%s%s%s%s%s%s%s%s%s)",
-			(msr & 1 << 0) ? "PROCHOT, " : "",
-			(msr & 1 << 1) ? "ThermStatus, " : "",
-			(msr & 1 << 2) ? "bit2, " : "",
-			(msr & 1 << 4) ? "Graphics, " : "",
-			(msr & 1 << 5) ? "Auto-HWP, " : "",
-			(msr & 1 << 6) ? "VR-Therm, " : "",
-			(msr & 1 << 8) ? "Amps, " : "",
-			(msr & 1 << 9) ? "CorePwr, " : "",
-			(msr & 1 << 10) ? "PkgPwrL1, " : "",
-			(msr & 1 << 11) ? "PkgPwrL2, " : "",
-			(msr & 1 << 12) ? "MultiCoreTurbo, " : "",
-			(msr & 1 << 13) ? "Transitions, " : "",
+			(msr & 1 << 15) ? "bit15, " : "",
 			(msr & 1 << 14) ? "bit14, " : "",
-			(msr & 1 << 15) ? "bit15, " : "");
+			(msr & 1 << 13) ? "Transitions, " : "",
+			(msr & 1 << 12) ? "MultiCoreTurbo, " : "",
+			(msr & 1 << 11) ? "PkgPwrL2, " : "",
+			(msr & 1 << 10) ? "PkgPwrL1, " : "",
+			(msr & 1 << 9) ? "CorePwr, " : "",
+			(msr & 1 << 8) ? "Amps, " : "",
+			(msr & 1 << 6) ? "VR-Therm, " : "",
+			(msr & 1 << 5) ? "Auto-HWP, " : "",
+			(msr & 1 << 4) ? "Graphics, " : "",
+			(msr & 1 << 2) ? "bit2, " : "",
+			(msr & 1 << 1) ? "ThermStatus, " : "",
+			(msr & 1 << 0) ? "PROCHOT, " : "");
 		fprintf(stderr, " (Logged: %s%s%s%s%s%s%s%s%s%s%s%s%s%s)\n",
-			(msr & 1 << 16) ? "PROCHOT, " : "",
-			(msr & 1 << 17) ? "ThermStatus, " : "",
-			(msr & 1 << 18) ? "bit18, " : "",
-			(msr & 1 << 20) ? "Graphics, " : "",
-			(msr & 1 << 21) ? "Auto-HWP, " : "",
-			(msr & 1 << 22) ? "VR-Therm, " : "",
-			(msr & 1 << 24) ? "Amps, " : "",
-			(msr & 1 << 25) ? "CorePwr, " : "",
-			(msr & 1 << 26) ? "PkgPwrL1, " : "",
-			(msr & 1 << 27) ? "PkgPwrL2, " : "",
-			(msr & 1 << 28) ? "MultiCoreTurbo, " : "",
-			(msr & 1 << 29) ? "Transitions, " : "",
+			(msr & 1 << 31) ? "bit31, " : "",
 			(msr & 1 << 30) ? "bit30, " : "",
-			(msr & 1 << 31) ? "bit31, " : "");
+			(msr & 1 << 29) ? "Transitions, " : "",
+			(msr & 1 << 28) ? "MultiCoreTurbo, " : "",
+			(msr & 1 << 27) ? "PkgPwrL2, " : "",
+			(msr & 1 << 26) ? "PkgPwrL1, " : "",
+			(msr & 1 << 25) ? "CorePwr, " : "",
+			(msr & 1 << 24) ? "Amps, " : "",
+			(msr & 1 << 22) ? "VR-Therm, " : "",
+			(msr & 1 << 21) ? "Auto-HWP, " : "",
+			(msr & 1 << 20) ? "Graphics, " : "",
+			(msr & 1 << 18) ? "bit18, " : "",
+			(msr & 1 << 17) ? "ThermStatus, " : "",
+			(msr & 1 << 16) ? "PROCHOT, " : "");
 
 	}
 	if (do_gfx_perf_limit_reasons) {
-- 
2.4.0.rc1

