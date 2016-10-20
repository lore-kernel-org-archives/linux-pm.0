From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] cpufreq: intel_pstate: Remove PID debugfs when not used
Date: Thu, 20 Oct 2016 13:37:05 -0700
Message-ID: <1476995826-15536-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1476995826-15536-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:21280 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755189AbcJTUhW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Oct 2016 16:37:22 -0400
In-Reply-To: <1476995826-15536-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When target state is calculated using get_target_pstate_use_cpu_load(),
PID controller is not used, hence it has no effect on performance.
So don't present debugfs entries to tune PID controller.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 52cedd6..5725b85 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1844,7 +1844,9 @@ static int __init intel_pstate_init(void)
 	if (rc)
 		goto out;
 
-	intel_pstate_debug_expose_params();
+	if (pstate_funcs.get_target_pstate != get_target_pstate_use_cpu_load)
+		intel_pstate_debug_expose_params();
+
 	intel_pstate_sysfs_expose_params();
 
 	if (hwp_active)
-- 
2.7.4

