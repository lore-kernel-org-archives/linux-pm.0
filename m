From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 14/16] cpufreq: stats: don't update stats from show_trans_table()
Date: Tue,  6 Jan 2015 21:09:13 +0530
Message-ID: <f419ef9f927ecb15c961873281ae46abe6d5ff00.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:40775 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479AbbAFPkV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 10:40:21 -0500
Received: by mail-pa0-f42.google.com with SMTP id et14so31328328pad.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2015 07:40:21 -0800 (PST)
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
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
index 66ebdc4c1762..6e87dd9c4083 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -68,7 +68,6 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 	ssize_t len = 0;
 	int i, j;
 
-	cpufreq_stats_update(stats);
 	len += snprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
 	len += snprintf(buf + len, PAGE_SIZE - len, "         : ");
 	for (i = 0; i < stats->state_num; i++) {
-- 
2.2.0

