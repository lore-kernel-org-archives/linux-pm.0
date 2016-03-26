From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] powercap: intel_rapl: Add missing Haswell model
Date: Sat, 26 Mar 2016 05:03:38 -0700
Message-ID: <1458993818-19387-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:26881 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263AbcCZMGo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 26 Mar 2016 08:06:44 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added missing model 0x46.

Tested-and-reported-by: Piotr Maksymiuk <piotr.maksymiuk@movishell.pl>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 2c0235d..769a803 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1105,6 +1105,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(0x3f, rapl_defaults_hsw_server),/* Haswell servers */
 	RAPL_CPU(0x4f, rapl_defaults_hsw_server),/* Broadwell servers */
 	RAPL_CPU(0x45, rapl_defaults_core),/* Haswell ULT */
+	RAPL_CPU(0x46, rapl_defaults_core),/* Haswell */
 	RAPL_CPU(0x47, rapl_defaults_core),/* Broadwell-H */
 	RAPL_CPU(0x4E, rapl_defaults_core),/* Skylake */
 	RAPL_CPU(0x4C, rapl_defaults_cht),/* Braswell/Cherryview */
-- 
1.9.1

