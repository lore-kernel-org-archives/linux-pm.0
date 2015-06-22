From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 01/10] cpufreq: Use __func__ to print function's name
Date: Mon, 22 Jun 2015 13:32:48 +0530
Message-ID: <e836441d6e1ad1ba8c136dc301ee2ad9df08fa72.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33529 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380AbbFVIDL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 04:03:11 -0400
Received: by pdjn11 with SMTP id n11so133804600pdj.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 01:03:11 -0700 (PDT)
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Its better to use __func__ to print functions name instead of writing
the name in the print statement. This also has the advantage that a
change in function's name doesn't force us to change the print message
as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0b3c60861bdf..5863db9213aa 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2097,8 +2097,7 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 		if (!try_module_get(policy->governor->owner))
 			return -EINVAL;
 
-	pr_debug("__cpufreq_governor for CPU %u, event %u\n",
-		 policy->cpu, event);
+	pr_debug("%s: for CPU %u, event %u\n", __func__, policy->cpu, event);
 
 	mutex_lock(&cpufreq_governor_lock);
 	if ((policy->governor_enabled && event == CPUFREQ_GOV_START)
-- 
2.4.0

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
