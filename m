From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [UPDATE][PATCH] cpufreq: intel_pstate: Remove PID debugfs when not used
Date: Fri, 21 Oct 2016 09:38:20 -0700
Message-ID: <1477067900-31244-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:64995 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935664AbcJUQig (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Oct 2016 12:38:36 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

When target state is calculated using get_target_pstate_use_cpu_load(),
PID controller is not used, hence it has no effect on performance.
So don't present debugfs entries to tune PID controller.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
update:
Moved the check to the intel_pstate_debug_expose_params() as hwp_active
was already getting checked for not presenting debugfs.

 drivers/cpufreq/intel_pstate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 52cedd6..165c2d5 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -636,8 +636,10 @@ static void __init intel_pstate_debug_expose_params(void)
 	struct dentry *debugfs_parent;
 	int i = 0;
 
-	if (hwp_active)
+	if (hwp_active || pstate_funcs.get_target_pstate ==
+	    get_target_pstate_use_cpu_load)
 		return;
+
 	debugfs_parent = debugfs_create_dir("pstate_snb", NULL);
 	if (IS_ERR_OR_NULL(debugfs_parent))
 		return;
-- 
2.7.4

