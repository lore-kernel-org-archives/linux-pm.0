From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 4/7] Revert "cpufreq: Drop rwsem lock around CPUFREQ_GOV_POLICY_EXIT"
Date: Wed,  3 Feb 2016 19:32:20 +0530
Message-ID: <dc9cc32a46664fb49cae5d6f09b4559583cabbbe.1454507872.git.viresh.kumar@linaro.org>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454507872.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454507872.git.viresh.kumar@linaro.org>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Earlier, when the struct freq-attr was used to represent governor
attributes, the standard cpufreq show/store sysfs attribute callbacks
were applied to the governor tunable attributes and they always acquire
the policy->rwsem lock before carrying out the operation.  That could
have resulted in an ABBA deadlock if governor tunable attributes are
removed under policy->rwsem while one of them is being accessed
concurrently (if sysfs attributes removal wins the race, it will wait
for the access to complete with policy->rwsem held while the attribute
callback will block on policy->rwsem indefinitely).

We attempted to address this issue by dropping policy->rwsem around
governor tunable attributes removal (that is, around invocations of the
->governor callback with the event arg equal to CPUFREQ_GOV_POLICY_EXIT)
in cpufreq_set_policy(), but that opened up race conditions that had not
been possible with policy->rwsem held all the time.

The previous commit, "cpufreq: governor: New sysfs show/store callbacks
for governor tunables", fixed the original ABBA deadlock by adding new
governor specific show/store callbacks.

We don't have to drop rwsem around invocations of governor event
CPUFREQ_GOV_POLICY_EXIT anymore, and original fix can be reverted now.

Fixes: 955ef4833574 ("cpufreq: Drop rwsem lock around CPUFREQ_GOV_POLICY_EXIT")
Reported-by: Juri Lelli <juri.lelli@arm.com>
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
