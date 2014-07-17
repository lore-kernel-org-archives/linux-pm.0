From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V1 Resend 2/4] cpufreq: don't restore policy->cpus on failure to move kobj
Date: Thu, 17 Jul 2014 10:48:26 +0530
Message-ID: <d923db741b0c3dd09667f67cf37700b90b6b698f.1405573982.git.viresh.kumar@linaro.org>
References: <cover.1405573982.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:54912 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbaGQFT7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jul 2014 01:19:59 -0400
Received: by mail-qc0-f172.google.com with SMTP id l6so1707111qcy.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2014 22:19:58 -0700 (PDT)
In-Reply-To: <cover.1405573982.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1405573982.git.viresh.kumar@linaro.org>
References: <cover.1405573982.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arvind.chauhan@arm.com, srivatsa@mit.edu, skannan@codeaurora.org, ybu@qti.qualcomm.com, Viresh Kumar <viresh.kumar@linaro.org>

While hot-unplugging policy->cpu, we call cpufreq_nominate_new_policy_cpu() to
nominate next owner of policy, i.e. policy->cpu. If we fail to move policy
kobject under the new policy->cpu, we try to update policy->cpus with the old
policy->cpu.

This would have been required in case old-cpu is removed from policy->cpus in
the first place. But its not done before calling
cpufreq_nominate_new_policy_cpu(), but during the POST_DEAD notification which
happens quite late in the hot-unplugging path.

So, this is just some useless code hanging around, get rid of it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6f02485..e572d51 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1322,11 +1322,6 @@ static int cpufreq_nominate_new_policy_cpu(struct cpufreq_policy *policy,
 	ret = kobject_move(&policy->kobj, &cpu_dev->kobj);
 	if (ret) {
 		pr_err("%s: Failed to move kobj: %d\n", __func__, ret);
-
-		down_write(&policy->rwsem);
-		cpumask_set_cpu(old_cpu, policy->cpus);
-		up_write(&policy->rwsem);
-
 		ret = sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
 					"cpufreq");
 
-- 
2.0.0.rc2

