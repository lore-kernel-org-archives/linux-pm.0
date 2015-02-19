From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 05/20] cpufreq: Clear policy->cpus even for the last CPU
Date: Thu, 19 Feb 2015 17:02:07 +0530
Message-ID: <8c1be216c9f2e2b14a12d6acdbe49b7241d19ad0.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:37178 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbbBSLdl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 06:33:41 -0500
Received: by pdbfl12 with SMTP id fl12so8299703pdb.4
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2015 03:33:41 -0800 (PST)
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

We clear policy->cpus mask while CPUs are hotplugged out. We do it for all CPUs
except the last CPU of the policy. I don't remember what the rationale behind
that was, but I couldn't think of anything that will break if we remove this
conditional clearing and always clear policy->cpus.

The benefit we get out of it is, we can know if a policy is active or not by
checking if this field is empty or not. That will be used by later commits.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d06d1241a900..6ed87d02d293 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1430,9 +1430,7 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 
 	down_write(&policy->rwsem);
 	cpus = cpumask_weight(policy->cpus);
-
-	if (cpus > 1)
-		cpumask_clear_cpu(cpu, policy->cpus);
+	cpumask_clear_cpu(cpu, policy->cpus);
 	up_write(&policy->rwsem);
 
 	/* If cpu is last user of policy, free policy */
-- 
2.3.0.rc0.44.ga94655d

