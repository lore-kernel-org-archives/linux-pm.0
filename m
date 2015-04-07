From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] thermal/intel_powerclamp: add id for broadwell server
Date: Tue,  7 Apr 2015 05:47:26 -0700
Message-ID: <1428410846-21067-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30791 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754002AbbDGMsV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Apr 2015 08:48:21 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Broadwell server has support for package C-states, idle injection works
as expected on this platform.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/thermal/intel_powerclamp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 12623bc..3e228d5 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -689,6 +689,7 @@ static const struct x86_cpu_id intel_powerclamp_ids[] = {
 	{ X86_VENDOR_INTEL, 6, 0x46},
 	{ X86_VENDOR_INTEL, 6, 0x4c},
 	{ X86_VENDOR_INTEL, 6, 0x4d},
+	{ X86_VENDOR_INTEL, 6, 0x4f},
 	{ X86_VENDOR_INTEL, 6, 0x56},
 	{}
 };
-- 
1.9.1

