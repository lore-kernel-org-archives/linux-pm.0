From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/17] tools/power turbostat: fix Denverton BCLK
Date: Sat, 24 Dec 2016 15:53:38 -0500
Message-ID: <5bbac26eae35065a9b2a5279118daad14f88eae9.1482612381.git.len.brown@intel.com>
References: <20161224205345.29129-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34424 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbcLXU4K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Dec 2016 15:56:10 -0500
Received: by mail-qk0-f195.google.com with SMTP id t184so21764976qkd.1
        for <linux-pm@vger.kernel.org>; Sat, 24 Dec 2016 12:56:10 -0800 (PST)
In-Reply-To: <20161224205345.29129-1-lenb@kernel.org>
In-Reply-To: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
References: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Xiaolong Wang <xiaolong.wang@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Xiaolong Wang <xiaolong.wang@linux.intel.com>

Add Denverton to the group of SandyBridge and later processors,
to let the bclk be recognized as 100MHz rather than 133MHz,
then avoid the wrong value of the frequencies based on it,
including Bzy_MHz, max efficiency freuency, base frequency,
and turbo mode frequencies.

Signed-off-by: Xiaolong Wang <xiaolong.wang@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 2056c148c684..89c31e90a85e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2938,6 +2938,7 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_KABYLAKE_DESKTOP:	/* KBL */
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
+	case INTEL_FAM6_ATOM_DENVERTON:	/* DNV */
 		return 1;
 	}
 	return 0;
-- 
2.11.0.161.g6610af872

