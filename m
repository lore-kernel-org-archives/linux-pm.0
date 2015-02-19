From: Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>
Subject: [PATCH] thermal/intel_powerclamp: add id for Avoton SoC
Date: Thu, 19 Feb 2015 12:40:58 -0600
Message-ID: <1424371258-9531-1-git-send-email-miguel.bernal.marin@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12394 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107AbbBSSlc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 19 Feb 2015 13:41:32 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Jose Navarro <jose.navarro@intel.com>, Jose Carlos Venegas Munoz <jos.c.venegas.munoz@intel.com>, Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>

Enable Intel Powerclamp driver on Atom* Processor C2000 Product
Family for Microservers (Avoton). Avoton - SoCs for micro-servers
has package C-states which can be used for idle injection.

Reported-by: Jose Navarro <jose.navarro@intel.com>
Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Tested-by:  Jose Carlos Venegas Munoz <jos.c.venegas.munoz@intel.com>
Signed-off-by: Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>
---
 drivers/thermal/intel_powerclamp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 6ceebd6..12623bc 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -688,6 +688,7 @@ static const struct x86_cpu_id intel_powerclamp_ids[] = {
 	{ X86_VENDOR_INTEL, 6, 0x45},
 	{ X86_VENDOR_INTEL, 6, 0x46},
 	{ X86_VENDOR_INTEL, 6, 0x4c},
+	{ X86_VENDOR_INTEL, 6, 0x4d},
 	{ X86_VENDOR_INTEL, 6, 0x56},
 	{}
 };
-- 
2.3.0

