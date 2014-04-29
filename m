From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] thermal/intel_powerclamp: add newer cpu ids
Date: Tue, 29 Apr 2014 00:35:54 -0700
Message-ID: <1398756954-26442-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37670 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbaD2PtV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 29 Apr 2014 11:49:21 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Add support for Broadwell and Valleyview CPUs

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/thermal/intel_powerclamp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index a084325..95cb7fc 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -681,8 +681,10 @@ static const struct x86_cpu_id intel_powerclamp_ids[] = {
 	{ X86_VENDOR_INTEL, 6, 0x2d},
 	{ X86_VENDOR_INTEL, 6, 0x2e},
 	{ X86_VENDOR_INTEL, 6, 0x2f},
+	{ X86_VENDOR_INTEL, 6, 0x37},
 	{ X86_VENDOR_INTEL, 6, 0x3a},
 	{ X86_VENDOR_INTEL, 6, 0x3c},
+	{ X86_VENDOR_INTEL, 6, 0x3d},
 	{ X86_VENDOR_INTEL, 6, 0x3e},
 	{ X86_VENDOR_INTEL, 6, 0x3f},
 	{ X86_VENDOR_INTEL, 6, 0x45},
-- 
1.8.1.2

