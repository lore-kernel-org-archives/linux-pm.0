From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 03/14] cpufreq: stats: don't check for freq table while freeing stats
Date: Fri,  2 Jan 2015 11:16:40 +0530
Message-ID: <9e3d68b2be73cc83a60c952067eba21918abfa44.1420177186.git.viresh.kumar@linaro.org>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:48777 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbbABFrN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 00:47:13 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so23065992pdb.22
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 21:47:13 -0800 (PST)
In-Reply-To: <cover.1420177186.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420177186.git.viresh.kumar@linaro.org>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

While we allocate stats, we do need to check if freq-table is present or not as
we need to use it then. But while freeing stats, all we need to know is if stats
holds a valid pointer value. There is no use of testing if cpufreq table is
present or not.

Don't check it.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>
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

