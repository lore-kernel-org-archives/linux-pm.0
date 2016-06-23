From: Xiaolong Wang <xiaolong.wang@linux.intel.com>
Subject: [PATCH] powercap/intel_rapl: Add support for Ivy Bridge server
Date: Thu, 23 Jun 2016 15:33:24 +0800
Message-ID: <1466667204-26340-1-git-send-email-xiaolong.wang@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20464 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573AbcFWHoV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 23 Jun 2016 03:44:21 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: jacob.jun.pan@linux.intel.com, rjw@rjwysocki.net, Xiaolong Wang <xiaolong.wang@linux.intel.com>

It's confirmed that RAPL works as expected on Ivy Bridge servers.
Tested against processor: Intel(R) Xeon(R) CPU E5-2697 v2 @2.70GHz

Signed-off-by: Xiaolong Wang <xiaolong.wang@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 06d21e6..fbab29d 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1134,6 +1134,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(INTEL_FAM6_SANDYBRIDGE_X,	rapl_defaults_core),
 
 	RAPL_CPU(INTEL_FAM6_IVYBRIDGE,		rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_IVYBRIDGE_X,	rapl_defaults_core),
 
 	RAPL_CPU(INTEL_FAM6_HASWELL_CORE,	rapl_defaults_core),
 	RAPL_CPU(INTEL_FAM6_HASWELL_ULT,	rapl_defaults_core),
-- 
1.8.3.1

