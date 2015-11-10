From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] cpufreq: intel_pstate: wrong flag checking for no_acpi_perf
Date: Mon,  9 Nov 2015 18:58:10 -0800
Message-ID: <1447124291-14059-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1447124291-14059-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48368 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbbKJC7E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Nov 2015 21:59:04 -0500
In-Reply-To: <1447124291-14059-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, lenlenb@kernel.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The checking of no_acpi_perf flag is wrong. Since there is null
check in acpi_processor_unregister_performance this doesn't cause
any issue when this flag is 0.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index a0b8180..69dc9b5 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -328,7 +328,7 @@ static int intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu;
 
-	if (!no_acpi_perf)
+	if (no_acpi_perf)
 		return 0;
 
 	cpu = all_cpu_data[policy->cpu];
-- 
1.9.3

