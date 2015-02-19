From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 07/20] cpufreq: Call schedule_work() for the last active policy
Date: Thu, 19 Feb 2015 17:02:09 +0530
Message-ID: <d9273b6f27de39f077b97f2929b47aa885220933.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:38018 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbbBSLdt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 06:33:49 -0500
Received: by pdbfp1 with SMTP id fp1so8275373pdb.5
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2015 03:33:49 -0800 (PST)
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

We need to call schedule_work() only for the policy belonging to boot CPU, i.e.
CPU0. Checking for list_is_last() wouldn't work anymore as there can be inactive
policies present in the list after the last active one. 'policy' still points to
the last active policy at the termination of the for_each_active_policy() loop,
use that to call schedule_work().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d3f9ce3b94d3..e728c796c327 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1779,15 +1779,14 @@ void cpufreq_resume(void)
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
+	 * schedule call cpufreq_update_policy() for boot CPU, i.e. last
+	 * policy in list. It will verify that the current freq is in
+	 * sync with what we believe it to be.
+	 */
+	schedule_work(&policy->update);
 }
 
 /**
-- 
2.3.0.rc0.44.ga94655d

