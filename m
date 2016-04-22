From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] powercap/intel_rapl: Add support for Kabylake
Date: Fri, 22 Apr 2016 10:17:19 -0700
Message-ID: <1461345439-21215-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54372 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932298AbcDVRSy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Apr 2016 13:18:54 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Kabylake is similar to Skylake in terms of RAPL.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 8fad0a7..470bb62 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1101,6 +1101,8 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(0X5C, rapl_defaults_core),/* Broxton */
 	RAPL_CPU(0x5E, rapl_defaults_core),/* Skylake-H/S */
 	RAPL_CPU(0x57, rapl_defaults_hsw_server),/* Knights Landing */
+	RAPL_CPU(0x8E, rapl_defaults_core),/* Kabylake */
+	RAPL_CPU(0x9E, rapl_defaults_core),/* Kabylake */
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
-- 
1.9.1

