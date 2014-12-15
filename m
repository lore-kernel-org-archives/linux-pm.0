From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/2] powercap/rapl: add ids for future xeon cpus
Date: Mon, 15 Dec 2014 10:14:15 -0800
Message-ID: <1418667255-8804-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32153 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbaLOSSK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Dec 2014 13:18:10 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Enable RAPL driver on Xeon cpu id 0x56.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index c71443c..ee00ffb 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1041,6 +1041,7 @@ static const struct x86_cpu_id rapl_ids[] = {
 	RAPL_CPU(0x45, rapl_defaults_core),/* Haswell ULT */
 	RAPL_CPU(0x4C, rapl_defaults_atom),/* Braswell */
 	RAPL_CPU(0x4A, rapl_defaults_atom),/* Tangier */
+	RAPL_CPU(0x56, rapl_defaults_atom),/* Future Xeon */
 	RAPL_CPU(0x5A, rapl_defaults_atom),/* Annidale */
 	{}
 };
-- 
1.9.1

