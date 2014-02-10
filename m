From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/2] powercap/intel_rapl: relax sanity check on energy counters
Date: Mon, 10 Feb 2014 06:11:51 -0800
Message-ID: <1392041512-15769-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37364 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbaBJWLX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 10 Feb 2014 17:11:23 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: vince@deater.net, Jacob Pan <jacob.jun.pan@linux.intel.com>

Some RAPL domains may not be active at the time driver is being
loaded. Checking energy counter increment may be too
strict and time consuming. So relax the sanity check on energy
counters of these domains.
Otherwise, they may be ignored and become unavailable to the
powercap framework.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 3c67683..0e37fe1 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1147,6 +1147,11 @@ static int rapl_check_domain(int cpu, int domain)
 	if (rdmsrl_safe_on_cpu(cpu, msr, &val1))
 		return -ENODEV;
 
+	/* PP1/uncore/graphics domain may not be active at the time of
+	 * driver loading. So skip further checks.
+	 */
+	if (domain == RAPL_DOMAIN_PP1)
+		return 0;
 	/* energy counters roll slowly on some domains */
 	while (++retry < 10) {
 		usleep_range(10000, 15000);
-- 
1.8.1.2

