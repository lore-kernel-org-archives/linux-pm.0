From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Downgrade print level for _PPC
Date: Sun, 29 May 2016 23:31:23 -0700
Message-ID: <1464589883-29350-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58140 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753773AbcE3Gc0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 30 May 2016 02:32:26 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Downgrade pr_info to pr_debug for message
"_PPC limits will be enforced "
In server systems with many cores this message is annoying.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3a9c432..0d159b5 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -449,7 +449,7 @@ static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 		cpu->acpi_perf_data.states[0].core_frequency =
 					policy->cpuinfo.max_freq / 1000;
 	cpu->valid_pss_table = true;
-	pr_info("_PPC limits will be enforced\n");
+	pr_debug("_PPC limits will be enforced\n");
 
 	return;
 
-- 
2.5.0

