From: Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com>
Subject: [PATCH 1/4] powercap / RAPL: Add support for Skylake H/S
Date: Fri, 31 Jul 2015 08:07:10 -0700
Message-ID: <1438355230-124417-1-git-send-email-radivoje.jovanovic@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753179AbbGaPKH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 31 Jul 2015 11:10:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Radivoje Jovanovic <radivoje.jovanovic@intel.com>

From: Radivoje Jovanovic <radivoje.jovanovic@intel.com>

This patche enabled RAPL to support Intel Skylake H/S

Signed-off-by: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 482b22d..bca9620 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1101,6 +1101,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(0x4A, rapl_defaults_tng),/* Tangier */
 	RAPL_CPU(0x56, rapl_defaults_core),/* Future Xeon */
 	RAPL_CPU(0x5A, rapl_defaults_ann),/* Annidale */
+	RAPL_CPU(0x5E, rapl_defaults_core),/* Skylake-H/S */
 	RAPL_CPU(0x57, rapl_defaults_hsw_server),/* Knights Landing */
 	{}
 };
-- 
1.9.1

