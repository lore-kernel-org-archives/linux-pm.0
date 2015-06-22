From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/10] cpufreq: ondemand: Drop unnecessary locks from update_sampling_rate()
Date: Mon, 22 Jun 2015 13:32:53 +0530
Message-ID: <88c876acc1389b613a7721afdd369d60841f93e9.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33317 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756129AbbFVID3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 04:03:29 -0400
Received: by padev16 with SMTP id ev16so129131523pad.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 01:03:28 -0700 (PDT)
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434959517.git.viresh.kumar@linaro.org>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

'timer_mutex' is required to sync work-handlers of policy->cpus.
update_sampling_rate() is just canceling the works and queuing them
again. This isn't protecting anything at all in update_sampling_rate()
and is not gonna be of any use.

Even if a work-handler is already running for a CPU,
cancel_delayed_work_sync() will wait for it to finish.

Drop these unnecessary locks.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_ondemand.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 774bbddae2c9..841e1fa96ee7 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -267,28 +267,20 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
 		cpufreq_cpu_put(policy);
 
-		mutex_lock(&dbs_info->cdbs.ccdbs->timer_mutex);
-
-		if (!delayed_work_pending(&dbs_info->cdbs.dwork)) {
-			mutex_unlock(&dbs_info->cdbs.ccdbs->timer_mutex);
+		if (!delayed_work_pending(&dbs_info->cdbs.dwork))
 			continue;
-		}
 
 		next_sampling = jiffies + usecs_to_jiffies(new_rate);
 		appointed_at = dbs_info->cdbs.dwork.timer.expires;
 
 		if (time_before(next_sampling, appointed_at)) {
-
-			mutex_unlock(&dbs_info->cdbs.ccdbs->timer_mutex);
 			cancel_delayed_work_sync(&dbs_info->cdbs.dwork);
-			mutex_lock(&dbs_info->cdbs.ccdbs->timer_mutex);
 
 			gov_queue_work(dbs_data, policy,
 				       usecs_to_jiffies(new_rate),
 				       cpumask_of(cpu));
 
 		}
-		mutex_unlock(&dbs_info->cdbs.ccdbs->timer_mutex);
 	}
 }
 
-- 
2.4.0

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
