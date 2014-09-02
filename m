From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] powercap/rapl: change domain detection message
Date: Tue,  2 Sep 2014 02:55:21 -0700
Message-ID: <1409651721-16746-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42811 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666AbaIBRyz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Sep 2014 13:54:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Many CPUs do not support complete set of RAPL domains, as a
result this detection failed message is very misleading and
can be annoying.

 [    5.082632] intel_rapl: RAPL domain core detection failed
 [    5.088370] intel_rapl: RAPL domain uncore detection failed

So lower the warning message to info and only print out the RAPL
domains that are supported.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index b1cda6f..d32b7a6 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1166,11 +1166,10 @@ static int rapl_detect_domains(struct rapl_package *rp, int cpu)
 
 	for (i = 0; i < RAPL_DOMAIN_MAX; i++) {
 		/* use physical package id to read counters */
-		if (!rapl_check_domain(cpu, i))
+		if (!rapl_check_domain(cpu, i)) {
 			rp->domain_map |= 1 << i;
-		else
-			pr_warn("RAPL domain %s detection failed\n",
-				rapl_domain_names[i]);
+			pr_info("Found RAPL domain %s\n", rapl_domain_names[i]);
+		}
 	}
 	rp->nr_domains = bitmap_weight(&rp->domain_map,	RAPL_DOMAIN_MAX);
 	if (!rp->nr_domains) {
-- 
2.0.0.5.gbce14aa

