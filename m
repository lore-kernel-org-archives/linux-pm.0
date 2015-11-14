From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3] cpufreq: intel_pstate: wrong call to acpi_processor_unregister_performance
Date: Fri, 13 Nov 2015 17:17:01 -0800
Message-ID: <1447463821-14595-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1447463821-14595-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:2150 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573AbbKNBSe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 13 Nov 2015 20:18:34 -0500
In-Reply-To: <1447463821-14595-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When the no_acpi_perf is set to 1, that means that we haven't called
acpi_processor_register_performance(), so we shouldn't also call
acpi_processor_unregister_performance in intel_pstate_exit_perf_limits().

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 6ec39ef..bad1ee3 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -326,13 +326,9 @@ static int intel_pstate_init_perf_limits(struct cpufreq_policy *policy)
 
 static int intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
 {
-	struct cpudata *cpu;
-
 	if (!no_acpi_perf)
-		return 0;
+		acpi_processor_unregister_performance(policy->cpu);
 
-	cpu = all_cpu_data[policy->cpu];
-	acpi_processor_unregister_performance(policy->cpu);
 	return 0;
 }
 
-- 
2.4.3

