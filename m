From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH RESEND 08/11] cpufreq: rename __cpufreq_set_policy() as cpufreq_set_policy()
Date: Wed,  2 Oct 2013 14:13:16 +0530
Message-ID: <e76f74ec04b6487442ae1d7f8b0004f00ad97290.1380703248.git.viresh.kumar@linaro.org>
References: <cover.1380703248.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:64839 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab3JBIod (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2013 04:44:33 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so584973pbc.16
        for <linux-pm@vger.kernel.org>; Wed, 02 Oct 2013 01:44:33 -0700 (PDT)
In-Reply-To: <cover.1380703248.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380703248.git.viresh.kumar@linaro.org>
References: <cover.1380703248.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Earlier there used to be two functions named __cpufreq_set_policy() and
cpufreq_set_policy(), but now we only have a single routine lets name it
cpufreq_set_policy() instead of __cpufreq_set_policy().

This also removes some invalid comments or fixes some incorrect comments.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1394dac..267ae99 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -371,7 +371,7 @@ show_one(scaling_min_freq, min);
 show_one(scaling_max_freq, max);
 show_one(scaling_cur_freq, cur);
 
-static int __cpufreq_set_policy(struct cpufreq_policy *policy,
+static int cpufreq_set_policy(struct cpufreq_policy *policy,
 				struct cpufreq_policy *new_policy);
 
 /**
@@ -392,7 +392,7 @@ static ssize_t store_##file_name					\
 	if (ret != 1)							\
 		return -EINVAL;						\
 									\
-	ret = __cpufreq_set_policy(policy, &new_policy);		\
+	ret = cpufreq_set_policy(policy, &new_policy);		\
 	policy->user_policy.object = policy->object;			\
 									\
 	return ret ? ret : count;					\
@@ -450,11 +450,7 @@ static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
 						&new_policy.governor))
 		return -EINVAL;
 
-	/*
-	 * Do not use cpufreq_set_policy here or the user_policy.max
-	 * will be wrongly overridden
-	 */
-	ret = __cpufreq_set_policy(policy, &new_policy);
+	ret = cpufreq_set_policy(policy, &new_policy);
 
 	policy->user_policy.policy = policy->policy;
 	policy->user_policy.governor = policy->governor;
@@ -796,11 +792,11 @@ static void cpufreq_init_policy(struct cpufreq_policy *policy)
 	int ret = 0;
 
 	memcpy(&new_policy, policy, sizeof(*policy));
-	/* assure that the starting sequence is run in __cpufreq_set_policy */
+	/* assure that the starting sequence is run in cpufreq_set_policy */
 	policy->governor = NULL;
 
 	/* set default policy */
-	ret = __cpufreq_set_policy(policy, &new_policy);
+	ret = cpufreq_set_policy(policy, &new_policy);
 	policy->user_policy.policy = policy->policy;
 	policy->user_policy.governor = policy->governor;
 
@@ -1803,10 +1799,10 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
 EXPORT_SYMBOL(cpufreq_get_policy);
 
 /*
- * data   : current policy.
- * policy : policy to be set.
+ * policy : current policy.
+ * new_policy: policy to be set.
  */
-static int __cpufreq_set_policy(struct cpufreq_policy *policy,
+static int cpufreq_set_policy(struct cpufreq_policy *policy,
 				struct cpufreq_policy *new_policy)
 {
 	int ret = 0, failed = 1;
@@ -1952,7 +1948,7 @@ int cpufreq_update_policy(unsigned int cpu)
 		}
 	}
 
-	ret = __cpufreq_set_policy(policy, &new_policy);
+	ret = cpufreq_set_policy(policy, &new_policy);
 
 	up_write(&policy->rwsem);
 
-- 
1.7.12.rc2.18.g61b472e

