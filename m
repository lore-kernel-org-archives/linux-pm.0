From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 4/9] cpufreq: governor: Drop __gov_queue_work()
Date: Mon, 27 Jul 2015 17:58:09 +0530
Message-ID: <4f7aef4f032e082a5093b91d244647f339ef6558.1437999691.git.viresh.kumar@linaro.org>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437999691.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437999691.git.viresh.kumar@linaro.org>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

__gov_queue_work() isn't required anymore and can be merged with
gov_queue_work(). Do it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index a890450711bb..3ddc27764e10 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -158,25 +158,20 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 }
 EXPORT_SYMBOL_GPL(dbs_check_cpu);
 
-static inline void __gov_queue_work(int cpu, struct dbs_data *dbs_data,
-		unsigned int delay)
-{
-	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
-
-	mod_delayed_work_on(cpu, system_wq, &cdbs->dwork, delay);
-}
-
 void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
 		    unsigned int delay, const struct cpumask *cpus)
 {
-	int i;
+	struct cpu_dbs_info *cdbs;
+	int cpu;
 
 	mutex_lock(&cpufreq_governor_lock);
 	if (!policy->governor_enabled)
 		goto out_unlock;
 
-	for_each_cpu(i, cpus)
-		__gov_queue_work(i, dbs_data, delay);
+	for_each_cpu(cpu, cpus) {
+		cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
+		mod_delayed_work_on(cpu, system_wq, &cdbs->dwork, delay);
+	}
 
 out_unlock:
 	mutex_unlock(&cpufreq_governor_lock);
-- 
2.4.0
