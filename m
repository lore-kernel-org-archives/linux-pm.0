From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 11/13] cpufreq: stats: don't update stats on false notifiers
Date: Thu, 18 Dec 2014 17:30:28 +0530
Message-ID: <1345c88e4a97e7e12feaa6904ee782caa141f802.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:54905 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaLRMBp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 07:01:45 -0500
Received: by mail-pd0-f180.google.com with SMTP id w10so1284858pde.25
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2014 04:01:45 -0800 (PST)
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

No idea when 'old_index == new_index' in transition notifier (probably never?),
but if this happens, we aren't supposed to update time_in_state by calling
cpufreq_stats_update(). Its only relevant when we are changing frequencies.

So, move the call after matching indexes.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index c0c2ddece8fe..7701532b32c8 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -293,11 +293,11 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
 	if (old_index == -1 || new_index == -1)
 		return 0;
 
-	cpufreq_stats_update(stat);
-
 	if (old_index == new_index)
 		return 0;
 
+	cpufreq_stats_update(stat);
+
 	spin_lock(&cpufreq_stats_lock);
 	stat->last_index = new_index;
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
-- 
2.2.0

