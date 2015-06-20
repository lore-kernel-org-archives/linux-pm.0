From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 10/10] cpufreq: propagate errors returned from
 __cpufreq_governor()
Date: Sat, 20 Jun 2015 08:42:07 +0530
Message-ID: <20150620031207.GE1955@linux>
References: <cover.1434713657.git.viresh.kumar@linaro.org>
 <46b51eea20399c927fb1f16839773f618133ae09.1434713657.git.viresh.kumar@linaro.org>
 <55845930.7020503@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:35392 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535AbbFTDMM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 23:12:12 -0400
Received: by pdbci14 with SMTP id ci14so43661672pdb.2
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 20:12:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55845930.7020503@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 19-06-15, 23:32, Preeti U Murthy wrote:
> If INIT itself fails, we need to set policy->governor to NULL. I
> included this in the testing of the patchset.

Diff from earlier patch:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index da672b910760..59fa0c1b7922 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2284,14 +2284,23 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	old_gov = policy->governor;
 	/* end old governor */
 	if (old_gov) {
-		if(!(ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP))) {
+		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
+		if (ret) {
+			/* This can happen due to race with other operations */
+			pr_debug("%s: Failed to Stop Governor: %s (%d)\n",
+				 __func__, old_gov->name, ret);
+			return ret;
+		} else {
 			up_write(&policy->rwsem);
 			ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
 			down_write(&policy->rwsem);
-		}
 
-		if (ret)
-			return ret;
+			if (ret) {
+				pr_err("%s: Failed to Exit Governor: %s (%d)\n",
+				       __func__, old_gov->name, ret);
+				return ret;
+			}
+		}
 	}
 
 	/* start new governor */
@@ -2309,7 +2318,9 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	pr_debug("starting governor %s failed\n", policy->governor->name);
 	if (old_gov) {
 		policy->governor = old_gov;
-		if (!__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT))
+		if (__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT))
+			policy->governor = NULL;
+		else
 			__cpufreq_governor(policy, CPUFREQ_GOV_START);
 	}
 

New-patch:

--------------8<-------------------

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 11 Sep 2014 10:50:48 +0530
Subject: [PATCH] cpufreq: propagate errors returned from __cpufreq_governor()

Return codes aren't honored properly in cpufreq_set_policy(). This can
lead to two problems:
- wrong errors propagated to sysfs
- we try to do next state-change even if the previous one failed

cpufreq_governor_dbs() now returns proper errors on all invalid
state-transition requests and this code should honor that.

Reviewed-and-Tested-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b612411655f9..59fa0c1b7922 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2284,16 +2284,29 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	old_gov = policy->governor;
 	/* end old governor */
 	if (old_gov) {
-		__cpufreq_governor(policy, CPUFREQ_GOV_STOP);
-		up_write(&policy->rwsem);
-		__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
-		down_write(&policy->rwsem);
+		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
+		if (ret) {
+			/* This can happen due to race with other operations */
+			pr_debug("%s: Failed to Stop Governor: %s (%d)\n",
+				 __func__, old_gov->name, ret);
+			return ret;
+		} else {
+			up_write(&policy->rwsem);
+			ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+			down_write(&policy->rwsem);
+
+			if (ret) {
+				pr_err("%s: Failed to Exit Governor: %s (%d)\n",
+				       __func__, old_gov->name, ret);
+				return ret;
+			}
+		}
 	}
 
 	/* start new governor */
 	policy->governor = new_policy->governor;
-	if (!__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT)) {
-		if (!__cpufreq_governor(policy, CPUFREQ_GOV_START))
+	if (!(ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT))) {
+		if (!(ret = __cpufreq_governor(policy, CPUFREQ_GOV_START)))
 			goto out;
 
 		up_write(&policy->rwsem);
@@ -2305,11 +2318,13 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
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
viresh
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
