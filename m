From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/6] thermal/cpu_cooling: quit early after updating policy
Date: Thu, 30 Jul 2015 12:40:31 +0530
Message-ID: <47594802e96dc2b1e727fd88f92b3fa4459b4d09.1438239727.git.viresh.kumar@linaro.org>
References: <cover.1438239727.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33894 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbbG3HK5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2015 03:10:57 -0400
Received: by pacan13 with SMTP id an13so19150174pac.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2015 00:10:56 -0700 (PDT)
In-Reply-To: <cover.1438239727.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438239727.git.viresh.kumar@linaro.org>
References: <cover.1438239727.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, radivoje.jovanovic@linux.intel.com, punit.agrawal@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

If a valid cpufreq_dev is found for policy->cpu, we should update the
policy and quit the for loop. There is no need to keep traversing the
list of cpufreq_dev's.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index d010c6d0d722..276cec5a1fb7 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -232,6 +232,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 			if (policy->max != max_freq)
 				cpufreq_verify_within_limits(policy, 0,
 							     max_freq);
+			break;
 		}
 		mutex_unlock(&cooling_cpufreq_lock);
 		break;
-- 
2.4.0

