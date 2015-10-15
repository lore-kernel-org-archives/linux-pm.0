From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/5] cpufreq: Use cpumask_copy instead of cpumask_or to copy a mask
Date: Thu, 15 Oct 2015 21:35:21 +0530
Message-ID: <376fd4d59723a89b40a0f12def43722874c43be8.1444924623.git.viresh.kumar@linaro.org>
References: <cover.1444924623.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33796 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403AbbJOQFn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 12:05:43 -0400
Received: by payp3 with SMTP id p3so43952560pay.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 09:05:42 -0700 (PDT)
In-Reply-To: <cover.1444924623.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1444924623.git.viresh.kumar@linaro.org>
References: <cover.1444924623.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

->related_cpus is empty at this point of time and copying ->cpus to it
or orring ->related_cpus with ->cpus would result in the same value. But
cpumask_copy makes it rather clear.

Reviewed-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8701dc559850..16b9e811ff01 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1214,7 +1214,7 @@ static int cpufreq_online(unsigned int cpu)
 
 	if (new_policy) {
 		/* related_cpus should at least include policy->cpus. */
-		cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
+		cpumask_copy(policy->related_cpus, policy->cpus);
 		/* Remember CPUs present at the policy creation time. */
 		cpumask_and(policy->real_cpus, policy->cpus, cpu_present_mask);
 	}
-- 
2.4.0

