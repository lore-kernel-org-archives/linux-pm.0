From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 5/9] cpufreq: ondemand: Drop unnecessary locks from update_sampling_rate()
Date: Mon, 27 Jul 2015 17:58:10 +0530
Message-ID: <e0795dfc4f83b6cfeabe856dcf4e5f8f2f5b3538.1437999691.git.viresh.kumar@linaro.org>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437999691.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437999691.git.viresh.kumar@linaro.org>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
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
index 2474c9c34022..f1551fc7b4fd 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -267,28 +267,20 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
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
 				       usecs_to_jiffies(new_rate),
 				       cpumask_of(cpu));
 
 		}
-		mutex_unlock(&dbs_info->cdbs.shared->timer_mutex);
 	}
 }
 
-- 
2.4.0
