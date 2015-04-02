From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Schedule work for the first-online CPU on resume
Date: Thu,  2 Apr 2015 10:21:33 +0530
Message-ID: <9775122d957a0cd594cfc43b2d81ebbf78e6dc2f.1427950272.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36116 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbbDBEvr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 00:51:47 -0400
Received: by pdea3 with SMTP id a3so26031695pde.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2015 21:51:46 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, "3.15+" <stable@vger.kernel.org>

All CPUs leaving the first-online CPU are hotplugged out on suspend and
and cpufreq core stops managing them.

On resume, we need to call cpufreq_update_policy() for this CPU's policy
to make sure its frequency is in sync with cpufreq's cached value, as it
might have got updated by hardware during suspend/resume.

The policies are always added to the top of the policy-list. So, in
normal circumstances, CPU 0's policy will be the last one in the list.
And so the code checks for the last policy.

But there are cases where it will fail. Consider quad-core system, with
policy-per core. If CPU0 is hotplugged out and added back again, the
last policy will be on CPU1 :(

To fix this in a proper way, always look for the policy of the first
online CPU. That way we will be sure that we are calling
cpufreq_update_policy() for the only CPU that wasn't hotplugged out.

Cc: 3.15+ <stable@vger.kernel.org> # 3.15+
Fixes: 2f0aea936360 ("cpufreq: suspend governors on system suspend/hibernate")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 28e59a48b35f..8ae655c364f4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1698,15 +1698,18 @@ void cpufreq_resume(void)
 		    || __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS))
 			pr_err("%s: Failed to start governor for policy: %p\n",
 				__func__, policy);
-
-		/*
-		 * schedule call cpufreq_update_policy() for boot CPU, i.e. last
-		 * policy in list. It will verify that the current freq is in
-		 * sync with what we believe it to be.
-		 */
-		if (list_is_last(&policy->policy_list, &cpufreq_policy_list))
-			schedule_work(&policy->update);
 	}
+
+	/*
+	 * schedule call cpufreq_update_policy() for first-online CPU, as that
+	 * wouldn't be hotplugged-out on suspend. It will verify that the
+	 * current freq is in sync with what we believe it to be.
+	 */
+	policy = cpufreq_cpu_get_raw(cpumask_first(cpu_online_mask));
+	if (WARN_ON(!policy))
+		return;
+
+	schedule_work(&policy->update);
 }
 
 /**
-- 
2.3.0.rc0.44.ga94655d

