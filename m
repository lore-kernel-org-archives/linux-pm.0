From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/10] cpufreq: Get rid of ->governor_enabled and its lock
Date: Mon, 22 Jun 2015 13:32:57 +0530
Message-ID: <cede9bfa2fe08e36549fdfc2c866cdbdaa8ca4c2.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33980 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756168AbbFVIDn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 04:03:43 -0400
Received: by pabvl15 with SMTP id vl15so82806735pab.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 01:03:42 -0700 (PDT)
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Invalid state-transitions is verified by governor core now and there is
no need to replicate that in cpufreq core.

Stop verifying the same in cpufreq core. That will get rid of
policy->governor_enabled and cpufreq_governor_lock.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 24 ------------------------
 include/linux/cpufreq.h   |  1 -
 2 files changed, 25 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 5863db9213aa..7c46c3f3d938 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -102,7 +102,6 @@ static LIST_HEAD(cpufreq_governor_list);
 static struct cpufreq_driver *cpufreq_driver;
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
-DEFINE_MUTEX(cpufreq_governor_lock);
 
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
@@ -2099,21 +2098,6 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 
 	pr_debug("%s: for CPU %u, event %u\n", __func__, policy->cpu, event);
 
-	mutex_lock(&cpufreq_governor_lock);
-	if ((policy->governor_enabled && event == CPUFREQ_GOV_START)
-	    || (!policy->governor_enabled
-	    && (event == CPUFREQ_GOV_LIMITS || event == CPUFREQ_GOV_STOP))) {
-		mutex_unlock(&cpufreq_governor_lock);
-		return -EBUSY;
-	}
-
-	if (event == CPUFREQ_GOV_STOP)
-		policy->governor_enabled = false;
-	else if (event == CPUFREQ_GOV_START)
-		policy->governor_enabled = true;
-
-	mutex_unlock(&cpufreq_governor_lock);
-
 	ret = policy->governor->governor(policy, event);
 
 	if (!ret) {
@@ -2121,14 +2105,6 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 			policy->governor->initialized++;
 		else if (event == CPUFREQ_GOV_POLICY_EXIT)
 			policy->governor->initialized--;
-	} else {
-		/* Restore original values */
-		mutex_lock(&cpufreq_governor_lock);
-		if (event == CPUFREQ_GOV_STOP)
-			policy->governor_enabled = true;
-		else if (event == CPUFREQ_GOV_START)
-			policy->governor_enabled = false;
-		mutex_unlock(&cpufreq_governor_lock);
 	}
 
 	if (((event == CPUFREQ_GOV_POLICY_INIT) && ret) ||
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 29ad97c34fd5..bb02f9a6bbc5 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -81,7 +81,6 @@ struct cpufreq_policy {
 	unsigned int		policy; /* see above */
 	struct cpufreq_governor	*governor; /* see below */
 	void			*governor_data;
-	bool			governor_enabled; /* governor start/stop flag */
 	char			last_governor[CPUFREQ_NAME_LEN]; /* last governor used */
 
 	struct work_struct	update; /* if update_policy() needs to be
-- 
2.4.0

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
