From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 09/18] cpufreq: Mark policy->governor = NULL for fallback policies
Date: Tue, 27 Jan 2015 14:06:15 +0530
Message-ID: <ee81ef766064a79a5332f390d39dc3e4cca5fca5.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:56943 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757898AbbA0IhP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:37:15 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb1so17156883pad.10
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:37:15 -0800 (PST)
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 21c8ef6073d7..ed36c09f83cc 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1032,9 +1032,6 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
 	}
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	if (policy)
-		policy->governor = NULL;
-
 	return policy;
 }
 
@@ -1466,6 +1463,8 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 
 		if (!cpufreq_suspended)
 			cpufreq_policy_free(policy);
+		else
+			policy->governor = NULL;
 	} else if (has_target()) {
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
 		if (!ret)
-- 
2.3.0.rc0.44.ga94655d

