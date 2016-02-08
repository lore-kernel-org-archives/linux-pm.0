From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 05/13] Revert "cpufreq: Drop rwsem lock around CPUFREQ_GOV_POLICY_EXIT"
Date: Mon,  8 Feb 2016 17:09:19 +0530
Message-ID: <7e22fb3b804f65b33a37c871a6d5023897b8641f.1454931188.git.viresh.kumar@linaro.org>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454931188.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454931188.git.viresh.kumar@linaro.org>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
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
index 29755fcbf200..9c62bf35b9dc 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2204,10 +2204,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 			return ret;
 		}
 
-		up_write(&policy->rwsem);
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
-		down_write(&policy->rwsem);
-
 		if (ret) {
 			pr_err("%s: Failed to Exit Governor: %s (%d)\n",
 			       __func__, old_gov->name, ret);
@@ -2223,9 +2220,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 		if (!ret)
 			goto out;
 
-		up_write(&policy->rwsem);
 		__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
-		down_write(&policy->rwsem);
 	}
 
 	/* new governor failed, so re-start old one */
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 11aa93134493..2a029c587975 100644
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
2.7.1.370.gb2aa7f8
