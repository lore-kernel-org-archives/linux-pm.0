From: "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH] x86/intel_idle: add GLK support
Date: Sat, 22 Apr 2017 23:06:25 -0700
Message-ID: <20170423060625.4593-1-david.e.box@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:14997 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1427568AbdDWGG2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 23 Apr 2017 02:06:28 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lenb@kernel.org, jacob.jun.pan@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

From: "Box, David E" <david.e.box@intel.com>

Gemini Lake uses the same C-states as Broxton and also uses the
IRTL MSR's to determine maximum C-state latency.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/idle/intel_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index e045a5c..778af71 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1097,6 +1097,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(INTEL_FAM6_XEON_PHI_KNL,		idle_cpu_knl),
 	ICPU(INTEL_FAM6_XEON_PHI_KNM,		idle_cpu_knl),
 	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		idle_cpu_bxt),
+	ICPU(INTEL_FAM6_ATOM_GEMINI_LAKE,	idle_cpu_bxt),
 	ICPU(INTEL_FAM6_ATOM_DENVERTON,		idle_cpu_dnv),
 	{}
 };
@@ -1309,6 +1310,7 @@ static void intel_idle_state_table_update(void)
 		ivt_idle_state_table_update();
 		break;
 	case INTEL_FAM6_ATOM_GOLDMONT:
+	case INTEL_FAM6_ATOM_GEMINI_LAKE:
 		bxt_idle_state_table_update();
 		break;
 	case INTEL_FAM6_SKYLAKE_DESKTOP:
-- 
2.9.3
