From: yu.c.chen@intel.com
Subject: [PATCH][RFC] cpufreq: intel_pstate: Avoid time-costly synchronization if schedutil is not enabled
Date: Tue, 10 May 2016 17:24:12 +0800
Message-ID: <1462872252-16152-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18988 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036AbcEJJRU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 10 May 2016 05:17:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

From: Chen Yu <yu.c.chen@intel.com>

Commit bb6ab52f2bef ("intel_pstate: Do not set utilization update
hook too early") moved the assignment of utilization update hook
from intel_pstate_init_cpu to intel_pstate_set_policy(), however
after moving, we need to leverage synchronize_sched() to deal
with synchronization, which is time-costly because it needs to
wait for all the CPUs to go through a grace period.

Actuall we don't need to synchronize_sched if schedutil has
not been enabled, which also can address the problem in our case,
thus bypass the synchronize_sched during bootup.

Fixes: bb6ab52f2bef "intel_pstate: Do not set utilization update hook too early"
Link: https://bugzilla.kernel.org/show_bug.cgi?id=116371
Tested-by: Tian Ye <yex.tian@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b230eba..9811e4e 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -162,6 +162,7 @@ struct _pid {
  * struct cpudata -	Per CPU instance data storage
  * @cpu:		CPU number for this instance data
  * @update_util:	CPUFreq utility callback information
+ * @update_util_set:	CPUFreq utility callback is set
  * @pstate:		Stores P state limits for this CPU
  * @vid:		Stores VID limits for this CPU
  * @pid:		Stores PID parameters for this CPU
@@ -179,6 +180,7 @@ struct cpudata {
 	int cpu;
 
 	struct update_util_data update_util;
+	bool   update_util_set;
 
 	struct pstate_data pstate;
 	struct vid_data vid;
@@ -1287,11 +1289,18 @@ static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
 	/* Prevent intel_pstate_update_util() from using stale data. */
 	cpu->sample.time = 0;
 	cpufreq_set_update_util_data(cpu_num, &cpu->update_util);
+	cpu->update_util_set = true;
 }
 
 static void intel_pstate_clear_update_util_hook(unsigned int cpu)
 {
+	struct cpudata *cpu_data = all_cpu_data[cpu];
+
+	if (!cpu_data->update_util_set)
+		return;
+
 	cpufreq_set_update_util_data(cpu, NULL);
+	cpu_data->update_util_set = false;
 	synchronize_sched();
 }
 
-- 
2.7.4

