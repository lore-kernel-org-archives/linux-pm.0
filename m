From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/9] cpufreq: Use __func__ to print function's name
Date: Mon, 27 Jul 2015 17:58:06 +0530
Message-ID: <a131c99933f5dd7eefbd39358a2dc2b13663ca7b.1437999691.git.viresh.kumar@linaro.org>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36523 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbbG0M2g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 08:28:36 -0400
Received: by pdjr16 with SMTP id r16so52371456pdj.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2015 05:28:35 -0700 (PDT)
In-Reply-To: <cover.1437999691.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437999691.git.viresh.kumar@linaro.org>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

Its better to use __func__ to print functions name instead of writing
the name in the print statement. This also has the advantage that a
change in function's name doesn't force us to change the print message
as well.

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 46251e8d30f2..f620055279f3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2074,8 +2074,7 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 		if (!try_module_get(policy->governor->owner))
 			return -EINVAL;
 
-	pr_debug("__cpufreq_governor for CPU %u, event %u\n",
-		 policy->cpu, event);
+	pr_debug("%s: for CPU %u, event %u\n", __func__, policy->cpu, event);
 
 	mutex_lock(&cpufreq_governor_lock);
 	if ((policy->governor_enabled && event == CPUFREQ_GOV_START)
-- 
2.4.0

