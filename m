From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 03/13] cpufreq: stats: don't check for freq table while freeing stats
Date: Thu, 18 Dec 2014 17:30:20 +0530
Message-ID: <1ba77985e7069b5199f95c57878d56307046a44f.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:56875 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbaLRMBO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 07:01:14 -0500
Received: by mail-pa0-f45.google.com with SMTP id lf10so1281238pab.32
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2014 04:01:13 -0800 (PST)
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

While we allocate stats, we do need to check if freq-table is present or not as
we need to use it then. But while freeing stats, all we need to know is if stats
holds a valid pointer value. There is no use of testing if cpufreq table is
present or not.

Don't check it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 403671b1a5ee..62b6133f06aa 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -174,8 +174,7 @@ static void cpufreq_stats_free_table(unsigned int cpu)
 	if (!policy)
 		return;
 
-	if (cpufreq_frequency_get_table(policy->cpu))
-		__cpufreq_stats_free_table(policy);
+	__cpufreq_stats_free_table(policy);
 
 	cpufreq_cpu_put(policy);
 }
-- 
2.2.0

