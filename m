From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 12/20] cpufreq: Mark policy->governor = NULL for inactive policies
Date: Thu, 19 Feb 2015 17:02:14 +0530
Message-ID: <466c5246b6ad83b960eeb63ab34a04379448980d.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:42270 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbbBSLeI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 06:34:08 -0500
Received: by padhz1 with SMTP id hz1so8833229pad.9
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2015 03:34:08 -0800 (PST)
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Later commits would change the way policies are managed today. Policies wouldn't
be freed on cpu hotplug (currently they aren't freed on suspend), and while the
CPU is offline, the sysfs cpufreq files would still be present.

Because we don't mark policy->governor as NULL, it still contains pointer of the
last governor it used. And when we read the 'scaling_governor' file, it shows
the old value.

To prevent from this, mark policy->governor as NULL after we have issued
CPUFREQ_GOV_POLICY_EXIT event for its governor.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b7cd1bf97044..cab4cfdd3ebb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1094,7 +1094,6 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
 	if (likely(policy)) {
 		/* Policy should be inactive here */
 		WARN_ON(!policy_is_inactive(policy));
-		policy->governor = NULL;
 	}
 
 	return policy;
@@ -1497,6 +1496,8 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 
 		if (!cpufreq_suspended)
 			cpufreq_policy_free(policy);
+		else
+			policy->governor = NULL;
 	} else if (has_target()) {
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
 		if (!ret)
-- 
2.3.0.rc0.44.ga94655d

