From: Dasaratharaman Chandramouli
	<dasaratharaman.chandramouli@intel.com>
Subject: [PATCH] powercap / RAPL: Support Knights Landing
Date: Tue, 19 May 2015 15:37:49 -0700
Message-ID: <1432075069-18196-1-git-send-email-dasaratharaman.chandramouli@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64395 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbbESWZc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 May 2015 18:25:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan Jun <jacob.jun.pan@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nikhil Rao <nikhil.rao@intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>

This patch enables intel_rapl driver to run on the
next-generation Intel(R) Xeon Phi Microarchitecture
code named "Knights Landing"

Signed-off-by: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index fd24323..5796332 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1069,6 +1069,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(0x4A, rapl_defaults_atom),/* Tangier */
 	RAPL_CPU(0x56, rapl_defaults_core),/* Future Xeon */
 	RAPL_CPU(0x5A, rapl_defaults_atom),/* Annidale */
+	RAPL_CPU(0x57, rapl_defaults_hsw_server),/* Knights Landing */
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
-- 
1.8.1.5

