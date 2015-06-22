From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 10/10] cpufreq: propagate errors returned from
 __cpufreq_governor()
Date: Mon, 22 Jun 2015 10:51:06 +0530
Message-ID: <20150622052106.GA3878@linux>
References: <cover.1434713657.git.viresh.kumar@linaro.org>
 <46b51eea20399c927fb1f16839773f618133ae09.1434713657.git.viresh.kumar@linaro.org>
 <55845930.7020503@linux.vnet.ibm.com>
 <20150620031207.GE1955@linux>
 <55879214.2070809@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34757 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914AbbFVFVT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 01:21:19 -0400
Received: by pabvl15 with SMTP id vl15so80066372pab.1
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2015 22:21:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55879214.2070809@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 22-06-15, 10:11, Preeti U Murthy wrote:
> There are some checkpatch errors on this patch.

--------------8<------------------

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 11 Sep 2014 10:50:48 +0530
Subject: [PATCH] cpufreq: propagate errors returned from __cpufreq_governor()

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
index b612411655f9..0b3c60861bdf 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2284,16 +2284,31 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
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
@@ -2305,11 +2320,13 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
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
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
