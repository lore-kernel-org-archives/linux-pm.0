From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 9/9] cpufreq: Get rid of ->governor_enabled and its lock
Date: Mon, 27 Jul 2015 17:58:14 +0530
Message-ID: <3667769d0c2fe326f89171d87cfe1d5eb8686115.1437999691.git.viresh.kumar@linaro.org>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437999691.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437999691.git.viresh.kumar@linaro.org>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
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
index f620055279f3..c0d49950db01 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -102,7 +102,6 @@ static LIST_HEAD(cpufreq_governor_list);
 static struct cpufreq_driver *cpufreq_driver;
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
-DEFINE_MUTEX(cpufreq_governor_lock);
 
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
@@ -2076,21 +2075,6 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 
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
@@ -2098,14 +2082,6 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
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
index bde1e567b3a9..5930c6b3a1d8 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -82,7 +82,6 @@ struct cpufreq_policy {
 	unsigned int		policy; /* see above */
 	struct cpufreq_governor	*governor; /* see below */
 	void			*governor_data;
-	bool			governor_enabled; /* governor start/stop flag */
 	char			last_governor[CPUFREQ_NAME_LEN]; /* last governor used */
 
 	struct work_struct	update; /* if update_policy() needs to be
-- 
2.4.0
