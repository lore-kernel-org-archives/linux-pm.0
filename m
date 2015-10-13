From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 1/5] cpufreq: ondemand: Drop unnecessary locks from update_sampling_rate()
Date: Tue, 13 Oct 2015 13:39:01 +0530
Message-ID: <56084623b2c27372a4c2c598151dd47176c3e26f.1444723240.git.viresh.kumar@linaro.org>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444723240.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1444723240.git.viresh.kumar@linaro.org>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

'timer_mutex' is required to sync work-handlers of policy->cpus.
update_sampling_rate() is just canceling the works and queuing them
again. This isn't protecting anything at all in update_sampling_rate()
and is not gonna be of any use.

Even if a work-handler is already running for a CPU,
cancel_delayed_work_sync() will wait for it to finish.

Drop these unnecessary locks.

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_ondemand.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 1fa9088c84a8..03ac6ce54042 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -267,27 +267,19 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
 		cpufreq_cpu_put(policy);
 
-		mutex_lock(&dbs_info->cdbs.shared->timer_mutex);
-
-		if (!delayed_work_pending(&dbs_info->cdbs.dwork)) {
-			mutex_unlock(&dbs_info->cdbs.shared->timer_mutex);
+		if (!delayed_work_pending(&dbs_info->cdbs.dwork))
 			continue;
-		}
 
 		next_sampling = jiffies + usecs_to_jiffies(new_rate);
 		appointed_at = dbs_info->cdbs.dwork.timer.expires;
 
 		if (time_before(next_sampling, appointed_at)) {
-
-			mutex_unlock(&dbs_info->cdbs.shared->timer_mutex);
 			cancel_delayed_work_sync(&dbs_info->cdbs.dwork);
-			mutex_lock(&dbs_info->cdbs.shared->timer_mutex);
 
 			gov_queue_work(dbs_data, policy,
 				       usecs_to_jiffies(new_rate), true);
 
 		}
-		mutex_unlock(&dbs_info->cdbs.shared->timer_mutex);
 	}
 }
 
-- 
2.4.0
