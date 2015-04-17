From: Dasaratharaman Chandramouli
	<dasaratharaman.chandramouli@intel.com>
Subject: [PATCH] intel powerclamp: support Knights Landing
Date: Fri, 17 Apr 2015 15:31:06 -0700
Message-ID: <1429309866-63063-1-git-send-email-dasaratharaman.chandramouli@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:15255 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669AbbDQWbZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 Apr 2015 18:31:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan Jun <jacob.jun.pan@intel.com>
Cc: Nikhil Rao <nikhil.rao@intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>

This patch enables intel_powerclamp driver to run on the
next-generation Intel(R) Xeon Phi Microarchitecture
code named "Knights Landing"

Signed-off-by: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
---
 drivers/thermal/intel_powerclamp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 12623bc..e34ccd5 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -690,6 +690,7 @@ static const struct x86_cpu_id intel_powerclamp_ids[] = {
 	{ X86_VENDOR_INTEL, 6, 0x4c},
 	{ X86_VENDOR_INTEL, 6, 0x4d},
 	{ X86_VENDOR_INTEL, 6, 0x56},
+	{ X86_VENDOR_INTEL, 6, 0x57},
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_powerclamp_ids);
-- 
1.8.1.5

