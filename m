From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/7] cpufreq: update user_policy.* on success
Date: Mon,  3 Aug 2015 08:36:16 +0530
Message-ID: <141bb39218b253c4952eb9d98eb72a8a8dc98e49.1438571116.git.viresh.kumar@linaro.org>
References: <cover.1438571116.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438571116.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438571116.git.viresh.kumar@linaro.org>
References: <cover.1438571116.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

'user_policy' caches properties of a policy that are set by userspace.
And these must be updated only if cpufreq core was successful in
updating them based on request from user space.

In store_scaling_governor(), we are updating user_policy.policy and
user_policy.governor even if cpufreq_set_policy() failed. That's
incorrect.

Fix this by updating user_policy.* only if we were successful in
updating the properties.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 86d69416821b..8e71d8e08439 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -671,14 +671,12 @@ static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
 		return -EINVAL;
 
 	ret = cpufreq_set_policy(policy, &new_policy);
+	if (ret)
+		return ret;
 
 	policy->user_policy.policy = policy->policy;
 	policy->user_policy.governor = policy->governor;
-
-	if (ret)
-		return ret;
-	else
-		return count;
+	return count;
 }
 
 /**
-- 
2.4.0
