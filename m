From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 15/16] cpufreq: stats: don't update stats on false notifiers
Date: Tue,  6 Jan 2015 21:09:14 +0530
Message-ID: <de372ca3df4ad156f54cc82ae830b213125c8423.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:46060 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479AbbAFPkZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 10:40:25 -0500
Received: by mail-pd0-f173.google.com with SMTP id ft15so30542758pdb.18
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2015 07:40:25 -0800 (PST)
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

We need to call cpufreq_stats_update() to update 'time_in_state' for the last
frequency. This is achieved by calling it from cpufreq_stat_notifier_trans(),
which is called after frequency transition.

But if we detect that the cpu's frequency haven't really changed and its a false
POSTCHANGE notification, we don't really need to update time_in_state.

It wouldn't cause any harm in calling cpufreq_stats_update() but we can avoid
calling it here and call it when the frequency really changes. The result will
be the same but more efficient.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 6e87dd9c4083..71fcc7c198a1 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -289,11 +289,11 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
 	if (old_index == -1 || new_index == -1)
 		return 0;
 
-	cpufreq_stats_update(stats);
-
 	if (old_index == new_index)
 		return 0;
 
+	cpufreq_stats_update(stats);
+
 	spin_lock(&cpufreq_stats_lock);
 	stats->last_index = new_index;
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
-- 
2.2.0

