From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 15/19] cpufreq: remove useless usage of cpufreq_governor_mutex in __cpufreq_governor
Date: Mon, 11 Jan 2016 17:35:56 +0000
Message-ID: <1452533760-13787-16-git-send-email-juri.lelli@arm.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com
List-Id: linux-pm@vger.kernel.org

Commit 6f1e4efd882e ("cpufreq: Fix timer/workqueue corruption by
protecting reading governor_enabled") made policy->governor_enabled
guarded by cpufreq_governor_mutex in __cpufreq_governor. Now that
holding of policy->rwsem is asserted in __cpufreq_governor,
cpufreq_governor_mutex is overkilling.

Remove such usage. Also, this cleans up semantic of
cpufreq_governor_mutex: it guards cpufreq_governor_list only.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 drivers/cpufreq/cpufreq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index ba452c3..d58a622 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1993,11 +1993,9 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 
 	pr_debug("%s: for CPU %u, event %u\n", __func__, policy->cpu, event);
 
-	mutex_lock(&cpufreq_governor_mutex);
 	if ((policy->governor_enabled && event == CPUFREQ_GOV_START)
 	    || (!policy->governor_enabled
 	    && (event == CPUFREQ_GOV_LIMITS || event == CPUFREQ_GOV_STOP))) {
-		mutex_unlock(&cpufreq_governor_mutex);
 		return -EBUSY;
 	}
 
@@ -2006,8 +2004,6 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 	else if (event == CPUFREQ_GOV_START)
 		policy->governor_enabled = true;
 
-	mutex_unlock(&cpufreq_governor_mutex);
-
 	ret = policy->governor->governor(policy, event);
 
 	if (!ret) {
@@ -2017,12 +2013,10 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 			policy->governor->initialized--;
 	} else {
 		/* Restore original values */
-		mutex_lock(&cpufreq_governor_mutex);
 		if (event == CPUFREQ_GOV_STOP)
 			policy->governor_enabled = true;
 		else if (event == CPUFREQ_GOV_START)
 			policy->governor_enabled = false;
-		mutex_unlock(&cpufreq_governor_mutex);
 	}
 
 	if (((event == CPUFREQ_GOV_POLICY_INIT) && ret) ||
-- 
2.2.2
