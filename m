From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4] cpufreq: governor: Quit work-handlers early if governor is stopped
Date: Thu, 29 Oct 2015 08:08:38 +0530
Message-ID: <133510f34e89a9be81766bea3c7ddc1605198ee6.1446086230.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36074 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbbJ2CjK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 22:39:10 -0400
Received: by pacfv9 with SMTP id fv9so26052872pac.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2015 19:39:09 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

gov_queue_work() acquires cpufreq_governor_lock to allow
cpufreq_governor_stop() to drain delayed work items possibly scheduled
on CPUs that share the policy with a CPU being taken offline.

However, the same goal may be achieved in a more straightforward way if
the policy pointer in the struct cpu_dbs_info matching the policy CPU is
reset upfront by cpufreq_governor_stop() under the timer_mutex belonging
to it and checked against NULL, under the same lock, at the beginning of
dbs_timer().

In that case every instance of dbs_timer() run for a struct cpu_dbs_info
sharing the policy pointer in question after cpufreq_governor_stop() has
started will notice that that pointer is NULL and bail out immediately
without queuing up any new work items.  In turn, gov_cancel_work()
called by cpufreq_governor_stop() before destroying timer_mutex will
wait for all of the delayed work items currently running on the CPUs
sharing the policy to drop the mutex, so it may be destroyed safely.

Make cpufreq_governor_stop() and dbs_timer() work as described and
modify gov_queue_work() so it does not acquire cpufreq_governor_lock any
more.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
@Rafael: Please apply this patch alone for now, let me work out with the
timer/work thing first before applying other patches.

V3->V4:
- Updated changelog as suggested by Rafael.

 drivers/cpufreq/cpufreq_governor.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 11258c4c1b17..b260576ddb12 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -171,10 +171,6 @@ void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
 {
 	int i;
 
-	mutex_lock(&cpufreq_governor_lock);
-	if (!policy->governor_enabled)
-		goto out_unlock;
-
 	if (!all_cpus) {
 		/*
 		 * Use raw_smp_processor_id() to avoid preemptible warnings.
@@ -188,9 +184,6 @@ void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
 		for_each_cpu(i, policy->cpus)
 			__gov_queue_work(i, dbs_data, delay);
 	}
-
-out_unlock:
-	mutex_unlock(&cpufreq_governor_lock);
 }
 EXPORT_SYMBOL_GPL(gov_queue_work);
 
@@ -229,13 +222,24 @@ static void dbs_timer(struct work_struct *work)
 	struct cpu_dbs_info *cdbs = container_of(work, struct cpu_dbs_info,
 						 dwork.work);
 	struct cpu_common_dbs_info *shared = cdbs->shared;
-	struct cpufreq_policy *policy = shared->policy;
-	struct dbs_data *dbs_data = policy->governor_data;
+	struct cpufreq_policy *policy;
+	struct dbs_data *dbs_data;
 	unsigned int sampling_rate, delay;
 	bool modify_all = true;
 
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
 
@@ -252,6 +256,7 @@ static void dbs_timer(struct work_struct *work)
 	delay = dbs_data->cdata->gov_dbs_timer(cdbs, dbs_data, modify_all);
 	gov_queue_work(dbs_data, policy, delay, modify_all);
 
+unlock:
 	mutex_unlock(&shared->timer_mutex);
 }
 
@@ -478,9 +483,17 @@ static int cpufreq_governor_stop(struct cpufreq_policy *policy,
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
2.6.2.198.g614a2ac

