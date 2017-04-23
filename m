From: "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH] powercap/intel_rapl: Add support for Gemini Lake
Date: Sun, 23 Apr 2017 07:15:20 -0700
Message-ID: <20170423141520.7517-1-david.e.box@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33389 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1045525AbdDWOPV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 23 Apr 2017 10:15:21 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, jacob.jun.pan@linux.intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Box, David E" <david.e.box@intel.com>

Gemini Lake RAPL support is similar to Goldmont.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 9a25110..9ddad08 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1164,6 +1164,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(INTEL_FAM6_ATOM_MERRIFIELD,	rapl_defaults_tng),
 	RAPL_CPU(INTEL_FAM6_ATOM_MOOREFIELD,	rapl_defaults_ann),
 	RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_ATOM_GEMINI_LAKE,	rapl_defaults_core),
 	RAPL_CPU(INTEL_FAM6_ATOM_DENVERTON,	rapl_defaults_core),
 
 	RAPL_CPU(INTEL_FAM6_XEON_PHI_KNL,	rapl_defaults_hsw_server),
-- 
2.9.3
