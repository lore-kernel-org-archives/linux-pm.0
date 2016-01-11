From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 16/19] cpufreq: hold policy->rwsem across CPUFREQ_GOV_POLICY_EXIT
Date: Mon, 11 Jan 2016 17:35:57 +0000
Message-ID: <1452533760-13787-17-git-send-email-juri.lelli@arm.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com
List-Id: linux-pm@vger.kernel.org

There are no good reasons why policy->rwsem cannot be hold across calls to
__cpufreq_governor with CPUFREQ_GOV_POLICY_EXIT event.

Remove {up,down}_write across such call sites. This also verify assertion
that policy->rwsem is always hold when calling into __cpufreq_governor.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 drivers/cpufreq/cpufreq.c | 4 ----
 include/linux/cpufreq.h   | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d58a622..797bfae 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2182,9 +2182,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 			return ret;
 		}
 
-		up_write(&policy->rwsem);
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
-		down_write(&policy->rwsem);
 
 		if (ret) {
 			pr_err("%s: Failed to Exit Governor: %s (%d)\n",
@@ -2201,9 +2199,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 		if (!ret)
 			goto out;
 
-		up_write(&policy->rwsem);
 		__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
-		down_write(&policy->rwsem);
 	}
 
 	/* new governor failed, so re-start old one */
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 88a4215..79b87ce 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -100,10 +100,6 @@ struct cpufreq_policy {
 	 * - Any routine that will write to the policy structure and/or may take away
 	 *   the policy altogether (eg. CPU hotplug), will hold this lock in write
 	 *   mode before doing so.
-	 *
-	 * Additional rules:
-	 * - Lock should not be held across
-	 *     __cpufreq_governor(data, CPUFREQ_GOV_POLICY_EXIT);
 	 */
 	struct rw_semaphore	rwsem;
 
-- 
2.2.2
