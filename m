From: dirk.brandewie@gmail.com
Subject: [PATCH 3/5] intel_pstate: Don't lose sysfs settings during cpu offline
Date: Mon, 13 Oct 2014 08:37:42 -0700
Message-ID: <1413214664-17687-3-git-send-email-dirk.j.brandewie@intel.com>
References: <1413214664-17687-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:48013 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbaJMPh5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Oct 2014 11:37:57 -0400
In-Reply-To: <1413214664-17687-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, dirk.brandewie@gmail.com, Dirk Brandewie <dirk.j.brandewie@intel.com>, stable@vger.kernel.org

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

The user may have custom settings don't destroy them during suspend.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=80651

Reported-by: Tobias Jakobi <liquid.acid@gmx.net>
Cc: stable@vger.kernel.org
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index a85b262..db03cbb 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -702,7 +702,9 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 {
 	struct cpudata *cpu;
 
-	all_cpu_data[cpunum] = kzalloc(sizeof(struct cpudata), GFP_KERNEL);
+	if (!all_cpu_data[cpunum])
+		all_cpu_data[cpunum] = kzalloc(sizeof(struct cpudata),
+					       GFP_KERNEL);
 	if (!all_cpu_data[cpunum])
 		return -ENOMEM;
 
@@ -782,8 +784,6 @@ static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
 
 	del_timer_sync(&all_cpu_data[cpu_num]->timer);
 	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate);
-	kfree(all_cpu_data[cpu_num]);
-	all_cpu_data[cpu_num] = NULL;
 }
 
 static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
-- 
1.9.3

