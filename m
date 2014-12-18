From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/13] cpufreq: stats: don't update stats from show_trans_table()
Date: Thu, 18 Dec 2014 17:30:27 +0530
Message-ID: <ae5d7a3fe1439a7dc1d1a11c785f662c6d308077.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:50168 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaLRMBl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 07:01:41 -0500
Received: by mail-pd0-f169.google.com with SMTP id z10so1318454pdj.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2014 04:01:41 -0800 (PST)
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_stats_update() updates time_in_state and nothing else. It should ideally
be updated only in two cases:
- User requested for the current value of time_in_state.
- We have switched states and so need to update time for the last state.

Currently, we are also doing this while user asks for the transition table of
frequencies. It wouldn't do any harm, but no good as well. Its useless here.

Remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index dd55d57655ce..c0c2ddece8fe 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -77,7 +77,6 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 	ssize_t len = 0;
 	int i, j;
 
-	cpufreq_stats_update(stat);
 	len += snprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
 	len += snprintf(buf + len, PAGE_SIZE - len, "         : ");
 	for (i = 0; i < stat->state_num; i++) {
-- 
2.2.0

