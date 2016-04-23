From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix processing for turbo activation ratio
Date: Fri, 22 Apr 2016 19:53:59 -0700
Message-ID: <1461380039-13804-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:15325 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbcDWDA3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Apr 2016 23:00:29 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When the config TDP level is not nominal (level = 0), the MSR values for
reading level 1 and level 2 ratios contain power in low 14 bits and actual
ratio bits are at bits [23:16]. The current processing for level 1 and
level 2 is wrong as there is no shift done to get actual ratio.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1b2767d..03f94c2 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -813,6 +813,10 @@ static int core_get_max_pstate(void)
 			if (err)
 				goto skip_tar;
 
+			/* For level 1 and 2, bits[23:16] contains ratio */
+			if (tdp_ctrl)
+				tdp_ratio >>= 16;
+			tdp_ratio &= 0xff; /* ratios are only 8 bits long */
 			if (tdp_ratio - 1 == tar) {
 				max_pstate = tar;
 				pr_debug("max_pstate=TAC %x\n", max_pstate);
-- 
2.5.0

