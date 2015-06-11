From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 11/12] cpufreq: propagate errors returned from __cpufreq_governor()
Date: Thu, 11 Jun 2015 16:21:54 +0530
Message-ID: <1e4cea25fc1bf43924a39944ca9d1ec0782621e8.1434019473.git.viresh.kumar@linaro.org>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34615 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbbFKKw4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 06:52:56 -0400
Received: by payr10 with SMTP id r10so2311066pay.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 03:52:56 -0700 (PDT)
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

At few places in cpufreq_set_policy() either we aren't checking return errors of
__cpufreq_governor() or aren't returning them as is to the callers. This
sometimes propagates wrong errors to sysfs OR we try to do more operations even
if we have failed.

Now that we return -EBUSY from __cpufreq_governor() on invalid requests, there
are more chances of hitting these errors. Lets fix them by checking and
returning errors properly.

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

