From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 5/5] cpufreq: Get rid of ->governor_enabled and its lock
Date: Tue, 13 Oct 2015 13:39:05 +0530
Message-ID: <123bfd25c7433733005efd57f819a27471471f81.1444723240.git.viresh.kumar@linaro.org>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444723240.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1444723240.git.viresh.kumar@linaro.org>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

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
index 25c4c15103a0..0c89b09672e4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -102,7 +102,6 @@ static LIST_HEAD(cpufreq_governor_list);
 static struct cpufreq_driver *cpufreq_driver;
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
-DEFINE_MUTEX(cpufreq_governor_lock);
 
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
@@ -2035,21 +2034,6 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 
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
@@ -2057,14 +2041,6 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
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
index dca22de98d94..d211da0763b7 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -80,7 +80,6 @@ struct cpufreq_policy {
 	unsigned int		policy; /* see above */
 	struct cpufreq_governor	*governor; /* see below */
 	void			*governor_data;
-	bool			governor_enabled; /* governor start/stop flag */
 	char			last_governor[CPUFREQ_NAME_LEN]; /* last governor used */
 
 	struct work_struct	update; /* if update_policy() needs to be
-- 
2.4.0
