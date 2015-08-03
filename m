From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5/7] cpufreq: remove redundant 'policy' field from user_policy
Date: Mon,  3 Aug 2015 08:36:18 +0530
Message-ID: <376177c9f626d0a32fcc45fb1a66d5806efc5ab5.1438571116.git.viresh.kumar@linaro.org>
References: <cover.1438571116.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438571116.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438571116.git.viresh.kumar@linaro.org>
References: <cover.1438571116.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Its always same as policy->policy, and there is no need to keep another
copy of it. Remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 10 +---------
 include/linux/cpufreq.h   |  1 -
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 3033952391fe..a80bd68bbd74 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -671,11 +671,7 @@ static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
 		return -EINVAL;
 
 	ret = cpufreq_set_policy(policy, &new_policy);
-	if (ret)
-		return ret;
-
-	policy->user_policy.policy = policy->policy;
-	return count;
+	return ret ? ret : count;
 }
 
 /**
@@ -1322,9 +1318,6 @@ static int cpufreq_online(unsigned int cpu)
 		goto out_exit_policy;
 	}
 
-	if (new_policy)
-		policy->user_policy.policy = policy->policy;
-
 	up_write(&policy->rwsem);
 
 	kobject_uevent(&policy->kobj, KOBJ_ADD);
@@ -2302,7 +2295,6 @@ int cpufreq_update_policy(unsigned int cpu)
 	memcpy(&new_policy, policy, sizeof(*policy));
 	new_policy.min = policy->user_policy.min;
 	new_policy.max = policy->user_policy.max;
-	new_policy.policy = policy->user_policy.policy;
 
 	/*
 	 * BIOS might change freq behind our back
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 752bf8a5c314..54dbbff0a55e 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -54,7 +54,6 @@ struct cpufreq_cpuinfo {
 struct cpufreq_real_policy {
 	unsigned int		min;    /* in kHz */
 	unsigned int		max;    /* in kHz */
-	unsigned int		policy; /* see above */
 };
 
 struct cpufreq_policy {
-- 
2.4.0
