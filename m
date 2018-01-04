From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: stats: Change return type of cpufreq_stats_update() as void
Date: Thu,  4 Jan 2018 08:53:54 +0530
Message-ID: <2d7702d02aba4d70f8d9a3e3612a7daea97aa3f5.1515036227.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37660 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751536AbeADDYB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jan 2018 22:24:01 -0500
Received: by mail-pl0-f67.google.com with SMTP id s3so317325plp.4
        for <linux-pm@vger.kernel.org>; Wed, 03 Jan 2018 19:24:01 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org

It always returns 0 and none of its callers check its return value. Make
it return void.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 1e55b5790853..1572129844a5 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -27,7 +27,7 @@ struct cpufreq_stats {
 	unsigned int *trans_table;
 };
 
-static int cpufreq_stats_update(struct cpufreq_stats *stats)
+static void cpufreq_stats_update(struct cpufreq_stats *stats)
 {
 	unsigned long long cur_time = get_jiffies_64();
 
@@ -35,7 +35,6 @@ static int cpufreq_stats_update(struct cpufreq_stats *stats)
 	stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
 	stats->last_time = cur_time;
 	spin_unlock(&cpufreq_stats_lock);
-	return 0;
 }
 
 static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
-- 
2.15.0.194.g9af6a3dea062
