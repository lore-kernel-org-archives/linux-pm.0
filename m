From: Vincent Minet <vincent@vincent-minet.net>
Subject: [PATCH] intel_pstate: Set cpu number before accessing MSRs
Date: Sat,  5 Jul 2014 01:51:33 +0200
Message-ID: <1404517893-30272-1-git-send-email-vincent@vincent-minet.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.didaction.com ([87.98.175.59]:60841 "EHLO
	mail.didaction.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939AbaGEAEI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jul 2014 20:04:08 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dirk Brandewie <dirk.j.brandewie@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>

Ensure that cpu->cpu is set before writing MSR_IA32_PERF_CTL during CPU
initialization. Otherwise only cpu0 has its P-state set and all other
cores are left with their values unchanged.

In most cases, this is not too serious because the P-states will be set
correctly when the timer function is run.
But when the default governor is set to performance, the per-cpu
current_pstate stays the same forever and no attempts are made to write
the MSRs again.

Signed-off-by: Vincent Minet <vincent@vincent-minet.net>
---
 drivers/cpufreq/intel_pstate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 924bb2d..eff0f9a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -696,9 +696,8 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 
 	cpu = all_cpu_data[cpunum];
 
-	intel_pstate_get_cpu_pstates(cpu);
-
 	cpu->cpu = cpunum;
+	intel_pstate_get_cpu_pstates(cpu);
 
 	init_timer_deferrable(&cpu->timer);
 	cpu->timer.function = intel_pstate_timer_func;
-- 
2.0.0

