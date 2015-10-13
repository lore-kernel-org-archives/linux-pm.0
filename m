From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH Resend] cpufreq: Drop redundant check for inactive policies
Date: Tue, 13 Oct 2015 10:57:13 +0530
Message-ID: <2d6d59c2b0654872a32a9b63874b750e6b808cb5.1444713966.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

We just made sure policy->cpu is online and this check will always fail
as the policy is active. Drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Saravana Kannan <skannan@codeaurora.org>
---
Resending as a separate patch.

 drivers/cpufreq/cpufreq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 58aabe0f2d2c..4fa2215cc6ec 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -843,18 +843,11 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 
 	down_write(&policy->rwsem);
 
-	/* Updating inactive policies is invalid, so avoid doing that. */
-	if (unlikely(policy_is_inactive(policy))) {
-		ret = -EBUSY;
-		goto unlock_policy_rwsem;
-	}
-
 	if (fattr->store)
 		ret = fattr->store(policy, buf, count);
 	else
 		ret = -EIO;
 
-unlock_policy_rwsem:
 	up_write(&policy->rwsem);
 unlock:
 	put_online_cpus();
-- 
2.4.0
