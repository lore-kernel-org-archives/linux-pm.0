From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 12/19] cpufreq: fix locking of policy->rwsem in cpufreq_init_policy
Date: Mon, 11 Jan 2016 17:35:53 +0000
Message-ID: <1452533760-13787-13-git-send-email-juri.lelli@arm.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com
List-Id: linux-pm@vger.kernel.org

There are paths in cpufreq_init_policy where policy is used, but its rwsem
is not held.

Fix it.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 drivers/cpufreq/cpufreq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e7fc5c9..2c7cc6c73 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -998,21 +998,24 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
 {
 	int ret = 0;
 
+	down_write(&policy->rwsem);
+
 	/* Has this CPU been taken care of already? */
-	if (cpumask_test_cpu(cpu, policy->cpus))
+	if (cpumask_test_cpu(cpu, policy->cpus)) {
+		up_write(&policy->rwsem);
 		return 0;
+	}
 
 	if (has_target()) {
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		if (ret) {
+			up_write(&policy->rwsem);
 			pr_err("%s: Failed to stop governor\n", __func__);
 			return ret;
 		}
 	}
 
-	down_write(&policy->rwsem);
 	cpumask_set_cpu(cpu, policy->cpus);
-	up_write(&policy->rwsem);
 
 	if (has_target()) {
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
@@ -1020,10 +1023,12 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
 			ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 
 		if (ret) {
+			up_write(&policy->rwsem);
 			pr_err("%s: Failed to start governor\n", __func__);
 			return ret;
 		}
 	}
+	up_write(&policy->rwsem);
 
 	return 0;
 }
-- 
2.2.2
