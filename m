From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 8/9] cpufreq: governor: Quit work-handlers early if governor is stopped
Date: Mon, 27 Jul 2015 17:58:13 +0530
Message-ID: <fec14dd72428a3940d367cb365d55a5a35921b83.1437999691.git.viresh.kumar@linaro.org>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437999691.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437999691.git.viresh.kumar@linaro.org>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

cpufreq_governor_lock is abused by using it outside of cpufreq core,
i.e. in cpufreq-governors. But we didn't had a solution at that point of
time, and so doing that was the only acceptable solution:

6f1e4efd882e ("cpufreq: Fix timer/workqueue corruption by protecting
reading governor_enabled")

The cpufreq governor core is fixed now against possible races and things
are in much better shape.

cpufreq core is checking for invalid state-transitions of governors in
__cpufreq_governor() with help of governor_enabled flag. The governor
core is already taking care of that now and so we can get rid of those
extra checks in __cpufreq_governor().

To do that, we first need to get rid of the dependency on
governor_enabled flag in governor core, in gov_queue_work.

This patch is about getting rid of this dependency.

When a CPU is hot removed we'll cancel all the delayed work items via
gov_cancel_work(). Normally this will just cancels a delayed timer on
each CPU that the policy is managing and the work won't run. But if the
work is already running, the workqueue code will wait for the work to
finish before continuing to prevent the work items from re-queuing
themselves like they normally do.

This scheme will work most of the time, except for the case where the
work function determines that it should adjust the delay for all other
CPUs that the policy is managing. If this scenario occurs, the canceling
CPU will cancel its own work but queue up the other CPUs works to run.

And we will enter a situation where gov_cancel_work() has returned with
work being queued on few CPUs.

To fix that in a different (non-hacky) way, set set shared->policy to
false before trying to cancel the work. It should be updated within
timer_mutex, which will prevent the work-handlers to start. Once the
work-handlers finds that we are already trying to stop the governor, it
will exit early. And that will prevent queuing of works again as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 3ddc27764e10..bb12acff3ba6 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -164,17 +164,10 @@ void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
 	struct cpu_dbs_info *cdbs;
 	int cpu;
 
-	mutex_lock(&cpufreq_governor_lock);
-	if (!policy->governor_enabled)
-		goto out_unlock;
-
 	for_each_cpu(cpu, cpus) {
 		cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
 		mod_delayed_work_on(cpu, system_wq, &cdbs->dwork, delay);
 	}
-
-out_unlock:
-	mutex_unlock(&cpufreq_governor_lock);
 }
 EXPORT_SYMBOL_GPL(gov_queue_work);
 
@@ -213,14 +206,25 @@ static void dbs_timer(struct work_struct *work)
 	struct cpu_dbs_info *cdbs = container_of(work, struct cpu_dbs_info,
 						 dwork.work);
 	struct cpu_common_dbs_info *shared = cdbs->shared;
-	struct cpufreq_policy *policy = shared->policy;
-	struct dbs_data *dbs_data = policy->governor_data;
+	struct cpufreq_policy *policy;
+	struct dbs_data *dbs_data;
 	unsigned int sampling_rate, delay;
 	const struct cpumask *cpus;
 	bool load_eval;
 
 	mutex_lock(&shared->timer_mutex);
 
+	policy = shared->policy;
+
+	/*
+	 * Governor might already be disabled and there is no point continuing
+	 * with the work-handler.
+	 */
+	if (!policy)
+		goto unlock;
+
+	dbs_data = policy->governor_data;
+
 	if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
 		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
@@ -237,6 +241,7 @@ static void dbs_timer(struct work_struct *work)
 	delay = dbs_data->cdata->gov_dbs_timer(cdbs, dbs_data, load_eval);
 	gov_queue_work(dbs_data, policy, delay, cpus);
 
+unlock:
 	mutex_unlock(&shared->timer_mutex);
 }
 
@@ -473,9 +478,17 @@ static int cpufreq_governor_stop(struct cpufreq_policy *policy,
 	if (!shared || !shared->policy)
 		return -EBUSY;
 
+	/*
+	 * Work-handler must see this updated, as it should not proceed any
+	 * further after governor is disabled. And so timer_mutex is taken while
+	 * updating this value.
+	 */
+	mutex_lock(&shared->timer_mutex);
+	shared->policy = NULL;
+	mutex_unlock(&shared->timer_mutex);
+
 	gov_cancel_work(dbs_data, policy);
 
-	shared->policy = NULL;
 	mutex_destroy(&shared->timer_mutex);
 	return 0;
 }
-- 
2.4.0
