From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] intel_pstate: Add support for SKL
Date: Wed, 28 Jan 2015 13:53:28 -0800
Message-ID: <1422482008-16896-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44372 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830AbbA2BSN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 Jan 2015 20:18:13 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

Add SKL cpuid

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 742eefb..7d9f822 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -825,6 +825,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(0x46, core_params),
 	ICPU(0x47, core_params),
 	ICPU(0x4c, byt_params),
+	ICPU(0x4e, core_params),
 	ICPU(0x4f, core_params),
 	ICPU(0x56, core_params),
 	{}
-- 
1.9.3

