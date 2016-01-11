From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 02/19] cpufreq: merge governor lock and mutex
Date: Mon, 11 Jan 2016 17:35:43 +0000
Message-ID: <1452533760-13787-3-git-send-email-juri.lelli@arm.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com
List-Id: linux-pm@vger.kernel.org

From: Michael Turquette <mturquette@baylibre.com>

Commit 95731ebb114c ("cpufreq: Fix governor start/stop race condition")
introduced cpufreq_governor_lock. This was actually overkilling, as the
same can be achieved by using the existing cpufreq_governor_mutex.
Removing cpufreq_governor_lock cleans things up and makes deadlocks less
likely to happen.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
---
 drivers/cpufreq/cpufreq.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7bdd845..0802705 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -102,7 +102,7 @@ static LIST_HEAD(cpufreq_governor_list);
 static struct cpufreq_driver *cpufreq_driver;
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
-static DEFINE_MUTEX(cpufreq_governor_lock);
+static DEFINE_MUTEX(cpufreq_governor_mutex);
 
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
@@ -146,7 +146,6 @@ void disable_cpufreq(void)
 {
 	off = 1;
 }
-static DEFINE_MUTEX(cpufreq_governor_mutex);
 
 bool have_governor_per_policy(void)
 {
@@ -1963,11 +1962,11 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 
 	pr_debug("%s: for CPU %u, event %u\n", __func__, policy->cpu, event);
 
-	mutex_lock(&cpufreq_governor_lock);
+	mutex_lock(&cpufreq_governor_mutex);
 	if ((policy->governor_enabled && event == CPUFREQ_GOV_START)
 	    || (!policy->governor_enabled
 	    && (event == CPUFREQ_GOV_LIMITS || event == CPUFREQ_GOV_STOP))) {
-		mutex_unlock(&cpufreq_governor_lock);
+		mutex_unlock(&cpufreq_governor_mutex);
 		return -EBUSY;
 	}
 
@@ -1976,7 +1975,7 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 	else if (event == CPUFREQ_GOV_START)
 		policy->governor_enabled = true;
 
-	mutex_unlock(&cpufreq_governor_lock);
+	mutex_unlock(&cpufreq_governor_mutex);
 
 	ret = policy->governor->governor(policy, event);
 
@@ -1987,12 +1986,12 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 			policy->governor->initialized--;
 	} else {
 		/* Restore original values */
-		mutex_lock(&cpufreq_governor_lock);
+		mutex_lock(&cpufreq_governor_mutex);
 		if (event == CPUFREQ_GOV_STOP)
 			policy->governor_enabled = true;
 		else if (event == CPUFREQ_GOV_START)
 			policy->governor_enabled = false;
-		mutex_unlock(&cpufreq_governor_lock);
+		mutex_unlock(&cpufreq_governor_mutex);
 	}
 
 	if (((event == CPUFREQ_GOV_POLICY_INIT) && ret) ||
-- 
2.2.2
