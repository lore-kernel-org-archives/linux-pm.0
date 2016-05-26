From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Use clamp_val()
Date: Thu, 26 May 2016 11:27:24 +0530
Message-ID: <e2db536d885243b7999382aea886912ad40049cc.1464242226.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33704 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbcEZF5d (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2016 01:57:33 -0400
Received: by mail-pf0-f177.google.com with SMTP id b124so27463568pfb.0
        for <linux-pm@vger.kernel.org>; Wed, 25 May 2016 22:57:33 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

Use clamp_val() instead of open coding it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0b5cf0e4bd4f..6ddb12c0f6fb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1963,10 +1963,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 		return -ENODEV;
 
 	/* Make sure that target_freq is within supported range */
-	if (target_freq > policy->max)
-		target_freq = policy->max;
-	if (target_freq < policy->min)
-		target_freq = policy->min;
+	clamp_val(target_freq, policy->min, policy->max);
 
 	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
 		 policy->cpu, target_freq, relation, old_target_freq);
-- 
2.7.1.410.g6faf27b

