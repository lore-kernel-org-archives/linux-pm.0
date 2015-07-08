From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/2] cpufreq: Properly handle errors from cpufreq_init_policy()
Date: Wed,  8 Jul 2015 15:12:16 +0530
Message-ID: <043703bd1914d52340653c3cc31207e505df6139.1436348436.git.viresh.kumar@linaro.org>
References: <276debea91831d86c34079f6a40d773ce258a62c.1436348436.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35793 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934620AbbGHJme (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 05:42:34 -0400
Received: by pdrg1 with SMTP id g1so11451861pdr.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2015 02:42:34 -0700 (PDT)
In-Reply-To: <276debea91831d86c34079f6a40d773ce258a62c.1436348436.git.viresh.kumar@linaro.org>
In-Reply-To: <276debea91831d86c34079f6a40d773ce258a62c.1436348436.git.viresh.kumar@linaro.org>
References: <276debea91831d86c34079f6a40d773ce258a62c.1436348436.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, tixy@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

cpufreq_init_policy() can fail, and we don't do anything except a call
to ->exit() on that. The policy should be freed if this happens.

Lets do it properly.

Reported-by: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b7aac8eec525..006299214d2e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1051,11 +1051,10 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
 	return cpufreq_add_dev_symlink(policy);
 }
 
-static void cpufreq_init_policy(struct cpufreq_policy *policy)
+static int cpufreq_init_policy(struct cpufreq_policy *policy)
 {
 	struct cpufreq_governor *gov = NULL;
 	struct cpufreq_policy new_policy;
-	int ret = 0;
 
 	memcpy(&new_policy, policy, sizeof(*policy));
 
@@ -1074,12 +1073,7 @@ static void cpufreq_init_policy(struct cpufreq_policy *policy)
 		cpufreq_parse_governor(gov->name, &new_policy.policy, NULL);
 
 	/* set default policy */
-	ret = cpufreq_set_policy(policy, &new_policy);
-	if (ret) {
-		pr_debug("setting policy failed\n");
-		if (cpufreq_driver->exit)
-			cpufreq_driver->exit(policy);
-	}
+	return cpufreq_set_policy(policy, &new_policy);
 }
 
 static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
@@ -1376,7 +1370,12 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 	}
 
-	cpufreq_init_policy(policy);
+	ret = cpufreq_init_policy(policy);
+	if (ret) {
+		pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
+		       __func__, cpu, ret);
+		goto out_remove_policy_notify;
+	}
 
 	if (!recover_policy) {
 		policy->user_policy.policy = policy->policy;
@@ -1396,6 +1395,9 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 
 	return 0;
 
+out_remove_policy_notify:
+	/* cpufreq_policy_free() will notify based on this */
+	recover_policy = true;
 out_exit_policy:
 	up_write(&policy->rwsem);
 
-- 
2.4.0

