From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5/5] cpufreq: Drop redundant check for inactive policies
Date: Sun, 11 Oct 2015 22:51:14 +0530
Message-ID: <2d6d59c2b0654872a32a9b63874b750e6b808cb5.1444583718.git.viresh.kumar@linaro.org>
References: <cover.1444583718.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35189 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbbJKRVt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 11 Oct 2015 13:21:49 -0400
Received: by pabve7 with SMTP id ve7so74365267pab.2
        for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2015 10:21:48 -0700 (PDT)
In-Reply-To: <cover.1444583718.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1444583718.git.viresh.kumar@linaro.org>
References: <cover.1444583718.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

We just made sure policy->cpu is online and this check will always fail
as the policy is active. Drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
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

