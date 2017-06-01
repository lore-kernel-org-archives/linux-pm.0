From: Adam Lessnau <adam.lessnau@intel.com>
Subject: [PATCH] powercap/rapl: prevent overridding bits outside of the mask
Date: Thu,  1 Jun 2017 11:21:50 +0200
Message-ID: <20170601092150.4474-1-adam.lessnau@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:4034 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751589AbdFAJWN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Jun 2017 05:22:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Adam Lessnau <adam.lessnau@intel.com>

Fixes wrong bits shift operation in the rapl_write_data_raw function, which
might cause overridding bits outside of the mask.

For example, writing new TIME_WINDOW1 value can override POWER_LIMIT1.

Signed-off-by: Adam Lessnau <adam.lessnau@intel.com>
---
 drivers/powercap/intel_rapl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 3c71f608b444..6dc27afb8527 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -887,7 +887,9 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 
 	cpu = rd->rp->lead_cpu;
 	bits = rapl_unit_xlate(rd, rp->unit, value, 1);
-	bits |= bits << rp->shift;
+	bits <<= rp->shift;
+	bits &= rp->mask;
+
 	memset(&ma, 0, sizeof(ma));
 
 	ma.msr_no = rd->msrs[rp->id];
-- 
2.13.0
