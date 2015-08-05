From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] intel_pstate: Add SKY-S support
Date: Wed,  5 Aug 2015 12:47:14 -0700
Message-ID: <1438804034-20237-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37845 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542AbbHETrO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 5 Aug 2015 15:47:14 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

Whitelist the SKL-S processor

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 429ee27..8759fa2 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1007,6 +1007,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(0x4c, byt_params),
 	ICPU(0x4e, core_params),
 	ICPU(0x4f, core_params),
+	ICPU(0x5e, core_params),
 	ICPU(0x56, core_params),
 	ICPU(0x57, knl_params),
 	{}
-- 
2.4.3

