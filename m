From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 05/16] cpufreq: stats: don't check for freq table while freeing stats
Date: Tue,  6 Jan 2015 21:09:04 +0530
Message-ID: <c3e21fccfda1f296f7fab8c2169c0a98046e1cd9.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:52707 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbbAFPjr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 10:39:47 -0500
Received: by mail-pd0-f180.google.com with SMTP id fl12so15004252pdb.11
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2015 07:39:46 -0800 (PST)
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
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
index 21bec770569d..e9d68420b876 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -168,8 +168,7 @@ static void cpufreq_stats_free_table(unsigned int cpu)
 	if (!policy)
 		return;
 
-	if (cpufreq_frequency_get_table(policy->cpu))
-		__cpufreq_stats_free_table(policy);
+	__cpufreq_stats_free_table(policy);
 
 	cpufreq_cpu_put(policy);
 }
-- 
2.2.0

