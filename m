From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5/5] cpufreq: Get rid of ->governor_enabled and its lock
Date: Tue,  2 Feb 2016 16:27:25 +0530
Message-ID: <48d24fd180e1fdf1c06a6992748c6365be43e937.1454410226.git.viresh.kumar@linaro.org>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454410226.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454410226.git.viresh.kumar@linaro.org>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Invalid state-transitions is verified by governor core now and there is
no need to replicate that in cpufreq core. Also we don't drop
policy->rwsem anymore, which makes rest of the races go away.

Simplify code a bit now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 24 ------------------------
 include/linux/cpufreq.h   |  1 -
 2 files changed, 25 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 5f7e24567e0e..052ad1b9372c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -102,7 +102,6 @@ static LIST_HEAD(cpufreq_governor_list);
 static struct cpufreq_driver *cpufreq_driver;
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
-DEFINE_MUTEX(cpufreq_governor_lock);
 
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
@@ -1963,21 +1962,6 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 
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
@@ -1985,14 +1969,6 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
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
index 79b87cebaa9c..e90cf5d31e85 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -80,7 +80,6 @@ struct cpufreq_policy {
 	unsigned int		last_policy; /* policy before unplug */
 	struct cpufreq_governor	*governor; /* see below */
 	void			*governor_data;
-	bool			governor_enabled; /* governor start/stop flag */
 	char			last_governor[CPUFREQ_NAME_LEN]; /* last governor used */
 
 	struct work_struct	update; /* if update_policy() needs to be
-- 
2.7.0.79.gdc08a19
