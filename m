From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 11/14] cpufreq: stats: don't update stats on false notifiers
Date: Fri,  2 Jan 2015 11:16:48 +0530
Message-ID: <bc9a1be9bacfe155f89989404b6eba916286b4c5.1420177186.git.viresh.kumar@linaro.org>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:41708 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbbABFro (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 00:47:44 -0500
Received: by mail-pa0-f45.google.com with SMTP id lf10so23609831pab.4
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 21:47:44 -0800 (PST)
In-Reply-To: <cover.1420177186.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420177186.git.viresh.kumar@linaro.org>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

No idea when 'old_index == new_index' in transition notifier (probably never?),
but if this happens, we aren't supposed to update time_in_state by calling
cpufreq_stats_update(). Its only relevant when we are changing frequencies.

So, move the call after matching indexes.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>
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

