From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/7] cpufreq: use memcpy() to copy policy
Date: Mon,  3 Aug 2015 08:36:15 +0530
Message-ID: <28169f7e8afdd4c3697c672c804a826dd86cb773.1438571116.git.viresh.kumar@linaro.org>
References: <cover.1438571116.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438571116.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438571116.git.viresh.kumar@linaro.org>
References: <cover.1438571116.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

cpufreq_get_policy() is useful if the pointer to policy isn't available
in advance. But if it is available, then there is no need to call
cpufreq_get_policy(). Directly use memcpy() to copy the policy.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 293f47b814bf..86d69416821b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -606,9 +606,7 @@ static ssize_t store_##file_name					\
 	int ret, temp;							\
 	struct cpufreq_policy new_policy;				\
 									\
-	ret = cpufreq_get_policy(&new_policy, policy->cpu);		\
-	if (ret)							\
-		return -EINVAL;						\
+	memcpy(&new_policy, policy, sizeof(*policy));			\
 									\
 	ret = sscanf(buf, "%u", &new_policy.object);			\
 	if (ret != 1)							\
@@ -662,9 +660,7 @@ static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
 	char	str_governor[16];
 	struct cpufreq_policy new_policy;
 
-	ret = cpufreq_get_policy(&new_policy, policy->cpu);
-	if (ret)
-		return ret;
+	memcpy(&new_policy, policy, sizeof(*policy));
 
 	ret = sscanf(buf, "%15s", str_governor);
 	if (ret != 1)
-- 
2.4.0
