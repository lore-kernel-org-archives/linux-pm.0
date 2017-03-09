From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC 7/9] cpufreq: governor: support scheduler cpufreq callbacks on remote CPUs
Date: Thu,  9 Mar 2017 17:15:17 +0530
Message-ID: <49216ebaad6b26a1d5916350d07654181662b15b.1489058244.git.viresh.kumar@linaro.org>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35344 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932283AbdCILqC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Mar 2017 06:46:02 -0500
Received: by mail-pg0-f44.google.com with SMTP id b129so25706578pgc.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Mar 2017 03:46:01 -0800 (PST)
In-Reply-To: <cover.1489058244.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489058244.git.viresh.kumar@linaro.org>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org

From: Steve Muckle <smuckle.linux@gmail.com>

In preparation for the scheduler cpufreq callback happening on remote
CPUs, add support for this in the legacy (ondemand and conservative)
governors. The legacy governors make assumptions about the callback
occurring on the CPU being updated.

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
[ vk: minor updates in commit log ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 47e24b5384b3..c9e786e7ee1f 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -315,7 +315,7 @@ static void dbs_update_util_handler(struct update_util_data *data, u64 time,
 
 	policy_dbs->last_sample_time = time;
 	policy_dbs->work_in_progress = true;
-	irq_work_queue(&policy_dbs->irq_work);
+	irq_work_queue_on(&policy_dbs->irq_work, data->cpu);
 }
 
 static void gov_set_update_util(struct policy_dbs_info *policy_dbs,
-- 
2.7.1.410.g6faf27b
