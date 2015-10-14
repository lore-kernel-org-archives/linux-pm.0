From: amy.l.wiles@intel.com
Subject: [PATCH 2/2] Enabled Broxton RAPL support
Date: Wed, 14 Oct 2015 08:09:15 -0700
Message-ID: <1444835355-26582-4-git-send-email-amy.l.wiles@intel.com>
References: <1444835355-26582-3-git-send-email-amy.l.wiles@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36840 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753937AbbJNWNU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Oct 2015 18:13:20 -0400
In-Reply-To: <1444835355-26582-3-git-send-email-amy.l.wiles@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, srinivas.pandruvada@intel.com, linux-pm@vger.kernel.org
Cc: Amy Wiles <amy.l.wiles@intel.com>

From: Amy Wiles <amy.l.wiles@intel.com>

Signed-off-by: Amy Wiles <amy.l.wiles@intel.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 5efacd0..cc97f08 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1102,6 +1102,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(0x4A, rapl_defaults_tng),/* Tangier */
 	RAPL_CPU(0x56, rapl_defaults_core),/* Future Xeon */
 	RAPL_CPU(0x5A, rapl_defaults_ann),/* Annidale */
+	RAPL_CPU(0X5C, rapl_defaults_core),/* Broxton */
 	RAPL_CPU(0x5E, rapl_defaults_core),/* Skylake-H/S */
 	RAPL_CPU(0x57, rapl_defaults_hsw_server),/* Knights Landing */
 	{}
-- 
1.9.1

