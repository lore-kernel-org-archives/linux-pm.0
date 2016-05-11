From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v2] cpufreq: intel_pstate: Avoid unnecessary synchronize_sched() during initialization
Date: Wed, 11 May 2016 14:33:08 +0800
Message-ID: <1462948388-2941-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:10422 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbcEKG0Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 11 May 2016 02:26:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

Currently in intel_pstate_clear_update_util_hook, after
clearing the utilization update hook, we leverage
synchronize_sched() to deal with synchronization, which
is a little bit time-costly because synchronize_sched()
has to wait for all the CPUs to go through a grace period.

Actually, the synchronize_sched() is not necessary if the utilization
update hook has not been set for the given CPU yet, so make the driver
check if that's the case and avoid the synchronize_sched() call in
that case.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=116371
Tested-by: Tian Ye <yex.tian@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2:
 - Rewrite the commit log according to Rafael's suggestion.
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

