From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 5/5] cpufreq: postfix policy directory with the first CPU in related_cpus
Date: Thu, 15 Oct 2015 21:35:25 +0530
Message-ID: <f64c9a0941f179d55ab95f4b9a038df0acbfefa3.1444924623.git.viresh.kumar@linaro.org>
References: <cover.1444924623.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33694 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754AbbJOQGU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 12:06:20 -0400
Received: by pabrc13 with SMTP id rc13so91737394pab.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 09:06:20 -0700 (PDT)
In-Reply-To: <cover.1444924623.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1444924623.git.viresh.kumar@linaro.org>
References: <cover.1444924623.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

The sysfs policy directory is postfixed currently with the CPU number
for which the policy was created, which isn't necessarily the first CPU
in related_cpus mask.

To make it more consistent and predictable, lets postfix the policy with
the first cpu in related-cpus mask.

Suggested-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4fa2215cc6ec..3fe13875565d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1022,7 +1022,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
 	struct cpufreq_policy *policy;
-	int ret;
 
 	if (WARN_ON(!dev))
 		return NULL;
@@ -1040,13 +1039,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
 		goto err_free_rcpumask;
 
-	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
-				   cpufreq_global_kobject, "policy%u", cpu);
-	if (ret) {
-		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
-		goto err_free_real_cpus;
-	}
-
 	INIT_LIST_HEAD(&policy->policy_list);
 	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
@@ -1057,7 +1049,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	policy->cpu = cpu;
 	return policy;
 
-err_free_real_cpus:
 	free_cpumask_var(policy->real_cpus);
 err_free_rcpumask:
 	free_cpumask_var(policy->related_cpus);
@@ -1163,6 +1154,16 @@ static int cpufreq_online(unsigned int cpu)
 		cpumask_copy(policy->related_cpus, policy->cpus);
 		/* Remember CPUs present at the policy creation time. */
 		cpumask_and(policy->real_cpus, policy->cpus, cpu_present_mask);
+
+		/* Initialize the kobject */
+		ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
+					   cpufreq_global_kobject, "policy%u",
+					   cpumask_first(policy->related_cpus));
+		if (ret) {
+			pr_err("%s: failed to init policy->kobj: %d\n",
+			       __func__, ret);
+			goto out_exit_policy;
+		}
 	}
 
 	/*
-- 
2.4.0

