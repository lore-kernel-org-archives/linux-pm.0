From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/5] cpufreq: Don't drop rwsem before calling CPUFREQ_GOV_POLICY_EXIT
Date: Tue,  2 Feb 2016 16:27:24 +0530
Message-ID: <3d58d4f0bec5e8e941cf96e159c8c21e68956cad.1454410226.git.viresh.kumar@linaro.org>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454410226.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454410226.git.viresh.kumar@linaro.org>
References: <cover.1454410226.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Commit 955ef4833574 ("cpufreq: Drop rwsem lock around
CPUFREQ_GOV_POLICY_EXIT") dropped these because of some ABBA lockup
issues.

The previous commit has fixed them all and we don't need to drop these
locks anymore.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 5 -----
 include/linux/cpufreq.h   | 4 ----
 2 files changed, 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e979ec78b695..5f7e24567e0e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2155,10 +2155,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 			return ret;
 		}
 
-		up_write(&policy->rwsem);
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
-		down_write(&policy->rwsem);
-
 		if (ret) {
 			pr_err("%s: Failed to Exit Governor: %s (%d)\n",
 			       __func__, old_gov->name, ret);
@@ -2174,9 +2171,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 		if (!ret)
 			goto out;
 
-		up_write(&policy->rwsem);
 		__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
-		down_write(&policy->rwsem);
 	}
 
 	/* new governor failed, so re-start old one */
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 88a4215125bc..79b87cebaa9c 100644
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
2.7.0.79.gdc08a19
