From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 17/17] cpufreq: move some initialization stuff to cpufreq_policy_alloc()
Date: Fri,  2 Jan 2015 12:34:38 +0530
Message-ID: <a00aab63c7b296546fbd59ed8670a97eec0c4ec7.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:44531 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbABHGA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 02:06:00 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so23711949pab.2
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 23:05:59 -0800 (PST)
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

We need to initialize completion and work only on policy allocation and not
really on the policy restore side and so we better move this piece of code to
cpufreq_policy_alloc().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 62c6a0b8b0d1..ace5dd4cd271 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1019,6 +1019,8 @@ static struct cpufreq_policy *cpufreq_policy_alloc(void)
 	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
 	init_waitqueue_head(&policy->transition_wait);
+	init_completion(&policy->kobj_unregister);
+	INIT_WORK(&policy->update, handle_update);
 
 	return policy;
 
@@ -1142,9 +1144,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 
 	cpumask_copy(policy->cpus, cpumask_of(cpu));
 
-	init_completion(&policy->kobj_unregister);
-	INIT_WORK(&policy->update, handle_update);
-
 	/* call driver. From then on the cpufreq must be able
 	 * to accept all calls to ->verify and ->setpolicy for this CPU
 	 */
-- 
2.2.0

