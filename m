From: Xiaolong Wang <xiaolong.wang@linux.intel.com>
Subject: [PATCH] tools/power/turbostat: add Denverton to has_snb_msr()
Date: Fri, 30 Sep 2016 17:53:40 +0800
Message-ID: <1475229220-4880-1-git-send-email-xiaolong.wang@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: len.brown@intel.com, jacob.jun.pan@linux.intel.com, Xiaolong Wang <xiaolong.wang@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Add Denverton to the group of SandyBridge and later processors,
to let the bclk be recognized as 100MHz rather than 133MHz,
then avoid the wrong value of the frequencies based on it,
including Bzy_MHz, max efficiency freuency, base frequency,
and turbo mode frequencies.

Signed-off-by: Xiaolong Wang <xiaolong.wang@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index aabc79c..1f09154 100644
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
1.8.3.1
