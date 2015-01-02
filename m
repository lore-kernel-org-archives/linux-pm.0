From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 10/14] cpufreq: stats: don't update stats from show_trans_table()
Date: Fri,  2 Jan 2015 11:16:47 +0530
Message-ID: <ed5230f9ad37345410b40783cb6cafb369260113.1420177186.git.viresh.kumar@linaro.org>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:64105 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbbABFrk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 00:47:40 -0500
Received: by mail-pd0-f172.google.com with SMTP id y13so23306558pdi.3
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 21:47:39 -0800 (PST)
In-Reply-To: <cover.1420177186.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420177186.git.viresh.kumar@linaro.org>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_stats_update() updates time_in_state and nothing else. It should ideally
be updated only in two cases:
- User requested for the current value of time_in_state.
- We have switched states and so need to update time for the last state.

Currently, we are also doing this while user asks for the transition table of
frequencies. It wouldn't do any harm, but no good as well. Its useless here.

Remove it.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>
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

