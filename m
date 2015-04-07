From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] powercap/rapl: add id for broadwell server
Date: Tue,  7 Apr 2015 05:50:35 -0700
Message-ID: <1428411035-21174-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55676 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753496AbbDGMve (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Apr 2015 08:51:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Validated RAPL functions on this platform. Add support to driver.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 63d4033..678ac8c 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1062,6 +1062,7 @@ static const struct x86_cpu_id rapl_ids[] = {
 	RAPL_CPU(0x3c, rapl_defaults_core),/* Haswell */
 	RAPL_CPU(0x3d, rapl_defaults_core),/* Broadwell */
 	RAPL_CPU(0x3f, rapl_defaults_hsw_server),/* Haswell servers */
+	RAPL_CPU(0x4f, rapl_defaults_hsw_server),/* Broadwell servers */
 	RAPL_CPU(0x45, rapl_defaults_core),/* Haswell ULT */
 	RAPL_CPU(0x4C, rapl_defaults_atom),/* Braswell */
 	RAPL_CPU(0x4A, rapl_defaults_atom),/* Tangier */
-- 
1.9.1

