From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] powercap/rapl: add cpu id for broxton
Date: Mon, 23 Nov 2015 10:46:57 -0800
Message-ID: <1448304417-11023-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50214 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752947AbbKWSry (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Nov 2015 13:47:54 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Broxton is Atom based SoC which supports RAPL interface
that is compatible with Core.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 5efacd0..bfc353b 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1104,6 +1104,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(0x5A, rapl_defaults_ann),/* Annidale */
 	RAPL_CPU(0x5E, rapl_defaults_core),/* Skylake-H/S */
 	RAPL_CPU(0x57, rapl_defaults_hsw_server),/* Knights Landing */
+	RAPL_CPU(0x5C, rapl_defaults_core),/* Broxton */
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
-- 
1.9.1

