From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 10/10] cpufreq: propagate errors returned from __cpufreq_governor()
Date: Fri, 19 Jun 2015 17:18:10 +0530
Message-ID: <46b51eea20399c927fb1f16839773f618133ae09.1434713657.git.viresh.kumar@linaro.org>
References: <cover.1434713657.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33727 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbbFSLtF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 07:49:05 -0400
Received: by padev16 with SMTP id ev16so83995807pad.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 04:49:05 -0700 (PDT)
In-Reply-To: <cover.1434713657.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434713657.git.viresh.kumar@linaro.org>
References: <cover.1434713657.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Return codes aren't honored properly in cpufreq_set_policy(). This can
lead to two problems:
- wrong errors propagated to sysfs
- we try to do next state-change even if the previous one failed

cpufreq_governor_dbs() now returns proper errors on all invalid
state-transition requests and this code should honor that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b612411655f9..da672b910760 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2284,16 +2284,20 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	old_gov = policy->governor;
 	/* end old governor */
 	if (old_gov) {
-		__cpufreq_governor(policy, CPUFREQ_GOV_STOP);
-		up_write(&policy->rwsem);
-		__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
-		down_write(&policy->rwsem);
+		if(!(ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP))) {
+			up_write(&policy->rwsem);
+			ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+			down_write(&policy->rwsem);
+		}
+
+		if (ret)
+			return ret;
 	}
 
 	/* start new governor */
 	policy->governor = new_policy->governor;
-	if (!__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT)) {
-		if (!__cpufreq_governor(policy, CPUFREQ_GOV_START))
+	if (!(ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT))) {
+		if (!(ret = __cpufreq_governor(policy, CPUFREQ_GOV_START)))
 			goto out;
 
 		up_write(&policy->rwsem);
@@ -2305,11 +2309,11 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	pr_debug("starting governor %s failed\n", policy->governor->name);
 	if (old_gov) {
 		policy->governor = old_gov;
-		__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT);
-		__cpufreq_governor(policy, CPUFREQ_GOV_START);
+		if (!__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT))
+			__cpufreq_governor(policy, CPUFREQ_GOV_START);
 	}
 
-	return -EINVAL;
+	return ret;
 
  out:
 	pr_debug("governor: change or update limits\n");
-- 
2.4.0

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
