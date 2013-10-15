From: dirk.brandewie@gmail.com
Subject: [PATCH] cpfreq/intel_pstate: Fix max_perf_pct on resume
Date: Tue, 15 Oct 2013 11:06:14 -0700
Message-ID: <1381860374-29681-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:62424 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932760Ab3JOSGY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2013 14:06:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rjw@rjwysocki.net
Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>, stable@vger.kernel.org

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

If the system is suspended while max_perf_pct is less than 100 percent
or no_turbo set policy->{min,max} will be set incorrectly with scaled
values which turn the scaled values into hard limits.

Fixes https://bugzilla.kernel.org/show_bug.cgi?id=61241

Reported-by: Patrick Bartels <petzicus@googlemail.com>
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/cpufreq/intel_pstate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 32b3479..3335f55 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -652,9 +652,8 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	else
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
 
-	intel_pstate_get_min_max(cpu, &min_pstate, &max_pstate);
-	policy->min = min_pstate * 100000;
-	policy->max = max_pstate * 100000;
+	policy->min = cpu->pstate.min_pstate * 100000;
+	policy->max = cpu->pstate.turbo_pstate * 100000;
 
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * 100000;
-- 
1.8.3.1

