From: amy.l.wiles@intel.com
Subject: [PATCH] The x86 cpu RAPL id was added in to support BXT core
Date: Tue, 13 Oct 2015 08:59:23 -0700
Message-ID: <1444751963-23743-1-git-send-email-amy.l.wiles@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:62582 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbbJMXDZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Oct 2015 19:03:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, srinivas.pandruvada@intel.com, linux-pm@vger.kernel.org
Cc: Amy Wiles <amy.l.wiles@intel.com>

From: Amy Wiles <amy.l.wiles@intel.com>

BUG=None
TEST=Navigate to /sys/class/powercap and check that the directory intel-rapl:0 is present

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

