From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/17] tools/power turbostat: Denverton uses a 25 MHz crystal, not 19.2 MHz
Date: Sat, 24 Dec 2016 15:53:43 -0500
Message-ID: <7268d407ad4c49fbd521fb2e2f675a447bfef472.1482612381.git.len.brown@intel.com>
References: <20161224205345.29129-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33553 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbcLXU4O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Dec 2016 15:56:14 -0500
Received: by mail-qt0-f195.google.com with SMTP id 41so9409537qtn.0
        for <linux-pm@vger.kernel.org>; Sat, 24 Dec 2016 12:56:13 -0800 (PST)
In-Reply-To: <20161224205345.29129-1-lenb@kernel.org>
In-Reply-To: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
References: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

This changes only the TSC frequency decoding line seen with --debug

old: TSC: 1382 MHz (19200000 Hz * 216 / 3 / 1000000)
new: TSC: 1800 MHz (25000000 Hz * 216 / 3 / 1000000)

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index cfdb574ea302..3708386531f2 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3315,10 +3315,10 @@ void process_cpuid()
 					crystal_hz = 24000000;	/* 24.0 MHz */
 					break;
 				case INTEL_FAM6_SKYLAKE_X:	/* SKX */
+				case INTEL_FAM6_ATOM_DENVERTON:	/* DNV */
 					crystal_hz = 25000000;	/* 25.0 MHz */
 					break;
 				case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
-				case INTEL_FAM6_ATOM_DENVERTON:	/* DNV */
 					crystal_hz = 19200000;	/* 19.2 MHz */
 					break;
 				default:
-- 
2.11.0.161.g6610af872

