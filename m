From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] thermal/powerclamp: add id for braswell cpu
Date: Thu,  4 Dec 2014 10:53:43 -0800
Message-ID: <1417719223-2890-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:13943 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbaLDSyU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 4 Dec 2014 13:54:20 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Braswell also has package C-states which can be used for idle
injection. This patch adds Braswell CPU ID in intel powerclamp
driver.
---
 drivers/thermal/intel_powerclamp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 95cb7fc..b46c706 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -689,6 +689,7 @@ static const struct x86_cpu_id intel_powerclamp_ids[] = {
 	{ X86_VENDOR_INTEL, 6, 0x3f},
 	{ X86_VENDOR_INTEL, 6, 0x45},
 	{ X86_VENDOR_INTEL, 6, 0x46},
+	{ X86_VENDOR_INTEL, 6, 0x4c},
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);
-- 
1.9.1

