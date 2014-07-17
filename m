From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V1 Resend 3/4] cpufreq: propagate error returned by kobject_move()
Date: Thu, 17 Jul 2014 10:48:27 +0530
Message-ID: <c2cebd3136383eb20ef86800955040c633969d82.1405573982.git.viresh.kumar@linaro.org>
References: <cover.1405573982.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:50433 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbaGQFUG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jul 2014 01:20:06 -0400
Received: by mail-qc0-f180.google.com with SMTP id l6so1718681qcy.11
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2014 22:20:05 -0700 (PDT)
In-Reply-To: <cover.1405573982.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1405573982.git.viresh.kumar@linaro.org>
References: <cover.1405573982.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arvind.chauhan@arm.com, srivatsa@mit.edu, skannan@codeaurora.org, ybu@qti.qualcomm.com, Viresh Kumar <viresh.kumar@linaro.org>

We are returning -EINVAL instead of the error returned from kobject_move() when
it fails. Propagate the actual error number.

Also add a meaningful print when sysfs_create_link() fails.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e572d51..ec25ca6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1322,10 +1322,12 @@ static int cpufreq_nominate_new_policy_cpu(struct cpufreq_policy *policy,
 	ret = kobject_move(&policy->kobj, &cpu_dev->kobj);
 	if (ret) {
 		pr_err("%s: Failed to move kobj: %d\n", __func__, ret);
-		ret = sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
-					"cpufreq");
 
-		return -EINVAL;
+		if (sysfs_create_link(&cpu_dev->kobj, &policy->kobj, "cpufreq"))
+			pr_err("%s: Failed to restore kobj link to cpu:%d\n",
+			       __func__, cpu_dev->id);
+
+		return ret;
 	}
 
 	return cpu_dev->id;
-- 
2.0.0.rc2

