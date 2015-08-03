From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/7] cpufreq: remove redundant 'governor' field from user_policy
Date: Mon,  3 Aug 2015 08:36:17 +0530
Message-ID: <d75d3b711046f712f102815cbb83b2a2207e32cd.1438571116.git.viresh.kumar@linaro.org>
References: <cover.1438571116.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438571116.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438571116.git.viresh.kumar@linaro.org>
References: <cover.1438571116.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Its always same as policy->governor, and there is no need to keep
another copy of it. Remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 7 ++-----
 include/linux/cpufreq.h   | 1 -
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8e71d8e08439..3033952391fe 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -675,7 +675,6 @@ static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
 		return ret;
 
 	policy->user_policy.policy = policy->policy;
-	policy->user_policy.governor = policy->governor;
 	return count;
 }
 
@@ -1323,10 +1322,9 @@ static int cpufreq_online(unsigned int cpu)
 		goto out_exit_policy;
 	}
 
-	if (new_policy) {
+	if (new_policy)
 		policy->user_policy.policy = policy->policy;
-		policy->user_policy.governor = policy->governor;
-	}
+
 	up_write(&policy->rwsem);
 
 	kobject_uevent(&policy->kobj, KOBJ_ADD);
@@ -2305,7 +2303,6 @@ int cpufreq_update_policy(unsigned int cpu)
 	new_policy.min = policy->user_policy.min;
 	new_policy.max = policy->user_policy.max;
 	new_policy.policy = policy->user_policy.policy;
-	new_policy.governor = policy->user_policy.governor;
 
 	/*
 	 * BIOS might change freq behind our back
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index bedcc90c0757..752bf8a5c314 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -55,7 +55,6 @@ struct cpufreq_real_policy {
 	unsigned int		min;    /* in kHz */
 	unsigned int		max;    /* in kHz */
 	unsigned int		policy; /* see above */
-	struct cpufreq_governor	*governor; /* see below */
 };
 
 struct cpufreq_policy {
-- 
2.4.0
