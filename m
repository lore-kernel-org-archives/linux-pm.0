From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 04/16] cpufreq: stats: initialize 'cur_time' on its definition
Date: Tue,  6 Jan 2015 21:09:03 +0530
Message-ID: <f6b08820927c368580677af08411ed3963292fc1.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:41324 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbbAFPjn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 10:39:43 -0500
Received: by mail-pa0-f44.google.com with SMTP id et14so31363370pad.3
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2015 07:39:42 -0800 (PST)
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

'cur_time' is defined in the first line and is then assigned a value in the next
line. Initialize it while defining it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 14f8d858a63d..21bec770569d 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -36,9 +36,8 @@ static DEFINE_PER_CPU(struct cpufreq_stats *, cpufreq_stats_table);
 static int cpufreq_stats_update(unsigned int cpu)
 {
 	struct cpufreq_stats *stat;
-	unsigned long long cur_time;
+	unsigned long long cur_time = get_jiffies_64();
 
-	cur_time = get_jiffies_64();
 	spin_lock(&cpufreq_stats_lock);
 	stat = per_cpu(cpufreq_stats_table, cpu);
 	if (stat->time_in_state)
-- 
2.2.0

