From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 13/16] cpufreq: stats: time_in_state can't be NULL in cpufreq_stats_update()
Date: Tue,  6 Jan 2015 21:09:12 +0530
Message-ID: <8017f76ae8b40b747ecea193aaaacc70fa6f7257.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:50680 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbbAFPkS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 10:40:18 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so31244466pab.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2015 07:40:17 -0800 (PST)
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

'time_in_state' can't be NULL if 'stats' is valid. These are allocated together
and only if time_in_state is allocated successfully, we update policy->stats.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 17df8c507594..66ebdc4c1762 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -35,9 +35,7 @@ static int cpufreq_stats_update(struct cpufreq_stats *stats)
 	unsigned long long cur_time = get_jiffies_64();
 
 	spin_lock(&cpufreq_stats_lock);
-	if (stats->time_in_state)
-		stats->time_in_state[stats->last_index] +=
-			cur_time - stats->last_time;
+	stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
 	stats->last_time = cur_time;
 	spin_unlock(&cpufreq_stats_lock);
 	return 0;
-- 
2.2.0

