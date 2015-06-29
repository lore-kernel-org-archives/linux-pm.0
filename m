From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] thermal/powerclamp: add cpu id for denlow platform
Date: Mon, 29 Jun 2015 08:53:18 -0700
Message-ID: <1435593198-18550-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64471 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbbF2PyS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 29 Jun 2015 11:54:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Add support for Intel Denlow UP server platform.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/thermal/intel_powerclamp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 725718e..d534357 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -693,6 +693,7 @@ static const struct x86_cpu_id intel_powerclamp_ids[] __initconst = {
 	{ X86_VENDOR_INTEL, 6, 0x3f},
 	{ X86_VENDOR_INTEL, 6, 0x45},
 	{ X86_VENDOR_INTEL, 6, 0x46},
+	{ X86_VENDOR_INTEL, 6, 0x47},
 	{ X86_VENDOR_INTEL, 6, 0x4c},
 	{ X86_VENDOR_INTEL, 6, 0x4d},
 	{ X86_VENDOR_INTEL, 6, 0x4f},
-- 
1.9.1

