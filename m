From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 5/5] cpufreq: propagate errors returned from __cpufreq_governor()
Date: Sat, 18 Jul 2015 11:31:03 +0530
Message-ID: <bd5d174f57c2c82b3f432c23071fe1cff7dff9b1.1437199001.git.viresh.kumar@linaro.org>
References: <2874468.iRvuV1Y9DI@vostro.rjw.lan>
 <cover.1437199001.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34252 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673AbbGRGBc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Jul 2015 02:01:32 -0400
Received: by pacan13 with SMTP id an13so71871064pac.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2015 23:01:32 -0700 (PDT)
In-Reply-To: <cover.1437199001.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437199001.git.viresh.kumar@linaro.org>
References: <cover.1437199001.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

Return codes aren't honored properly in cpufreq_set_policy(). This can
lead to two problems:
- wrong errors propagated to sysfs
- we try to do next state-change even if the previous one failed

cpufreq_governor_dbs() now returns proper errors on all invalid
state-transition requests and this code should honor that.

Reviewed-and-tested-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a7b6ac6e048e..a3e8fb61cbcc 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2295,16 +2295,31 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	old_gov = policy->governor;
 	/* end old governor */
 	if (old_gov) {
-		__cpufreq_governor(policy, CPUFREQ_GOV_STOP);
+		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
+		if (ret) {
+			/* This can happen due to race with other operations */
+			pr_debug("%s: Failed to Stop Governor: %s (%d)\n",
+				 __func__, old_gov->name, ret);
+			return ret;
+		}
+
 		up_write(&policy->rwsem);
-		__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+		ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
 		down_write(&policy->rwsem);
+
+		if (ret) {
+			pr_err("%s: Failed to Exit Governor: %s (%d)\n",
+			       __func__, old_gov->name, ret);
+			return ret;
+		}
 	}
 
 	/* start new governor */
 	policy->governor = new_policy->governor;
-	if (!__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT)) {
-		if (!__cpufreq_governor(policy, CPUFREQ_GOV_START))
+	ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT);
+	if (!ret) {
+		ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
+		if (!ret)
 			goto out;
 
 		up_write(&policy->rwsem);
@@ -2316,11 +2331,13 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	pr_debug("starting governor %s failed\n", policy->governor->name);
 	if (old_gov) {
 		policy->governor = old_gov;
-		__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT);
-		__cpufreq_governor(policy, CPUFREQ_GOV_START);
+		if (__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT))
+			policy->governor = NULL;
+		else
+			__cpufreq_governor(policy, CPUFREQ_GOV_START);
 	}
 
-	return -EINVAL;
+	return ret;
 
  out:
 	pr_debug("governor: change or update limits\n");
-- 
2.4.0

