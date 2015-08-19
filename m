From: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
Subject: [PATCH] powercap / RAPL: disable the 2nd power limit properly
Date: Wed, 19 Aug 2015 14:26:03 +0900
Message-ID: <55D4136B.80402@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40]:26557 "EHLO
	mgwym01.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbbHSFkd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2015 01:40:33 -0400
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
	by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id DF680AC03A5
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2015 14:30:16 +0900 (JST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-pm@vger.kernel.org

Let rapl_unregister_powercap() disable the second power limit
only if it exists.
Intel64 SDM Vol.3 14.9 says that the package domain has it
but neither the power plane domain nor the DRAM domain has it.

Signed-off-by: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>

---
 drivers/powercap/intel_rapl.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 482b22d..314fb5c 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1145,9 +1145,11 @@ static int rapl_unregister_powercap(void)
 			pr_debug("remove package, undo power limit on %d: %s\n",
 				rp->id, rd->name);
 			rapl_write_data_raw(rd, PL1_ENABLE, 0);
-			rapl_write_data_raw(rd, PL2_ENABLE, 0);
 			rapl_write_data_raw(rd, PL1_CLAMP, 0);
-			rapl_write_data_raw(rd, PL2_CLAMP, 0);
+			if (find_nr_power_limit(rd) > 1) {
+				rapl_write_data_raw(rd, PL2_ENABLE, 0);
+				rapl_write_data_raw(rd, PL2_CLAMP, 0);
+			}
 			if (rd->id == RAPL_DOMAIN_PACKAGE) {
 				rd_package = rd;
 				continue;
